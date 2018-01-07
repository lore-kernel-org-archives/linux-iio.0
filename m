Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754072AbeAGRRr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jan 2018 12:17:47 -0500
Date: Sun, 7 Jan 2018 17:17:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: George Edward Bulmer <gebulmer@googlemail.com>,
        gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, masneyb@onstation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: light: Add breaks to lengthy lines
Message-ID: <20180107171742.6b892736@archlinux>
In-Reply-To: <1515343347.8292.1.camel@perches.com>
References: <20180107150801.21617-1-gebulmer@googlemail.com>
        <20180107162848.37108f96@archlinux>
        <1515343347.8292.1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 07 Jan 2018 08:42:27 -0800
Joe Perches <joe@perches.com> wrote:

> On Sun, 2018-01-07 at 16:28 +0000, Jonathan Cameron wrote:
> > On Sun,  7 Jan 2018 15:08:01 +0000
> > George Edward Bulmer <gebulmer@googlemail.com> wrote:
> >   
> > > This fixes three instances of checkpatch warning:
> > > WARNING: line over 80 characters
> > > 
> > > Signed-off-by: George Edward Bulmer <gebulmer@googlemail.com>  
> > 
> > Applied, thanks,  
> 
> I believe these are examples of long line conversions
> that should not be applied.

On this one I disagree. The line breaks don't hurt readability
so aren't a problem.  The benefit is admittedly small, however
we are adding churn in a fairly safe place - this stuff rarely
changes.

> 
> Most of the problem here is the very long identifier naming.
> 57 character identifiers are pretty unnecessary.

The long line is because the name is encoding a very specific thing
and personally I would rather not have to guess what a shorter abbreviation
meant for the cost of saving a few characters in a filename.

Of course, we could deliberately use a different name for the sysfs
file from the value used for the identifier in the code, but that
would result in complexity just to reduce the line length.

This particular one is close to the most pathological case in the IIO
ABI though :)

It is possible to change to the code constructed version of the same
thing, but that's a rather more involved change and one we haven't
commonly done.  (using the .read_avail callbacks in IIO).

Jonathan

> 
> > Jonathan  
> > > ---
> > >  drivers/staging/iio/light/tsl2x7x.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> > > index 42ed9c015aaf..126e11530ce0 100644
> > > --- a/drivers/staging/iio/light/tsl2x7x.c
> > > +++ b/drivers/staging/iio/light/tsl2x7x.c
> > > @@ -1441,7 +1441,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
> > >  
> > >  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> > >  	&dev_attr_in_illuminance0_calibscale_available.attr,
> > > -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> > > +	&iio_const_attr_in_illuminance0_integration_time_available
> > > +		.dev_attr.attr,
> > >  	&dev_attr_in_illuminance0_target_input.attr,
> > >  	&dev_attr_in_illuminance0_calibrate.attr,
> > >  	&dev_attr_in_illuminance0_lux_table.attr,
> > > @@ -1455,7 +1456,8 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
> > >  
> > >  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> > >  	&dev_attr_in_illuminance0_calibscale_available.attr,
> > > -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> > > +	&iio_const_attr_in_illuminance0_integration_time_available
> > > +		.dev_attr.attr,
> > >  	&dev_attr_in_illuminance0_target_input.attr,
> > >  	&dev_attr_in_illuminance0_calibrate.attr,
> > >  	&dev_attr_in_illuminance0_lux_table.attr,
> > > @@ -1471,7 +1473,8 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
> > >  
> > >  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> > >  	&dev_attr_in_illuminance0_calibscale_available.attr,
> > > -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> > > +	&iio_const_attr_in_illuminance0_integration_time_available
> > > +		.dev_attr.attr,
> > >  	&dev_attr_in_illuminance0_target_input.attr,
> > >  	&dev_attr_in_illuminance0_calibrate.attr,
> > >  	&dev_attr_in_illuminance0_lux_table.attr,  
> > 
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

