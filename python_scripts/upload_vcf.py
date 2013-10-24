#!/usr/bin/python

import psycopg2, vcf, sys, StringIO, time, getopt


def main(argv):

    # Create a log file for writing major events and the time of those events
    now = time.strftime("%H:%M:%S +0000", time.localtime())
    log_file = open('loading_status.txt', 'w')
    log_file.write('Starting to load data at:' + now + "\n")
    log_file.close()
    try:
        opts, args = getopt.getopt(argv, "ht:f:", ["tab=", "file="])
    except getopt.GetoptError:
        print('upload_vcf.py -t <table_name> -f <import_filename>')
        sys.exit(2)
    
    # etract command line arguments and bind to variables 
    for opt, arg in opts:
        if opt == '-h':
            print('load_data.py -t <tablename> -f <filename>')
            sys.exit()
        elif opt in ("-t", "--tab"):
            table = arg
        elif opt in ("-f", "--file"):
            file = arg
            
    print(table + ' : ' + file)
    parsed_buffer = parse_vcf(file)
    upload_data(parsed_buffer, table)
    
def parse_vcf(file):
    
    
    # Create a reader object to parse the VCF
    vcf_reader = vcf.Reader(open(file, 'r'))
    # create a sting buffer to hold the complete results
    tab_buffer = StringIO.StringIO()
    
    
    # bind the record elements into variables
    for record in vcf_reader:
        
        chrom = str(record.CHROM)
        id = str(record.ID)
        pos = str(record.POS)
        ref = str(record.REF)
        alt = str(record.ALT)
        qual = str(record.FILTER)
          
        # try:
            # ad = str(record.FORMAT[0])
        # except KeyError as e:
        ad = ''
            # pass
          
        # try:
            # dp_format = str(record.FORMAT[1])
        # except KeyError as e:
        dp_format = ''
            # pass
          
        # try:
            # gq = str(record.FORMAT[2])
        # except KeyError as e:
        gq = ''
            # pass
          
        # try:
            # gt = str(record.FORMAT[3])
        # except KeyError as e:
        gt = ''
            # pass
          
        # try:
            # mlpsac = str(record.FORMAT[4])
        # except KeyError as e:
        mlpsac = ''
            # pass
          
        # try:
            # mlpsaf = str(record.FORMAT[5])
        # except KeyError as e:
        mlpsaf = ''
            # pass
          
        # try:
            # pl = str(record.FORMAT[6])
        # except KeyError as e:
        pl = ''
            # pass
          
        try:
            ac = str(record.INFO['AC'])
        except KeyError as e:
            ac = ''
            pass
              
        try:
            af = str(record.INFO['AF'])
        except KeyError as e:
            af = ''
            pass
              
        try:
            an = str(record.INFO['AN'])
        except KeyError as e:
            an = ''
            pass
              
        try:
            baseQ = str(record.INFO['BaseQRankSum'])
        except KeyError as e:
            baseQ = ''
            pass
              
        try:
            dp = str(record.INFO['DP'])
        except KeyError as e:
            dp = ''
            pass
          
        try:
            ds = str(record.INFO['DS'])
        except KeyError as e:
            ds = ''
            pass
              
        try:
            dels = str(record.INFO['Dels'])
        except KeyError as e: 
            dels = ''
            pass
              
        try:
            fs = str(record.INFO['FS'])
        except KeyError as e: 
            fs = ''
            pass
              
        try:
            hapScore = str(record.INFO['HaplotypeScore'])
        except KeyError as e:
            hapScore = ''
            pass
          
        try:
            inbreedingCoeff = str(record.INFO['InbreedingCoeff'])
        except KeyError as e:
            inbreedingCoeff = ''
            pass
  
        try:
            mleac = str(record.INFO['MLEAC'])
        except KeyError as e:
            mleac = ''
            pass
              
        try:
            mleaf = str(record.INFO['MLEAF'])
        except KeyError as e:
            mleaf = ''
            pass
              
        try:
            mq = str(record.INFO['MQ'])
        except KeyError as e:
            mq = ''
            pass
          
        try:
            mq0 = str(record.INFO['MQ0'])              
        except KeyError as e:
            mq0 = ''
            pass
              
        try:
            mqRankSum = str(record.INFO['MQRankSum'])
        except KeyError as e:
            mqRankSum = ''
            pass
          
        try:
            qd = str(record.INFO['QD'])
        except KeyError as e:
            qd = ''
            pass
          
        try:
            rpa = str(record.INFO['RPA'])
        except KeyError as e:
            rpa = ''
            pass
          
        try:
            ru = str(record.INFO['RU'])
        except KeyError as e:
            ru = ''
            pass
          
        try:
            readSum = str(record.INFO['ReadPosRankSum'])
        except KeyError as e:
            readSum = ''
            pass
          
        try:
            str_vcf = str(record.INFO['STR'])
        except KeyError as e:
            str_vcf = ''
            pass
          
         
        # create and appended to a string buffer
        line = id + '\t' + chrom + '\t' + pos + '\t' + ref + '\t' + alt + '\t' + ad + '\t' + dp_format + '\t' + gq + '\t' + gt + '\t' + mlpsac + '\t' + mlpsaf + '\t' + pl + '\t' + ac + '\t' + af + '\t' + an + '\t' + baseQ + '\t' + dp + '\t' + ds + '\t' + dels + '\t' + fs + '\t' + hapScore +  '\t' + inbreedingCoeff + '\t' + mleac + '\t' + mleaf + '\t' + mq + '\t' + mq0 + '\t' + mqRankSum + '\t' + qd + '\t' + rpa + '\t' + ru + '\t' + readSum  + '\t' +  str_vcf + '\n'
        tab_buffer.write(line)
 
        #insert_vcf (id, chrom, pos, ref, alt, ad, dp_format, gq, gt, mlpsac, mlpsaf, pl, ac, af, an, baseQ, dp, ds, dels, fs, hapScore, inbreedingCoeff, mleac, mleaf, mq, mq0, mqRankSum, qd, rpa, ru, readSum, str_vcf)    
    return (tab_buffer)
        
