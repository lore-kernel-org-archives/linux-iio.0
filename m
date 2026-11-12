Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520264;
	b=QdyzxsjLpGu7a1eysSBi5Wh6qxypRk7skeVAbkh+r4/tFTbmCNTQB7rp7RElYWSC1oki
	 Cc7NryOc6vDB60TyDlFVV4sAk3gv0vB2d7mDfR1c6yUvjrAthvPd7/o2GCGrD+mccYfn4
	 QCe0uFvhfiJF7rbftlzVWaxtFFpI3PdLFnFnFnnAzbQWUpbOG8wljGZXHFFm09xI21GTt
	 vYH0oAKVogZdKai0fkM6iTmGjjrWdNQjH0WSujN6ii996aXhyW1aS6eNpYetYdrLh72Tn
	 /m3YFDDd1ansAwHjukphIJeQSwaiAQrHwNYswPeAk3T14YoBjEaM9HpyiyFjV/bTp5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520264;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gmrG0l+ukSDMRt6gwqGsJcFUSJ/sybe81S1+WHCje+k=;
	b=3vbHfovRL5TqFC3yRj0S0+DZ+ZxcHH3s1QlRe+FA6/sKd/KYA8BXGutlE6JNQCP7LFa3
	 JFTYejsNx83NjijmsByp8aIEYmXaz1mvXntL8KKPV6ihRz57gojFHX04iLUUzy8AWr51N
	 S/a2o86SqWFnYXHL8Vp9am6AmWofTeKWp1xkY3g9rMtyqUlzCZ4M3mDsJenrCgR4bL1FJ
	 Haci/b47R59xktHmkGCQHE4mFAfWNSETUnNvaRlSf2L3+kZEpPwnAbDCmkfIXFe4T87BR
	 vQSEpAbuZ/7O30ALPhM6mcShSpAfLF8hVzQbMfRFJi6nGaN/SUINDn2HEZ0C9yCYqbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZS44Xc+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD205606A321;
	Thu, 12 Nov 2026 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZS44Xc+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F6A1F000C4;
	Thu, 12 Nov 2026 21:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794520264;
	bh=gmrG0l+ukSDMRt6gwqGsJcFUSJ/sybe81S1+WHCje+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VZS44Xc+vioMWCvhMpG9l6glLs0DHvfdDN0xQJZpPYUzUCLGFq7sWlnRbN3hpJkcK
	 VtYmcSwbX6AMsHyNmkmGTzQLlVxSQXs48KEajbDFWsOfT9OCj+CUHn0ZvBx9lbZRyu
	 06VCqYb9xAOy35EKmjlAApgHRXvTWOlEGnqMf+EL51MHbSVQPQQi2NPIwIdRROiQbR
	 3xnZ1DDEvbXiCbObdeQWkMO/ck5T6B5WxhOuUWIPIckUG5AXtIkbBmf0rwaj6+s+Ip
	 9OMmVIWyu0gSo7Mw5jbOMQcRkfO5g70KZHY6yWeDZJuPKkQ51xIxkJoHtsdxSgXAx4
	 I8jWmwayb+EbA==
Date: Thu, 12 Nov 2026 15:51:01 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	kernel@axis.com, Jonathan Cameron <jic23@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	devicetree@vger.kernel.org,
	Henrik Grimler <henrik.grimler@axis.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Joshua Crofts <crofts@kernel.org>
Subject: Re: [PATCH v9 1/7] dt-bindings: iio: imu: icm42600: Drop interrupt
 requirement
Message-ID: <179452026140.1424831.15365336615656404366.robh@kernel.org>
References: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
 <20261112-b4-inv_icm42370p-v9-1-875c828a281e@axis.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-b4-inv_icm42370p-v9-1-875c828a281e@axis.com>


On Thu, 12 Nov 2026 15:29:27 +0100, Kanak Shilledar wrote:
> The devicetree documentation for the invensense,icm426xx devices was
> documented wrongly. As per the discussion in the thread[1], the IMUs can
> work in polling mode, making the interrupts as not required.
> 
> Fix the dt-binding to not have interrupt property as mandatory. The
> driver will need to be fixed to not fail if interrupts are missing from
> the device tree. This will be done in a separate patch.
> 
> Link: https://lore.kernel.org/linux-iio/20261018034134.2bf170a0@jic23-hlaptop/ [1]
> Fixes: 22addefdabdf ("dt-bindings: iio: imu: icm42600: Add icm42607")
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml  | 15 ---------------
>  1 file changed, 15 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

