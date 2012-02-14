Return-Path: <danny.kukawka@bisect.de>
From: Danny Kukawka <danny.kukawka@bisect.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] adis16080: fix compiler -Wuninitialized
Date: Tue, 14 Feb 2012 18:36:59 +0100
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
References: <1329230136-26576-1-git-send-email-danny.kukawka@bisect.de> <20120214150455.GN4141@mwanda> <4F3A7B29.10603@cam.ac.uk>
In-Reply-To: <4F3A7B29.10603@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201202141837.01552.danny.kukawka@bisect.de>
List-ID: <linux-iio@vger.kernel.org>

On Dienstag, 14. Februar 2012, Jonathan Cameron wrote:
> On 2/14/2012 3:04 PM, Dan Carpenter wrote:
> > On Tue, Feb 14, 2012 at 03:35:36PM +0100, Danny Kukawka wrote:
> >> Fix for:
> >> drivers/staging/iio/gyro/adis16080_core.c: In function
> >>    =E2=80=98adis16080_read_raw=E2=80=99:
> >> drivers/staging/iio/gyro/adis16080_core.c:99:8: warning: =E2=80=98ut=
=E2=80=99
> >>    may be used uninitialized in this function [-Wuninitialized]
> >>
> >> Initialize ut and change error handling from adis16080_read_raw().
> >>
> >> Signed-off-by: Danny Kukawka<danny.kukawka@bisect.de>
> >> ---
> >>   drivers/staging/iio/gyro/adis16080_core.c |    4 ++--
> >>   1 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/iio/gyro/adis16080_core.c
> >> b/drivers/staging/iio/gyro/adis16080_core.c index 1815490..e0b2a29
> >> 100644
> >> --- a/drivers/staging/iio/gyro/adis16080_core.c
> >> +++ b/drivers/staging/iio/gyro/adis16080_core.c
> >> @@ -82,7 +82,7 @@ static int adis16080_read_raw(struct iio_dev
> >> *indio_dev, long mask)
> >>   {
> >>   	int ret =3D -EINVAL;
> >> -	u16 ut;
> >> +	u16 ut =3D 0;
> >>   	/* Take the iio_dev status lock */
> >>
> >>   	mutex_lock(&indio_dev->mlock);
> >> @@ -94,7 +94,7 @@ static int adis16080_read_raw(struct iio_dev
> >> *indio_dev, if (ret<  0)
> >>   			break;
> >>   		ret =3D adis16080_spi_read(indio_dev,&ut);
> >> -		if (ret<  0)
> >> +		if (ret)
> >>   			break;
> >
> > Either one of these changes would silence the warning from gcc
> > (which is a false positive).  I would keep the "ut =3D 0;" change and
> > leave the error handling the same.  That way we check for less than
> > zero consistently instead of checking some for non-zero and some for
> > less than zero.
>
> Agreed.  I've always been lazy on this one as it was a false positive,
> but might as well
> get rid of it...

I'm okay with 'ut =3D 0;'.=20

I guess it's hard for gcc to find out that spi_read() will only return 0 or=
 a=20
negative value in error case. That's why gcc may assume 'ut' could be used=
=20
initialized since adis16080_spi_read() may return with a value > 0.

And in case spi_read() or one of the functions behind would change it could=
=20
cause an initialized 'ut'. The code may should always check for "ret !=3D 0=
" as=20
already done in some other places (in similar cases) to be save.

Danny
