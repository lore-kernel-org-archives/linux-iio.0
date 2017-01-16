Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36716 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdAPSMO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 13:12:14 -0500
Date: Mon, 16 Jan 2017 10:10:38 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: "Andrew F. Davis" <afd@ti.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: health: afe4403: retrieve a valid iio_dev in
 suspend/resume
Message-ID: <20170116181036.GA2739@d830.WORKGROUP>
References: <20170115035141.GA19547@d830.WORKGROUP>
 <9fc37bb7-0a0c-cf68-51e5-c91d096262d7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9fc37bb7-0a0c-cf68-51e5-c91d096262d7@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 16, 2017 at 10:38:27AM -0600, Andrew F. Davis wrote:
> On 01/14/2017 09:51 PM, Alison Schofield wrote:
> > The suspend/resume functions were using dev_to_iio_dev() to get
> > the iio_dev. That only works on IIO dev's.  Replace it with spi
> > functions to get the correct iio_dev.
> > 
> > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> 
> Was this found with an automated tool? If not, it might be nice to have
> a Coccinelle style check for this. Anyway for this and the afe4404
> version patch:
> 
> Acked-by: Andrew F. Davis <afd@ti.com>
> 
Hi Andrew,

Just caught my eye while looking at these drivers for another reason:
they popped up in a cocci scan looking for drivers with regmap and dev
struct in global data. The dev struct may be redundant since it
can be retrieved from regmap.  I'm going to look at that a bit further
and send a patch if appropriate.

Back to dev_to_iio_dev...it's a case of history repeating itself, but
not so often anymore.  I grep'd one more that I'll patch.  So, although
it appears close to extinction, a cocci check would be great.  It would
be even more valuble if worked with a more general check of the IIO
conversion/naming functions that are ripe for misuse.

I'll propose this as an intern task.

If anyone has read this far and wants to chime in with their favorite
misused funcs to add to the todo list...please do.

thanks,
alisons

> > ---
> >  drivers/iio/health/afe4403.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> > index 9a08146..6bb23a4 100644
> > --- a/drivers/iio/health/afe4403.c
> > +++ b/drivers/iio/health/afe4403.c
> > @@ -422,7 +422,7 @@ MODULE_DEVICE_TABLE(of, afe4403_of_match);
> >  
> >  static int __maybe_unused afe4403_suspend(struct device *dev)
> >  {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
> >  	struct afe4403_data *afe = iio_priv(indio_dev);
> >  	int ret;
> >  
> > @@ -443,7 +443,7 @@ static int __maybe_unused afe4403_suspend(struct device *dev)
> >  
> >  static int __maybe_unused afe4403_resume(struct device *dev)
> >  {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
> >  	struct afe4403_data *afe = iio_priv(indio_dev);
> >  	int ret;
> >  
> > 
