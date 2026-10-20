Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485484;
	b=DGPaaMqdnH+pJojd2lq/z9/+sHRpSmwWUhKM0bckWx482E1Urd64nUdrLm7YLZs03A9h
	 NP4CAuVqJJDWwz7+RqwaNXApv5hdXPiMqQnAiQrQ6+2wXe/+N1myOlFgqY1cngkrN0Hcf
	 vX4nZsEsVdf5nXezpLqP7TL16vF11iYWKJ9cAksOlOmemw8ggnmF2XOwFmVbaTGjvo2RF
	 Bw0x1wrNnMhKghGjCKkgYdbiH8PVhtcCLRAv1vXmftw14wlQegA5eDx/D5XRrNE5bw5l3
	 nFslh3DGHg3DN1FtQSFVeaooKwbA/6ANRMnh51sCQyHbNCVeeMs2aZZceJHHJIVbntA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485484;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VHl3GFnK/1yqp8JLtxfjT1mXRdPR3XfGGv+ZQvmy8F0=;
	b=ppQaYblp2+5Ipu9i3xWOEblO35oC1MMw7Y8QMeAB/e3PBUrYsFWgKYbe3hOGMptOrbjv
	 p+xDrTKrjT2baekYQLEdmdASZQK1+294MKDTJpOXyj2jTbE/lz3L3lmGRL6yFaYUidMIN
	 TyOSRomZxsJgOm3xgtrY9oz1/Fqm0kk+s7V4SlKdkBUeNG/TD9nIUIBmFKeBh57K+3TS6
	 WRYeFwmjEtu7BddnlgKJKigkvSSNcz22DTF774ixvzhk+0KJ8TDSi2yo/KDaCwyrMYJ92
	 jk9Aix/7YI/j3pus11RTQc/9lBJlK6fVJDgCN8jSRVFcq7E+XkM/KjNQl7w9Q50G0xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3oc8iRU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2F606A31D;
	Tue, 20 Oct 2026 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3oc8iRU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96301F000C4;
	Tue, 20 Oct 2026 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485483;
	bh=VHl3GFnK/1yqp8JLtxfjT1mXRdPR3XfGGv+ZQvmy8F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P3oc8iRUR4azpGz6RNOpfSxY5BZOJFRePNicdlb3KpileJajPSAZBrabuQmNvbpGs
	 pJDTkhsw5fnBCSZDwVBqTyF84ij+lTf6YFQHle0CCCghrtAJbwrxgutCIoseLcCA2Z
	 +Cy5B6UQ0hkMtXXa8jCjQ9RIUzrwg9fFC95vSrXVYq2PuL/6Twty5jaz9U/1ArmBTB
	 wJRKMd3U81KDZsarKJWI2rARwFabW3M1EP7JH0gnGU7rM6+nEOmre4l/lEfmF3Pc5b
	 xE6ujxsSjoq97BmPbdOxSoxg1kYHERT2LIrifnQUzvTWek9FizJgYu32Oq5Jh0bJbv
	 3TWFiQvxMtj+w==
Date: Tue, 20 Oct 2026 10:38:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: proximity: Add Benewake TF-Luna
Message-ID: <20261020-formidable-aardvark-of-biology-cffcc9@quoll>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
 <20261020-tf-luna-v1-2-53a88f93db24@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020-tf-luna-v1-2-53a88f93db24@gmail.com>

On Tue, Oct 20, 2026 at 12:03:42AM +0530, Vidhu Sarwal wrote:
> Add binding for the Benewake TF-Luna, a single point ToF
> LiDAR distance sensor with a range of 0.2 m to 8 m.
> 
> The sensor talks either UART or I2C, selected by the level of pin 5 at
> power-up. This binding covers the I2C interface. Pin 6 is a data ready

Binding should in general cover both interfaces. You will not get
different compatible for UART. Incompatible changes won't be accepted,
either.

> output and is described as an interrupt.
> 
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
> ---
>  .../bindings/iio/proximity/benewake,tf-luna.yaml   | 58 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 64 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

