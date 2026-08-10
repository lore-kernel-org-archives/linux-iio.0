Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0B3264C8;
	Mon, 10 Aug 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377008; cv=none; b=p6k8L0xP7GGH67R8W0nEdOmCOrmGeNmIjPSPRyf6569bfhyhBiPFyxmdY5LUJ+FKNW0IYbyPKpPcDdPoAwkaG6q1lt5CFACuX5deWFYaGAduhRuUwpSwaDDdZjY4+WuAZZr3wcQTvZubTD3kRTE3EhIN0RqLr/rTpfsMuusskS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377008; c=relaxed/simple;
	bh=+lplEc5+Ave7IJoDCcAzK0ejdXxOsbgsB2DHBr+pqHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoQknh3zD3J0Fc0FftRfw2pe3wunsJCVrm2ACMody+sb6rFbTZi4/JfuDLgNqMFgEj2YVOj+zM8T3QcD7S/KxG83JgH6tGScX1+CrwCy0AC8Om5OxQfq7CHwu+wR52ttlqNM6YwuzsFlCgB8SKaDq8nli319g/J8PX8hFxXZhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEC7+jk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEC7+jk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077DB1F000E9;
	Mon, 10 Aug 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786377007;
	bh=K9G5EI+czVg81EvlC+03Pnlf6q/wHtvJ1RGkumGw1Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DEC7+jk2ZhAoW0YCJyUac2XljJsPxJvSbsycuQXWTSbvCrZeDfdlkqZY34MKZdHxg
	 bKlLMSfpRlqp7At99IzfobkJc7OS0UgH4A4Z3tJBsyfXF+TCHNaDd/3A56r6P22GYg
	 pLq48r1l6wx2ptePExjXcVNhY/Q0F4fXmbiwPPFMGiI38IBYM0qgeZgggtuSMgPEbg
	 0LF3mr9W3E2Ut/gb8uOxhDTVSZ1DFychHL6qUc5iT7pYSKfOzDTp0pPmeqzkF9bNXs
	 finSqGpMykagPFPL+0hGprGQNh+XO9YBLb8llzb+zgXJ4bjHllDB6Hlojo0bdYaPHa
	 Q3NTTFtGhAqVw==
Date: Mon, 10 Aug 2026 10:50:06 -0500
From: Rob Herring <robh@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>,
	Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Message-ID: <20260810155006.GA1815611-robh@kernel.org>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
 <20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>

On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:
> LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> without interrupt support.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>  1 file changed, 1 insertion(+)

sashiko issue should be addressed.
