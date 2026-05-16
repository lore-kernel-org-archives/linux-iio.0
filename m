Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468302750FB;
	Sat, 16 May 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949809; cv=none; b=mIvCFFop17an+Kxtr862Gz/gHE6xXlj/0iGkMLoPNWycMldijzVc9TMlMLwEHQkS0p0Allqr2JL9L9e4w3pb2YhibQVNVrjk5a8kW7joACJ+EcGkiiFkLruWoKVlOtVlo/j5/HNLtwFUm4EhI6LVQoqtzEKzsRTGzu9en4rEObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949809; c=relaxed/simple;
	bh=NfHy2FDDpiyvBxXVBseWqTQgrM7XfCcCYDjCRbyQZtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEnvHB1D/HMCZPZ0l5+EDKxoG5p4NLjNQC7BoYkOep4cGdoV0VKkmAm/ZJzRof2uZPIilrgIXczTC1E3KxoO8B4qW+zy40oUhjCfLXkxPWC1xCzlgtTFEBrTdqBc5CcL/5xHJo+ryfUjsty2/M0oyqRfRWx/DzLlN+RtfZD8fAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX+waRUY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX+waRUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAEFC19425;
	Sat, 16 May 2026 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778949808;
	bh=NfHy2FDDpiyvBxXVBseWqTQgrM7XfCcCYDjCRbyQZtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qX+waRUYUSpStVNRh620djQbEDHJ0zuT4WVPkze83DO4ADQNdG1PwGQC3DptZgX2P
	 uSN1NvATpIXSjeR3cXP+dwWuysEgah3N5O6SMOQSScnsmaR6XS68G2xUQ0XRI4m9UL
	 MHIMh/mL3Xd6Xg1gPR39Osal59nLZm2ftRA57BQgWeTZOJJ/r4v8GKGyOmpGn7+Nwa
	 5dq7dbhHyqOHR2hIqJPhaxE7RKBq49u3tQNMyyxCqXhObI3k60tMmFetY7+2xXCFk4
	 KxUCifTEYmtEH5iIJl6Q1v2Xsr0s2hwlYVkiWhIcRB43rNqJdhXQZvdXSn2gdIJ940
	 oEdpWIf6G3gwQ==
Date: Sat, 16 May 2026 17:43:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] iio: temperature: ltc2983: Fix macro
 parenthesization and rename
Message-ID: <20260516174318.3d613a42@jic23-huawei>
In-Reply-To: <20260514144712.64374-2-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
	<20260514144712.64374-2-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 17:46:48 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Wrap the 'chan' parameter in LTC2983_CHAN_START_ADDR() and
> LTC2983_CHAN_RES_ADDR() with parentheses to prevent potential
> macro argument expansion issues. Also rename LTC2983_CHAN_START_ADDR
> to LTC2983_CHAN_ASSIGN_ADDR and LTC2983_CHAN_RES_ADDR to
> LTC2983_RESULT_ADDR, to better reflect the datasheet names and avoid
> them being confused as related.
> 
> Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
Firstly 12 chars of the hash is enough.
Secondly why a fix at all?

Looks like a readability improvement but not something we'd backport.

Also as Sashiko points out you need to mention the additional parameter.
 https://sashiko.dev/#/patchset/20260514144712.64374-1-liviu.stan%40analog.com

Also, build your series one patch at a time.  This looks like it won't build.
Jonathan

> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> ---
> Changes in v2:
> - New patch.
> 
>  drivers/iio/temperature/ltc2983.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 38e6f8dfd3b8..a292274e6ff0 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -56,10 +56,10 @@
>  #define LTC2983_EEPROM_WRITE_TIME_MS		2600
>  #define LTC2983_EEPROM_READ_TIME_MS		20
>  
> -#define LTC2983_CHAN_START_ADDR(chan) \
> -			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
> -#define LTC2983_CHAN_RES_ADDR(chan) \
> -			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> +#define LTC2983_CHAN_ASSIGN_ADDR(chan) \
> +			((((chan) - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
> +#define LTC2983_RESULT_ADDR(chan, base) \
> +			((((chan) - 1) * 4) + (base))
>  #define LTC2983_THERMOCOUPLE_DIFF_MASK		BIT(3)
>  #define LTC2983_THERMOCOUPLE_SGL(x) \
>  				FIELD_PREP(LTC2983_THERMOCOUPLE_DIFF_MASK, x)
> @@ -351,7 +351,7 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
>  					const struct ltc2983_sensor *sensor,
>  					u32 chan_val)
>  {
> -	u32 reg = LTC2983_CHAN_START_ADDR(sensor->chan);
> +	u32 reg = LTC2983_CHAN_ASSIGN_ADDR(sensor->chan);
>  
>  	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
>  	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
> @@ -1197,7 +1197,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
>  	}
>  
>  	/* read the converted data */
> -	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan),
> +	ret = regmap_bulk_read(st->regmap, LTC2983_RESULT_ADDR(sensor->chan, base_reg),
>  			       &st->temp, sizeof(st->temp));
>  	if (ret)
>  		return ret;

