Return-Path: <groeck@ericsson.com>
Date: Wed, 5 Oct 2011 02:40:09 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Device-drivers-devel@blackfin.uclinux.org" <Device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] staging:iio:adc:ad7314 removal. Supported via hwmon.
Message-ID: <20111005094009.GA14989@ericsson.com>
References: <1317378054-9511-1-git-send-email-jic23@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D59177146E7343656@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E7343656@LIMKCMBX1.ad.analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 05, 2011 at 04:39:01AM -0400, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-09-30:
> > Driver ported over to hwmon where it fits much better.
> >
> > Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> 
> > ---
> > Technically there is a slight loss of functionality in the hwmon
> > driver (no power down mode).
> >
> > Otherwise, lets clear this one out.
> >
> > 3 more to go on my removal list ;)
> > adt7310, adt7410 and adt75.
> >

Just noticed this part. ADT75 is the Analog version of LM75. 
Any reason not to use the standard LM75 driver instead ?

On a side note, the iio adt75 driver won't work properly if oneshot is configured.
I'll leave it to the readers to figure out why ;).

Regarding the power down mode, shouldn't this be supported using the standard 
suspend/resume API with CONFIG_PM ? Or does iio have a parallel mechanism ?

Thanks,
Guenter
