Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:53993 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753897AbeAGQmc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jan 2018 11:42:32 -0500
Message-ID: <1515343347.8292.1.camel@perches.com>
Subject: Re: [PATCH] staging: iio: light: Add breaks to lengthy lines
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>,
        George Edward Bulmer <gebulmer@googlemail.com>
Cc: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, masneyb@onstation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date: Sun, 07 Jan 2018 08:42:27 -0800
In-Reply-To: <20180107162848.37108f96@archlinux>
References: <20180107150801.21617-1-gebulmer@googlemail.com>
         <20180107162848.37108f96@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2018-01-07 at 16:28 +0000, Jonathan Cameron wrote:
> On Sun,  7 Jan 2018 15:08:01 +0000
> George Edward Bulmer <gebulmer@googlemail.com> wrote:
> 
> > This fixes three instances of checkpatch warning:
> > WARNING: line over 80 characters
> > 
> > Signed-off-by: George Edward Bulmer <gebulmer@googlemail.com>
> 
> Applied, thanks,

I believe these are examples of long line conversions
that should not be applied.

Most of the problem here is the very long identifier naming.
57 character identifiers are pretty unnecessary.

> Jonathan
> > ---
> >  drivers/staging/iio/light/tsl2x7x.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> > index 42ed9c015aaf..126e11530ce0 100644
> > --- a/drivers/staging/iio/light/tsl2x7x.c
> > +++ b/drivers/staging/iio/light/tsl2x7x.c
> > @@ -1441,7 +1441,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
> >  
> >  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> >  	&dev_attr_in_illuminance0_calibscale_available.attr,
> > -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> > +	&iio_const_attr_in_illuminance0_integration_time_available
> > +		.dev_attr.attr,
> >  	&dev_attr_in_illuminance0_target_input.attr,
> >  	&dev_attr_in_illuminance0_calibrate.attr,
> >  	&dev_attr_in_illuminance0_lux_table.attr,
> > @@ -1455,7 +1456,8 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
> >  
> >  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> >  	&dev_attr_in_illuminance0_calibscale_available.attr,
> > -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> > +	&iio_const_attr_in_illuminance0_integration_time_available
> > +		.dev_attr.attr,
> >  	&dev_attr_in_illuminance0_target_input.attr,
> >  	&dev_attr_in_illuminance0_calibrate.attr,
> >  	&dev_attr_in_illuminance0_lux_table.attr,
> > @@ -1471,7 +1473,8 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
> >  
> >  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> >  	&dev_attr_in_illuminance0_calibscale_available.attr,
> > -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> > +	&iio_const_attr_in_illuminance0_integration_time_available
> > +		.dev_attr.attr,
> >  	&dev_attr_in_illuminance0_target_input.attr,
> >  	&dev_attr_in_illuminance0_calibrate.attr,
> >  	&dev_attr_in_illuminance0_lux_table.attr,
> 
> 
