Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E69381AF1;
	Sun, 13 Sep 2026 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332732; cv=none; b=K4KeNi53L2FtJl1byUmg+gffDdXyEXMcVbj31Wst1qyrpVLh7q0hx6TPUgAkqdPEfNkR18DldtPvWuwMU33GDJyVo1/NL3ThHtcGM8ifl0YdnVx/doUd+M29CcKtBmAltyeUjkMwgxl3yIqVscUBNCM5HOk7KwGDuMUI1p2wYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332732; c=relaxed/simple;
	bh=MCGdrRYJULoLW56qLOMGtzGYAB4mtYZNs/cTtMAHWJE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cJYHCq+KPUnzJEQE9Y4KYfDn2/mr0sJHzRmTaUKsUlIzgzefjoLKXTPGsN+5wnJfEjbEMMkaF97W7dHWuxZ/+HW42KRJq6uNDaRgtLI36jbYVcK7TSHHtE2LronMqwVgvsqivVgfuU5RFxC6K4bLeorFaeSvRbxQScjkZobGUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0J8vaU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0J8vaU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050351F008A0;
	Sun, 13 Sep 2026 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789332731;
	bh=TjVxCbAEbneiu/1aE0gLYluR9jIDsZDKOOpdr+iR0XE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=g0J8vaU9xrYyiFPapyiUf3C14jq16odOght7ZahZtp9mtWKE8fYiyTRnflF5Gch6e
	 Vxl8foPvNJNzqIidKvAH2A1vFjoGFNMujDFJXmVYWq1S3HUjVN27zGOM1EFRIp52OE
	 XQckZ3fmAigg6vapR/FWE/DK7Fc6v4RaQRCMC5+t2vODqWwo9iNZjD3HpstTzhwBEX
	 W2IFhLbLxiFVhF68ExCXYyfKIZBl9je9vyvy6+pA0naOXeCPtStalIV/GcrT6JNrXp
	 uKWppiObzbvnQiZ+pzzXgZq3N5sNJWr9QP5OY55F4v0A5tv76P7cdrhph19+vackT9
	 LPAPcxxBeBLaQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 07/17] iio: adc: ad7768: Add power mode helper
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260910-ad7768-driver-v7-7-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-7-7f70b07627e1@analog.com>
Date: Sun, 13 Sep 2026 21:51:54 +0100
Message-Id: <178933271416.413489.11205164036404426330.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=MCGdrRYJULoLW56qLOMGtzGYAB4mtYZNs/cTtMAHWJE=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqpwz46oOaWYRMAG9k1e6lx5HlIKM4n5ceFM89y
 dPDpFFjxmeJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaqcM+BEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiGpPEACi+0LPpq6PeXMDHlykkQnggBbE3g8ggsjfm5lOnIrs/GO
 2Y6KyM8edwnqQxChG2ixaIfM9HOvRo3WUi2iR1A4CVKbi2qS27TRVG5t+YIUiNVIxDx3tMucymT
 Abk1fLPkS1Rf0+AIKi/ggBZWdHzcazkVWNroiLKF2zXhsfCb4auSx4H69rioVjoRZEu5BHXuOGv
 0Baakzsfg0Xnz+Vmjp2pKU9jJbxQupLaKLa+vJ4nX0xCkJA2gtUBx3RE9MZ5ftihFgpBrKCc71Y
 5FLRJ88x1wMGMt+3sLQ3TFLqLW0FThl2/3h6rkdwBqS55ujkS/nAClaYLqwzGPWbX6NtgZqb9ZY
 Z2Lw9I85dQDg0Lx5dORCCnnGKkwdL0gCapipDQn/J99Z2GUJoED0yZwVS9TB5qHrtqfaIlEOMtk
 LNVZ6s8shP34soW5Xc0hyQknYQHjCHRz2pvfaATVLjkpCoT3LihBXqTzTSTfFhDO6hi0r94k6Fx
 sMjLoef7dwFgCN4AB9XvGdbAhANygNq7NoebANvXZxUWJR8sJ7/e9lhY56I5vDhjAkS/tbJ2L3K
 AfBfYHNBg64FIP3ORQFGXzKYm7sqMBTVWCJsUJqXU6Yxllz6B+LMCmppy8qnc/LWZW/x6JiLNm7
 0YihU9LPZwBlz/+cY2vulQmJatB5RYdVh18237w==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Describe each power mode and its internal master-clock divisor in a
