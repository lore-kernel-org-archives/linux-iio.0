Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AAA387362;
	Fri, 10 Apr 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807560; cv=none; b=n4kvnyYrLoRJlIzrW0zSOGbMtcptC3O4jPtmOfPXbUZdGFpa6Kov4873bFNKUmfmeZdcv/N3pcLoHcxypGkBFvxYO5bmq3Gku4WPaDXDIGHK8PEiT8LBMx93l3maa5fxv5qhzOjb5408Fj0QWNWUY2VsEvGkyhPyNOn2K5p+d/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807560; c=relaxed/simple;
	bh=4lKyUYf33uMWkL8SNs7JwGmghsUEa5VhF79A85XN9qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIjlDfP2CA3PlsX16c3i83rzFnrhgbRiC5ZN137knVjbMlN+1+aStmp3i/SZv0WroInaKhWevxui0OOmrtOjoMkHbJuT4ph9aLX9juMxyBEtJzQ4P968qKve0L88Mv2pIUaBUrgxd4oP/7L6bQ7smEuvNo5ROn3n1O21SmhL0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJvastzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJvastzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97AAC19421;
	Fri, 10 Apr 2026 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775807560;
	bh=4lKyUYf33uMWkL8SNs7JwGmghsUEa5VhF79A85XN9qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJvastzXMOV7l28p7uj6aWysA/P5MARC4SG8VBAXo6dLPXhyfqPmCxj4ib/zUvnDR
	 93tOaro2PUhna3avFc4RYoC7l8ymKttCwyBET88AxGz32h6mz78KJYZhZd4jh9p+yN
	 cLhcLkixrJIOTRghbQRgcnCDwSPAZDnT8vjyl/ap/b6+m2Idl5W6AyzpHixzCyUq92
	 3PaVp4UTFVgRRbJpy6LL3py/uHBMoWGbPvYoPspRISZ6jKQlJnaswd82nw4uGrlu8K
	 tF5++1ZqZPYocaoS1q+mv1DtL8g3+MftEzsy1Ys7VA/QH3D5VmvnHsJLX8cyjnj/PH
	 Xc6OFmYze/Rvw==
Date: Fri, 10 Apr 2026 09:52:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add QST Corporation
Message-ID: <20260410-watchful-magnificent-caracara-0cae3d@quoll>
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
 <20260409210639.3197576-2-hardik.phalet@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260409210639.3197576-2-hardik.phalet@pm.me>

On Thu, Apr 09, 2026 at 09:07:20PM +0000, Hardik Phalet wrote:
> Add the vendor prefix 'qst' for QST Corporation, a manufacturer of
> MEMS sensors.
> 
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 5d2a7a8d3ac6..71a1b9087c5e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1244,6 +1244,8 @@ patternProperties:
>      description: Shenzhen QiShenglong Industrialist Co., Ltd.
>    "^qnap,.*":
>      description: QNAP Systems, Inc.
> +  "^qst,.*":

Website tells me qstcorp.com, so prefix is qstcorp. Unless it is
different company, but then just explain that in commit msg (e.g.
provide link to website).

Best regards,
Krzysztof

