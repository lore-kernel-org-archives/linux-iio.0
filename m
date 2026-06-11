Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9847F9E8;
	Thu, 11 Jun 2026 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195875; cv=none; b=Dnrg4qyczii2m7oaXpQ+eg1umbBqE+Jy7hJVzgQVjRPMSNgmVKWcBzwDOkS1XGobIkUh7TcHCVQZ6GDwGBiHzcvNqxpc/WsrJdiRL0Y+M58uwg3Asqla0ROD30JbLvm4rzSMN1wnlLJdDXc1IAcy8rU36d8Mo8MdEqVpOenfJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195875; c=relaxed/simple;
	bh=Czp49NyWJhyOcAe+nFbYDUszD3TnaiMKBGQg3us4D+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5zzD6fxVoHZ0GJVFlCbBIcX5lhgEVoeIXZcQ2SLe414FCWeu2PemjPabiMhh7Uf2K8GcSZdc0qPaB9BWp6klYETXUpz/778IepI9G4N4yCkgeHsoqxiH5mAfvyEHbHDuLiIYD5lJN9TKckBd8YjZVZljx72v2ZtEfGNa8FjyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okaG9bdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okaG9bdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070CD1F00893;
	Thu, 11 Jun 2026 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195874;
	bh=ef0nR/F/3mauVtjPQKNzv0MDN5cCbO2Pdn8BUSaOyxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=okaG9bdiR0+20Z2ZlUm2AZfM/nYhVULe6RDzWHnaRvEBHroTojrpfwlptOET66ZiA
	 LHiZgcVYzwnzyRk7IENhOSxWu8MFc6lvQeqxwcqqq/VVgOEKSOzw5AEsBzgNt13C3X
	 QyVc7Ru+IsBM7hgT1nA7hTZT19XrWi9VYnbH/vAFXguoHRl+Zd4s+yy3BwyPd4RnKb
	 OTjF+LleVIyGNWhC+5Xg5iyP/YkPGPpr36JlFVI5NP0lfNw+UF9oAkTMj6+6LGcT1+
	 ObsNTmr8+Q5r5sXFbOSMuj9eR5x8NImDfijzM6x7FzU8jmoqZHoGG7Xr7/NOKUXMTz
	 jnHBSoHogBd3A==
Date: Thu, 11 Jun 2026 17:37:48 +0100
From: Lee Jones <lee@kernel.org>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 3/4] mfd: mt6397-core: add mt6323 AUXADC support
Message-ID: <20260611163748.GB1212816@google.com>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
 <20260602-mt6323-adc-v1-3-68ec737508ee@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-mt6323-adc-v1-3-68ec737508ee@protonmail.com>

Interesting.  Has this been considered?

/* Sashiko Automation: Issues Found (1 Findings) */

On Tue, 02 Jun 2026, Roman Vivchar via B4 Relay wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> The mt6323 PMIC includes an AUXADC. Register the AUXADC in the mt6323
> devices array to allow the corresponding driver to probe using compatible
> string.
> 
> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  drivers/mfd/mt6397-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 3e58d0764c7e..013b0857fb54 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -125,6 +125,9 @@ static const struct resource mt6323_pwrc_resources[] = {
>  
>  static const struct mfd_cell mt6323_devs[] = {
>  	{
> +		.name = "mt6323-auxadc",
> +		.of_compatible = "mediatek,mt6323-auxadc",

[Severity: High]
Does adding this compatible string expose an unhandled edge case in the
auxadc driver?

If this device is instantiated directly from a Device Tree without an MFD
parent (e.g., at the DT root), dev->parent could be the platform bus
(which has a NULL parent) or NULL itself.

Looking at mt6323_auxadc_probe() in drivers/iio/adc/mt6323-auxadc.c:

    regmap = dev_get_regmap(dev->parent->parent, NULL);

Could blindly dereferencing dev->parent->parent here, or passing a NULL
device to dev_get_regmap() (which calls devres_find()), result in a
kernel oops if probed as a root node?


> +	}, {
>  		.name = "mt6323-rtc",
>  		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
>  		.resources = mt6323_rtc_resources,
> 
> -- 
> 2.54.0
> 
> 

-- 
Lee Jones
