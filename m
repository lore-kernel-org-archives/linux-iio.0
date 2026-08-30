Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2AF284693;
	Sun, 30 Aug 2026 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123656; cv=none; b=SL0eB1GOPViZmkeN58GaEvUH2nGMvB0ldRrJ8DfUKEFgUkLMgswzA6R6URt5mmRIrobUyEbF8ZbZDle2tnUWkHa034I1bFYt7nuQM7J1ZPT8Jf6ANO1fjQvJW4cXPf42bYKUzGGiRMZHCdvH3ae3a5ZwA6LK1fhsN7fRME5+H2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123656; c=relaxed/simple;
	bh=/gD1bRyUD9lAr7kPqObTWN/5lcLzH/7pa/dj2dGN3xs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=csXBLhFU16YTNZbvrIcOE48V8mVl5M8CuzONVoxt33WwNbhCzy1CoFmDF7LVKplmL7p9fNDTuJLSShQ5mAEsDUlHtoovcO2DJPQllfWx/AL/Gdr9ShcI1g1HVqKkCKcYiSDiG3eyIZll4cI971LqPf3SmR2ekQlv2OUgc2m2gPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU/uWLPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU/uWLPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E471F000E9;
	Sun, 30 Aug 2026 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123654;
	bh=jEc+OWjw/vRC6lJj8t0UU+EdidL2IMvi946D48sxWng=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QU/uWLPv1eHez3WivDJuc9DN+G4/JFVafo+2BgM5ctTZqjzyHgKuQGkc5hsgmYmSz
	 ZYybv9wQTcYid1XhCw93WhD9vgMy5TC0CbvAquRfTfqR3BwDp5g+mRiGTlLiEY4Zeb
	 4z5E8E4WhguiKaJYQyvVqMvf5OyT009dxvtMuLGc0FoK8rXYysmWOv11G/jcEVYI/P
	 YYHjnxmvfEMCNHD4EWgBtWVRGCt/Llr0eeoJWdQvb70WD0OoCXnxF4kEaINFqatVwB
	 NNegxxQ1ar78+zoJqxpcCeAWxr/VdfUv4rJqORXi4aOXy00ZVt743USMQSMKjzQURa
	 X+iTr4keRX/vg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/3] iio: adc: ti-ads112c14: add DRDY interrupt
 support
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-1-1e51a6e20a69@baylibre.com>
References: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
 <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-1-1e51a6e20a69@baylibre.com>
Date: Sun, 30 Aug 2026 22:00:34 +0100
Message-Id: <178812363490.2788519.13850448264886940088.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9342;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=/gD1bRyUD9lAr7kPqObTWN/5lcLzH/7pa/dj2dGN3xs=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlJn1zXXerepFNpdsKUVZ1gZkHzMVLiABSrHwo
 Myp3e0HdpqJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapSZ9REcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiIxgD/0UOXg5r1K5UBZYz2nEVyRanwxdzgTcEWCV8paBpaYa+77
 kZBEdecRSPizU1HSZ4FMxWwO0dmf7amVmK81kS75ggRLgRUQ2U5nfOR4XPD6ErZZu5TwGxeUzqa
 MM3u3Ptj3n1rUIQ12lplwm1XPjdzqefIJJB15kEnns8j8tZVqYddljO7MKLSLTKqKVWiFK3Tn/0
 hz4t2orV6Q1RjC1PHI061vw+C9khvJN7zH50ruwsbDNofX4gHPx+56vVmcJh1+cJ8qy6U4FnJS3
 XLIkQxxLPfWBi6wxofmC3SXwNwLMJKyY6AjWC+vH9zjdYR7OR380YjFKYvLzX84esCIE3Rt1y56
 fTBtTkvb1Ow12A1FaWdohYTWyNNASJZtl0phzhoGpvkpPKafZeCVFeo2IVvO7WhV2qY1SXaeGIj
 6l4tdEWxFlQ+sY2U5dx/lDwqoux9kWBYz/MuQ/ZWA7p29ln2S4O/zgQpayyx0upj+gtOkwK2aFz
 bYuzFZsQfpDaXzHaVt1MXNphnPpL4CAMujucGGGpH7OSS87eJrezmmla3eND5210t23uTb33Az4
 M6jjtKA8wE8RH3vN98Kj3rPrr9z2U8d6hWVmC3TG5a/YVvrbL0alSMQ+vt2R+W/mJZHnaGI4eOL
 /Vrb5W8l8Om2S/v/UMFTMkjPzN2mdJWpdWbqx2A==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add handling for the DRDY interrupt to wait for data ready events rather
> than polling (only when it is wired up).
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

I'm messing with "b4 review tui" to see if it works well for me and
given it has nice sashiko integration, we have comments from there
inline.  To me they all seem fine.

One request - I think we should add a little more detail
to the dt-binding about interrupt types that make sense.
That can be a follow up though if this series is otherwise ready
to go.

