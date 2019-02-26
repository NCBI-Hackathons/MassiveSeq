#include <iostream>
#include <string>
#include <string.h>
#include <strings.h>
#include <sstream>
#include <algorithm>
#include <iterator>
#include <fstream>
#include <stdio.h>
#include <string>
#include <vector>
#include <stdlib.h>

using namespace std;

// dfranz
// this thing searches for matches from sample counts and 
// master gene list
// to compile
// sudo g++ lol.cpp  -o lol -std=c++11
// first argument is the file that contents sample data (full path)


int main(int argc, char *argv[]) {
	setbuf(stdout, NULL);

	FILE *f = fopen("sorted.txt", "w");


	//printf("%s\n", argv[1]);
    string line,line2;
    // LOOP MASTER GENE LIST
    ifstream myfile ("/vol_c/gene_list.txt");
    if (myfile.is_open())
    {
        while ( getline (myfile,line) )
        {
     		int found=0;
		// LOOP THE LOCAL SAMPLE DATA
	        ifstream myfile2 (argv[1]);
                if (myfile2.is_open())
                {
                    while (getline(myfile2,line2)) {
                    	vector<string> myvector;
                	istringstream iss(line2);
            		copy(
                		istream_iterator<string>(iss),
                		istream_iterator<string>(),
                		back_inserter(myvector)
            		);

			if (line == myvector[0]) {
				fprintf(f, "%s\n", myvector[1].c_str());
				//printf("%s\n",myvector[1].c_str());
				found=1;
			}
                        //printf("%s %s\n", line.c_str(),myvector[0].c_str());
                    }
                }

		if (!found) {
			//printf("0\n");
			//outfile << "0" << "\n";
			fprintf(f,"%i\n",0);
		}
        }
        
    }

    fclose(f); //.close();

    return 0;
}





