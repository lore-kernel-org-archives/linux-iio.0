Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D62236EE;
	Wed, 22 Jul 2026 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683529; cv=none; b=tAcpnRhXaJiT9eOWSj4N0D6FsnxzZhP7t0MRF2+NIdhyjcqciJFUGP9EJZ4uMh3ABWQ5MCTXdDLJwuilUE/dROadOccMu627DpUoTQ0sz7uzBmgkl2NPlhLfdWsOs+GbZKifUcbmVJNS821Nu9feDT6L69Owml9tLDd/DTY7rCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683529; c=relaxed/simple;
	bh=ivTrIKDfkPt2OM3ODn/+YgLslgQIcl3AcMNyWAZ0tEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVL6kpMfTLkszTDWd7cgF6vEJuEJG899muSEYBN0tOf8HvAK2FMopJVi3EhKbLyKOm7hX3VgcuJPSdKGIwMNZOQlNhdkIYNp8Loh+ijhCg6lXmPcxm/8baZHeag0HhLeuL54nfeG474S0dokoZapFDGYgOP4WIhLE9xi7H7LneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrzEEtp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrzEEtp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A61F000E9;
	Wed, 22 Jul 2026 01:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784683527;
	bh=9JQDuIPMRGm1AZBtkGOnYehCcEprY2pwmL3Pl10VzPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KrzEEtp8KLGRhZLa23sHMQkSZkQARgkrTuXfo7+bgykg941ep7a1dOer7hfDEdtgX
	 i3a7qXPBxL70T8S1za8y3xhbo3oAhcysl8b3q/x+Hp1jqDCjELLOg8U6K6FyB1Y41e
	 Si+HkdkALZdVWmLFnlhQlE5sQWHaecnD6xkgqYCXoL3zD54CMBfhxBMAlH2fVzyapP
	 Wh4BbK9ygcdDC8Urom+mkq52dTiPfcv+bo2jD3/93YuLKhlgklT42L5YqtrFTin4hd
	 +F8v/E0zhYxbeerwwElAK8OfuC45YCoj82cly3pJTTdOTTf4SoJs+C7D1feQiPJLGQ
	 +zFV2rq62/DyA==
Date: Wed, 22 Jul 2026 02:25:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata
 helpers
Message-ID: <20260722022519.3b1e4fd3@jic23-huawei>
In-Reply-To: <20260617080031.99156-7-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
	<20260617080031.99156-7-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 11:00:23 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
> only in lm3533_device_setup(), which in turn is only called by
> lm3533_device_init(). Incorporate their code directly into
> lm3533_device_init() to simplify driver readability.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

>  static int lm3533_device_init(struct lm3533 *lm3533)
>  {
>  	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
> @@ -437,9 +396,21 @@ static int lm3533_device_init(struct lm3533 *lm3533)
>  
>  	lm3533_enable(lm3533);
>  
> -	ret = lm3533_device_setup(lm3533, pdata);
> -	if (ret)
> +	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> +				 LM3533_BOOST_FREQ_MASK,
> +				 pdata->boost_freq << LM3533_BOOST_FREQ_SHIFT);

As you are touching this maybe get rid of the shifts and have one source
of info on where the field lies in the register.

				 FIELD_PREP(LM3533_BOOST_FREQ_MASK, pdata->boost_freq));

> +	if (ret) {
> +		dev_err(lm3533->dev, "failed to set boost frequency\n");
>  		goto err_disable;
> +	}
> +
> +	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> +				 LM3533_BOOST_OVP_MASK,
> +				 pdata->boost_ovp << LM3533_BOOST_OVP_SHIFT);
> +	if (ret) {
> +		dev_err(lm3533->dev, "failed to set boost ovp\n");
> +		goto err_disable;
> +	}
>  
>  	lm3533_device_als_init(lm3533);
>  	lm3533_device_bl_init(lm3533);

