Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0E2AEF5;
	Fri, 10 Jul 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783647597; cv=none; b=l83iluxY6iin2qkcMx5YZ6QzWDru4G85mW/6m56Q1yoO8MlpyODa1XzrSG5iqc/NjT5OIJ7Z7xr/qN0fBE91d1y9XRqsHGR5jaMi+i3zSKdeX5JKT6f/tqxQRSoFSK8xetaklNO6QK5fQ8AqPKoBKywrWtAloNcB6ZgoSA0bIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783647597; c=relaxed/simple;
	bh=cUBVyZI3iYzLKWMJuqgnvmoXqw3n6EnxScqGD+AWtVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNDGnx1gW1owre63NqCyO3LsRyfn5Z1zhyUqdyH4+/cCQ+GJWdtsYh6tVvZzx26/QQ5eiGew7chJNTw8W2DDcjd0CVVKle2mYCl2IJ+FR7xTE3JMn3KPsgHmKSHsmM5Vu474MbGAYVmD/TLxAhK++e8NGETabXtT98i/ppvmrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxeLZXfI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxeLZXfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B901F000E9;
	Fri, 10 Jul 2026 01:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783647595;
	bh=EQuZbHgu/I8MUtI51d+1TjEXGoO04JHKmOy5gEswLS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NxeLZXfIPrLnn1rdtiSLe0YI3yMgsXdI+sfwgbbzw0EWl7qZy+DqiPqZc8QWDQTxz
	 suXaK1qkuhTDt5/8AxA/5E9dxNEwD+59Mz7V8/6EMy4t7mdzybYFFTiNjkj0w1rLZh
	 36H0hi4YaNbtqHQDEuUEw1ESDsMdGFzO4NdQINgc4fWDz8DAJBQvS5earkFjvdHKon
	 ILWaxUv832hsw+LwZEnZJ+Dbn3mjwjPPzaScwSitCcj1g1/WT5nRZ09LZoR3sU2qvq
	 aNCLaIf2IXT15JjlHQWYdeayMt8q9exRVoDhV4gqObvrmRQQRPV0qn3SgxKPlxHdwX
	 2nIYQBDoQL2nA==
Date: Fri, 10 Jul 2026 02:39:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jananisunil.dev@gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260710023947.0056f29e@jic23-huawei>
In-Reply-To: <20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
	<20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> +
> +      adi,prebuf-pos-en:

Spell out precharge and probably enable as well so
adi,prechargebuf-pos-enable


> +        type: boolean
> +        description: Enable positive input precharge buffer
> +
> +      adi,prebuf-neg-en:
> +        type: boolean
> +        description: Enable negative input precharge buffer
> +
> +      adi,refbuf-pos-en:
> +        type: boolean
> +        description: Enable positive reference buffer
> +
> +      adi,refbuf-neg-en:
> +        type: boolean
> +        description: Enable negative reference buffer
