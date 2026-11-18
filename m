Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019516;
	b=4kpur6lU7kNRsp4BJo74K1+zMtNLpN7QicFqN8p9Mu6SCIW9xjmeYOJgCmbgPqfmY5pL
	 7Sr9JlKZIP9imN7NQFK1v82DIUkfAz2BQMHPjaanPbf0f51UZpmUncJCufbB87DFuAi4d
	 b8+akz2ylFLHFBxopc9hsZh8xlBouLAGXpo13Y6eqkMdLca7Ywz9Ebz+cmZTFOaYZLENo
	 oXqm7nt45gg92C6uOQDQU0ZLrTqTfdAXXWdoOkmwIsiBYrhaCjndXY2JmFvZQJbA8MH1C
	 W6LmoMHdmSOT5FWFWMF+UdAEPV9TFCgm+1v6/XWtv+/uuTUdKtlyTZiTu613WLPdcxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019516;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ne9zjfCtE2ZYUY/5J+qHTBhV7SIbNLnRnfVz2YJDTqU=;
	b=byyTct2QTsVOr2i3wRcLtuRZVKMBKJQYA0sdgVbgRXgRT8NrH3yQ4KSj30kYsfTLEtGz
	 plrzsLjDKCP4MSE81/Dn8Q9JtVS7hl+PBZwNRdzW9DctP/FI7sYjJVlF8TPTVB87w5Lgj
	 iFCPvx3QSwI64FMKnS6xqkDIpDQINhJe3rD345YBkk/LEUbKbAbch7fb/20DVMrhSzZkh
	 peshUdd8U7qjX+tG49VxXwfYX84ug2rLIeaQY/UoT3B6suHxhoSzpc7OhZ1WTfUnYHtdK
	 ZYfr/UGqKzlNpemqyoGpe1E/6Z7mNMJ3kcKLboFU0SvUcPtZF3gFOEBh58/yqJkO+0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnFBLaJi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77732606A330;
	Wed, 18 Nov 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnFBLaJi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37041F000C4;
	Wed, 18 Nov 2026 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019516;
	bh=Ne9zjfCtE2ZYUY/5J+qHTBhV7SIbNLnRnfVz2YJDTqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZnFBLaJi6RcEic/+9H5w4sIwZIkB+fnu0L7z9GJjIX5mDcz2/9l//34AP9Wh4SG/T
	 I0OtIQ4XDPgRuwTOJq+PI5uZUfSycMTi6M96eNe2u7y0yBtvV68mtKTJSeUpdUXcg0
	 JU+M17y+AbLItrwJGiPGetc6fOEMgfyt/bTm6u9ZioMeyqUEYkVwt1um7Kv7ZjG4gX
	 myzW6MOFrtP7pfSZC0+qmGfuWSfItXR/TuVlmM6YZbWFTGM+HdggDC9w5Vc2laEaep
	 XGhXAroYBK0kiWB7JlKmFP21z9V3QQgqxhRDT2zvrJpT20sDFSFxv/20yI92+haDmu
	 NxmxG5man5cNg==
Date: Wed, 18 Nov 2026 10:31:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: nuno.sa@analog.com, dlechner@baylibre.com,
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, cwweng@nuvoton.com, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, andy@kernel.org,
	chernyakin.victor.j@outlook.com
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: adc: Fix channel property
 validation
Message-ID: <179501951295.2811032.13608319647135153156.robh@kernel.org>
References: <20261117082832.1551574-1-cwweng.linux@gmail.com>
 <20261117082832.1551574-2-cwweng.linux@gmail.com>
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
In-Reply-To: <20261117082832.1551574-2-cwweng.linux@gmail.com>


On Tue, 17 Nov 2026 16:28:30 +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> The common ADC channel binding currently uses an anyOf constraint
> to require the reg property and select between single-channel and
> diff-channels.
> 
> However, the reg-only branch allows validation to succeed even when
> both single-channel and diff-channels are present, bypassing the
> intended mutual exclusion.
> 
> Replace the anyOf constraint with an explicit reg requirement and
> a not constraint that rejects channels specifying both properties.
> 
> This preserves support for reg-only, single-ended and differential
> channel descriptions while rejecting conflicting configurations.
> 
> Fixes: dd471a2b7759 ("dt-bindings: iio: adc: Add single-channel property")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../devicetree/bindings/iio/adc/adc.yaml        | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

