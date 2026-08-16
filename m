Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A803BCD20;
	Sun, 16 Aug 2026 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786912285; cv=none; b=UmUmvB9NbzMybe59PBbmXZlJ7atgPQvyXi28NnqWU0ArC7N/gpPbETt7iuzLnJ6yZZA5kbjqn3uz7bos76ocUHzXii7IoX7AdlbYfyDMrMPKRyOl1m7XEViFptNvS4pp3y9m8TqGSL8xXLfW9HCZ42h+OfFrYiBujyyIaXb4tH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786912285; c=relaxed/simple;
	bh=7fs/oNKCMaIJ8Jj3NW0EDADK4iWbpQa+hiHgWZQBAs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8hPamViBKEhekMDuoViuGYmcuxxFGZrPF9hLP6i1YxcXbn/smWJUMKa8L/xmioVJE5Hq8wWlywJ6iXqtEMpvt3TzdJdquoenhEPRnaMHc92np+fWRWMnSiqelopNXyDsFgPePT1ky/q0aXxdhjWbFmvoW5C0Hk3+JGnTKstu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS2Rz2GT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS2Rz2GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4822D1F000E9;
	Sun, 16 Aug 2026 20:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786912283;
	bh=6njgFRFPGUSbH+3ZFMbhA1Q+9+3WSCElXSQY1MXlrJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QS2Rz2GTNxGawsdllNaNwfwA2MzlFnB1CCqKYlxhgUx0WsulF+tYvr1pVd/jUojMn
	 RYoPhH2OnWvtubn4Cr8ImWMebJB7TsEpwCt/JwWr+AZF/SxvcqLW1wQrNGVSoPHD2A
	 AemZdV2d16UeHP8kySrqod9Klr2BBnFYVSruKfzm/m0pt14xEAJkKxd7/EuX9FPcuV
	 +u2Ag/CnM2GE01mwO6gVnHDjoi/2JlTsDgORO0vujs+qz38vZkFz1gKfLeCCFwjE9b
	 9HlFR47PmHnauJ/oCnfTxd3ePjoSqhmbN6YbwAvgyGCn6sybKWiIwGAa5R4WmaBcQK
	 d6pFckXhxWWoQ==
Date: Sun, 16 Aug 2026 21:31:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: adc: ti-ads112c14: support external clock
Message-ID: <20260816213118.40db2e12@jic23-huawei>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-filter-support-v1-1-4d3ba00caf18@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
	<20260807-iio-adc-ti-ads112c14-filter-support-v1-1-4d3ba00caf18@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Aug 2026 19:19:46 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for external an external clock source to the TI ADS112C14
> ADC driver. The unused fclk_hZ field is added in preparation for filter

Hz

Other than that LGTM.

> support.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ti-ads112c14.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index fa6eeaf81738..5f03e6985efa 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -11,6 +11,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitmap.h>
>  #include <linux/cleanup.h>
> +#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
> @@ -178,6 +179,8 @@ static const u32 ads112c14_pga_gains_x10[] = {
>  	200, 320, 500, 640, 1000, 1280, 2000, 2560,	/* 8 - 15 */
>  };
>  
> +#define ADS112C14_INTERNAL_CLK_Hz 4096000
> +
>  #define ADS112C14_I2C_CRC8_POLYNOMIAL 0x07
>  DECLARE_CRC8_TABLE(ads112c14_crc8_table);
>  
> @@ -268,6 +271,7 @@ struct ads112c14_data {
>  	struct iio_trigger *drdy_trig;
>  	/* Synchronizes access to register value fields. */
>  	struct mutex lock;
> +	long fclk_Hz;
>  	int drdy_irq;
>  	struct completion drdy_completion;
>  	bool i2c_crc_enabled;
> @@ -1516,6 +1520,7 @@ static int ads112c14_probe(struct i2c_client *client)
>  	const struct ads112c14_chip_info *info;
>  	struct iio_dev *indio_dev;
>  	struct ads112c14_data *data;
> +	struct clk *clk;
>  	bool need_avdd_ref, need_ext_ref;
>  	u32 refp_uV = 0;
>  	u32 refn_uV = 0;
> @@ -1608,6 +1613,12 @@ static int ads112c14_probe(struct i2c_client *client)
>  		return dev_err_probe(dev, -EINVAL,
>  				     "external reference measurements require either refp-supply or ti,refp-refn-resistor-ohms property\n");
>  
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clk\n");
> +
> +	data->fclk_Hz = clk ? clk_get_rate(clk) : ADS112C14_INTERNAL_CLK_Hz;
> +
>  	/* It takes some time for the internal reference to stabilize. */
>  	fsleep(10 * USEC_PER_MSEC);
>  
> @@ -1678,6 +1689,10 @@ static int ads112c14_probe(struct i2c_client *client)
>  			return dev_err_probe(dev, data->drdy_irq,
>  					     "failed to get drdy interrupt\n");
>  
> +		if (clk)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "cannot use both DRDY and CLK - they share the same pin\n");
> +
>  		/*
>  		 * REVISIT: would probably need to implement a pin controller in
>  		 * order to support open drain option here.
> @@ -1717,6 +1732,20 @@ static int ads112c14_probe(struct i2c_client *client)
>  			return ret;
>  	}
>  
> +	if (clk) {
> +		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
> +					 ADS112C14_GPIO_CFG_GPIO3_CFG,
> +					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
> +						    ADS112C14_GPIO_CFG_GPIO_CFG_INPUT));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_set_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				      ADS112C14_DEVICE_CFG_CLK_SEL);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ads112c14_populate_tables(data);
>  
>  	indio_dev->name = info->name;
> 

