Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:52199 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbbGEXj5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 5 Jul 2015 19:39:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2015 01:39:53 +0200
From: <harald@ccbib.org>
To: Jonathan Bell <jonathan@raspberrypi.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>,
	Richard Weinberger <richard@nod.at>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>, <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] iio: humidity: dht11: Rewrite decode algorithm, improve
 read reliability
In-Reply-To: <op.x1bjac2cfh00o9@enterprised.lan>
References: <op.x1bjac2cfh00o9@enterprised.lan>
Message-ID: <33438a3f3e237279d0807a4241efa495@imap.cosmopool.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

Thanks for looking into this driver. Actually I'm working actively (even
if at a low pace) on cleaning up and improving the code, so I'd appreciate
coordination of work. I currently have a patch under review, so you will
need to rebase your patch once mine got merged.

Also you should split your patch into logical changes an grouping them
into fixes, improvements and cleanups, so that I can ACK them
individually.

On Sun, 5 Jul 2015 22:00:02 +0100, Jonathan Bell
<jonathan@raspberrypi.org>
wrote:
> This driver has a poor read success rate when any amount of hard-IRQ
> latency is encountered. On the Raspberry Pi platform for example, the
> read success rate is ~50% with no hardware activity and practically 0%
> with any other significant hardware activity.

Actually I developed and tested this driver on a slow platform
(imx233-olinuxino) and it worked quite well there, so I believe what
really
fixes your problems is the added calls to smp_mb(), which you entirely
forgot to mention in your summary below.

I admit I never tested my code on any multicore system and if decoding
results are really that bad there, this is a serious bug. Obviously I'm
not
competent about multiprocessing and can't review your solution, but if you
can confirm, that just adding smp_mb() calls to the existing code fixes
your problems, then you can add my Acked-By to such a patch and this
should
be applied as fix.


About your other changes:
> Rewrite several aspects of the decode mechanism to make it more robust:
> 
> - Cater for GPIO chips that can raise interrupts when I/O pins
>    are set as output by expanding the maximum number of edges recorded.
> - Start decoding the bitstream right-justified to make the driver
agnostic
>    towards whether the start bits generate IRQs.

That was the original behaviour, but is actively prohibited by some GPIO
chip drivers. We asked Linus Walleij about it in
https://lkml.org/lkml/2014/12/1/171 who replied:
"IRQs on pins set to output *does* *not* *make* *sense*." I still
disagree,
but I don't feel like diving into discussions like this. I'll be happy if
you can convince him, because the DHT11 driver lost a nice diagnostic
feature with that change, but before that GPIO code is changed, there is
no chance this can be added back.

> - Only bother decoding for GPIO "high" bit-times - the high-time is what
>    encodes the useful information.
> - Use simple split-the-difference thresholding to decide if a received
>    data bit is a "1" or "0", instead of comparing relative bit periods.

These changes are actually in my queue of cleanup patches. However
selecting the right threshold is not quite trivial: There are the timing
differences between sensor variants but there are also timing differences
depending on cable length. I have DHT22s connected to cables up to
15 meters. You must be careful to select a threshold that really works
with different impedances, etc.

> - Refine the start bit timing to use usleep_range() to stop the later
>    sensor models from timing out if the msleep() takes longer than
>    expected.

Do you have any data (or even experiemental results) backing this change?
The start bit timing is bothering me for a long time now: I never got
any conclusive answer, what is best. However I never saw any problems
obviously attributable to start bit time outs either. (Your change of
course makes sense independent of the actual timing used.)

> Also tweak a few error paths to be more informative.

That's also on my todo list of cleanups. (And already begun with the patch
currently under review.)

> The sensor decode success rate on a Pi after these changes is 99.1% with
> no other hardware activity and approximately 78% with an Ethernet ping
> flood happening concurrently.

Actually if you used the information from the GPIO "low" timings for error
correction, you probably could improve the ping flood case. However I'm
not
sure if it is worth the effort and code complexity.

