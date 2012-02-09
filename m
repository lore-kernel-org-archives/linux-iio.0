Return-Path: <jic23@kernel.org>
Message-ID: <4F3438A5.6050003@kernel.org>
Date: Thu, 09 Feb 2012 21:20:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 guenter.roeck@ericsson.com, khali@linux-fr.org,
 dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
 linus.walleij@linaro.org, maxime.ripard@free-electrons.com,
 thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
 w.sang@pengutronix.de, marek.vasut@gmail.com,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping
 and getting IIO channels.
References: <1327837614-24176-1-git-send-email-jic23@kernel.org> <1327837614-24176-2-git-send-email-jic23@kernel.org> <20120209181056.GA957@kroah.com> <4F3411BA.5070401@kernel.org> <20120209185754.GA10284@kroah.com> <20120209191509.GM3058@opensource.wolfsonmicro.com> <20120209191718.GA10999@kroah.com> <20120209192054.GN3058@opensource.wolfsonmicro.com>
In-Reply-To: <20120209192054.GN3058@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/09/2012 07:20 PM, Mark Brown wrote:
> On Thu, Feb 09, 2012 at 11:17:18AM -0800, Greg KH wrote:
>> On Thu, Feb 09, 2012 at 07:15:10PM +0000, Mark Brown wrote:
> 
>>> This is nothing to do with init ordering, it's all about the
>>> two devices finding each other at all.
> 
>> Ok, if that's all this is for, they why name it "iio in-kernel
>> logic"? That made me believe that this is something that is
>> needed if anyone who happens to want to use the iio interface
>> needs it.
> 
>> If it's just "iio discovery" then call it that :)
> 
> I think that's all due to the overall goal of the patch series -
> the original use case for IIO was purely for userspace users and
> what the patch series is doing is adding the ability to use IIO
> devices from within the kernel.
That was my thinking.  Happy to take suggestions for clearer naming!

Jonathan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPNDilAAoJEFSFNJnE9BaI4wMP/21QLUcAzWgrlK+Vv5c8TAvf
pXDQ2iZgtaA/JcTVpTh6VwI4cXJYI4Oq/MrokZaLJBS1avx9QEiyHjoXS8khLyi0
hKU0J5xgG61y6h/MMugqt06O4rIuuByOSuk7uWAvv9TN19ukVDsYG84Ct44XJeKb
MfOVPm/YDRpHMAOvWPgEGJAfa3CcYPTf6E5MBsjcx2+kLxkzvNwpA5LAw+nLwq+q
wEYNubsgp2U16S+Nf9Sqwhzzrg7UDbqOwWT/VkU1M9g5VtGcFYrAMhrnK36dTSXj
Rkl1o7UIW6tRWggIvQ9TInYS+PMybumdGNL3zjxJcTCfGoxeGlMH5mGsviCIMDrg
exDRyAoE6fiT6RxFe8OADwBuDunk5RQcZRq9LIC+lH68qq9n3FrqerCBue52yVL5
fzKgsQSlOfpvbSQPqGZh76xKSEXpANIJD8cLSaa6spO5QmwzK6hRtExWD84mtcgB
k7s+G9vEoHo7CeaLZbwdbsdk3CZ3+PXgtWDOhx6+e4JhIoIR7UneFhJBw6jlkSFf
9a4cr6rW48M4Vh8Z3u6rsMl+ZJbiD5LXfKNtGhmOKPGHtEsxYCuJk3HXZO+voE0q
44RlIO0ijt8bV0xJcxSWI3+ArIhHEN9bW/8Zx8ELUoFA+Rs29SUAlHhEL0XGoHKZ
H3RbDS7Cj9ji4gVxzocn
=hQ9x
-----END PGP SIGNATURE-----
