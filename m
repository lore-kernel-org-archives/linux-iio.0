Return-Path: <jic23@cam.ac.uk>
Message-ID: <4EB7F4FD.8040801@cam.ac.uk>
Date: Mon, 07 Nov 2011 15:10:53 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: linux-next: build error from iio_simple_dummy_buffer.c
References: <20111028112910.GB14881@longonot.mountain> <4EAE8574.2050900@cam.ac.uk> <20111031113820.GB15494@mwanda>
In-Reply-To: <20111031113820.GB15494@mwanda>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/31/2011 11:38 AM, Dan Carpenter wrote:
> On Mon, Oct 31, 2011 at 11:24:36AM +0000, Jonathan Cameron wrote:
>> On 10/28/11 12:29, Dan Carpenter wrote:
>>> I get a compile error in linux-next:
>>> 
>>> CC [M]  drivers/staging/iio/iio_simple_dummy_buffer.o 
>>> drivers/staging/iio/iio_simple_dummy_buffer.c: In function
>>> ‘iio_simple_dummy_configure_buffer’: 
>>> drivers/staging/iio/iio_simple_dummy_buffer.c:154:18: error:
>>> ‘THIS_MODULE’ undeclared (first use in this function) 
>>> drivers/staging/iio/iio_simple_dummy_buffer.c:154:18: note:
>>> each undeclared identifier is reported only once for each
>>> function it appears in make[1]: ***
>>> [drivers/staging/iio/iio_simple_dummy_buffer.o] Error 1 make:
>>> *** [drivers/staging/iio/iio_simple_dummy_buffer.o] Error 2
>>> 
>>> We could just include <linux/module.h> I guess?
>> Yup, my bad.  Do you want to do the patch, or shall I do it and 
>> credit it to you?
> 
> Do no work and collect a Reported-by is always prefered.  :)
Got fixed by
8e336a722bb234f9d7805647e0290f2a397ca04d
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJOt/TxAAoJEFSFNJnE9BaIdlwP/0oEbaKms5Ly/Xnhk6Gvd8dG
EJINGtoeMMIRzbTDMX3t+72TX/epKOq/rMy7HOdNrUb+vGzraGyAHIigadqH8k7u
/t8h1GEpUG4EZ932ki5Xa/ZaEIoHkbHLkSNMO48CzbwKrGix3T90TDpXkFP3CaMp
+2p74KZIpE++aeeGuZ81dcCsOZ2RAjgaE4LVzEGecO9vaThLLbEr644Hx/gYGqEZ
OY5l6/AmRppk7bzaU33i6FdcfXaLbhfElG8A5CpDp0362NPp7pb8YesbOMAo97Fd
RjP87LYyD790OLs0Ek6o//qppjXgQopt5bp+u/5hrtVRuojMi/DeyTmg+ADs4Sr6
UbGsC105gAxdsoQN86SA7AIqVU1SYJ4k4ZuiopB4DaheX2G7AIrg4ODcbCZWW8VZ
G0ubHLKmW00kZKFS3DQJwsegmK/oQ4Det766EdmNvOQL/eLqrbr4SAsk3V5d+jHR
NuIC7IoVFUVzzyQK4XmlclVWYO8+EfPaZHmwjJbrtJvCimGW9b4lVaM2jaEdrLg4
n4Gt9GLQwujbWllse0EITCuTpAopqPs1akpDIb04v08t/3r7AbIvEFinqIm5aihR
SloWRrpw4sjy0HOozO8f5CyfltvXnkMKJhrliQRQpO1Ma+mYfLfA8aPRxZzydFwm
JPDVtEuAv3qw0JO4Gnkw
=B527
-----END PGP SIGNATURE-----
