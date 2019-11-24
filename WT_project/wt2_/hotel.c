#include <stdio.h>
#include <string.h>
#include <libpq-fe.h> //link with -lpq
#include <stdlib.h>


void do_exit(PGconn *conn) {
    
    PQfinish(conn);
    exit(1);
}


int main(void)
{
	
	int i=0,j=0,k=0;
	char *data,*pch,*ch,str[10][20],nstr[30][20],c;
	char f[100],l[100];
	printf("%s%c%c\n","Content-Type:text/html;charset=iso-8859-1",13,10);
	printf("<TITLE>Reservation</TITLE>\n");
	printf("<H3></H3>\n");
	data = getenv("QUERY_STRING");
	
	//printf("%s\n",data);
	pch = strtok (data,"=,&");
	//printf("%s",pch);
	while (pch != NULL)
	{
		//printf ("<br>%s",pch);
		strcpy(str[i],pch);
	    	pch = strtok (NULL, " =,&");
		i++;  
	}
	//printf("%s",str[1]);
	ch=str[1];
	//printf("%s",ch);
	
    	 PGconn *conn = PQconnectdb("user=postgres dbname=prameet");

   	if (PQstatus(conn) == CONNECTION_BAD) {
        
        	fprintf(stderr,"Connection to database failed: %s\n",
        	    PQerrorMessage(conn));
        	do_exit(conn);
    	}
    
    	char buffer[1024];
	int num=snprintf(buffer,sizeof(buffer),"select distinct name,room.roomno,street from reservation,room,location,hotel where room.hotel_id=hotel.hotel_id and hotel.pincode=location.pincode and 		  hotel.hotel_id=reservation.hotel_id and city='%s' and end_date<current_date union select distinct name,room.roomno,street from reservation,room,location,hotel where	room.hotel_id=hotel.hotel_id and hotel.pincode=location.pincode and hotel.hotel_id=reservation.hotel_id and city='%s' and roomstatus='Available';",ch,ch);
	if (num>sizeof(buffer))
		printf("buffer was too small\n");

   	 PGresult *res = PQexec(conn, buffer);    
    
   	 if (PQresultStatus(res) != PGRES_TUPLES_OK) {
	
        	printf("No data retrieved\n");        
        	PQclear(res);
        	do_exit(conn);
    	 }   	 
    
    	int rows = PQntuples(res);
    	char h[rows][100],*s,*r,*p;
    	for(int i=0; i<rows; i++) {
        
        	//printf("<br>%s %s %s \n", PQgetvalue(res, i, 0), 
        	  //PQgetvalue(res, i, 1), PQgetvalue(res, i, 2));
        	s=PQgetvalue(res,i,0);
        	r=PQgetvalue(res,i,1);
        	p=PQgetvalue(res,i,2);
		strcpy(h[i],s);
		strcat(h[i]," ");
		strcat(h[i],r);
		strcat(h[i]," ");
		strcat(h[i],p);
    	}    
    	/*for(i=0;i<rows;i++)
    	{
    		printf("<br>%s\n",h[i]);
    	}*/
 
    	PQclear(res);
    	PQfinish(conn);
    	printf("<link rel=\"stylesheet\" type=\"text/css\" href=\"/style.css\">\n");
    	printf("<h1 style=\"text-align:center;color:dodgerblue;\">HOTEL SYSTEM</h1>");
    	printf("<ul>");
  	printf("<li><img  src=\"pes_logo.png\" height=\"50px\" width=\"200px\"></li>");

  	printf("<li style=\"float:right\"><a href=\"#about\">About</a></li>");
   	printf("<li style=\"float:right\"><a href=\"#contact\">Contact</a></li>");
    	printf("<li style=\"float:right\"><a href=\"#news\">News</a></li>");
  	printf("<li style=\"float:right\"><a class=\"active\" href=\"#home\">Home</a></li>");
	printf("</ul>");
	printf("<br>");
	printf("<div>");
	printf("<form name=b method=\"GET\" action=\"http://localhost/cgi-bin/hotel1.cgi\" onsubmit=\"return validation()\">");
	printf("place:<br><select id=\"hotel\" name=\"hotel\">");
	for(i=0;i<rows;i++)
	{
        	printf("<option value=\"%s\"> %s </option>",h[i],h[i]);
	}
	printf("</select><br><br>");
	printf("<label for=\"fname\">First Name:</label><br>");
    	printf("<input type=\"text\" id=\"fname\" name=\"firstname\" placeholder=\"Your name..\" required><br><br>");
    	
    	printf("<label for=\"phone\">Phone No.:</label><br>");
    	printf("<input type=\"text\" id=\"phone\" name=\"phone\" placeholder=\"enter your phone no..\" required><br><br>");
    	
    	printf("<label for=\"stdate\">Start Date:</label><br>");
    	printf("<input type=\"date\" id=\"stdate\" name=\"stdate\" placeholder=\"enter date..\" required><br>");
	
	printf("<label for=\"enddate\">End Date:</label><br>");
    	printf("<input type=\"date\" id=\"enddate\" name=\"enddate\" placeholder=\"enter date..\" required><br>");
    	
	printf("<input type=\"submit\">");
	printf("<input type=\"reset\" value=\"Reset\" onClick=\"window.location.reload()\">");
	printf("</form>");
	printf("</div>");
    	return 0;

}

//strcpy(root.name,str[1]);
//root.age=(int)str[11];
//root.sex=(char)str[9];






