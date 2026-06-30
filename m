Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09672175A68;
	Tue, 30 Jun 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861276; cv=none; b=HkLRiugjVl/x2ferLdATLwGNnJTFx3c24R+VHc9aTCiWbDX00KwXi20VP9D6vdDfd2k9IXQ5U0zq1oh5DrEJJFVHWx6KjVVf3AYEMVt/BnyoESXiZ560OVE7WNZnybe55d86u940zbsR8hsBQpGhOuG9RbF+NySVK43t+AM5dbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861276; c=relaxed/simple;
	bh=wVnIGTlSBEIEohoyG2uaAVbHHqyFvj/he2KdFH2NUAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhPNRfqnYbdl2MNvE96qMHit75JP7MhVluII1wInHNYpsd4EV6k64vJDD0Oqub2QcS6+TEglW1mcxpppqZGQJhlfFGr/NBJgcZ8+ycvqLljaBezirgSZzQdMeyq9b3MNDEgnrdn5fpHfB8/YEVETRHJFvHQocR73QXCExBf6OLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD5ShwRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD5ShwRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0FE1F000E9;
	Tue, 30 Jun 2026 23:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782861274;
	bh=Yug25z57xNKOJ09AwXvWfA6cHZQYGF2mhv6t8wj4HzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cD5ShwRBXT028RBXd5+7MNuzyeUaqndWzf98+NbAbeaOrIBQSfuxrrVXVtRkw4cNb
	 ihLSIPXVeTCtaIVD5zVHU25roMi5mdAN4ZHUogta8wMJRlhHXkRD/9wCCf4kXECIrf
	 glh4tQfGU01lsGnyBGYfedfGtisgaaXmSSFm+AE7/g3Q0j2GdA8vkPLim2us6umgq/
	 yUdZzo4LQ41TI0J6Xb04nwefOJKGY26IHZqn+z1c5c973ZsjO4khNEyKtX3XtV8P2t
	 nk+BopwocXtM2PzY5PZ1VBEJhT2HX7Sv9TtXsVeTzV6HvcZZS67rCRwtBANvqon058
	 c5AVpG6R57v9A==
Date: Wed, 1 Jul 2026 00:14:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mike.looijmans@topic.nl, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,ads1298: add ADS1299 EEG
 ADC variants
Message-ID: <20260701001428.1670e3cc@jic23-huawei>
In-Reply-To: <20260630140311.1473031-1-shofiqtest@gmail.com>
References: <20260630140311.1473031-1-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 17:03:10 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> The ADS1299, ADS1299-4, and ADS1299-6 share the same SPI interface
> and register map as the ADS1298 ECG ADC family but are designed for
> EEG and biopotential measurement.  Key differences from ADS1298:
> - PGA gain up to 24x (vs 12x for ADS1298)
> - Internal reference is always 2.4V (no 4V option)
> 
> Add compatible strings and update the vref-supply description to
> document the ADS1299 reference voltage behaviour.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

>  
>  maintainers:
>    - Mike Looijmans <mike.looijmans@topic.nl>
> @@ -17,6 +22,9 @@ properties:
>    compatible:
>      enum:
>        - ti,ads1298
> +      - ti,ads1299
> +      - ti,ads1299-4
> +      - ti,ads1299-6

As the channel count is a discoverable feature (encoded as a field in the
ID Register, I think we can use just the one compatible).  FWIW it is
nice to see a manufacturer making this discoverable!  I'd expect any
future drop in parts to vary the other part of the ID, but this field
should be respected - as such this doesn't fall into the stuff I've been
discussing with DT maintainers about fallback compatibles needing to
be specific (I'm way behind so not sure where that thread got to!)

Jonathan
