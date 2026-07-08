Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057B3EFD07;
	Wed,  8 Jul 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545062; cv=none; b=P/tZ7nH/hy4+VXpFDT7Vw0szDOagdEAGhQ87efR6vJggOCY7jJVsnxwI9gUwxZEuT+nAgo535NxN2vbWI+A2W+VaIT/GyRzhTf6d9E5w8KVmZDsl/Hd/pYo6JX1Y9txqyU1e2ngjnd8Ff5Ekkt9bWTIYkxEg1FSJNFidIndEFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545062; c=relaxed/simple;
	bh=JFWZOyPGpgvPIKoXB9WjWQ8d7pCeLRsaN96svQ8fHNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/L3lhlFjj35H3hrUoROeFHHtRguwE9IRRCWy3WqPwlF6IHm1Mq/FbdL9C+b/+5751RASj3LSZFkzWKuQOKDD4tRfYVMshXUbVSeZFc/d/Wk3jDQQp/dSjgkxNbc3L/PMWs62sKnV7kqbhHsa7iINTsd4XnBh1DSNIK+NvJLwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dekQRjgj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dekQRjgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEF91F000E9;
	Wed,  8 Jul 2026 21:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545061;
	bh=tkJStVQQrBUVTUaskhv5zoU/YZtR/Z//KEgb+Nu4U5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dekQRjgjNEfXhlQmyfoUDHiLn7BOa1vrUXPYlOF7nZT0gYD6oWWmhiYaf1OQ34y31
	 qbk2C0vFSHkKFrQSQrGyMQWPiMLPaKBRt7Q/Cdoyk8W3jGRGBtPQN07cQm6DaL94DJ
	 liYCCyfJECEuEN9RP9GTZpUqVsh1vA7E2jpW+il+Afq+NyvgBUWpXE49gsa6njMmm5
	 pIBI2zhomAjp6hSuqoOZ2DwGWQG5OW+HXEZUMS38cM2HFh2pYITcTKOdCkkNECtRbu
	 XDVCXFhBzOP0+TcbgG3tosHfbUe70o7c/6ZnxShy8QP07T6fDX/4V0IvI5rLU5VoEn
	 Nmh0+1GaRps4Q==
Date: Wed, 8 Jul 2026 22:10:56 +0100
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
Subject: Re: [PATCH v4 3/4] mfd: mt6397-core: add mt6323 AUXADC support
Message-ID: <20260708211056.GB1727174@google.com>
References: <20260623-mt6323-adc-v4-0-299680ad3194@protonmail.com>
 <20260623-mt6323-adc-v4-3-299680ad3194@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623-mt6323-adc-v4-3-299680ad3194@protonmail.com>

On Tue, 23 Jun 2026, Roman Vivchar via B4 Relay wrote:

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

Doesn't apply.  Please rebase and resent with my:

Acked-by: Lee Jones <lee@kernel.org>

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
