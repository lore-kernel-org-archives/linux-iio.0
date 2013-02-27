Return-Path: <chrismicali@gmail.com>
Date: Wed, 27 Feb 2013 14:32:46 -0500
From: Chris Micali <chrismicali@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
 "=?utf-8?Q?linux-iio=40vger.kernel.org?=" <linux-iio@vger.kernel.org>
Message-ID: <5CCB32D4B146494F902390C27F8216A8@gmail.com>
In-Reply-To: <512E55AA.6050203@metafoo.de>
References: <26387F1A648A4D3D9BB4142C4F0AAE98@gmail.com>
 <512E2F31.8000604@metafoo.de>
 <B42F83EDFE8B4D2D8D46B6241B49B4E8@gmail.com>
 <512E3592.4020702@metafoo.de>
 <4AEA8015FE824807B3CF62B7B35FC5D3@gmail.com>
 <512E43A9.4090301@metafoo.de>
 <5277B88AB1FF4E6A83920766C0BE13F7@gmail.com>
 <512E5054.8030905@kernel.org> <512E55AA.6050203@metafoo.de>
Subject: Re: IIO Drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Guys, =20

Thanks a lot for the help=21  I finally tracked down issues, it was a com=
bination of a few things:

1. The .channel had to be 0, not 1 in the driver (scan=5Findex didn't mat=
ter)
2. 1 or more scan=5Felements have to be enabled as you mentioned
2. When echoing into the sysfs files it has to have a space after the num=
ber (cat 1 > in=5Fvoltage0=5Fen and not cat 1>in=5Fvo=E2=80=A6)  (duh=21)=

3. The generic=5Fbuffer.c program had a few bugs in it causing crashes.  =
I updated the iio=5Futils.h to a newer version I found here: https://gith=
ub.com/analogdevicesinc/iio-oscilloscope and then made a few modification=
s (the newer iio=5Futils did not parse a few things right in the channel =
details like bigendian/littleendian)

So generic=5Fbuffer is now correctly sampling (although it crashes after =
a couple, it's probably another iio=5Futils issue)

Thanks=21=21

-chris


On Wednesday, =46ebruary 27, 2013 at 1:51 PM, Lars-Peter Clausen wrote:

> On 02/27/2013 07:28 PM, Jonathan Cameron wrote:
> > On 02/27/2013 05:36 PM, Chris Micali wrote:
> > > lars, =20
> > > =20
> > > I was under the impression that flag gets added automatically by ii=
o=5Ftriggered=5Fbuffer=5Fsetup (industrialiio-triggers.c:77) - I actually=
 am now able to enable the scan=5Felement after changing my channel .chan=
nel and .scan=5Findex to 0 (trying to match exactly the other drivers.)
> =20
> Yea, you are right I missed the iio=5Ftriggered=5Fbuffer=5Fsetup part.
> =20
> > Strange, scan=5Findex should have defaulted to zero and the .channel =
value shouldn't have mattered
> > for buffered reads (just effects naming). Might have caused issues wi=
th userspace expecting a channel 0
> > though...
> =20
> =20
> =20
> I guess the scan=5Findex had nothing to do with this, but I suggested t=
o set
> scan=5Felements/in=5Fvoltage0=5Fen to 1, so this clearly wouldn't have =
worked with
> .channel being 1.
> =20
> > =20
> > > When i run general=5Fbuffer (from the docs dir) with that scan elem=
ent enabled it can no longer read the trigger (Could not open /trigger/cu=
rrent=5Ftrigger =46ailed to write current=5Ftrigger file) - this succeeds=
 if that scan=5Felement is not enabled. =20
> =20
> You can't change the trigger if the buffer is currently enabled. Make s=
ure that
> he buffer is disabled (check the buffer/enable attribute).
> =20
> - Lars
> u
