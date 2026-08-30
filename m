Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F44279907;
	Sun, 30 Aug 2026 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123657; cv=none; b=sLlfFqE6xZPSR2utgf2Z4lNqe1iSmX2o0R0/WCGOt0uNHzQR5JEdtRBgQ80CFD0EOAVuNnFSMjsuif+MLTfnDq3LniiILAlMVeCzwGQX7k0qGxHLWPIZ6bgs3vZHfmeT4j/xSw4HGRwIg9XauLFiFPyFz9AywARib65jSK3xn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123657; c=relaxed/simple;
	bh=nw+Y9zFroB6yPKvqzQTMcfA0M2z+Wmw2rDDJgwrAP4Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=s5NwykazdolkcY7y0s1At+tuthp/7owH7EMrLiL4//19dYoNEZHL3A6E/wPuoIYJeFCNqTnoJuPWnl2IY8n+a8JFmZJcaq+jCV3RURGSdwY4pgCbzWoP5jC99QjJ9LUI8Wmf+sYJuWcZCiKEVxo51AKFW3ooRmbADp4qLVi3iM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXHrID5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXHrID5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2316F1F00A3D;
	Sun, 30 Aug 2026 21:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123656;
	bh=ychzp4QE8CYMx3sUGGqXn0rCA2pRhz4wz69YCWiLapo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=FXHrID5oRLnaDM9Uznvmxfirtn2fkKlNObIoMdVFiIjrmq8KltUAroGXqIgzNM8QK
	 177r/Gif/EAO+rwgmNamIkxSKCKLIzj/qEr2Mu9v20SJDinFvbKUDzLmZWEMfLdKjK
	 H6n9R+6K0SVd4Zif6pKN10JwJcTKKhKfYm05QLDmy8s3pbhcEIDn2AkWs71evAOyFy
	 4utzbIZ9smWUIILfzMNIHxqyCKBGxJlj/nW0cZAeKQvjUMI6CsD+pCZxmj9Uav3BAq
	 Xi+w5Ollo+pEXvOeRCVYEpKiuaAjAvLq+00YanC3Yo1THIwweqv5h5knPg4LzRQNRZ
	 nk26jxzsVd63Q==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com>
References: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
 <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com>
Date: Sun, 30 Aug 2026 22:00:34 +0100
Message-Id: <178812363490.2788519.7648614173312615575.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6111;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=nw+Y9zFroB6yPKvqzQTMcfA0M2z+Wmw2rDDJgwrAP4Q=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlJoFnFBpqNMN3DzmZ6MK1rYhA3SoSUuKeSyJU
 ZNMEl9jnLuJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapSaBREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiDvRD/4hYBihT31nGeAeomIRaZOcOktnGza2w0+WxAHb0DByEPC
 uf3LSEA5fmJ6aKHjaixFnGP5AvwkETB2EzNSTM4E/THf+bINQgTgkH2CE3kHfBOv4YIOFsXxApc
 bXFCpEh23eVI2I1I3z4Gm/J8JJcROiRDjGmSyaDUqLBPAYZBMRb/xE3kxM/7zeaXTA14xpEPPym
 L2Frvp99WzU2Zp+dE+otvOBy5InLJ1FfVGeHgoSd4WORPpqSdTI3xKxJrcVZtfDrhIWbYWvcau4
 9ZjdNQJvki6gvlmk+FNVy8PY6q7QIZN673/QjdbFurxN9I2WqqUwwSZoBJ5ejKgYEVgHL3rXlwn
 JRBR15b81pCXD3RR2erJEW1tIoWHfs0OEW2pYf+Bv3EvVxy2QnVS0w6hcTLQzCccbNTj9a24rLQ
 RanAGot8r1WmsMn4E8UCLpXDbppJDbr0m7l2zSico9fRDDYCWSn/ta7PzTaSxIquhNPB4AgLm1c
 hmclkOsee1Gu+mXsu1idehX6IyFfoXVF8UbrZbDdB3o6Z5w4zgXv2eJKViIN3arqD/vwfVXkeAs
 4EdRUxIcGPXFNSsKDNaTRzqGAOnI1rJT1wZbDojgNxwPhCTqnEnnE16L3+lnSNv0B+/ozDve4l3
 LOnvbhA84+IQ0bEusIWy1Xd8ONR0fvqHzML1Q7w==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
