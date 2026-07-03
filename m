Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E86386441;
	Fri,  3 Jul 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072550; cv=none; b=ioLMPfC3BImO2YXNayJvlRJUV4VeKUiO2YKDmZHQNH40hiU2BQNOgAGnLR1IQNTvtQrHS/LxsYvgRwf0FaFZ60VT/QdiVo4Ae0GZf2qdFexoNGn5ha3ZH7HUv86JV2rXj+89MTrmv3DRAMG1xWeG/0u3YbCG4SaGfw37oh10AGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072550; c=relaxed/simple;
	bh=xqqVWlrEtKB4IAiKjKGR5fWksCcDTT/TguBL/MzbRFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVuRsLy3qO+3sUf0q+ISkVlgGm/vXDI/h5G+w7NW78zVGQLMcI0fYKnR7bR0wVZ//LVJhmMq28TkqDkxx+b0ZzTEIqRLOe3bXX/HhAr8OA3MrGmkp4aO93L5oy6f+GMjRbSp+UMWaOmD73AhyEHnKhpvn6ROAynK/fN/nD0DJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyh2XrQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyh2XrQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5AF1F000E9;
	Fri,  3 Jul 2026 09:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072525;
	bh=YpZ1jfCWhrVBcLjBi9vDokGbQRvmdQp3uAcCE7337Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dyh2XrQWeiEVFwIupCu8VvprLM0VyKHl84pR00aKeg+cAMJUq9hiOSn4OSBgRwpxF
	 Hfl45KLAqY84ELk2Vg8bEuk6RVCOswSlgMfLc8tsAG7sPZXopuI4Ay7fvxsFxu7i8v
	 Y56smDvKTM1lZIIqmENZ6Pvq/SLQ/3rIZn6SN5Uwqp9I3AcSOpilh/mNry1gEIXaM9
	 4zvns/YNjW7wGY/qzHI0/rdfsFhKcGF+ZN+yGa9E1KGcBX8w64joEdSy++LyFsXvPY
	 BRacyv5IKFgPT+9EAIzlnZToHYqi+xlDLiGyihmYFLUr1QtNJyXSPOQ7mgFx1wLHZp
	 yfSwghHm754ww==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfacF-00000000i1C-1qOY;
	Fri, 03 Jul 2026 11:55:23 +0200
Date: Fri, 3 Jul 2026 11:55:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
Message-ID: <akeHC-OA8tqM941f@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-6-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-6-clamor95@gmail.com>

On Wed, Jun 17, 2026 at 11:00:22AM +0300, Svyatoslav Ryhel wrote:
> The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
> are used only in lm3533_als_setup(). Incorporate their code into
> lm3533_als_setup() directly to simplify driver readability.

That's a debatable claim.

> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
>  1 file changed, 16 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index a9af8e2b965f..69bac1b202f1 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c

> -static int lm3533_als_setup(struct lm3533_als *als,
> -			    const struct lm3533_als_platform_data *pdata)
> -{
> -	int ret;
> -
> -	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
> +			   pdata->r_select);
>  	if (ret)
> -		return ret;
> -
> -	/* ALS input is always high impedance in PWM-mode. */
> -	if (!pdata->pwm_mode) {
> -		ret = lm3533_als_set_resistor(als, pdata->r_select);
> -		if (ret)
> -			return ret;
> -	}
> +		return dev_err_probe(dev, ret, "failed to set resistor\n");
>  	return 0;
>  }

There's nothing hard to read about the above. To the contrary the logic
is more obvious this way.

You also remove the high-impedance comment for no good reason.

Johan
