Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-relay42-dus.antispameurope.com ([94.100.134.242]:60818 "EHLO
	mx-relay42-dus.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752311AbaKJKED (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Nov 2014 05:04:03 -0500
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: gyro: itg3200: add suspend/resume support.
Date: Mon, 10 Nov 2014 10:57:30 +0100
Cc: NeilBrown <neilb@suse.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	GTA04 owners <gta04-owner@goldelico.com>,
	"chr >> Doug Anderson" <dianders@chromium.org>,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>,
	"christian.strobel@iis.fraunhofer.de >> Christian Strobel"
	<christian.strobel@iis.fraunhofer.de>
References: <20141108111833.3829480c@notabene.brown> <545E0401.2000505@kernel.org>
In-Reply-To: <545E0401.2000505@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Message-Id: <201411101057.30228.manuel.stahl@iis.fraunhofer.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Looks good to me.

Regards,
Manuel Stahl

Am Samstag, 8. November 2014, 12:52:33 schrieb Jonathan Cameron:
> On 08/11/14 00:18, NeilBrown wrote:
> > 
> > 
> > Unless we put the device to sleep when not it use, it wastes
> > 6mA.
> > 
> > If the device is asleep on probe, the 'id' register
> > sometimes mis-reads - so reset first.  If the device responds
> > at all a command sent to the address, it is almost certainly
> > the correct device already.
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> Hi Neil,
> 
> Looks fine to me - but you should have cc'd a few people from
> the listed driver authors.  Will give them a few days to respond...
> 
> Jonathan
> > 
> > diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> > index 6a8020d48140..394667fb23f9 100644
> > --- a/drivers/iio/gyro/itg3200_core.c
> > +++ b/drivers/iio/gyro/itg3200_core.c
> > @@ -223,6 +223,7 @@ static int itg3200_initial_setup(struct iio_dev *indio_dev)
> >  	int ret;
> >  	u8 val;
> >  
> > +	ret = itg3200_reset(indio_dev);
> >  	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_ADDRESS, &val);
> >  	if (ret)
> >  		goto err_ret;
> > @@ -351,6 +352,35 @@ static int itg3200_remove(struct i2c_client *client)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_PM_SLEEP
> > +static int itg3200_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct itg3200 *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	dev_dbg(&st->i2c->dev, "suspend device");
> > +
> > +	ret = itg3200_write_reg_8(indio_dev,
> > +			ITG3200_REG_POWER_MANAGEMENT,
> > +			ITG3200_SLEEP);
> > +	return ret;
> > +}
> > +
> > +static int itg3200_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +
> > +	itg3200_reset(indio_dev);
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(itg3200_pm_ops, itg3200_suspend, itg3200_resume);
> > +#define ITG3200_PM_OPS (&itg3200_pm_ops)
> > +#else
> > +#define ITG3200_PM_OPS NULL
> > +#endif
> > +
> >  static const struct i2c_device_id itg3200_id[] = {
> >  	{ "itg3200", 0 },
> >  	{ }
> > @@ -361,6 +391,7 @@ static struct i2c_driver itg3200_driver = {
> >  	.driver = {
> >  		.owner  = THIS_MODULE,
> >  		.name	= "itg3200",
> > +		.pm	= ITG3200_PM_OPS,
> >  	},
> >  	.id_table	= itg3200_id,
> >  	.probe		= itg3200_probe,
> > 
> 
> 

