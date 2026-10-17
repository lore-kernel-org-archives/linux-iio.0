Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034C29BDBB;
	Sat, 17 Oct 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195266; cv=none; b=ODlvkeuq4w08gvLXQPgVZY0xg5JalPrr1te/uEu3jwmlWvZ9Wm/TlxBVAFS2rtLpeA6xjBYRYkiQV3TVo87aIEU2ODq2A8oi0JXKKgE3e4CWCkrXaTmbx7RJ0nw/mTZndQgIBDhUZfabrGrbSQvohE+8uqBlaJGw+T1oNMQ8n/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195266; c=relaxed/simple;
	bh=bbvyDCyl5V7rxc1BMkTXwlxZXxQVNgJhMBGAauiTPbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GW+36WJ8sQx7zuwWtn6xQMMQM4rtA2S44q/EtDsQ1XZ2Bd0QDzHzv73R2/8G5swzpNHBvA3rRpEX3XOqCCCy1Tv09pvw92p0LfguBIr1fYYzeCw85CA9iN8IMoCnmEp6xUiVxW8EFDfdlLdzSTyge6qmc8RhgXh8P4BNU4Eyh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZqjl9xz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZqjl9xz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AEE1F000C4;
	Sat, 17 Oct 2026 00:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195264;
	bh=mDyQS28YPpqG7oqyELh8/8B+SfUFxCQNLB98lk/aFPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BZqjl9xzSdQ5AIXTod7KOQ1pFfNmvP91PwiRQYtnroxCV4NRMF233B4s4PVKTdq4S
	 U4W7m53KTdyVpxgP2ey7IOyXOauy7h6F9v8sYuMnuLst4+0XfTO1MYIO4X83d+WdAU
	 Cyy/rccrPTBjikueKrLjOQgr/JNqZtXGomZWWnZrHvyvHLjW228NOMZaAiImbkKCuP
	 3EwIp6ZgmpQWo0oZC9//dtPr/W9r8jhhhW67Hs++GNLFioMZCUAv3paZs1GLLvJvbF
	 j4F4MQwgwItL0X/obr+fZEGGeXDVOrnonvRFMUWnt4XwCxiDnSGcTqcXDz9T8E3TfA
	 RL++vCK+/ZRyg==
Date: Sat, 17 Oct 2026 01:00:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: linux-iio@vger.kernel.org, Eddie James <eajames@linux.ibm.com>, Joel
 Stanley <joel@jms.id.au>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= <u.kleine-koenig@baylibre.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rupesh
 Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: pressure: dps310: add Zilltek ZTS8032
 support
Message-ID: <20261017010058.667e7293@jic23-hlaptop>
In-Reply-To: <20261016153533.3701000-6-paulius.zaleckas@gmail.com>
References: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
	<20261016153533.3701000-6-paulius.zaleckas@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 18:35:33 +0300
Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:

> The Zilltek ZTS8032 has the DPS310 register map, scale factors and
> compensation, with these differences:
> 
> - two more pressure coefficients, c31 and c40 at 0x22-0x25, adding
>   c40 * Praw_sc^4 + c31 * Traw_sc * Praw_sc^3 to the polynomial
> - TMP_EXT is MEAS_CFG bit 3, and the temperature coefficients are for
>   the internal sensor (COEF_SRCE reads 0x06). TMP_CFG bit 7 is the top
>   bit of a 4-bit TMP_RATE, so the DPS310 TMP_EXT write would select a
>   25/16 Hz background rate instead of the external sensor.
> - product ID 0x11 instead of 0x10, the driver does not check it
> 
> Add its chip data, reading 22 coefficient bytes and leaving TMP_CFG at
> 0, a Horner step for each of c40 and c31, and the I2C and OF IDs.
> 
> Tested on a ZTS8032 over I2C: in_pressure_input is within 1 Pa of the
> datasheet formula evaluated from the raw and coefficient registers at
> every oversampling rate from 1 to 128, and TMP_CFG reads 0x00 after
> probe.
> 
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Just a few small things.

Thanks,

Jonathan

> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index d0a2f6c6ec48..a97e82843dcd 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c

>  static const struct dps310_chip_info dps310_chip_info = {
> @@ -101,6 +107,14 @@ static const struct dps310_chip_info dps310_chip_info = {
>  	.coef_len = DPS310_COEF_LEN,
>  };
>  
> +/* TMP_CFG bit 7 is a rate bit here; the internal sensor is the default */

This is the comment that really confused me and lead to suggestion
of using a boolean for whether it was the external sensor or not.

> +static const struct dps310_chip_info zts8032_chip_info = {
> +	.name = "zts8032",
> +	.tmp_cfg = 0,
> +	.coef_len = ZTS8032_COEF_LEN,
> +	.has_c31_c40 = true,
> +};
> +
>  struct dps310_data {
>  	struct i2c_client *client;
>  	struct regmap *regmap;
> @@ -109,6 +123,7 @@ struct dps310_data {
>  
>  	s32 c0, c1;
>  	s32 c00, c10, c20, c30, c01, c11, c21;
> +	s32 c31, c40;
>  	s32 pressure_raw;
>  	s32 temp_raw;
>  	bool timeout_recovery_failed;
> @@ -211,6 +226,11 @@ static int dps310_get_coefs(struct dps310_data *data)
>  	c30 = (coef[16] << 8) | coef[17];
>  	data->c30 = sign_extend32(c30, 15);
>  
> +	if (data->info->has_c31_c40) {
> +		data->c31 = sign_extend32((coef[18] << 8) | coef[19], 15);
> +		data->c40 = sign_extend32((coef[20] << 8) | coef[21], 15);

Obviously lots of it here already but ideally use

data->c31 = sign_extend32(get_unaligned_be16(&coef[18]), 15);
etc

> +	}
> +
>  	return 0;

