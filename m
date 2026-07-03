Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A771D6BB;
	Fri,  3 Jul 2026 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783041240; cv=none; b=tJBr8mVtSkqT6pUYZs/tyKFH6CCstpzXiHx3Y52lpt09A1jOvuFbgJqgD72CDqLpBZGsU+6z5t1KOxOenAFc0sSGW0xbAS3jMgC3DsZh5ztUtTCDRFtvrvdC3GBjOzmfWunWXQhZ9ixBxfJ0K+BXmomLYTEpdQDHRD7pZP+wucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783041240; c=relaxed/simple;
	bh=qaWD7fvzzhjZlyRn7z75bZQgIM+VNx7pRFt3klFYLsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSFJyOP6d6PEz3bM3pLSxaKq37Qhp/Pn8n52OK/r98o6glBVVn91tJUvAkx5BumL/7CVr3rMovoegysWTvkKE7ruEEprud9DZXNFM2ym6v+BykbX6IeLs9CUPiyL85ctCEPO4K/OQW+vbOjOLvjCTvsZ7jTR//lXDCpmngVDH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNChDAMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNChDAMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7121F000E9;
	Fri,  3 Jul 2026 01:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783041239;
	bh=iqaQUvHecVpSFytc7D9ZSH0knopxc240NQ7wgWMeH/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nNChDAMy2lW81mXrq7w4gZdseyfnGsACPRHHZtoHMkxWP5Hnb6McOL7eUmpD5s5/L
	 clFIybQO1nl4CatjH1SMRgyl5ffAVLb5//Q1s5HpG+PGrrTI+aM4EigATc1CK/o/DE
	 1JgNh4LWrYI/9Zp3rXA7owT7YCVQflCRnqz6xXQgI3wxzHVOb5bGnbkRoKrrfMe0Nm
	 W7JvqlJU7aV3mBc2WvsSBJu8Z3ahHcmt6YOpn43HprIUhFxOettCEWzpj8iF8z7QkZ
	 8Dazf8BITT7rtKoprjpqMJHXs/PTTEF4YyLUoBPtIrGKqrnCKlUTDETMT3NGxZXaEV
	 sOuyA5VUnuXcg==
Date: Fri, 3 Jul 2026 02:13:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 08/16] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260703021354.04e341f0@jic23-huawei>
In-Reply-To: <20260630140207.GA2986379-robh@kernel.org>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-8-79125ffbe430@analog.com>
	<20260630140207.GA2986379-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  clock-output-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      enum: [ sync_clk, pdclk, sync_out ]


> > +dependencies:
> > +  adi,charge-pump-current-microamp: [ 'adi,pll-enable' ]
> > +  adi,refclk-out-drive-strength: [ 'adi,pll-enable' ]
> > +  lock-detect-gpios: [ 'adi,pll-enable' ]
> > +  interrupts: [ interrupt-names ]
> > +  clocks: [ clock-names ]  
> 
> As clocks is required below, then 'clock-names' is also always required.
> 
> > +  '#clock-cells': [ clock-output-names ]  
> 
> The h/w sometimes has clock outputs and sometimes doesn't? #clock-cells 
> should always be required IMO.

In this case, yup, required is fair enough, but more generally it
isn't uncommon to have a pin that is either a clock output or something
entirely different (often an input). Though in that case I'd expect a
check to make the two cases mutually exclusive.

Here they are always output clocks so required is fine.