> There's still a few rough corners - several versions of the datasheet
seem
> to suggest that a double-read is required to get an up-to-date value,
i.e.
> the last value converted is the one returned when a readout is
requested.

This also is not clear to me. The datasheets seem to be translations above
translations...

I'm not doing an actual review of your code before you split it into a
"one patch per change" series. But I hope this feedback helps you anyway.

Thanks,
Harald

> This can't be easily reconciled with the minimum repeat interval that is
> also specified - a 2 second round-trip time is a long time to block for.
> 
> As these sensors have a slow (~10s) response time to environment
changes,
> it's reasonable to assume that a measured value from 2 seconds ago will
> not be inaccurate.
> 
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.org>
> ---
> I only have access to an AM2302/DHT22 variant of the sensor. This patch
> could use some testing on the other models in the range.
> 
> I am aware of a pending patch that causes the driver to bail out of a
> reading if the kernel's timestamp resolution is too large. With the
change
> above, the driver won't be adversely affected unless the resolution is
> very coarse - ~50us per tick.
> 
>   drivers/iio/humidity/dht11.c |  157  
> +++++++++++++++++++++++-------------------
>   1 file changed, 86 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 7d79a1a..855fb30 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -38,22 +38,28 @@
> 
>   #define DRIVER_NAME	"dht11"
> 
> -#define DHT11_DATA_VALID_TIME	2000000000  /* 2s in ns */
> -
> -#define DHT11_EDGES_PREAMBLE 2
> +#define DHT11_START_EDGES 2
> +#define DHT11_ACK_EDGES 2
>   #define DHT11_BITS_PER_READ 40
> +#define DHT11_STOP_EDGES 2
> +
> +#define DHT11_MAX_EDGES (DHT11_START_EDGES + DHT11_ACK_EDGES + \
> +			DHT11_BITS_PER_READ * 2 + DHT11_STOP_EDGES)
> +
>   /*
> - * Note that when reading the sensor actually 84 edges are detected,
but
> - * since the last edge is not significant, we only store 83:
> + * Sensor variants have differing requirements for the start pulse.
> + * DHT11 is minimum 18ms, DHT21 is 1-10ms, DHT22 is 1ms.
> + * If a >20ms start pulse is driven on a DHT22 then the sensor doesn't 

> respond
> + * at all. Stick to the minimum that should work for all variants.
>    */
> -#define DHT11_EDGES_PER_READ (2*DHT11_BITS_PER_READ +  
> DHT11_EDGES_PREAMBLE + 1)
> -
> -/* Data transmission timing (nano seconds) */
> -#define DHT11_START_TRANSMISSION	18  /* ms */
> -#define DHT11_SENSOR_RESPONSE	80000
> -#define DHT11_START_BIT		50000
> -#define DHT11_DATA_BIT_LOW	27000
> -#define DHT11_DATA_BIT_HIGH	70000
> +#define DHT11_START_PULSE_MIN	18000 /* us */
> +#define DHT11_START_PULSE_MAX	20000 /* us */
> + /* Determinant for 1 or 0 decode. 27uS high-time for a 0, 70uS for a
1.  
> */
> +#define DHT11_BIT_THRESHOLD	51000 /* ns */
> +/* Limit repeat interval. Datasheet specifies minimum 2s interval */
> +#define DHT11_REPEAT_INTERVAL	2000000000 /* ns */
> +/* This is approx. 2x maximum readout time */
> +#define DHT11_CONV_TIMEOUT	20 /* ms */
> 
>   struct dht11 {
>   	struct device			*dev;
> @@ -70,10 +76,10 @@ struct dht11 {
> 
>   	/* num_edges: -1 means "no transmission in progress" */
>   	int				num_edges;
> -	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
> +	struct {s64 ts; int value; }	edges[DHT11_MAX_EDGES];
>   };
> 
> -static unsigned char dht11_decode_byte(int *timing, int threshold)
> +static unsigned char dht11_decode_byte(s64 *timing, int threshold)
>   {
>   	unsigned char ret = 0;
>   	int i;
> @@ -87,46 +93,55 @@ static unsigned char dht11_decode_byte(int *timing, 

> int threshold)
>   	return ret;
>   }
> 
> -static int dht11_decode(struct dht11 *dht11, int offset)
> +static int dht11_decode(struct dht11 *dht11)
>   {
> -	int i, t, timing[DHT11_BITS_PER_READ], threshold,
> -		timeres = DHT11_SENSOR_RESPONSE;
> +	int i, t, offset;
> +	s64 timing[DHT11_BITS_PER_READ];
>   	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
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
> +	dht11->timestamp = iio_get_time_ns();
> +	/*
> +	 * Start our decode taking into account that some GPIO chips
> +	 * won't interrupt when we drive the start bits.
> +	 */
> +	offset = dht11->num_edges - DHT11_STOP_EDGES - DHT11_BITS_PER_READ *
2;
> +	if (offset < 0) {
> +		dev_err(dht11->dev,
> +			"Decode failure: only %d edges recorded\n",
> +			dht11->num_edges);
>   		return -EIO;
>   	}
> -	threshold = DHT11_DATA_BIT_HIGH / timeres;
> -	if (DHT11_DATA_BIT_LOW/timeres + 1 >= threshold)
> -		pr_err("dht11: WARNING: decoding ambiguous\n");
> -
> -	/* scale down with timeres and check validity */
> -	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
> -		t = dht11->edges[offset + 2*i + 2].ts -
> -			dht11->edges[offset + 2*i + 1].ts;
> -		if (!dht11->edges[offset + 2*i + 1].value)
> -			return -EIO;  /* lost synchronisation */
> -		timing[i] = t / timeres;
> +	/* Check that our pulse train hasn't been corrupted by latency */
> +	for (i = 0; i < dht11->num_edges - 1; i++) {
> +		if (dht11->edges[i].value == dht11->edges[i + 1].value) {
> +			dev_err(dht11->dev,
> +				"Decode failure: missed edges (%d total)\n",
> +				dht11->num_edges);
> +			return -EIO;
> +		}
> +	}
> +	/* Find pairs of edges that correspond to a high interval */
> +	for (i = offset, t = 0; i < dht11->num_edges - DHT11_STOP_EDGES; i++)
{
> +		if (dht11->edges[i].value == 1 &&
> +				dht11->edges[i + 1].value == 0) {
> +			if (t == DHT11_BITS_PER_READ)
> +				break;
> +			timing[t++] = dht11->edges[i + 1].ts -
> +					dht11->edges[i].ts;
> +		}
>   	}
> 
> -	hum_int = dht11_decode_byte(timing, threshold);
> -	hum_dec = dht11_decode_byte(&timing[8], threshold);
> -	temp_int = dht11_decode_byte(&timing[16], threshold);
> -	temp_dec = dht11_decode_byte(&timing[24], threshold);
> -	checksum = dht11_decode_byte(&timing[32], threshold);
> +	hum_int = dht11_decode_byte(timing, DHT11_BIT_THRESHOLD);
> +	hum_dec = dht11_decode_byte(&timing[8], DHT11_BIT_THRESHOLD);
> +	temp_int = dht11_decode_byte(&timing[16], DHT11_BIT_THRESHOLD);
> +	temp_dec = dht11_decode_byte(&timing[24], DHT11_BIT_THRESHOLD);
> +	checksum = dht11_decode_byte(&timing[32], DHT11_BIT_THRESHOLD);
> 
> -	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
> +	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum) {
> +		dev_err(dht11->dev, "Decode failure: invalid checksum\n");
>   		return -EIO;
> +	}
> 
> -	dht11->timestamp = iio_get_time_ns();
>   	if (hum_int < 20) {  /* DHT22 */
>   		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
>   					((temp_int & 0x80) ? -100 : 100);
> @@ -153,12 +168,13 @@ static irqreturn_t dht11_handle_irq(int irq, void 

> *data)
>   	struct dht11 *dht11 = iio_priv(iio);
> 
>   	/* TODO: Consider making the handler safe for IRQ sharing */
> -	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0)
{
> +	if (dht11->num_edges < DHT11_MAX_EDGES && dht11->num_edges >= 0) {
>   		dht11->edges[dht11->num_edges].ts = iio_get_time_ns();
>   		dht11->edges[dht11->num_edges++].value =
>   						gpio_get_value(dht11->gpio);
> -
> -		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
> +		/* Ensure other cores can see our array update */
> +		smp_mb();
> +		if (dht11->num_edges >= DHT11_MAX_EDGES)
>   			complete(&dht11->completion);
>   	}
> 
> @@ -173,42 +189,35 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>   	int ret;
> 
>   	mutex_lock(&dht11->lock);
> -	if (dht11->timestamp + DHT11_DATA_VALID_TIME < iio_get_time_ns()) {
> +	if (dht11->timestamp + DHT11_REPEAT_INTERVAL < iio_get_time_ns()) {
>   		reinit_completion(&dht11->completion);
> 
>   		dht11->num_edges = 0;
> +		/* Ensure the IRQ handler knows we've started a reading */
> +		smp_mb();
> +
>   		ret = gpio_direction_output(dht11->gpio, 0);
>   		if (ret)
>   			goto err;
> -		msleep(DHT11_START_TRANSMISSION);
> -		ret = gpio_direction_input(dht11->gpio);
> -		if (ret)
> -			goto err;
> 
> -		ret = request_irq(dht11->irq, dht11_handle_irq,
> -				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -				  iio_dev->name, iio_dev);
> +		usleep_range(DHT11_START_PULSE_MIN, DHT11_START_PULSE_MAX);
> +
> +		ret = gpio_direction_input(dht11->gpio);
>   		if (ret)
>   			goto err;
> 
>   		ret = wait_for_completion_killable_timeout(&dht11->completion,
> -								 HZ);
> -
> -		free_irq(dht11->irq, iio_dev);
> -
> -		if (ret == 0 && dht11->num_edges < DHT11_EDGES_PER_READ - 1) {
> -			dev_err(&iio_dev->dev,
> -					"Only %d signal edges detected\n",
> -					dht11->num_edges);
> -			ret = -ETIMEDOUT;
> -		}
> +					msecs_to_jiffies(DHT11_CONV_TIMEOUT));
> +		/*
> +		 * If the completion call times out, it could be the case that
> +		 * the IRQ handler may have reported data which could contain
> +		 * sufficient recorded edges to achieve decode.
> +		 * Test based on the number of edges instead of timeout.
> +		 */
>   		if (ret < 0)
>   			goto err;
> 
> -		ret = dht11_decode(dht11,
> -				dht11->num_edges == DHT11_EDGES_PER_READ ?
> -					DHT11_EDGES_PREAMBLE :
> -					DHT11_EDGES_PREAMBLE - 2);
> +		ret = dht11_decode(dht11);
>   		if (ret)
>   			goto err;
>   	}
> @@ -274,9 +283,15 @@ static int dht11_probe(struct platform_device
*pdev)
>   		return -EINVAL;
>   	}
> 
> -	dht11->timestamp = iio_get_time_ns() - DHT11_DATA_VALID_TIME - 1;
> +	dht11->timestamp = iio_get_time_ns() - DHT11_REPEAT_INTERVAL - 1;
>   	dht11->num_edges = -1;
> 
> +	ret = devm_request_irq(dev, dht11->irq, dht11_handle_irq,
> +			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +			pdev->name, iio);
> +	if (ret)
> +		return ret;
> +
>   	platform_set_drvdata(pdev, iio);
> 
>   	init_completion(&dht11->completion);
