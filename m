Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52406 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbbDINNW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 09:13:22 -0400
Message-ID: <55267AEC.8000500@kernel.org>
Date: Thu, 09 Apr 2015 14:13:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
CC: Richard Weinberger <richard@nod.at>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] iio: dht11: Use new function ktime_get_resolution_ns()
References: <1428405156-6761-1-git-send-email-harald@ccbib.org> <1428405156-6761-3-git-send-email-harald@ccbib.org>
In-Reply-To: <1428405156-6761-3-git-send-email-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/15 12:12, Harald Geyer wrote:
> This cleans up the most ugly workaround in this driver. There are no
> functional changes yet in the decoding algorithm, but we improve the
> following things:
>  * Get rid of spurious warning messages on systems with fast HRTIMER.
>  * If the clock is not fast enough for decoding to work, we give
>    up immediately.
>  * In that case we return EAGAIN instead of EIO, so it's easier to
>    discriminate causes of failure.
> 
> Returning EAGAIN is somewhat controversial: It's technically correct
> as a faster clock might become available. OTOH once all clocks are
> enabled this is a permanent error. There is no ECLOCKTOOSLOW error
> code.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
Looks good to me.  Will wait for comments on the first patch though
before taking this... clearly that one will need a few acks if I take
it through IIO!

Jonathan
> ---
> changes since V1:
> call ktime_get_xxx() functions directly instead of using the wrappers
> of the iio subsystem.
> 
>  drivers/iio/humidity/dht11.c |   42 ++++++++++++++++++++++--------------------
>  1 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 7d79a1a..4cb25dc 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -33,6 +33,7 @@
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
> +#include <linux/timekeeping.h>
>  
>  #include <linux/iio/iio.h>
>  
> @@ -87,23 +88,11 @@ static unsigned char dht11_decode_byte(int *timing, int threshold)
>  	return ret;
>  }
>  
> -static int dht11_decode(struct dht11 *dht11, int offset)
> +static int dht11_decode(struct dht11 *dht11, int offset, int timeres)
>  {
> -	int i, t, timing[DHT11_BITS_PER_READ], threshold,
> -		timeres = DHT11_SENSOR_RESPONSE;
> +	int i, t, timing[DHT11_BITS_PER_READ], threshold;
>  	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
>  
> -	/* Calculate timestamp resolution */
> -	for (i = 1; i < dht11->num_edges; ++i) {
> -		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
> -		if (t > 0 && t < timeres)
> -			timeres = t;
> -	}
> -	if (2*timeres > DHT11_DATA_BIT_HIGH) {
> -		pr_err("dht11: timeresolution %d too bad for decoding\n",
> -			timeres);
> -		return -EIO;
> -	}
>  	threshold = DHT11_DATA_BIT_HIGH / timeres;
>  	if (DHT11_DATA_BIT_LOW/timeres + 1 >= threshold)
>  		pr_err("dht11: WARNING: decoding ambiguous\n");
> @@ -126,7 +115,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
>  	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
>  		return -EIO;
>  
> -	dht11->timestamp = iio_get_time_ns();
> +	dht11->timestamp = ktime_get_real_ns();
>  	if (hum_int < 20) {  /* DHT22 */
>  		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
>  					((temp_int & 0x80) ? -100 : 100);
> @@ -154,7 +143,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
>  
>  	/* TODO: Consider making the handler safe for IRQ sharing */
>  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> -		dht11->edges[dht11->num_edges].ts = iio_get_time_ns();
> +		dht11->edges[dht11->num_edges].ts = ktime_get_real_ns();
>  		dht11->edges[dht11->num_edges++].value =
>  						gpio_get_value(dht11->gpio);
>  
> @@ -170,10 +159,22 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  			int *val, int *val2, long m)
>  {
>  	struct dht11 *dht11 = iio_priv(iio_dev);
> -	int ret;
> +	int ret, timeres;
>  
>  	mutex_lock(&dht11->lock);
> -	if (dht11->timestamp + DHT11_DATA_VALID_TIME < iio_get_time_ns()) {
> +	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
> +		timeres = ktime_get_resolution_ns();
> +		if (DHT11_DATA_BIT_HIGH < 2*timeres) {
> +			dev_err(dht11->dev, "timeresolution %dns too low\n",
> +						timeres);
> +			/* In theory a better clock could become available
> +			 * at some point ... and there is no error code
> +			 * that really fits better.
> +			 */
> +			ret = -EAGAIN;
> +			goto err;
> +		}
> +
>  		reinit_completion(&dht11->completion);
>  
>  		dht11->num_edges = 0;
> @@ -208,7 +209,8 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  		ret = dht11_decode(dht11,
>  				dht11->num_edges == DHT11_EDGES_PER_READ ?
>  					DHT11_EDGES_PREAMBLE :
> -					DHT11_EDGES_PREAMBLE - 2);
> +					DHT11_EDGES_PREAMBLE - 2,
> +				timeres);
>  		if (ret)
>  			goto err;
>  	}
> @@ -274,7 +276,7 @@ static int dht11_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	dht11->timestamp = iio_get_time_ns() - DHT11_DATA_VALID_TIME - 1;
> +	dht11->timestamp = ktime_get_real_ns() - DHT11_DATA_VALID_TIME - 1;
>  	dht11->num_edges = -1;
>  
>  	platform_set_drvdata(pdev, iio);
> 

