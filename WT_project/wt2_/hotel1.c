#include <stdio.h>
#include <time.h>
#include <string.h>
#include <postgresql/libpq-fe.h>
#include <stdlib.h>

char *randstring(int length);
void do_exit(PGconn *conn) {
    
    PQfinish(conn);
    exit(1);
}


int main(void)
{
	static const char rnum[] ="0123456789";
	int i=0,j=0,k=0,len;
	char *data,*pch,*ch,str[20][20],nstr[30][20],*s,cust[10],resr[10],pay[10];
	char hname[50],*rno,*name,*phone,*stdate,*enddate;
	char f[100],l[100];
	printf("%s%c%c\n","Content-Type:text/html;charset=iso-8859-1",13,10);
	printf("<TITLE>Reservation</TITLE>\n");
	printf("<H3></H3>\n");
	
	data = getenv("QUERY_STRING");
	
	//printf("%s\n",data);
	pch = strtok (data,"=,+,&");
	//printf("%s",pch);
	while (pch != NULL)
	{
		//printf ("<br>%s",pch);
		strcpy(str[i],pch);
		pch = strtok (NULL, " =,+,&");
		i++;  
	}
	strcpy(hname,str[1]);
	strcat(hname," ");
	strcat(hname,str[2]);
	rno=str[3];
	name=str[6];
	phone=str[8];
	stdate=str[10];
	enddate=str[12];
	

	/*strcpy(rno,str[3]);
	strcpy(name,str[6]);
	strcpy(phone,str[8]);
	strcpy(stdate,str[10]);
	strcpy(enddate,str[12]);
	printf("%s<br>",str[1]);
	printf("%s<br>",str[2]);
	
	printf("%s<br>",str[3]);
	printf("%s<br>",str[4]);
	printf("%s<br>",str[5]);
	printf("%s<br>",str[6]);
	
	printf("%s<br>",str[7]);
	printf("%s<br>",str[8]);
	printf("%s<br>",str[9]);
	printf("%s<br>",str[10]);
	
	printf("%s<br>",str[11]);
	printf("%s<br>",str[12]);*/
	
	/*printf("%s<br>",hname);
	printf("%s<br>",rno);
	printf("%s<br>",name);
	printf("%s<br>",phone);
	printf("%s<br>",stdate);
	printf("%s<br>",enddate);*/
	
	
	
	//generate random ids
	s=randstring(4);
	//printf("%lu<br>",strlen(s));
	//printf("%s<br>",s);
	cust[0]='C';
	resr[0]='R';
	pay[0]='P';
	for(i=1;i<5;i++)
	{
		cust[i]=s[i-1];
		resr[i]=s[i-1];
		pay[i]=s[i-1];
	}
	//printf("%s<br>",cust);
	//printf("%s<br>",resr);
	//printf("%s<br>",pay);
		
	
	
    	PGconn *conn = PQconnectdb("user=postgres dbname=prameet");

   	if (PQstatus(conn) == CONNECTION_BAD) {
        
        	fprintf(stderr,"Connection to database failed: %s\n",
        	    PQerrorMessage(conn));
        	do_exit(conn);
    	}
    
    	char buffer[1024];
    	int num=snprintf(buffer,sizeof(buffer),"select hotel_id from hotel where name='%s'",hname);
    	if (num>sizeof(buffer))
		printf("buffer was too small\n");
	
    	
    	PGresult *res=PQexec(conn,buffer);
   	 if (PQresultStatus(res) != PGRES_TUPLES_OK) {
	
        	printf("No data retrieved\n");        
        	PQclear(res);
        	do_exit(conn);
    	 }   	 
    
    	int rows = PQntuples(res);
    	char h[rows][100],*hid;
    	for(int i=0; i<rows; i++) {
        
        	//printf("<br>%s %s %s \n", PQgetvalue(res, i, 0), 
        	  //PQgetvalue(res, i, 1), PQgetvalue(res, i, 2));
        	hid=PQgetvalue(res,i,0);
        	
    	}  
    	//printf("%s",hid);
    	PQclear(res);
    	char arr[1024];
    	num=snprintf(arr,sizeof(arr),"INSERT INTO customer VALUES('%s','%s','%s','%s','%s')",cust,name,rno,phone,hid);
    	if (num>sizeof(arr))
		printf("buffer was too small\n");
    	res=PQexec(conn,arr);
    	
   	PQclear(res);
   	
   	
   	
   	
   	char arr1[1024];
    	num=snprintf(arr1,sizeof(arr1),"INSERT INTO reservation VALUES('%s','%s','%s','%s','%s','Online','%s','%s')",hid,rno,pay,resr,cust,stdate,enddate);
    	if (num>sizeof(arr1))
		printf("buffer was too small\n");
    	res=PQexec(conn,arr1);
    	
   	PQclear(res);
   	
   	
   	
   	
   	char arr2[1024];
    	num=snprintf(arr2,sizeof(arr2),"INSERT INTO cost VALUES('%s','%s',%d)",pay,resr,1000);
    	if (num>sizeof(arr2))
		printf("buffer was too small\n");
    	res=PQexec(conn,arr2);
    	
   	PQclear(res); 
   	
   	//printf("%s",cust);
   	//printf("%s",pay);
   	
    	/*for(i=0;i<rows;i++)
    	{
    		printf("<br>%s\n",h[i]);
    	}*/
 
    	/*PQclear(res);
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
	printf("</select><br>");
	printf("<input type=\"submit\">");
	printf("<input type=\"reset\" value=\"Reset\" onClick=\"window.location.reload()\">");*/
	printf("<div>");
	printf("<h3 align=\"center\">SUCCESSFUL</h3>");
	printf("</div>");
    	return 0;

}

char *randstring(int length) {    
    static int mySeed = 25011984;
    char *string = "0123456789";
    size_t stringLen = strlen(string);        
    char *randomString = NULL;

    srand(time(NULL) * length + ++mySeed);

    if (length < 1) {
        length = 1;
    }

    randomString = malloc(sizeof(char) * (length +1));

    if (randomString) {
        short key = 0;

        for (int n = 0;n < length;n++) {            
            key = rand() % stringLen;          
            randomString[n] = string[key];
        }

        randomString[length] = '\0';

        return randomString;        
    }
    else {
        printf("No memory");
        exit(1);
    }
}