def upload_data(parsed_buffer, itablename):  
    
    # this command resets the pointer to the beginning of the buffer
    parsed_buffer.seek(0)
    now = time.strftime("%H:%M:%S +0000", time.localtime())
    try:
        # record event in log
        log_file = open('loading_status.txt', 'a')
        log_file.write("Uploading to the database at: " + now + "\n")
    except Exception as e:
        print("Can't open log file")
        
    try:
        # connect to the database
        con = psycopg2.connect(database='bigonc', user='bigonc_prd',  host='ion-21-9.sdsc.edu', password='abc') 
        cur = con.cursor()
    
        try:
            # bulk copy cursor pbject into target table
            cur.copy_from(parsed_buffer, itablename)
            con.commit();
        except psycopg2.IntegrityError:
            con.commit();
            log_file.write("Caught error (as expected):\n" + str(err) + "\n")
            pass
#         except Exception as err:
#             con.commit();
#             log_file.write("Caught error (as expected):\n" + str(err) + "\n")
#             pass # do not quit because of duplicate keys
        except Exception as e:
            con.commit();
            log_file.write("Copy failed at: " + now + " - " + e.pgerror)
            sys.exit(1)
        
    except psycopg2.NotSupportedError as e:
        now = time.strftime("%H:%M:%S +0000", time.localtime())
        log_file.write("Copy failed at: " + now + " - " + e.pgerror)
        sys.exit(1)
        
    finally:
    
            # if con:
            print('Finished')
            # con.close()
            now = time.strftime("%H:%M:%S +0000", time.localtime())
            log_file.write('Finished loading data at:' + now + "\n")
            log_file.close()
            
            
def insert_vcf(id, chrom, pos, ref, alt, ad, dp_format, gq, gt, mlpsac, mlpsaf, pl, ac, af, an, baseQ, dp, ds, dels, fs, hapScore, inbreedingCoeff, mleac, mleaf, mq, mq0, mqRankSum, qd, rpa, ru, readSum, str_vcf):
     
     # this command resets the pointer to the beginning of the buffer
    now = time.strftime("%H:%M:%S +0000", time.localtime())
    
    try:
        # record event in log
        log_file = open('loading_status.txt', 'a')
        log_file.write("Uploading to the database at: " + now + "\n")
    except Exception as e:
        print("Can't open log file")
    
    try:
        # connect to the database
        con = psycopg2.connect(database='postgres', user='postgres', password='2Nathan$', host='bigonc.sdsc.edu') 
        cur = con.cursor()
       
        try:
            if (id is None):
                id = 'N/A'
            cur.execute("insert into staging.vcf (id, chrom, pos, ref, alt, ad, dp_format, gq, gt, mlpsac, mlpsaf, pl, ac, af, an, baseQ, dp, ds, dels, fs, hapScore, inbreedingCoeff, mleac, mleaf, mq, mq0, mqRankSum, qd, rpa, ru, readSum, str_vcf) values(%s, %s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                    (id, chrom, pos, ref, alt, ad, dp_format, gq, gt, mlpsac, mlpsaf, pl, ac, af, an, baseQ, dp, ds, dels, fs, hapScore, inbreedingCoeff, mleac, mleaf, mq, mq0, mqRankSum, qd, rpa, ru, readSum, str_vcf)) 
            con.commit()
        except psycopg2.Error as e:
            now = time.strftime("%H:%M:%S +0000", time.localtime())
            log_file.write("Copy failed at: " + now + " - " + e.pgerror)
            sys.exit(1)
        except Exception as e:
            log_file.write("Insert Failed " + e.pgerror + "\n")
            sys.exit(1)
    except psycopg2.Error as e:
            log_file.write("Insert Failed " + e.pgerror + "\n")
            
    finally:
            
        # con.close()
        now = time.strftime("%H:%M:%S +0000", time.localtime())
        log_file.write('Finished loading data at:' + now + "\n")
        log_file.close()
                
# when invoked from the command line invoke this function
            
if __name__ == "__main__":
    print("Starting")
    main(sys.argv[1:])
else:
    print("Don't recognize this method\n" + __name__ + "\n")
    
