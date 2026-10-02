Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0433FE0A;
	Fri,  2 Oct 2026 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931819; cv=none; b=kvua/QGn3+JTwsIrhM3GfTiVDJ1fKUe5nLkQRNn3KDcAgdb2p6lXvKdrbNVw23Bjb0LVNpHHT1DGZqcZapMji4jlIIBVBNJnEZUV2yZF08d9mmIZkoU9xoBZiMS0HFeoUbiD5nUOhx4rOQhIEP3Ma6P8Tb0CxB6W/kV/Zp65mUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931819; c=relaxed/simple;
	bh=erFZpVSHUkxWhTkiSAOYGODrBZpNd+kBjM/Af5KkOY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcfk8eahjOygRZhvuu/wTNbQyEFi3WCk3wJkAVUOfc7nEIJvhqqsAXgMOJ/vj81mIuyInhuGnKLqiRoG0MkGgh0xIIybev5893mxdYTA0oBpjJdHIqlI039el3VP/jeAC7Q91nQTxdO4wVIGtu2qcgU0+eoCrUEpPQHSbPj+rRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMhj128m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMhj128m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEB21F000FF;
	Fri,  2 Oct 2026 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790931817;
	bh=yQxZFijEU5LHsqzlp6kC4YKHFl6QGIvDQevjxQ5kmyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PMhj128mwMLV5wxS5AIrCVz7sWVTvHfeMTUmtJNuQMrV/fEjwjC0ANphjgG8OAaNq
	 OSLjHK3uCMbVUpu0mYgpgErTjWVVLMe9WD7+Qrr5bkigcdQh4JqDmMxKeowUhRgbC0
	 b4p3M2Qu8uNS3IUEhscAJJbzwNepyc6xXKFYSRQNyWVYLpn2dojmo2Z2XD+A6996u7
	 //Au+sbQQ2UqZ4xnXAlvCyahXqXAyat9yvVYB6EKZSHsLZUErIHJK/BxjevvjRJnYQ
	 YpmjFn7W1D6cztpU0QScfgv7W6g2OZuTnXdZD6pGJ73e53km2ZfcjQ16G2dOJRVw0z
	 i78vsxykvbi7g==
Date: Fri, 2 Oct 2026 11:03:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
Message-ID: <20261002-succinct-voracious-orangutan-fdac5e@quoll>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
 <20261001-ast27xx-adc-upstream-v2-1-2f9c15cc0064@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-1-2f9c15cc0064@aspeedtech.com>

On Thu, Oct 01, 2026 at 05:50:36PM +0800, Billy Tsai wrote:
> The ADC's reference-voltage trimming data lives in a System Control
> Unit (SCU) register. SoCs with a single SCU instance let the driver
> locate it without any additional information, but SoCs such as AST2700
> that expose more than one SCU node need an explicit phandle to
> disambiguate which one holds the trimming data.
> 
> Add an "aspeed,trim-syscon" phandle property, and require it for the
> AST2700 compatibles since they are the first multi-SCU SoCs supported
> by this driver.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-sonnet-5

Your SoB is the last one.

With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

