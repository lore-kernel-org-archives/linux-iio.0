Return-Path: <SRS0=ABY1=LK=perches.com=joe@kernel.org>
Message-ID: <0c3d98ffd218e455eb864fdfd7715af19d43230c.camel@perches.com>
Subject: Re: [PATCH 1/4] iio: gyro: add support for fxas21002c
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>, Afonso Bordado
 <afonsobordado@az8.co>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Date: Mon, 27 Aug 2018 13:50:08 -0700
In-Reply-To: <20180827180805.7d4b9f4e@archlinux>
References: <20180825211910.22929-1-afonsobordado@az8.co>
	 <20180827180805.7d4b9f4e@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2018-08-27 at 18:08 +0100, Jonathan Cameron wrote:
> On Sat, 25 Aug 2018 22:19:07 +0100
> Afonso Bordado <afonsobordado@az8.co> wrote:
> 
> > FXAS21002C is a 3 axis gyroscope with integrated temperature sensor
> > 
> > Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> 
> Hi,
> 
> Driver is pretty clean so only a few minor comments inline.
> If we were late in a cycle I'd probably just have taken it and fixed up
> but as we have lots of time and I'm inherently lazy I'll let you do a v2 :)
> 
> Good job, thanks!
[]
> > diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
[]
> /* ... */
> 
> Please run checkpatch as IIRC it complains about this.

Running checkpatch and paying attention to what it bleats
is generally a good idea, as long as its bleats aren't
mindlessly followed.

And c99 style // comments have been ignored since:

commit dadf680de3c2eb4cba9840619991eda0cfe98778
Author: Joe Perches <joe@perches.com>
Date:   Tue Aug 2 14:04:33 2016 -0700

    checkpatch: allow c99 style // comments
    
    Sanitise the lines that contain c99 comments so that the error doesn't
    get emitted.
