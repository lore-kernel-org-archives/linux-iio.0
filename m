Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DEF3BADB7;
	Thu, 16 Jul 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189149; cv=none; b=sNyaGZV9Syn9PQ5ED+OIo8R1O8HcpSWiP0tB3cNgZg0xzg51oaPJe0kZg53wOQVJJP/TUV2PWOCbjnXCg+bGQe82DRdC/RWXEeCqPyrPjWM2fMwMKplJurxqj8jR+5xR7qLim7md33IB2PdTRGYM/teyymgZkMuKL4K2EzKRwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189149; c=relaxed/simple;
	bh=+k0jgJ0LsoTjh6F/y9dOO+rgftmMjNfpNwrXSjlTTro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMQ6TqxA2Q4kxlX0lcuMN4NQv/wuyvLeqeKeGXzultM36qzo7H1MJB/eFB8Jzp7iBIp6+YZo8QKzXFBsODFiBvEPg76a34QmgB9n1bSX09bqU8N70b7W3rizl3NuM5TF7vS3GQjS/s3DDWy/rGnQ4D7qGxdw58PHpXDGkov1AdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ/CIlcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ/CIlcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C3E1F000E9;
	Thu, 16 Jul 2026 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784189147;
	bh=xOF4UJ2ITBueBc5Lj1YTsidPFb8EKIWwD/e6hF2+jBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HZ/CIlcIvqqPEOTbJW0bqEGDnzpJ48h0xQA94ct2oUFewa7uh8CIn7kq9UAGzhkrR
	 AnQ6+4DeesmmWtjP1hUZFmM7DPXyJySBzPdbhZk4MDLnWLFLO4NP+zCZorAD1+qd4/
	 8KUEk/HoCKfhUOleXQZxjPCHM/6uomxXneP3D4ZMKmEtju1MuoCRujJMq00yrZVaXI
	 Vkh4yZN+x1onXLST7oDqCRHnc5IGUXfes4L+ZQ74nt+F1arfVloQPwpe/EPotRPSqm
	 Bq8fV3z0blVTd8jhF5i60ntS+xYuEEqFPK4wqXJMH4cu59VHWY8RiygTbBXEaxtj6P
	 vYM1C3KFssrKw==
Date: Thu, 16 Jul 2026 10:05:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: ltr501: Add missing
 ltr303 compatible
Message-ID: <20260716-adaptable-thankful-serval-ecb3cd@quoll>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
 <20260715-liteon-ltr329-v2-1-d18af55edab5@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715-liteon-ltr329-v2-1-d18af55edab5@geanix.com>

On Wed, Jul 15, 2026 at 02:27:23PM +0200, Esben Haabendal wrote:
> When support for ltr303 was back in 2021, the bindings documentation was
> not updated accordingly.
> 
> Fixes: 7d71d289e1ba ("iio: light: ltr501: Added ltr303 driver support")
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

