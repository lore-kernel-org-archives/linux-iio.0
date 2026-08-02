Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875E2264C7;
	Sun,  2 Aug 2026 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785694680; cv=none; b=isAXNOWEc7CtQjUEXcGekfhzdYKSElH4LYvxbUgqS1L/+QPl4QIINbgqQNcbbSAvcTOdRXZqrUJxYPZhhGNKKT7yUgEdrhBrA/D1kOAMmChiWYmv3BY7/5YlTSpvz4omwpJZyVtmvjmqRvBpzwoQpK7Ol/rbIMo4cZGUZzZLsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785694680; c=relaxed/simple;
	bh=o1eBXfB94obow01AtNkpYMoQ37BpmLtXBMkjD0JlqHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPIAeoD1VjUpSIdHLpXH39lWlzqJ05llH0P6rHFAH3U+ZT6coydxg37i4Dl6s19zYIy1tWbo606U5Q95aNzn51wAmhLJuKrXt7O6tAgimvXa9D+aZ2IAYKzNTSGiNsC8CJMUVVbe0FQLNDgUFkI/MKt8eeuSPlqX9HVJbtnd4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4El5Hl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4El5Hl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A831F000E9;
	Sun,  2 Aug 2026 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785694678;
	bh=1KW93rhzgnMdKxZPY9JoRqQbfL3fVg+wHOPB3wr4hnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g4El5Hl4ZZwDig7jXPfv9vZ1Cxm3KAEDJ4INO3+6mV66KjdFBA2wAvRHFL/ivPuwC
	 tMlptn2I+UGn9czePqOQ1prd/3A2O8y6EQNvxt2rLwX3w9AVIVeWtJIWLv018n5vBv
	 /XNGt7/ihHfh43j4Dn/RvXRDidQKC7s8ug1xNDRESCNn63Nrl1C0005yO6L6tXUTlJ
	 Jwi5bSMPTMAIG0zKB4rPXpqcEU3/2165EVSz7v0j8+hztNknxDtO3cO2CuQsLnf8ig
	 pOUiPkv23y9x7pEG8fVIlNlQ5AZcbvVlGtPhDfYcEApIHZfLYvS2Gze50uwupzf3Ww
	 h5vWVnnznYlNg==
Date: Sun, 2 Aug 2026 19:17:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
Message-ID: <20260802191753.2c98d7bb@jic23-huawei>
In-Reply-To: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-3-eb13da38e8fc@baylibre.com>
References: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
	<20260731-iio-adc-ti-ads112c14-continuous-mode-v2-3-eb13da38e8fc@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 18:48:12 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
> mode the ADC itself is starting each conversion, so we add a trigger
> based on the DRDY interrupt to read each sample. This mode is also
> limited in that only one channel can be enabled at a time since the
> chip does not have a sequencer or simultaneous sampling capability.
> Continuous mode will only be used when this new trigger is the current
> trigger.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
There is some follow on stuff in here from the earlier suggestion to
check the status register even when datardy involved

> ---
>  drivers/iio/adc/ti-ads112c14.c | 146 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 144 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index c6d83298c312..5147d10785fb 100644
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
> @@ -280,11 +283,32 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct ads112c14_data *data = iio_priv(indio_dev);
>  
> -	complete(&data->drdy_completion);
> +	if (indio_dev->trig && iio_trigger_using_own(indio_dev))
> +		iio_trigger_poll(data->drdy_trig);

Even for this path we should be checking it wasn't a spurious interrupt.
If that's happening in a threaded interrupt we'll then call iio_trigger_poll_nested()
and the handler will happen in the interrupt thread.   So the overhead
of that check should just be the check.

> +	else
> +		complete(&data->drdy_completion);

For this single shot read we are probably less bothered by overhead so
moving this to a thread should be fine I think.

>  
>  	return IRQ_HANDLED;
>  }
>  
> +static int ads112c14_trigger_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +
> +	if (state)
> +		enable_irq(data->drdy_irq);
> +	else
> +		disable_irq(data->drdy_irq);
> +

So do we need to do this to avoid some condition, or is this the defensive
stuff you pointed out in that other thread?

I'd normally expect a dataready trigger to be controlling if the interrupt
is generated at all rather than masking host end.

> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops ads112c14_trigger_ops = {
> +	.set_trigger_state = ads112c14_trigger_set_state,
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
