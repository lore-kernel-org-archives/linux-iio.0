Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6D45516F;
	Fri, 14 Aug 2026 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699440; cv=none; b=EF7l7iz1wuyGNUylbDJN9u7PYKDF6ufXJSccn+PtZj3n6PK7+1QGuAYrQwsRBZD1qGl1KHSvKVel3HUXFN3EwEPy+LHVBREeU3Sg11daqI2uDSa85RNCdXsuziuCZSkZYVIdhTv9bQIs4fKBtk+Mky9EaOoOjzTv6Yexr/++sds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699440; c=relaxed/simple;
	bh=aUxrx+USUqiZJc/nRcE6IOVNfHHcEMA82aVSXfYONkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX7e3PmRGnRqGwQUJ8qATTj9EcY42UcujW6JnSn7K4hia4USW5Zh8RJ8O5sds9JDIBPqzZY1ApE5LncvUromnTuzmfStPQvvzpTlC1gG5z3qjY3AY9Tkey9y/nChD1J3G41/O5sFwbzbz2Lm52v2IdI1eGSr7B3cSCyp9nfM1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS/ps7um; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS/ps7um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581F51F00A3A;
	Fri, 14 Aug 2026 09:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786699439;
	bh=GwV0mLaGaHAArZEHKfsDIpgpXCyPcPhKLOHEzYy7U+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mS/ps7umXHPfdDURz7oSdZ/Obs5vtpUy+0K4eJ+77ZwNrEnEh+emHrkBk2bTMYxBk
	 gQ2c9f2Wop8FORe0LG4MrjYo2t/T9d32QRkChXmMm2RNFR6Lv9h7A7KXpqLIG2D43U
	 reJ/OgdizzWxRwDvVYb1rfAiSwTbbCP74fA5lNJkY0ZKBRU7/sIR+oBG3bxeAPWWlz
	 KRGoGZSuGt5csj8AiMnFEnut4v3QOgITgb0nSJK/R01DfCFiGZB83A3Lq9Z5FKUZGx
	 ZDqRVbQGzX6Jzariqcjs1Rtt7t5oZdFCc/zZfFEloluyftg/rv+KlMVwy3S5CoHote
	 8wLOyIqw4vj6Q==
Date: Fri, 14 Aug 2026 11:23:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux@analog.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: accel: adxl367: update maintainer entries
Message-ID: <20260814-ingenious-grateful-tarsier-a94db6@quoll>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
 <20260813081452.4289-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813081452.4289-2-antoniu.miclaus@analog.com>

On Thu, Aug 13, 2026 at 11:14:50AM +0300, Antoniu Miclaus wrote:
> Cosmin's Analog Devices address is no longer valid, leaving the ADXL367
> binding without a reachable maintainer. Take over maintainership of the
> binding and add myself to the MAINTAINERS entry alongside Marcelo.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v2:
> - New patch.
> 
>  Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml | 2 +-
>  MAINTAINERS                                                  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> index f10d98d34cb8..29689bc38b90 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADXL367 3-Axis Digital Accelerometer
>  
>  maintainers:
> -  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>

Address is in three other bindings as well, can you fix all of them at
once?

Best regards,
Krzysztof

