Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84513128AB;
	Mon, 21 Sep 2026 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955468; cv=none; b=CbQK24/SkKTqN0PdsbKjzV+gtJCF94OpTxcgcKHu+N8qbAfc6mmE+h7bzBljjwQLhQNhwAwTzU+3oer2sMC5JfoQzW0VZZIUK+GkjZnOIbZnT/IOvNSa+z92LOvyEe22/85sMScRLfpicDNPmLNqdznpQwwjZdaixpHa4vS+Keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955468; c=relaxed/simple;
	bh=kQr1EzOJpH0kD99pcMQ3mEQS+8wfTD3X+BdzjpA4D00=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aV9/ZPakAQH+mJxTqpFXY19uCspRyuHSrMGlIA68xo35MbBchys+3+vchmHoVOXI/XOA4UNdEhchSlz4yjadDf5H2146/h2JZb3IRS0DT8OQ1ChXkVUUfoPVEDAIsO8Spd9/SF2+3sugLjOMu0mF9WzMgHMqaegrbj9/FsbL4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApFX2cTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApFX2cTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023A81F000FF;
	Mon, 21 Sep 2026 01:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955467;
	bh=tts3F4rct/Y5UM/3ZWSgRuG3ISsgLtpEch8hR8uAh10=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ApFX2cTcLUsp/okeGvfKrackxG3vAzw2ngJ7J44EbguMUOy1H+k+tshRvH57gVwSs
	 UYYIaL/p8RGFVKrIKYP+telLTQVrGXm5FubHxfiuRiWtmRARcJ20Ut+mQ1IxaEjKlA
	 IjYzMGw1ImbrqpcRzkAL2fZ2sm0ArvfrYaSmb9+DSysSSH9Jo31Q+olN8ykLDzakuM
	 XXH8nbgAImACDjdbsNkrSrhsNJndtqkI1W/epiGAWt+HwwlFy/5Y+gYpcFBVqWOp5a
	 9TrzbJXK4WhAAoH67daajWmCmfbZVXjqUFmde6d5A4C/7cXFqtE4WUxTW2wRX2EAiK
	 Bd2VppVDd6iYA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 14/15] iio: adc: ad4134: Support high-speed data
 capture
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org, 
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org, 
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
 marcelo.schmitt1@gmail.com
In-Reply-To: <0bf6ca5c7ac264b90429efb2009574db0d0e3315.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <0bf6ca5c7ac264b90429efb2009574db0d0e3315.1789494473.git.marcelo.schmitt@analog.com>
Date: Mon, 21 Sep 2026 02:50:45 +0100
Message-Id: <178995544508.955708.9260547168625494950.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=kQr1EzOJpH0kD99pcMQ3mEQS+8wfTD3X+BdzjpA4D00=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsI2FArKiPVUQ7fZF61tuUVGVabOhLUOM+JZd3
 cFQM45xkzmJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarCNhREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiCT/D/0d6jIeWkcC2Rt5DsWpbXBRed8GumyZ6GnAWRb43XxziMf
 gWmHDkWZycHr/uR3KOXgxqrskClA9wroq9KMXaof1KhcrMcMQ2gmyLqqGOW956MaZeRfpWBFJr4
 RSK2YgcVo8ueifQgyluNxvCvy2iY8oR9ap7QWMBAxc5JUy/enPo/BdRaoGKM2b9LjINlycw9Os5
 8OAgSl842N64cxKgpiX9BmDmKHpnh+dwNBLrxLKWpkFZATtuErw/Ny6awsMmXc2EpQxanTjq8op
 vOfKswFhaXQBXqBFbVMszHqRzWRE/uQ8tYs5Hx1/yQUSIRMbAxhG+ewcm3dxjON/fwfhGbsjNdz
 9zTDRP/HggY0B08LyCiTHgAeE8EUVvys82WeMYPufhUyMe6KwbFj1fKI4vG547S73d+3eIWY9lA
 Z6hebWrCjv2vsd2ONAZmeozb/DY2T202tAYomH9sCW1zl7w3GnRh6Fp3tANC17snHgF6eHSIGEQ
 zNrtm2URkeiqTW5FoD3/V2Y35QmWXE0iErOiHWTQ3zn+nxXU1mKiPrXXuu1/i50eAau89Wa62oT
 yp1PnyW90BgTcUbNA+f/jvJepqBBJffWG9eiHOM14PHJorCfTg70ASSVyirDrTQfjBDpZDU8ADD
 7Tjmiq6GTiwMCmlgQhBhew1oihoRmeRKUpmUvXA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Make use of SPI transfer offloading to speed up data capture, enabling data
> acquisition at faster sample rates (up to 1.496 MSPS).
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

A lot of sashiko feedback so I only took a cursory look.
Please address all that (or point out why it is wrong!)

Jonathan

> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index cc6bc325f6ee..94d979c61501 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c


...

> +static int ad4134_offload_setup(struct iio_dev *indio_dev, struct ad4134_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	ret = ad4134_pwm_get(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4134_offload_buffer_setup(indio_dev, st->spi);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Start with a sampling rate slower than 374 kSPS because that is the
> +	 * maximum rate supported with wideband filter (default on power up).
> +	 */
> +	st->odr_hz = 250 * HZ_PER_KHZ;
> +	ret = ad4134_update_conversion_rate(st, st->odr_hz);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set sampling freq\n");
> +
> +	indio_dev->setup_ops = &ad4134_offload_buffer_setup_ops;
> +	indio_dev->available_scan_masks = ad4134_scan_masks;
> +
> +	switch (st->spi->num_rx_lanes) {
> +	case 1:
> +		return regmap_update_bits(st->regmap, AD4134_DIG_IF_CFG_REG,
> +					  AD4134_DIF_IF_CFG_FORMAT_MASK,
> +					  FIELD_PREP(AD4134_DIF_IF_CFG_FORMAT_MASK,
> +						     AD4134_DATA_FORMAT_SINGLE_CH_MODE));
> +	case 4:
> +		return regmap_update_bits(st->regmap, AD4134_DIG_IF_CFG_REG,
> +					  AD4134_DIF_IF_CFG_FORMAT_MASK,
> +					  FIELD_PREP(AD4134_DIF_IF_CFG_FORMAT_MASK,
> +						     AD4134_DATA_FORMAT_QUAD_CH_PARALLEL));
> +	default:
> +		return dev_err_probe(dev, -EINVAL,
> +			"unsupported number of spi-rx-bus-width elements: %d\n",
> +			st->spi->num_rx_lanes);
> +	}
> +
> +	return 0;

Unreachable code so drop it.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
