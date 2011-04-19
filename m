Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:43632 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209Ab1DSNDf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Apr 2011 09:03:35 -0400
Message-ID: <4DAD889F.9060408@cam.ac.uk>
Date: Tue, 19 Apr 2011 14:05:35 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 2/2] IIO-onwards: ADC: AD7298: Use private data space
 from iio_allocate_device
References: <1303214170-10379-1-git-send-email-michael.hennerich@analog.com> <1303214170-10379-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303214170-10379-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/19/11 12:56, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Use private data space from iio_allocate_device
This is fine as is, but what about the following additional patch..
At some point I'd like to get rid of the explicit dev_data pointer
entirely.  Now I 'think' I've cleaned out all the uses of it in
here, but please do check it still works!

If you are happy with this, shall I just merge this one into
your patch?


[PATCH] staging:iio:ad7298: remove use of iio_dev->dev_data.

Also one small cleanup to avoid jumping backwards and forwards
between iio_dev and ad7298_state for no particular reason.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7298.h      |    4 ++--
 drivers/staging/iio/adc/ad7298_core.c |    5 ++---
 drivers/staging/iio/adc/ad7298_ring.c |    8 ++++----
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
index 7eb2c3b..628f5ad 100644
--- a/drivers/staging/iio/adc/ad7298.h
+++ b/drivers/staging/iio/adc/ad7298.h
@@ -54,11 +54,11 @@ struct ad7298_state {
 };
 
 #ifdef CONFIG_IIO_RING_BUFFER
-int ad7298_scan_from_ring(struct ad7298_state *st, long ch);
+int ad7298_scan_from_ring(struct iio_dev *indio_dev, long ch);
 int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7298_ring_cleanup(struct iio_dev *indio_dev);
 #else /* CONFIG_IIO_RING_BUFFER */