>
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 60eab4852ba2..63b819339788 100644
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

>  static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> @@ -581,12 +601,45 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
>  	return 0;
>  }
>  
> +static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
> +{
> +	unsigned long remaining;
> +	int ret;
> +
> +	reinit_completion(&data->drdy_completion);
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_START);

 | sashiko.dev <sashiko@sashiko.dev>:
 |
 | [Severity: Medium]
 | Could this allow a stale DRDY interrupt from a previous timed-out conversion
 | to falsely complete the wait?
 |
 | Since regmap_write() performs a slow I2C transaction that can sleep, if a
 | previous conversion had timed out, the device might complete it and assert
 |  the DRDY interrupt exactly during this regmap_write(). The interrupt handler
 | would then call complete(), causing the subsequent
 | wait_for_completion_timeout() to return immediately and the driver to read
 | stale data.
 |
 | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-1-1e51a6e20a69@baylibre.com

For this I don't think we care.  It is unlikely to happen and the chance
of getting stale data in that corner case probably doesn't bother us.

> +	if (ret)
> +		return ret;
> +
> +	remaining = wait_for_completion_timeout(&data->drdy_completion,
> +						msecs_to_jiffies(100));
> +
> +	return remaining ? 0 : -ETIMEDOUT;
> +}
> +
> +static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_START);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read_poll_timeout(data->regmap,
> +					ADS112C14_REG_STATUS_MSB, reg_val,
> +					FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
> +					1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
> +}
> +
>  static int ads112c14_single_conversion(struct ads112c14_data *data,
>  				       const struct iio_chan_spec *chan,
>  				       u8 *buf, bool for_scan)
>  {
>  	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
> -	u32 reg_val;
>  	int ret;
>  
>  	guard(mutex)(&data->lock);
> @@ -601,15 +654,10 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
>  			return ret;
>  	}
>  
> -	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> -			   ADS112C14_CONVERSION_CTRL_START);
> -	if (ret)
> -		return ret;
> -
> -	ret = regmap_read_poll_timeout(data->regmap,
> -				       ADS112C14_REG_STATUS_MSB, reg_val,
> -				       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
> -				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
> +	if (data->drdy_irq)
> +		ret = ads112c14_wait_for_conversion_irq(data);
> +	else
> +		ret = ads112c14_wait_for_conversion_poll(data);
>  	if (ret)
>  		return ret;
>  
> @@ -1391,6 +1439,38 @@ static int ads112c14_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	if (device_property_present(dev, "interrupt-names")) {
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

 | sashiko.dev <sashiko@sashiko.dev>:
 |
 | [Severity: High]
 | Does this unconditionally force GPIO3 into an output even on board designs
 | that use the dedicated DRDY pin instead?
 |
 | For package variants (like the TSSOP) with a dedicated DRDY pin, a board
 | designer might route the dedicated pin to the interrupt controller and use
 | GPIO3 for another circuit. By forcing GPIO3 to a push-pull output here,
 | the driver will drive voltage into whatever is connected to it, which could
 | cause an electrical short if it is tied to GND/VCC or another output.
 |
 | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-1-1e51a6e20a69@baylibre.com

This seems to be a datasheet misread. Kind of reasonable given
the datasheet talks about Data Ready (!DRDY) Pin. But that section goes
on to explain.

"GPIO3 can be configured as a dedicated DRDY output pin (GPIO3_CFG[1:0] = 10b or 11b, GPIO3_SRC = 1b)"

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
> +				       0, dev_name(dev), indio_dev);

 | sashiko.dev <sashiko@sashiko.dev>:
 |
 | [Severity: High]
 | Could this lead to an interrupt storm on systems with level-triggered
 | interrupts, or fail completely on nested IRQ controllers?
 |
 | The IRQ is requested without a thread function and without IRQF_ONESHOT or
 | explicit edge-trigger flags. Since ads112c14_drdy_irq_handler() is a hardirq
 | handler, it acknowledges the OS interrupt but cannot perform a sleeping I2C
 | transaction to clear the physical line state on the device.

IRQF_ONESHOT in a non threaded interrupt handler would be pointless.

 |
 | On level-triggered systems, this will cause the IRQ controller to immediately
 | re-trigger the interrupt, starving the CPU. Additionally, if the interrupt
 | is routed through an I2C/SPI GPIO expander (nested IRQ controller),
 | devm_request_irq() will fail with -EINVAL because a threaded handler is
 | strictly required.
 |
 | Would it be better to use a threaded IRQ with IRQF_ONESHOT, or strictly
 | require edge-triggering?
 |
 | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-1-1e51a6e20a69@baylibre.com

Personally I don't consider it the drivers job to handle broken firmware or
indeed the more complex cases of expanders that rely on threaded interrupts
only.  I do note that the dt file doesn't express that it expects
an edge interrupt though. Maybe that could be improved?  Not to mention
providing interrupts in one of the examples (that would at least
have hinted about this constraint).

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
