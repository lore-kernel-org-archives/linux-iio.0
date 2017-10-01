Return-Path: <SRS0=0fI7=BA=onstation.org=masneyb@kernel.org>
Date: Sun, 1 Oct 2017 06:58:17 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: Re: [PATCH 3/3] staging: iio: tsl2x7x: migrate *_thresh_period sysfs
 attributes to iio_event_spec
Message-ID: <20171001105817.salu4ymwgg4jrvqu@073846331c0b>
References: <20170930010921.15447-1-masneyb@onstation.org>
 <20170930010921.15447-4-masneyb@onstation.org>
 <20171001111446.75f3d7cf@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171001111446.75f3d7cf@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 01, 2017 at 11:14:46AM +0100, Jonathan Cameron wrote:
> On Fri, 29 Sep 2017 21:09:21 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > The sysfs attributes in_intensity0_thresh_period and
> > in_proximity0_thresh_period are currently directly created by the driver.
> > This patch migrates the creation of these sysfs attributes from the driver
> > to using the IIO core via iio_event_spec.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> 
> One question down the end about whether we should be using IIO_EV_DIR_EITHER
> rather than IIO_EV_DIR_NONE
> 
> NONE is only really for thing where a direction makes not sense rather
> than to remove the direction be specified for a particular element.
> 
> Otherwise looks good.  I'd just have changed this, but wasn't sure if
> there was deeper logic behind your choice that I was missing!

There wasn't any deeper logic to this. :) I'll test it with
IIO_EV_DIR_EITHER and send v2 with my next batch of cleanups unless you
change it before then.

Thanks,

Brian
