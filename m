Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:49561 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbaKDVmr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Nov 2014 16:42:47 -0500
Message-ID: <54594854.5000808@gmx.de>
Date: Tue, 04 Nov 2014 22:42:44 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: George McCollister <george.mccollister@gmail.com>,
	mranostay@gmail.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: as3935: Remove unnecessary semicolons
References: <1414770263-13146-1-git-send-email-george.mccollister@gmail.com> <1414770263-13146-2-git-send-email-george.mccollister@gmail.com>
In-Reply-To: <1414770263-13146-2-git-send-email-george.mccollister@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

George McCollister schrieb am 31.10.2014 16:44:
> Signed-off-by: George McCollister <george.mccollister@gmail.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/proximity/as3935.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 8349cc0..466aa43 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -95,7 +95,7 @@ static int as3935_read(struct as3935_state *st, unsigned int reg, int *val)
>  	*val = ret;
>  
>  	return 0;
> -};
> +}
>  
>  static int as3935_write(struct as3935_state *st,
>  				unsigned int reg,
> @@ -107,7 +107,7 @@ static int as3935_write(struct as3935_state *st,
>  	buf[1] = val;
>  
>  	return spi_write(st->spi, buf, 2);
> -};
> +}
>  
>  static ssize_t as3935_sensor_sensitivity_show(struct device *dev,
>  					struct device_attribute *attr,
> @@ -122,7 +122,7 @@ static ssize_t as3935_sensor_sensitivity_show(struct device *dev,
>  	val = (val & AS3935_AFE_MASK) >> 1;
>  
>  	return sprintf(buf, "%d\n", val);
> -};
> +}
>  
>  static ssize_t as3935_sensor_sensitivity_store(struct device *dev,
>  					struct device_attribute *attr,
> @@ -142,7 +142,7 @@ static ssize_t as3935_sensor_sensitivity_store(struct device *dev,
>  	as3935_write(st, AS3935_AFE_GAIN, val << 1);
>  
>  	return len;
> -};
> +}
>  
>  static IIO_DEVICE_ATTR(sensor_sensitivity, S_IRUGO | S_IWUSR,
>  	as3935_sensor_sensitivity_show, as3935_sensor_sensitivity_store, 0);
> @@ -214,7 +214,7 @@ err_read:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> -};
> +}
>  
>  static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
>  	.owner = THIS_MODULE,
> @@ -238,7 +238,7 @@ static void as3935_event_work(struct work_struct *work)
>  		dev_warn(&st->spi->dev, "noise level is too high");
>  		break;
>  	}
> -};
> +}
>  
>  static irqreturn_t as3935_interrupt_handler(int irq, void *private)
>  {
> @@ -417,7 +417,7 @@ unregister_trigger:
>  	iio_trigger_unregister(st->trig);
>  
>  	return ret;
> -};
> +}
>  
>  static int as3935_remove(struct spi_device *spi)
>  {
> @@ -429,7 +429,7 @@ static int as3935_remove(struct spi_device *spi)
>  	iio_trigger_unregister(st->trig);
>  
>  	return 0;
> -};
> +}
>  
>  static const struct spi_device_id as3935_id[] = {
>  	{"as3935", 0},
> 

