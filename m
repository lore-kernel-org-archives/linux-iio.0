Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeGURYx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 13:24:53 -0400
Date: Sat, 21 Jul 2018 17:31:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180721173131.6be1579f@archlinux>
In-Reply-To: <20180721153607.GA11127@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
        <20180721161934.75066d97@archlinux>
        <20180721153607.GA11127@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Jul 2018 21:06:08 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> > Hi Himanshu,
> > 
> > This was close to the point where I'd take it and make the few remaining
> > fixes myself.  I'm still bothered however by the fact the casts in the
> > various calibration functions are still not all justified so please take
> > another look at that.  Frankly it looks like the original author
> > threw in casts because they didn't want to have to think about which ones
> > actually do anything!  
> 
> Ok. I will remove the ones mentioned below.
> 
> > Few other things to fix up for v5 as well.  
> 
> I will send the fixes in an hour.
> 
> > Jonathan
> > 
> >   
> > > +#define   BME680_NB_CONV_MASK			GENMASK(3, 0)
> > > +#define	    BME680_RUN_GAS_EN_BIT		BIT(4)  
> > 
> > odd looking spacing above.  
> 
> I don't know why this is showing like that in the diff output, but I
> have checked the code by apllying to my test tree(git am <patch>) and
> there was no such spurious spacing!

You have a tab after the #define in this one instance - in the others it's
all spaces (as it should be)

...