> table. Replace the open-coded fast-mode setup with a helper that records
> the active mode, preparing for dynamic mode selection.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

This is just highlighting some feedback from sashiko.
I have very little idea what it is talking about!

If it is garbage, just reply to say so.

Thanks,

Jonathan

>
> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> index 44ba19fb2096..be815b8c6766 100644
> --- a/drivers/iio/adc/ad7768.c
> +++ b/drivers/iio/adc/ad7768.c
> @@ -41,6 +41,8 @@
>  #define AD7768_REG_POWER_MODE				0x04
>  #define   AD7768_SLEEP_MODE_MSK				BIT(7)
>  #define   AD7768_POWER_MODE_POWER_MODE_MSK		GENMASK(5, 4)
> +#define     AD7768_POWER_MODE_POWER_MODE_LOW		0x0
> +#define     AD7768_POWER_MODE_POWER_MODE_MEDIAN		0x2
>  #define     AD7768_POWER_MODE_POWER_MODE_FAST		0x3
>  #define   AD7768_POWER_MODE_LVDS_ENABLE			BIT(3)
>  #define   AD7768_POWER_MODE_MCLK_DIV_MSK		GENMASK(1, 0)
> @@ -102,6 +104,17 @@ enum ad7768_clock_source {
>  	AD7768_CLOCK_SOURCE_LVDS,
>  };
>  
> +struct ad7768_power_mode_info {
> +	unsigned int mode;
> +	unsigned int mclk_div;
> +};
> +
> +static const struct ad7768_power_mode_info ad7768_power_modes[] = {
> +	{ .mode = AD7768_POWER_MODE_POWER_MODE_LOW, .mclk_div = 32 },
> +	{ .mode = AD7768_POWER_MODE_POWER_MODE_MEDIAN, .mclk_div = 8 },
> +	{ .mode = AD7768_POWER_MODE_POWER_MODE_FAST, .mclk_div = 4 },
> +};
> +
>  struct ad7768_precharge_config {
>  	bool prebufp_en;
>  	bool prebufn_en;
> @@ -127,6 +140,7 @@ struct ad7768_state {
>  	const struct ad7768_chip_info *chip_info;
>  	struct iio_backend *back;
>  	unsigned int vref_uV[2];
> +	unsigned int power_mode_idx;
>  
>  	__be16 d16 __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -330,6 +344,32 @@ static int ad7768_sync(struct ad7768_state *st)
>  			       AD7768_DATA_CONTROL_SPI_SYNC);
>  }
>  
> +static int ad7768_set_power_mode(struct ad7768_state *st,
> +				 unsigned int mode_idx)
> +{
> +	const struct ad7768_power_mode_info *mode_info;
> +	int ret;
> +
> +	mode_info = &ad7768_power_modes[mode_idx];
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				 AD7768_POWER_MODE_POWER_MODE_MSK |
> +				 AD7768_POWER_MODE_MCLK_DIV_MSK,
> +				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
> +					    mode_info->mode) |
> +				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
> +					    mode_info->mode));

Sashiko:
[Severity: High]
When configuring MEDIAN mode via ad7768_set_power_mode(), does this code
inadvertently configure the MCLK_DIV bitfield using the power mode
register value instead of the correct clock divider register code?

For MEDIAN power mode, mode_info->mode is 0x2. Writing 0x2 to the MCLK_DIV
bitfield sets the hardware divider to 4 (MCLK/4), instead of the expected
divider of 8 (MCLK/8, which requires register value 0x1).

Since ad7768_power_modes correctly defines mclk_div = 8 for MEDIAN mode, the
software will calculate output rates and delays based on a divider of 8, while
the hardware runs twice as fast.
-
I haven't looked into this one so please check it out.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
