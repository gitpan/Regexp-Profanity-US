$_ = "1122a44";

while( m/(\d\d)/g )
  {
      print "Found $1\n";
  }
