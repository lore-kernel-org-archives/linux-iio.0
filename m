Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A6318EDA;
	Sun,  2 Aug 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785694210; cv=none; b=YgsUgd+qnlZ1nfRwoFHU2G5HH2BEn6b6F9uJBkHMI0RzFyBmmN3cXb5yVuWv7V8HEwpPk2o7+j2sEGb+0sxhEA97X+0V9mHGtwbWd7PSjcXKyB0WLagdQrao62H4hhpDW/cP5hn0I8nq22i3KsTOdncz0yYAAcGP1IqougKk9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785694210; c=relaxed/simple;
	bh=WVwZSo+2lQSOwKUEF8qs7W8nS6fkL1NCU++oS2jAgq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBB6/5H+KpnwNVpSjMuvoPeYqlbACvBuy3gCaJ1wvXawJwjdlUSuFUov8N4K39GhMfoA137i5zSq84Jd+QwAXHY5sabYTajji6+TXlbrFHd5NQJrjvXRlAM6tokJaGjRJ2ezyB/IRvvqI90229OEBErzTYiEGlnLMQG6wj45Ias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/u/HH90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/u/HH90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5151F000E9;
	Sun,  2 Aug 2026 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785694208;
	bh=VzsrZHtLRpTN1aNC+xRbwdlaCP2a4PCXuuWkoJNEO4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U/u/HH90CUdKpcohgpS01q5GV8BoJ+B1p6KQ4ucmiF1vNunQhZU/IiYP+Iq3B9YOP
	 4G2TOuYGlqOG2MvXp+f8oHTZL7AmZfsJf1+AdylgJFOy6rDM93lVo+iqiwZ8RqPhFG
	 iWfEGraJqvmksx6q9c3WiDchW0ZGT1DBavHUCbjXFv8MZQ2GCmF10k8xrJxJB1dKt7
	 iRw4Ao9jfXRvIHzMnjzQT/flAn9xmpOiW+oRy+PRO5csGYTqdcOfyq2bU/VDMnwnlT
	 zbYEWgEviafv0qxZ5KtJ2GJElO+Awd0WxevxQ8+R6Zukx14iK3L7S2Ua1ibhxT8kvX
	 VV6URc909x+Zw==
Date: Sun, 2 Aug 2026 19:10:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ti-ads112c14: add DRDY interrupt
 support
Message-ID: <20260802191001.279e994d@jic23-huawei>
In-Reply-To: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-1-eb13da38e8fc@baylibre.com>
References: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
	<20260731-iio-adc-ti-ads112c14-continuous-mode-v2-1-eb13da38e8fc@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 18:48:10 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add handling for the DRDY interrupt to wait for data ready events rather
> than polling (only when it is wired up).
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

Repeating discussion from other thread a bit just so people can find it.

> ---
> 
> Small note: the hard-coded 100 ms timeout will be replaced in a future
> series with a dynamic value, so I didn't bother with a macro or comments
> to explain why the value was chosen.
> 
> And passing indio_dev instead of data to irq is intentional as it will
> be used in the next patch.
> ---
>  drivers/iio/adc/ti-ads112c14.c | 105 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 95 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 8ad8caee0ff7..177f7064092e 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/cleanup.h>
> +#include <linux/completion.h>
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
>  #include <linux/dev_printk.h>
> @@ -19,6 +20,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/interrupt.h>
>  #include <linux/math64.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
> @@ -117,9 +119,15 @@
>  #define   ADS112C14_GPIO_CFG_GPIO2_CFG			GENMASK(5, 4)
>  #define   ADS112C14_GPIO_CFG_GPIO1_CFG			GENMASK(3, 2)
>  #define   ADS112C14_GPIO_CFG_GPIO0_CFG			GENMASK(1, 0)
> +#define     ADS112C14_GPIO_CFG_GPIO_CFG_DISABLED	  0
> +#define     ADS112C14_GPIO_CFG_GPIO_CFG_INPUT		  1
> +#define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL  2
> +#define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_OPEN_DRAIN 3
>  
>  #define ADS112C14_REG_GPIO_DATA_OUTPUT			0x0C
>  #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC		BIT(7)
> +#define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DAT_OUT  0
> +#define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY	  1
>  #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_SRC		BIT(6)
>  #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_DAT_OUT	BIT(3)
>  #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_DAT_OUT	BIT(2)
> @@ -251,6 +259,8 @@ struct ads112c14_data {
>  	struct regmap *regmap;
>  	/* Synchronizes access to register value fields. */
>  	struct mutex lock;
> +	int drdy_irq;
> +	struct completion drdy_completion;
>  	bool i2c_crc_enabled;
>  	u32 avdd_uV;
>  	u32 ext_ref_uV;
> @@ -265,6 +275,16 @@ struct ads112c14_data {
>  						 ARRAY_SIZE(ads112c14_sys_mon_channels));
>  };
>  
> +static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ads112c14_data *data = iio_priv(indio_dev);

This should probably be defending against spurious interrupts by checking
the status register.  Ideally that would be in a threaded handler to avoid
a retry loop and race conditions around the completion.

i.e. we should know it is our interrupt for sure before complete()


The interrupt lets us skip polling (unless we do get a spurious) in favour
of just checking the status once after the interrupt gives us a strong
indication it should be set.

> +
> +	complete(&data->drdy_completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> @@ -581,12 +601,50 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
>  	return 0;
>  }
>  
> +static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
> +{
> +	unsigned long remaining;
> +	int ret;
> +
> +	reinit_completion(&data->drdy_completion);
> +	enable_irq(data->drdy_irq);

With the status register check I don't think we need to be doing this fine
grained host side control of the interrupt enable.  They tend to be
a bit unpredictable.  So if we had seen an interrupt when it was disabled
you might immediately see it fire upon enabling here before you call
the start.

> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_START);
> +	if (ret)
> +		goto out;

Plus side of getting rid of the enable disable dance, is you can return directly
here giving us simpler code flow.

> +
> +	remaining = wait_for_completion_timeout(&data->drdy_completion,
> +						msecs_to_jiffies(100));
> +	ret = remaining ? 0 : -ETIMEDOUT;
> +
> +out:
> +	disable_irq(data->drdy_irq);
> +
> +	return ret;
> +}



> @@ -1392,6 +1445,38 @@ static int ads112c14_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	if (device_property_present(dev, "interrupts")) {
> +		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
> +		if (data->drdy_irq < 0)
> +			return dev_err_probe(dev, data->drdy_irq,
> +					     "failed to get drdy interrupt\n");
> +
> +		/*
> +		 * REVISIT: would probably need to implement a pin controller in
> +		 * order to support open drain option here.
> +		 */
> +		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
> +					 ADS112C14_GPIO_CFG_GPIO3_CFG,
> +					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
> +						    ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_DATA_OUTPUT,
> +					 ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC,
> +					 FIELD_PREP(ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC,
> +						    ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY));
> +		if (ret)
> +			return ret;
> +
> +		init_completion(&data->drdy_completion);
> +
> +		ret = devm_request_irq(dev, data->drdy_irq, ads112c14_drdy_irq_handler,
> +				       IRQF_NO_AUTOEN, dev_name(dev), indio_dev);
As above (and you pointed out in that other thread) IRQF_NO_AUTOEN is probably
not appropriate here as we aren't supposed to see interrupts until we ask the device
to do something.

> +		if (ret)
> +			return ret;
> +	}
> +
>  	ads112c14_populate_tables(data);
>  
>  	indio_dev->name = info->name;
> 

