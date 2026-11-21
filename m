Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304425;
	b=bnQzMhuFXd1W32LjhEESRyv9ewtgKj52YOG12GNZmW7P0xCQjn8YfRzXvLFBtQZLK/Lm
	 kYL/LBgstM6MC39zudImhzRpe/6lkfgmSnRXB4a4p/3t22ECNljxJDoz1qcDDKUWQ6WXw
	 1iuP2EA981rNloblt7tqi7zKkswyO2xryaJkNTR0ZWW152ysUtAhsIS3SaudFR83oMtAx
	 JGSCV9CvBFmVOYTzYa8PLeS492MbhnYXbHWllSVnPOPSo6D8SznCrKOOZ0brIaXpFqmGj
	 2y1mmMDJJl9XtLh+o1/2Dxi+7Mc8LmsHADoDy9quA+rHNGPDuqEB/VCvbMRN6YPbIHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304425;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GEoDwZcnGou1UJOraxPLD5sh8h1JR7DdmjoKvJQgqrY=;
	b=08wzrAwETEAzqJHjbHOvKdM7Y30zvJiF9kZQsw0tpDcBta3IC2UuxbCrTCJZLM3FpKxz
	 SyZPEjji9bnl485mQQIhLpISNrWxr8kk894WFymVpKWFFnVvus4tE3QT9O+JxJXdks0YB
	 Ypea6NQdp75j+R+RLNGlo/7xmVvwfb3OVWIfnovT5vC/yWkFb5WLPRgFH75++GDF1K66S
	 EdThUVjhh6jSlDZoFGCWf9StuvaJBrf8oeAHDmJs/YUk82BN1DzmIcXam1eJCbKeZqi2p
	 Bd53TbS3D2zDHFgwUd4Mt4DYhKjRQRZca1RZmNXAmcxFveibiqrqOWaRfifyHlJ7nJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7n94dUV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA5606A320;
	Sat, 21 Nov 2026 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7n94dUV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E9C1F000D3;
	Sat, 21 Nov 2026 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795304424;
	bh=GEoDwZcnGou1UJOraxPLD5sh8h1JR7DdmjoKvJQgqrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g7n94dUVtdkFYu9ExPfxfz8hdb1NubUDbNTvkiNEmw9Ziigm7deNjwMAeYiaarjtn
	 bw00i6RI5TXE0igWtwFbiZJGEy2m6BGvdPBrzbZCW4+uBNFqPwTsZ/0uXLQbsuJCuI
	 NWiVxLwWH9Cfmb2SFpoGgbuSA+5WtTAY3+cJrRqN9nD4I8gMfLAfWWAw2Fhr/ZdHtS
	 JAp/6rWfpCzut0a3lWnW+6wuqpBENBSvwl4HbRwDbt0NQr4vojIG0oVBNv1p8EBIlC
	 rV0fGxtAdWCZks4DvRWeooLWUZqYikF/T603fX99mjjCZ7T63GM/BUtLsHHDQXg8bt
	 FEjH62v458hEQ==
Date: Sat, 21 Nov 2026 23:40:15 +0000
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
Subject: Re: [PATCH v4 4/6] iio: adc: ad7625: move initial mode setup
Message-ID: <20261121234015.6cbb4bef@jic23-hlaptop>
In-Reply-To: <20261119112437.197306-5-Nicolae-daniel.Deaconescu@analog.com>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261119112437.197306-5-Nicolae-daniel.Deaconescu@analog.com>
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

On Thu, 19 Nov 2026 13:24:18 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

Rather than move, I'd say 'factor out' for the title and in this text.

> Move the EN pin mode setup from ad7625_probe() into
> ad7625_set_initial_mode(). Pick the mode first and check the result of
> setting it once, returning its error instead of -EINVAL. A following patch

It was only ever set once.  Anyhow the only bit of this paragraph I'd
keep is.  "Return error if reported by ad7960_set_mode() rather than
replacing it with -EINVAL"

> adds parts without EN pins that skip it.
This last bit is fine but I'd put it first as the 'why' answer for the
whole patch.


> 
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> ---
>  drivers/iio/adc/ad7625.c | 52 ++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> index ade2f2368bd8..127441050687 100644
> --- a/drivers/iio/adc/ad7625.c
> +++ b/drivers/iio/adc/ad7625.c
> @@ -561,6 +561,32 @@ static int devm_ad7625_regulator_setup(struct device *dev,
>  	return 0;
>  }
>  
> +static int ad7625_set_initial_mode(struct device *dev, struct ad7625_state *st)
> +{
> +	enum ad7960_mode mode;
> +	int ret;
> +
> +	/* Set the device mode based on detected EN configuration. */
> +	if (!st->info->has_bandwidth_control) {
> +		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
> +		return 0;
> +	}
> +
> +	if (st->can_wide_bandwidth)
> +		mode = AD7960_MODE_WIDE_BANDWIDTH;
> +	else if (st->can_narrow_bandwidth)
> +		mode = AD7960_MODE_NARROW_BANDWIDTH;
> +	else
> +		return dev_err_probe(dev, -EINVAL,
> +			"couldn't set device to wide or narrow bandwidth modes\n");
> +
> +	ret = ad7960_set_mode(st, mode, st->have_refin, st->vref_mv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set EN pins\n");
> +
> +	return 0;
> +}
> +
>  static int ad7625_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -595,29 +621,9 @@ static int ad7625_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	/* Set the device mode based on detected EN configuration. */
> -	if (!st->info->has_bandwidth_control) {
> -		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
> -	} else {
> -		/*
> -		 * If neither sampling mode is available, then report an error,
> -		 * since the other modes are not useful defaults.
> -		 */
> -		if (st->can_wide_bandwidth) {
> -			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
> -					      st->have_refin, st->vref_mv);
> -		} else if (st->can_narrow_bandwidth) {
> -			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
> -					      st->have_refin, st->vref_mv);
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

