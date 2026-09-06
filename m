Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BF3C1D61;
	Sun,  6 Sep 2026 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666635; cv=none; b=RlLVJaXw/1HZHe0alNyxJ7Y6TqBtNtZBNthxF+qCqsPHjEvaMaZjfskB5VllfnJFSeO4226Q0r1nXBTUcFw4IMr+ib14GZVVNyFejBKklRFL6LelBJPLQQQBMDpztPz7XMX9rquM6aauXaHkxMcWYZTFmFsghCNQ/XBf0plclSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666635; c=relaxed/simple;
	bh=RLov6ub4IeYD2dBYNyizsvoeVF+xvQDYZ2GF9N+CUQY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZUCS8RhKQEROS5kAWL74nemBDLONh72tDk7Uy4s+ORbfqU5gc2/d3hEdEAADRdpEVHqJL2wTGovi1dStFBLvOCLwI6vt6gq9W6ZVXrjmewXsiOLtkm6ylmzlIWqMJ5rrJCmLcg9MolmzEcBryT6UlFJwm49sYwlhsq1kbFd931A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml3eMwH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml3eMwH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83DE1F01558;
	Sun,  6 Sep 2026 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788666630;
	bh=hYuMozF6oBnraAHP2IxcyWNz9ALz0nYQbUmD97cNFC4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ml3eMwH0Nd7iTAM/vhBbaiWgvp+s8AO/6jo5fVKy4esU/qYq+5DqPUiGB9zVpjpC+
	 ruk+Oc0Qg9XxCWe/4MWiBLDVsys4zNpyU+1u0x5CFTBvRC5d1EcDJIPkq6JqaSiIh5
	 QwkPMIQ81PxNJnHYd83R1Rp+XtPWzmWwseBLg83ZHkhmx82ZkmJ36AVt8ouZAqu4td
	 sSd532XzLQRt6g/Qe78H68Dk8mis/VJ6HoYmt//4ch50RH8HZL0N2Eu1weoVLLSL8Q
	 2UtiL9MfuAdhJa4CQIHU1KoVXEgM6KjJkfAhoHc+0IbfLWkAu6SVyi2hwecM/n5OSH
	 ut1AZZ/BeLMTg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 09/17] iio: adc: ad7768: Configure channel sampling
 profiles
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
In-Reply-To: <20260904-ad7768-driver-v6-9-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-9-e4378f946bfb@analog.com>
Date: Sun, 06 Sep 2026 04:50:02 +0100
Message-Id: <178866660279.3402141.11547396116481181450.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=RLov6ub4IeYD2dBYNyizsvoeVF+xvQDYZ2GF9N+CUQY=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnOL+8jtY6tmLEQrmEiDA6ZQhbzJik80Itn7ah
 6mJWu+jwS+JAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzi/hEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiEsXEACVYm5edRwtHsNbSr97cxuSaOR+6pPwaJVkvnZmY+AU5z6
 OGwbIc1ZWKPpSxRF6UEpR+e7pGu0osB7jgZlLl3ioV9Mruy48yudrT7w6mMSBijuDR29OTTWviS
 oebz/cD7f3vWoUAmhiCYQujlesWO2XEUrf0hsonq5XgK/cpIhqK24yXmmlpYLzBQ4YGpfSI6/A5
 Qtw8qrRCIC/kTIgv9eJdX0ki7smc6JVqMhXm5lIGIuxFUmFLtODHt2IJROHNpg9DP3/Wt/TZ3cA
 XGnPOGky/KU0Fl4ovdgnWnMaQPnGmtfogaMbTovtvp8ehfbG8qdfOchMUcFKvcDAK7nsvtiC/fe
 QZMstVsRoUiq3QqRkoecaUaU1RGSDE9Z2HPO7QpuWEROS+NV9hhUmMbiODnnbDFPbxDjt6xFJAx
 mxQfnc9DidymrMVDqUDGFVSaH/ZmSuVM6WYz5M9VqhDTg6blHeA0j2YNyotpaVcaqj8ABn6yuXX
 1FSLHep/094hhkvx6CnRUvAQeH0JRobzoklxrTwjDna59PtcCojvA9AODSqLdr3Um+So+oQJC3k
 pZiBA7rMy7N8TvrvDnOugP5uNCQv8azXk6Ww1XWUzVfgwHTZdNfa55zx8aT5hxBxYMZlyv2vD2e
 DD4AAV942R4HGU0SHU/XRcILZMuG/zg8DtsQCYA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> At buffered capture setup, select the fastest compatible power mode for
> the enabled channel rates. Group channels into the two hardware mode
> profiles and program their decimation, mode selection, and data clock.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
There are a couple of sashiko comments on this.
I'm not sure what they are going on about, but please take a look
anyway!


>  
> +static u8 ad7768_channel_mode_mask(const struct ad7768_state *st, u8 ch)
> +{
> +	return BIT(ch) | ad7768_channel_mask(st, ch);

[Severity: Medium]
Does this bitwise OR inadvertently combine the logical channel index and the
physical channel mapping?

When this is applied to the AD7768_REG_CH_MODE_SEL register, it could result
in writing to reserved or unmapped hardware bits, which might lead to
unpredictable hardware state.

--

I'm not really sure what this code is trying to do so hard to comment
on whether sashiko is right or not.  If nothing else this code
needs a comment as it is takig the | of the raw position with one
that has been through the channel map.

> +}
> +
>  static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
>  {
>  	return GENMASK(st->chip_info->num_channels - 1, 0);

> @@ -478,11 +544,66 @@ static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
>  	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
>  		__clear_bit(st->chip_info->num_channels / 2, &standby_mask);
>  
> +	for_each_set_bit(c, scan_mask, st->chip_info->num_channels) {
> +		unsigned int mask;
> +		int mode;
> +
> +		mode = ad7768_find_matching_mode(mode_used, mode_freq,
> +						 st->ch_freq[c]);
> +		if (mode < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Over %d channel modes required\n",
> +					     AD7768_NUM_CHANNEL_MODES);
> +
> +		mode_freq[mode] = st->ch_freq[c];
> +		mode_used[mode] = true;
> +
> +		mask = ad7768_channel_mode_mask(st, c);
> +		ret = regmap_assign_bits(st->regmap, AD7768_REG_CH_MODE_SEL,
> +					 mask, mode);

[Severity: Medium]
This applies the multi-bit mask to the hardware configuration register.

Could this configure unintended channels or interfere with device compatibility?
-
This is just the end of what happens with the above.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