-static inline int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
+static inline int ad7298_scan_from_ring(struct iio_dev *indio_dev, long ch)
 {
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 8c0792b..442f48b 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -117,7 +117,7 @@ static int ad7298_read_raw(struct iio_dev *dev_info,
 			   long m)
 {
 	int ret;
-	struct ad7298_state *st = dev_info->dev_data;
+	struct ad7298_state *st = iio_priv(dev_info);
 	unsigned int scale_uv;
 
 	switch (m) {
@@ -127,7 +127,7 @@ static int ad7298_read_raw(struct iio_dev *dev_info,
 			if (chan->address == AD7298_CH_TEMP)
 				ret = -ENODEV;
 			else
-				ret = ad7298_scan_from_ring(st, chan->address);
+				ret = ad7298_scan_from_ring(dev_info, chan->address);
 		} else {
 			if (chan->address == AD7298_CH_TEMP)
 				ret = ad7298_scan_temp(st, val);
@@ -181,7 +181,6 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->dev_data = (void *)(st);
 	indio_dev->driver_module = THIS_MODULE;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad7298_channels;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index ad1f5b7..d0a0aeaaf 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -21,9 +21,9 @@
 
 #include "ad7298.h"
 
-int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
+int ad7298_scan_from_ring(struct iio_dev *dev_info, long ch)
 {
-	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	struct iio_ring_buffer *ring = dev_info->ring;
 	int ret;
 	u16 *ring_data;
 
@@ -59,7 +59,7 @@ error_ret:
  **/
 static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct ad7298_state *st = indio_dev->dev_data;
+	struct ad7298_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	size_t d_size;
 	int i, m;
@@ -121,7 +121,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct ad7298_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7298_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
 	__u16 buf[16];
-- 
1.7.3.4


> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/adc/ad7298.h      |    1 -
>  drivers/staging/iio/adc/ad7298_core.c |   68 ++++++++++++++++-----------------
>  drivers/staging/iio/adc/ad7298_ring.c |    2 +-
>  3 files changed, 34 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
> index 718e56a..7eb2c3b 100644
> --- a/drivers/staging/iio/adc/ad7298.h
> +++ b/drivers/staging/iio/adc/ad7298.h
> @@ -36,7 +36,6 @@ struct ad7298_platform_data {
>  };
>  
>  struct ad7298_state {
> -	struct iio_dev			*indio_dev;
>  	struct spi_device		*spi;
>  	struct regulator		*reg;
>  	size_t				d_size;
> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
> index ef670cf..8c0792b 100644
> --- a/drivers/staging/iio/adc/ad7298_core.c
> +++ b/drivers/staging/iio/adc/ad7298_core.c
> @@ -160,13 +160,13 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>  {
>  	struct ad7298_platform_data *pdata = spi->dev.platform_data;
>  	struct ad7298_state *st;
> -	int ret;
> +	int ret, regdone = 0;
> +	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
>  
> -	st = kzalloc(sizeof(*st), GFP_KERNEL);
> -	if (st == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
>  
>  	st->reg = regulator_get(&spi->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
> @@ -175,24 +175,18 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>  			goto error_put_reg;
>  	}
>  
> -	spi_set_drvdata(spi, st);
> +	spi_set_drvdata(spi, indio_dev);
>  
>  	st->spi = spi;
>  
> -	st->indio_dev = iio_allocate_device(0);
> -	if (st->indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_disable_reg;
> -	}
> -
> -	st->indio_dev->name = spi_get_device_id(spi)->name;
> -	st->indio_dev->dev.parent = &spi->dev;
> -	st->indio_dev->dev_data = (void *)(st);
> -	st->indio_dev->driver_module = THIS_MODULE;
> -	st->indio_dev->modes = INDIO_DIRECT_MODE;
> -	st->indio_dev->channels = ad7298_channels;
> -	st->indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
> -	st->indio_dev->read_raw = &ad7298_read_raw;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev_data = (void *)(st);
> +	indio_dev->driver_module = THIS_MODULE;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad7298_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
> +	indio_dev->read_raw = &ad7298_read_raw;
>  
>  	/* Setup default message */
>  
> @@ -217,41 +211,44 @@ static int __devinit ad7298_probe(struct spi_device *spi)
>  		st->int_vref_mv = AD7298_INTREF_mV;
>  	}
>  
> -	ret = ad7298_register_ring_funcs_and_init(st->indio_dev);
> +	ret = ad7298_register_ring_funcs_and_init(indio_dev);
>  	if (ret)
> -		goto error_free_device;
> +		goto error_disable_reg;
>  
> -	ret = iio_device_register(st->indio_dev);
> +	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_device;
> +		goto error_disable_reg;
> +	regdone = 1;
>  
> -	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
> +	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
>  					  &ad7298_channels[1], /* skip temp0 */
>  					  ARRAY_SIZE(ad7298_channels) - 1);
>  	if (ret)
>  		goto error_cleanup_ring;
> +
>  	return 0;
>  
>  error_cleanup_ring:
> -	ad7298_ring_cleanup(st->indio_dev);
> -	iio_device_unregister(st->indio_dev);
> -error_free_device:
> -	iio_free_device(st->indio_dev);
> +	ad7298_ring_cleanup(indio_dev);
>  error_disable_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
>  error_put_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_put(st->reg);
> -	kfree(st);
> -error_ret:
> +
> +	if (regdone)
> +		iio_device_unregister(indio_dev);
> +	else
> +		iio_free_device(indio_dev);
> +
>  	return ret;
>  }
>  
>  static int __devexit ad7298_remove(struct spi_device *spi)
>  {
> -	struct ad7298_state *st = spi_get_drvdata(spi);
> -	struct iio_dev *indio_dev = st->indio_dev;
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ad7298_state *st = iio_priv(indio_dev);
>  
>  	iio_ring_buffer_unregister(indio_dev->ring);
>  	ad7298_ring_cleanup(indio_dev);
> @@ -260,7 +257,8 @@ static int __devexit ad7298_remove(struct spi_device *spi)
>  		regulator_disable(st->reg);
>  		regulator_put(st->reg);
>  	}
> -	kfree(st);
> +	iio_device_unregister(indio_dev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
> index 19e6916..52363ca 100644
> --- a/drivers/staging/iio/adc/ad7298_ring.c
> +++ b/drivers/staging/iio/adc/ad7298_ring.c
> @@ -23,7 +23,7 @@
>  
>  int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
>  {
> -	struct iio_ring_buffer *ring = st->indio_dev->ring;
> +	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
>  	int ret;
>  	u16 *ring_data;
>  

