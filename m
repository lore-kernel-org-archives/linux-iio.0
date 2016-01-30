Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54066 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309AbcA3Rua (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 12:50:30 -0500
Subject: Re: [PATCH] iio: dht11: Use boottime
To: Abhilash Jindal <klock.android@gmail.com>,
	linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Harald Geyer <harald@ccbib.org>
References: <1453934762-6290-1-git-send-email-klock.android@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACF7E4.7040603@kernel.org>
Date: Sat, 30 Jan 2016 17:50:28 +0000
MIME-Version: 1.0
In-Reply-To: <1453934762-6290-1-git-send-email-klock.android@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/16 22:46, Abhilash Jindal wrote:
> Wall time obtained from ktime_get_real_ns is susceptible to sudden jumps due to
> user setting the time or due to NTP.  Boot time is constantly increasing time
> better suited for comparing two timestamps.
> 
> Signed-off-by: Abhilash Jindal <klock.android@gmail.com>
Seems sensible to me, but would like Richard / Harald to take a quick
look before I apply it.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/dht11.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 1165b1c..cfc5a05 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -117,7 +117,7 @@ static int dht11_decode(struct dht11 *dht11, int offset, int timeres)
>  	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
>  		return -EIO;
>  
> -	dht11->timestamp = ktime_get_real_ns();
> +	dht11->timestamp = ktime_get_boot_ns();
>  	if (hum_int < 20) {  /* DHT22 */
>  		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
>  					((temp_int & 0x80) ? -100 : 100);
> @@ -145,7 +145,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
>  
>  	/* TODO: Consider making the handler safe for IRQ sharing */
>  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> -		dht11->edges[dht11->num_edges].ts = ktime_get_real_ns();
> +		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
>  		dht11->edges[dht11->num_edges++].value =
>  						gpio_get_value(dht11->gpio);
>  
> @@ -164,7 +164,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  	int ret, timeres;
>  
>  	mutex_lock(&dht11->lock);
> -	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
> +	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boot_ns()) {
>  		timeres = ktime_get_resolution_ns();
>  		if (DHT11_DATA_BIT_HIGH < 2 * timeres) {
>  			dev_err(dht11->dev, "timeresolution %dns too low\n",
> @@ -279,7 +279,7 @@ static int dht11_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	dht11->timestamp = ktime_get_real_ns() - DHT11_DATA_VALID_TIME - 1;
> +	dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME - 1;
>  	dht11->num_edges = -1;
>  
>  	platform_set_drvdata(pdev, iio);
> 