> mode the ADC itself is starting each conversion, so we add a trigger
> based on the DRDY interrupt to read each sample. This mode is also
> limited in that only one channel can be enabled at a time since the
> chip does not have a sequencer or simultaneous sampling capability.
> Continuous mode will only be used when this new trigger is the current
> trigger.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Sashiko caught some interesting things in this one.

See inline.

>
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 23f15be303fb..878764deffc5 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/bitmap.h>
>  #include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/crc8.h>
> @@ -18,6 +19,7 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/interrupt.h>
> @@ -257,6 +259,7 @@ struct ads112c14_measurement {
>  struct ads112c14_data {
>  	const struct ads112c14_chip_info *chip_info;
>  	struct regmap *regmap;
> +	struct iio_trigger *drdy_trig;
>  	/* Synchronizes access to register value fields. */
>  	struct mutex lock;
>  	int drdy_irq;
> @@ -280,11 +283,18 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct ads112c14_data *data = iio_priv(indio_dev);
>  
> -	complete(&data->drdy_completion);
> +	if (indio_dev->trig && iio_trigger_using_own(indio_dev))


This indeed needs more guarding given we hit these interrupts for
a normal read (to get to the completion)


Likewise seems valid.

> +		iio_trigger_poll(data->drdy_trig);
> +	else
> +		complete(&data->drdy_completion);
>  
>  	return IRQ_HANDLED;
>  }

...

>  static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
>  {
>  	struct iio_poll_func *pf = private;
> @@ -961,6 +984,26 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
>  	u32 i;
>  	int ret;
>  
> +	if (iio_trigger_using_own(indio_dev)) {

 | sashiko.dev <sashiko@sashiko.dev>:
 |
 | [Severity: High]
 | Will this check incorrectly enable continuous mode processing for any
 | external trigger that belongs to its own device?
 |
 | If a user assigns an external trigger that sets its attached_own_device
 | property to true, iio_trigger_using_own() will evaluate to true. Could this
 | misroute the interrupt handler into assuming continuous mode when it should
 | not?
 |
 | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com

I think this is triggered by the more complex handling you have
to detect use of the dataready trigger below.  There is only one trigger
currently so they end up the same, but perhaps we should make the handling
more similar?

> +		const struct iio_chan_spec *chan;
> +
> +		chan = ads112c14_first_active_channel(indio_dev);
> +		if (!chan)
> +			goto out;
> +
> +		ret = ads112c14_scan_read(data, (u8 *)&data->scan[0]);

 | sashiko.dev <sashiko@sashiko.dev>:
 |
 | [Severity: High]
 | This is a pre-existing issue, but is there a missing length check in the
 | underlying I2C block read that leaves stack memory partially uninitialized?
 |
 | If i2c_smbus_read_i2c_block_data() (called by ads112c14_scan_read()) returns
 | a positive value smaller than the requested length, the condition if (ret < 0)
 | fails to catch the short read. Does this leak uninitialized stack memory to
 | userspace when data->scan is later pushed to the IIO buffers?
 |
 | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com

I haven't chased this one through - but in a similar example in a review
I did yesterday I suggested just initializing the memory anyway
so we don't have to care one way or the other.

> +		if (ret) {
> +			dev_err_once(indio_dev->dev.parent,
> +				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
> +				     chan->channel, ERR_PTR(ret));
> +			goto out;
> +		}
> +
> +		iio_push_to_buffers_with_ts(indio_dev, data->scan,
> +					    sizeof(data->scan), pf->timestamp);
> +		goto out;
> +	}
> +
>  	iio_for_each_active_channel(indio_dev, i) {
>  		const struct iio_chan_spec *chan = &indio_dev->channels[i];
>  
> @@ -992,6 +1035,88 @@ static const struct iio_info ads112c14_info = {
>  	.read_label = ads112c14_read_label,
>  };
>  

...

> +static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan;
> +	int ret;
> +
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return 0;
> +
> +	chan = ads112c14_first_active_channel(indio_dev);
> +	if (!chan)
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = ads112c14_prepare_channel(data, chan);


Hmm. Indeed an interesting corner...  From a quick look it is correct.
I'm not sure if this is in practice an existing bug - do other
drivers change acceptable channels based on another change such as
which trigger is in use?   Either way we need to close this.

We can't just go clearing the set bits on setting the trigger as
that might cause a regression.  So I think all we can do is add
a well commented additional check early in the buffer enable path.

Given the behaviour that is causing problems is present in this
driver we could either add the protection in fix and rely on that
going upstream first, or add it as first patch in this series and
let it work its way upstream with this patch.

Nice catch to sashiko!

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
