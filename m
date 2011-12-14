Return-Path: <jic23@kernel.org>
Message-ID: <4EE90304.8080902@kernel.org>
Date: Wed, 14 Dec 2011 20:11:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>,
 devel@linuxdriverproject.org, linux-iio@vger.kernel.org, gregkh@suse.de,
 jic23@cam.ac.uk, jbrenner@taosinc.com
Subject: Re: staging: iio: light: obsolete use of strict_strtoul v2
References: <1323733102-7868-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de> <20111213063350.GF3503@mwanda>
In-Reply-To: <20111213063350.GF3503@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/13/2011 06:33 AM, Dan Carpenter wrote:
> On Tue, Dec 13, 2011 at 12:38:20AM +0100, Johannes Tenschert 
> wrote:
>> Hi,
>> 
>> I changed the patch to use the right kstrto* as Dan Carpenter 
>> suggested, but I'm not familiar enough with the code to fix the 
>> divide by zero bug in a good way.
>> 
>> I also didn't change taos_settings because I don't know it well 
>> enough and don't want to introduce new bugs. So kstrtoint was 
>> used provisional to set it.
> 
> Yah, yah.  Neither of us know the code, so hopefully the iio people
> can comment.
I'm feeling lazy lets leave it for Jon when he gets to it ;)

(bug description is with the previous version of this patch in Dan's
response where he cc'd various people in).

Jonathan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJO6QLWAAoJEFSFNJnE9BaIvsYQALzcJmYzwfS6TSuKeWW/FIxt
zoddt9yjr/XP+nhLBxnPQo06hsgp8e0yxPIpe1xV+FFryb22eOLXXdCchbXSc5bE
UeKuwQjgtilLZYFAWxc5VvscaYtLvo82swyeDe8YldbQykXVYRuZcFebH2p1YQUU
ai3R7ykErgYft+39AwIaxS9irZoVte2+IhKazBuCs6JYebCJ3sBS6/5YFJDyI87Z
jLxPy69yhRBwv++rQ7gQwH1Z43DnYYfbxVbO/ZaD5we+2YnpAAc7IpSN4ZA5b34t
KdyFBJlC1RTSZc9qQfI4Jm50JFGvFXwMxD6wdbpOjzwq6rjvrAYlk/W9GI9OtScN
fhgpC3mGBKO059jrO34JWNtbuwl3QLmfIuqCRKiUX+yeKGJQpSMxIron0E6Hf2m7
FKSHtjlflsyIXwH0w1AtDxzqBhcn+AWB5agyDBX3oZEeIOS8id41ISIFpYQEk5xH
H2zG7YTzWQQVBStQlCEpgzqbGg2JTGElQJifBk677pZ7F09MHLnZiK+qbnALBaqO
3rDBA9ZbZckohtm2YCHPiT8dTNfT2yby3XMG5y12VNxPnSNRN+HrOBYa5FLESY7d
rgl9vdCLhJUSxF68/t1WsAZ5l/box9gqjqIz1QjNBIi9J14uQvF4LklASI55GVWk
d/WsoXgigTeuWld24BRc
=aw+/
-----END PGP SIGNATURE-----
