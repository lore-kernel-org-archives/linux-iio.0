Return-Path: <srinidhi.kasagar@stericsson.com>
Date: Tue, 17 Apr 2012 11:31:24 +0530
From: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] staging: iio: add lsm303dlh magnetometer driver
Message-ID: <20120417060123.GA923@bnru02>
References: <1333971244-10684-1-git-send-email-srinidhi.kasagar@stericsson.com>
 <4F834BE1.2010107@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4F834BE1.2010107@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Apr 09, 2012 at 22:51:45 +0200, Jonathan Cameron wrote:
> On 04/09/2012 12:34 PM, Srinidhi KASAGAR wrote:
> > Add support for lsm303dlh magnetometer device.
> >
> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Hi Srinidhi,
> 
> Basically a sound driver with a few easy bits to fix.
> 
> Few nitpicks and the error paths in probe need another look.
> 
Hi Jonathan,

[...]

> 
> We have the old question of _range attributes as well and their
> interaction with scale.  I've always been dubious about these,
> mainly because it's not entirely obvious how to format the
> weirder general cases.  Do you have a pressing need for range
> or could it just be dropped in favour of allowing write for the
> scale parameter? If nothing else, scale is available for inkernel
> users and range isn't.
If I need to drop range in favor of allowing write access for scale
as you mentioned above, do you mean to implement _write_raw with
IIO_CHAN_INFO_CALIBSCALE abi? Does it mean that user should be able
to pass the scale factors so that driver interprets it to the
corresponding range? 

Srinidhi
