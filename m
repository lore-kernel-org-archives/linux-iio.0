Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BE3E8665;
	Tue,  2 Jun 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409132; cv=none; b=sxbUkRDo5zAtUpuipRjJlqwzwI1DJAJsci5otVabkplsTlZcIdukzXKswtzA6RMTYfksXqeXrsLYT2XGMCqqf1V5B+HL2POG9c4/EeQPoCXDAjIL1YRrddc5dTM7PWbZre7DGrl5no877R3/9x1SXaNzKNleWKbKF3mHy0j01QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409132; c=relaxed/simple;
	bh=09NL+un6rl4U4C7BsxVzArGjjqcEtQxdpmghDXTV0P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYDImyJkxcO5jnlLOg/z25ljN5CrgmuSFL/KJgZs1USjcvrt00xYM5xmXZoYi5qYRgMiNB3RfBoHQLCG1IaGDTsqUWe2hJblBrcdIbucWJvdvC5uj5xXzJDWNWT5TfrwzT+HYoQK3Xoa5fPaEGkUJalJ18KvOip3wd2zwT2Bo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyNC9PbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyNC9PbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA5E1F00893;
	Tue,  2 Jun 2026 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780409131;
	bh=RwmM6VRZg5l+0GvbV/xOvwKkYl5MibkLoOqq8L//Tag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IyNC9PbBLUb7m07qNRltiOyeQtRvHibdxXDofusCnxdqOqIt4C/b08lD6V+mwRPqe
	 BgL28PJeGQuqV/eJbVS20qes2l1HBYm/COYkyP2Y07yswps9weXUxe1EGr1P+R21eM
	 7KJ7WLfgFMTl7FIIB9ToK604upmNy55XdOpmLKiz15HDL9tjaI6F8nEPm0qWavjQ3a
	 BBxu4CUkOhJkeq2yijdjb9G/EgfZSBXAri7+70ZuMiu2QHi7V7LZ6+bPdT+g8afoKh
	 wAJL1DKVpSU8RJ3mTi+we4xWC+3DvtcHPQ44jeTJ1oxJzmcrtqh+WlyuhGdvlH5Jzw
	 A49aM5OXdfG3g==
Date: Tue, 2 Jun 2026 15:05:25 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 09/11] video: backlight: lm3533_bl: Set initial
 mapping mode from DT
Message-ID: <ah7jJbAKI6cAJbS0@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-10-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-10-clamor95@gmail.com>

On Mon, Jun 01, 2026 at 06:18:29PM +0300, Svyatoslav Ryhel wrote:
> Add support to obtain the initial mapping mode from DT instead of leaving
> it unconfigured.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/backlight/lm3533_bl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index 36e6f027613a..f0d88b7bc229 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -34,6 +34,7 @@ struct lm3533_bl {
>
>  	u32 max_current;
>  	u32 pwm;
> +	bool linear;
>  };
>
>
> @@ -247,8 +248,15 @@ static struct attribute_group lm3533_bl_attribute_group = {
>
>  static int lm3533_bl_setup(struct lm3533_bl *bl)
>  {
> +	int id = lm3533_bl_get_ctrlbank_id(bl);
>  	int ret;
>
> +	ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> +				 CTRLBANK_AB_BCONF_MODE(id),
> +				 bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0);

I guess this is another candidate for regmap_assign_bits() but with that
change:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
