Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E63C1D65;
	Sun,  6 Sep 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666637; cv=none; b=MTpFoPKatIzpKl8zcfzrL5sj6uuW3xlRCmUAaXaUo58VOgpX6qxwuq02kciW/qAnzupcg7zRSAK0NXo7H3h2MnsykrFhrYPKeJUDaS0Xp9DdsGdJUBduZHNNzA3Kgpu6ILOY5BHuwW1sJczIZN/d443GfwFn870boDpWFnshKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666637; c=relaxed/simple;
	bh=Eaj9B23kkLTusQPr8k5w09gxhCHcQ5N6qdfjmpR9gXU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=sBpgZ8g9T9vhyrqNoapHYSvgZwqvpokjK/C64dSVUwg4tLm7Lwee5bEE9KQwtDdbGL0yoNaSmSQpClOL89qgq/qCn0MT4QvPfhcUKb8F3tts3WHFrPujIRWg2GzojB0CS+dprjm6V0kYp8o5QRJVPcg7H73Rmvbb4Da5fqexbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH6URtcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH6URtcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555BF1F00A3A;
	Sun,  6 Sep 2026 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788666629;
	bh=FP0Wy8wv/onkLi7BI6os9tMyVU+uf8yn3Vy9qx3uLsI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=KH6URtcFo7JywUUl2nq8l+DhfJMfipKvtJYzA/tt4ZuAW389bkX7/6L2bIq7rtvz/
	 EzRVC4YRaK4C3m91SMKEKBvTRVAh8yCLU6psHbq7AWcyCp/fEJwH0IdHDhxX3ZKuv7
	 4sC3qiolOqBNfZzdDK/0AUIU2aL+BbIUSnoI5I7Xf8ulkKfvlUteWl2IJxgNzOGt9f
	 3i13R+7LoGZWy4952HQHrE52JHP4h71et5ntFA8GbTZ2M9h7G9Eb88ilUkBTqWqshF
	 ZoDBzTszLKT9SAVcaoUDijnSfIWd9sAvpsfcWuC2WzTdNjowazS3h7W3tT1KokiSkb
	 XvsWz4YwF3JNg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 07/17] iio: adc: ad7768: Add power mode helper
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
In-Reply-To: <20260904-ad7768-driver-v6-7-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-7-e4378f946bfb@analog.com>
Date: Sun, 06 Sep 2026 04:50:02 +0100
Message-Id: <178866660278.3402141.4610124139369513566.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=Eaj9B23kkLTusQPr8k5w09gxhCHcQ5N6qdfjmpR9gXU=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnOL+nwTtCr/BmdO3QCO7WlXlHUnKXb1PSzeb5
 IcQA3Ydj9eJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzi/hEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiHQVD/4oMk6MzHV1nI+Mqqwe/23gvlKuna3KEHCJM3CqgzmGKNM
 6N37YiaBmuHKeLyXUB3dm3TCAJUU+TBHGHLH77G49xt64FZracVdQj+BkIGi24jbQ+5upLMxL/A
 KBg9VyMPyNZEx8L4bVEucjb1SvPBfw3IG0XtPdiaid+bmxnymFKkXfY893eyzTv+wHlMjUKbRl3
 SA5Hxp68u6qurcZkZ9U9SXFfniwz+HmLtoc2dA2R8xP5Mhf12sF87euZSXb/xBAN7WP5sPO/MWx
 FD0dovgTqEhBiktAcCvkfXOJjQzYLuI1HoKPgKIPzu6hbQyd2Hv2rFZHZZL74cpRsHAWXKunGTU
 Brx+2IUfMpoy6CtQAzU/698divEs8FDPIScqInfPeQW4Tx2cRysLXwTE21pI76ixeaph78dOIEq
 5BaZjAssdUIYDGEf9IRKxgKsepLUIsrh9Los19TMMAZ/Xczg3I6ew1du2O0XLT1mcyPUPOcMnb+
 StdHX1kpcvZUEqAxEXCFPFAasTvF2P7LNN86UrsJxt5z2qGcl5ABAkAzUl4seUN8bMIluAL+TPB
 3euqwOEBuC2xIQ0FuO2rsKcb54xF76x2Z6y3BQrMkeTfuA5xSWE4haUb93ypEBgBtHol9e31VTi
 nvjUJ38FRr7S0UMfGpNemRWaRhfU8mYsXVg06cw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Describe each power mode and its internal master-clock divisor in a
> table. Replace the open-coded fast-mode setup with a helper that records
> the active mode, preparing for dynamic mode selection.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

A sashiko comment that if nothing else suggest a nice little
optimization if there are no ordering issues. I haven't checked
the datasheet to be sure if there are or not.

>
> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> index 707f3ae70a95..71db57a2b9dd 100644
> --- a/drivers/iio/adc/ad7768.c
> +++ b/drivers/iio/adc/ad7768.c
...

>  
> +static int ad7768_set_power_mode(struct ad7768_state *st,
> +				 unsigned int mode_idx)
> +{
> +	const struct ad7768_power_mode_info *mode_info;
> +	int ret;
> +
> +	mode_info = &ad7768_power_modes[mode_idx];
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				 AD7768_POWER_MODE_POWER_MODE_MSK,
> +				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
> +					    mode_info->mode));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				 AD7768_POWER_MODE_MCLK_DIV_MSK,
> +				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
> +					    mode_info->mode));

Sashiko:
[Severity: Medium]
Does splitting this register update into two consecutive read-modify-write
operations to AD7768_REG_POWER_MODE create a problematic transient hardware
state?

Updating the analog power mode first and the digital clock divider second might
leave them temporarily mismatched. If the analog power mode is updated to a
lower state while the clock divider remains fast, could this violate internal
timing constraints and risk ADC glitches or unpredictable behavior?

Could these two fields be updated in a single regmap_update_bits() call to
avoid both the transient hardware state and the redundant SPI bus overhead?

-

Is there a reason to split these?  If not even if the transient
state doesn't matter, it would be nice to avoid the double write
and update both fields in one go.  You used to do that in the default
state setting that was removed, so good to keep that approach if
possible here.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
