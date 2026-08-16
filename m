Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FC331EB0;
	Sun, 16 Aug 2026 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786840783; cv=none; b=lVkee98K+oLdq9Hf0sZYxYMnws9H4ovduui1WjeBvLHx8BuxK6H457e/4YraC4ut8nmbRmR9qxWTxgV1CnEqeEodh6gqcZUXGyJ1R1b5p9I/pzQfwdA8lG2eOWlv2oAmJgJnNI9Q3GRwtNpglIJYIYTz/hTyP6XWorbOeI/4QXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786840783; c=relaxed/simple;
	bh=Nfn1pLCE8hsnf/y0DIVlf3tYFxTnV4+VtGWS+qu+HiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNEQq5n0mlRgSym3lf3TMHeYe9jJZZ3NoRsbbVOfusJaW3nqAbny/xTIQ3A68oCITS17OZC6GY+PwVB3ZfrTSDbNI0bjUpVFIdLBk8uLZn44dt3cborwYlpKUT5vfVL3l9cTZWCyXKj3DqhDOfYavXeT9N8UResg1gyhx4GdSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt1eUhGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt1eUhGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB11F000E9;
	Sun, 16 Aug 2026 00:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786840781;
	bh=NK5BKaCT2DGxpnly93TSo/qedpggoJaJFIWsB0r34ng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dt1eUhGHYMVHkfsJaXLTGV5aC+Qp5YvIhFhi+tG74BbdWmhGHnaJl05NSQkqChrA4
	 nryVZPg2tCXklNWYGAZ3cqMlzPWVsWy3m+SXmjalvu5VEreS1ShwC7CyfvZdGcA8g6
	 3g1eGNl/ElN8qm38JQbUpGjJnkHPTH6sZ3+fOEpC9tHw1H5yZQLAYIDKLGPH1oISvP
	 QDSgY6M7wVPxe85zvUuNTBPiquKo7fzZ6hwUZ1m6rAhf4bcPYcpcoYLYDGiuxqfuO0
	 kJluTTx3zYgXu2G2kpowOCR55DinmFDsKsMJjCRylmKAVc7EWXph5moXLO86UqJA/U
	 X3w2X63tr03Bg==
Date: Sun, 16 Aug 2026 01:39:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: accel: adxl367: add support for INT2
 interrupt pin
Message-ID: <20260816013936.01f135dc@jic23-huawei>
In-Reply-To: <20260813081452.4289-4-antoniu.miclaus@analog.com>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
	<20260813081452.4289-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 11:14:52 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADXL367 provides two independent interrupt output pins, INT1 and
> INT2, each with its own event mapping register (INTMAP1_LOWER at 0x2A
> and INTMAP2_LOWER at 0x2B) sharing an identical bit layout. Until now
> the driver hardcoded INT1 for all interrupt mappings, so a board that
> routes only INT2 to the host could never receive activity, inactivity
> or FIFO watermark interrupts.
> 
> Determine the connected pin from the interrupt-names device tree
> property using fwnode_irq_get_byname(), and route the interrupt
> mappings to the matching register. When no interrupt-names are present,
> default to INT1 to preserve the existing behaviour.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v2:
> - Propagate -EPROBE_DEFER from fwnode_irq_get_byname().
> - Drop the redundant irq return; the helper now only selects the INT map
>   register.
> 
>  drivers/iio/accel/adxl367.c | 39 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 8c3de11a10a3..df385740b17b 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -13,6 +13,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/unaligned.h>
> @@ -81,6 +82,7 @@
>  #define ADXL367_SAMPLES_L_MASK		GENMASK(7, 0)
>  
>  #define ADXL367_REG_INT1_MAP		0x2A
> +#define ADXL367_REG_INT2_MAP		0x2B
>  #define ADXL367_INT_INACT_MASK		BIT(5)
>  #define ADXL367_INT_ACT_MASK		BIT(4)
>  #define ADXL367_INT_FIFO_WATERMARK_MASK	BIT(2)
> @@ -168,6 +170,8 @@ struct adxl367_state {
>  	enum adxl367_odr	odr;
>  	enum adxl367_range	range;
>  
> +	u8		int_map_reg;
> +
>  	unsigned int	act_threshold;
>  	unsigned int	act_time_ms;
>  	unsigned int	inact_threshold;
> @@ -366,7 +370,7 @@ static int adxl367_set_act_interrupt_en(struct adxl367_state *st,
>  {
>  	unsigned int mask = adxl367_act_int_mask_tbl[act];
>  
> -	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
> +	return regmap_update_bits(st->regmap, st->int_map_reg,

>  				  mask, en ? mask : 0);
Whilst here.

	return regmap_assign_bits(st->regmap, st->int_map_reg, mask, en);

should do the job I think.  Maybe it is worth a precursor or follow up
patch tidying up any other instances of this pattern in this driver.
(Note I haven't actually checked if there are any!)

>  }
>  
> @@ -378,7 +382,7 @@ static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
>  	unsigned int val;
>  	int ret;
>  
> -	ret = regmap_read(st->regmap, ADXL367_REG_INT1_MAP, &val);
> +	ret = regmap_read(st->regmap, st->int_map_reg, &val);
>  	if (ret)
>  		return ret;
>  
> @@ -401,7 +405,7 @@ static int adxl367_set_act_en(struct adxl367_state *st,
>  static int adxl367_set_fifo_watermark_interrupt_en(struct adxl367_state *st,
>  						   bool en)
>  {
> -	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
> +	return regmap_update_bits(st->regmap, st->int_map_reg,
>  				  ADXL367_INT_FIFO_WATERMARK_MASK,
>  				  en ? ADXL367_INT_FIFO_WATERMARK_MASK : 0);
regmap_assign_bits()

>  }
> @@ -1426,6 +1430,31 @@ static int adxl367_setup(struct adxl367_state *st)
>  	return adxl367_set_measure_en(st, true);
>  }
>  
> +static int adxl367_set_int_map_reg(struct adxl367_state *st)
> +{
> +	int irq;
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +	if (irq > 0) {
> +		st->int_map_reg = ADXL367_REG_INT1_MAP;
> +		return 0;
> +	}
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +	if (irq > 0) {
> +		st->int_map_reg = ADXL367_REG_INT2_MAP;
> +		return 0;
> +	}
> +
> +	/* No interrupt-names: default to INT1 for backwards compatibility. */
> +	st->int_map_reg = ADXL367_REG_INT1_MAP;
> +	return 0;
> +}
> +
>  int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  		  void *context, struct regmap *regmap, int irq)
>  {
> @@ -1482,6 +1511,10 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  	if (ret)
>  		return ret;
>  
> +	ret = adxl367_set_int_map_reg(st);
> +	if (ret)
> +		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");
> +
>  	ret = devm_request_threaded_irq(st->dev, irq, NULL,
>  					adxl367_irq_handler, IRQF_ONESHOT,
>  					indio_dev->name, indio_dev);

