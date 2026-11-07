Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016751;
	b=Rlj2GXG5h9xEp/NB7wL4sDCBWiNXNNd1ONGrA/8u6wUEb0GusuOyjn7593t3JnyUjrjB
	 gVu4/4BFAnfoCaRovaFtDOMaayfMAxuNsX0vDPKXmpYAL6h2prW4qWLwx8aLSGlXXcByJ
	 QoCYskVObI8hvzVwM66Km2TUMpsKPy7yzUuZHqpA0061/ehsKrQpvdaUbGVgtYs/LDTiF
	 n6yxlGMXUYHOsj5wklG/iqoAsHQOxJ9h5IkM+pvU/6zX25eRQqr4DUbOZNMJLWk+VkVv6
	 AupT/2qNNEDmt9ZkK47DVrinmyAA2RQ0Ss2CY9zOlvzzdjS2Iynrgww0IAxFEaot4rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016751;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OcDhDE6L4bEAPPrfTMal2LeXvYqMPVJ8tS715WizQu8=;
	b=yTiaWUdKHgjsyJK0AgflNSlAmRehYYPBTSmuThIcExTVYK0tQ79MuXGXQQ3v63/wuqi3
	 04UvcN3tnTLarxGQsweTZTZmu6AHSqCFdalUuXOzrbvbTBg7vpa6ZYf2C+V0Pi0u6XKsN
	 kOCnm63Tw9TH2sgTKpekX2wLuxBNiAlOfmUanHgIXSVgkEeIoR0uZQNQr5cGF537Xh8P9
	 cetK4yJctr4uLm17FLlxubW/iauf5F2GVEMMbXnu+ozQj0RBn1TenxYxCiOicTDo+Qxjr
	 SXRrujzhNRVusC5jNu1AxQ30Jq5RPUnmxIS5ADEsRl1x6xpSzV0MgARXdg2ZlOBcPhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6KwUO9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D4606A326;
	Sat,  7 Nov 2026 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6KwUO9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F141F008A1;
	Sat,  7 Nov 2026 01:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794016750;
	bh=OcDhDE6L4bEAPPrfTMal2LeXvYqMPVJ8tS715WizQu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A6KwUO9w5Wsd6z0DblW/JRpI/NrIcSTC24a/3pxvbw7oQTWqj+scWvrUBtij3EpCB
	 JzJji53aWR3XFRTdd1lAEcy8is07Ohvgca6IMpmv9917jBzb5S5BSuCqFaTzYh6TGs
	 IlQ6NJYy81v8kV0VH9mmaj0s1YfvQ815qPmD9lJqjQM20DuWfXsXQZxJnyd61ubUqu
	 Oi+rxr6KiFIb8v4+ig0Kz84iLt26sMDigAB7ICLDFKmbhqNNCWd1WzBL+qKxvLMft6
	 v3CTpV/CE73f+kU1xPhDsyeYDDFmMWS0u6U8atHXSX05BQ16VUu35h1AxN/yTR84W8
	 iOJSrXOQX4Jww==
Date: Sat, 7 Nov 2026 01:59:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Joshua Crofts <crofts@kernel.org>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] iio: adc: ad7625: move initial mode setup
Message-ID: <20261107015901.0167e32d@jic23-hlaptop>
In-Reply-To: <20261106160529.876251-6-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261106160529.876251-6-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 18:05:17 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> Move the EN pin mode setup from ad7625_probe() into
> ad7625_set_initial_mode(). No behaviour change. A following patch adds
> parts without EN pins that skip it.
> 
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> ---
>  drivers/iio/adc/ad7625.c | 57 ++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> index e699a7023b02..133c83df8a52 100644
> --- a/drivers/iio/adc/ad7625.c
> +++ b/drivers/iio/adc/ad7625.c
> @@ -561,6 +561,37 @@ static int devm_ad7625_regulator_setup(struct device *dev,
>  	return 0;
>  }
>  
> +static int ad7625_set_initial_mode(struct device *dev, struct ad7625_state *st)
> +{
> +	int ret;
> +
> +	/* Set the device mode based on detected EN configuration. */
> +	if (!st->info->has_bandwidth_control) {
> +		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mV);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If neither sampling mode is available, then report an error,
> +	 * since the other modes are not useful defaults.
> +	 */
> +	if (st->can_wide_bandwidth) {
> +		ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
> +				      st->have_refin, st->vref_mV);
> +	} else if (st->can_narrow_bandwidth) {
> +		ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
> +				      st->have_refin, st->vref_mV);
> +	} else {
> +		return dev_err_probe(dev, -EINVAL,
> +			"couldn't set device to wide or narrow bandwidth modes\n");
> +	}
> +
> +	if (ret)
> +		return dev_err_probe(dev, -EINVAL, "failed to set EN pins\n");

That's ugly given we are some distance from where ret was set and it
is eating the value.  I'd just duplicate it in the if / else if and
perhaps give a more focused error message in each of those (I haven't
thought about what it would be so maybe it doesn't!)

I know this came from original code, but seems worth tidying up whilst
you are here.

> +
> +	return 0;
> +}
> +
>  static int ad7625_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -595,29 +626,9 @@ static int ad7625_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	/* Set the device mode based on detected EN configuration. */
> -	if (!st->info->has_bandwidth_control) {
> -		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mV);
> -	} else {
> -		/*
> -		 * If neither sampling mode is available, then report an error,
> -		 * since the other modes are not useful defaults.
> -		 */
> -		if (st->can_wide_bandwidth) {
> -			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
> -					      st->have_refin, st->vref_mV);
> -		} else if (st->can_narrow_bandwidth) {
> -			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
> -					      st->have_refin, st->vref_mV);
> -		} else {
> -			return dev_err_probe(dev, -EINVAL,
> -				"couldn't set device to wide or narrow bandwidth modes\n");
> -		}
> -
> -		if (ret)
> -			return dev_err_probe(dev, -EINVAL,
> -					     "failed to set EN pins\n");
> -	}
> +	ret = ad7625_set_initial_mode(dev, st);
> +	if (ret)
> +		return ret;
>  
>  	ret = devm_ad7625_pwm_get(dev, st);
>  	if (ret)

