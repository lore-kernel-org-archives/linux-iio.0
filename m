Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33323 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcADLoD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 06:44:03 -0500
Subject: Re: [PATCH 2/3] iio: dht11: Simplify decoding algorithm
To: Harald Geyer <harald@ccbib.org>, linux-iio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.org>
References: <1451485605-3441-1-git-send-email-harald@ccbib.org>
 <1451485605-3441-2-git-send-email-harald@ccbib.org>
Cc: Richard Weinberger <richard@nod.at>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568A5B02.9010601@kernel.org>
Date: Mon, 4 Jan 2016 11:44:02 +0000
MIME-Version: 1.0
In-Reply-To: <1451485605-3441-2-git-send-email-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/15 14:26, Harald Geyer wrote:
> The new algorithm uses a 'one size fits em all' threshold, which should
> be easier to understand and debug. I believe there are no regressions
> compared to the old adaptive threshold algorithm. I don't remember why
> I chose the old algorithm when I initially wrote the driver.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
Hmm. Couple of trivial bits inline.

I'd like some tested-by's on this one if possible...

Such a 'fun' device ;)

Jonathan
> ---
>  drivers/iio/humidity/dht11.c | 64 +++++++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 1ca284a..cd1477d 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -50,12 +50,32 @@
>  #define DHT11_EDGES_PER_READ (2 * DHT11_BITS_PER_READ + \
>  			      DHT11_EDGES_PREAMBLE + 1)
>  
> -/* Data transmission timing (nano seconds) */
> +/*
> + * Data transmission timing:
> + * Data bits are encoded as pulse length (high time) on the data line.
> + * 0-bit: 22-30uS -- typically 26uS (AM2302)
> + * 1-bit: 68-75uS -- typically 70uS (AM2302)
> + * The acutal timings also depend on the properties of the cable, with
actual
> + * longer cables typically making pulses shorter.
> + *
> + * Our decoding depends on the time resolution of the system:
> + * timeres > 34uS ... don't know what a 1-tick pulse is
> + * 34uS > timeres > 30uS ... no problem (30kHz and 32kHz clocks)
> + * 30uS > timeres > 23uS ... don't know what a 2-tick pulse is
> + * timeres < 23uS ... no problem
> + *
> + * Luckily clocks in the 33-44kHz range are quite uncommon, so we can
> + * support most systems if the threshold for decoding a pulse as 1-bit
> + * is chosen carefully. If somebody really wants to support clocks around
> + * 40kHz, where this driver is most unreliable, there are two options.
> + * a) select an implementation using busy loop polling on those systems
> + * b) use the checksum to do some probabilistic decoding
> + */
>  #define DHT11_START_TRANSMISSION	18  /* ms */
> -#define DHT11_SENSOR_RESPONSE	80000
> -#define DHT11_START_BIT		50000
> -#define DHT11_DATA_BIT_LOW	27000
> -#define DHT11_DATA_BIT_HIGH	70000
> +#define DHT11_MIN_TIMERES	34000  /* ns */
> +#define DHT11_THRESHOLD		49000  /* ns */
> +#define DHT11_AMBIG_LOW		23000  /* ns */
> +#define DHT11_AMBIG_HIGH	30000  /* ns */
>  
>  struct dht11 {
>  	struct device			*dev;
> @@ -76,43 +96,39 @@ struct dht11 {
>  	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
>  };
>  
> -static unsigned char dht11_decode_byte(int *timing, int threshold)
> +static unsigned char dht11_decode_byte(char *bits)
>  {
>  	unsigned char ret = 0;
>  	int i;
>  
>  	for (i = 0; i < 8; ++i) {
>  		ret <<= 1;
> -		if (timing[i] >= threshold)
> +		if (bits[i])
>  			++ret;
>  	}
>  
>  	return ret;
>  }
>  
> -static int dht11_decode(struct dht11 *dht11, int offset, int timeres)
> +static int dht11_decode(struct dht11 *dht11, int offset)
>  {
> -	int i, t, timing[DHT11_BITS_PER_READ], threshold;
> +	int i, t;
> +	char bits[DHT11_BITS_PER_READ];
>  	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
>  
> -	threshold = DHT11_DATA_BIT_HIGH / timeres;
> -	if (DHT11_DATA_BIT_LOW / timeres + 1 >= threshold)
> -		pr_err("dht11: WARNING: decoding ambiguous\n");
> -
> -	/* scale down with timeres and check validity */
>  	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
>  		t = dht11->edges[offset + 2 * i + 2].ts -
>  			dht11->edges[offset + 2 * i + 1].ts;
>  		if (!dht11->edges[offset + 2 * i + 1].value)
>  			return -EIO;  /* lost synchronisation */
> -		timing[i] = t / timeres;
> +		bits[i] = t > DHT11_THRESHOLD ? 1 : 0;
t > DHT11_THRESHOLD is already going to give 0 or 1...
>  	}
>  
> -	hum_int = dht11_decode_byte(timing, threshold);
> -	hum_dec = dht11_decode_byte(&timing[8], threshold);
> -	temp_int = dht11_decode_byte(&timing[16], threshold);
> -	temp_dec = dht11_decode_byte(&timing[24], threshold);
> -	checksum = dht11_decode_byte(&timing[32], threshold);
> +	hum_int = dht11_decode_byte(bits);
> +	hum_dec = dht11_decode_byte(&bits[8]);
> +	temp_int = dht11_decode_byte(&bits[16]);
> +	temp_dec = dht11_decode_byte(&bits[24]);
> +	checksum = dht11_decode_byte(&bits[32]);
>  
>  	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
>  		return -EIO;
> @@ -166,7 +182,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  	mutex_lock(&dht11->lock);
>  	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
>  		timeres = ktime_get_resolution_ns();
> -		if (DHT11_DATA_BIT_HIGH < 2 * timeres) {
> +		if (timeres > DHT11_MIN_TIMERES) {
>  			dev_err(dht11->dev, "timeresolution %dns too low\n",
>  				timeres);
>  			/* In theory a better clock could become available
> @@ -176,6 +192,10 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  			ret = -EAGAIN;
>  			goto err;
>  		}
> +		if (timeres > DHT11_AMBIG_LOW && timeres < DHT11_AMBIG_HIGH)
> +			dev_warn(dht11->dev,
> +				 "timeresolution: %dns - decoding ambiguous\n",
> +				 timeres);
>  
>  		reinit_completion(&dht11->completion);
>  
> @@ -211,7 +231,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  		offset = DHT11_EDGES_PREAMBLE +
>  				dht11->num_edges - DHT11_EDGES_PER_READ;
>  		for (; offset >= 0; --offset) {
> -			ret = dht11_decode(dht11, offset, timeres);
> +			ret = dht11_decode(dht11, offset);
>  			if (!ret)
>  				break;
>  		}
> 

