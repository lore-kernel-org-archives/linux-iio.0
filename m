Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CB390219;
	Fri, 24 Apr 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032851; cv=none; b=W070sOT8FhkkpdR3PXXA/kavyiVQ4CxEiKHDWeCNoIvNe8Y99QOPgrqlyJ+EwmuBvO1jh5xho3MROvh3SpMLrXslzbap1E8B5tI4ThJF27e2lzugfTD7lu7OSuvN1Ek0QPW7/4H/cq3BcvybmzsK1BhuCB5V9tKQ5UrRCjFszks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032851; c=relaxed/simple;
	bh=ZO9aEtxmQmqiOcUh+KVKA2CRIyUJT/YOpr6ZLOkTSx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0Svy5DCRsydsxoLPYxOls6O1cTVROnODa2ovZ9sVMRH3jBEdZpY7XL/qvhd2SK2KP1KDxRd+7Xy7RZJ/D4UsT+ge2vrOD3dDz67wbfloqodPFePWDj4cdLnM1O+t5BwtSdGcCopNB1m6ib3MPrOHfDhW6PIlZW3Z5+vodi1/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caZp/jxR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caZp/jxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92257C19425;
	Fri, 24 Apr 2026 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777032851;
	bh=ZO9aEtxmQmqiOcUh+KVKA2CRIyUJT/YOpr6ZLOkTSx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=caZp/jxRCJ2YGfckxgsVL4azsFonMiBQ9WYTxr+jdtdpvk9HcuiM+1I4Flyp73/y4
	 YKTIbF0/9ar8/8DDMvtSs9/XYatVezqMeNwbffL1oaRjLEZBJWYmvj2f7AEuBgTjNw
	 wMgTaN3EcbSt0d2aKscFwEyKvLwtnvNBmNZN6qWTI8n8UXN9mqmLvC6NBxaXTUZOkj
	 58Q2FjM5dva/eYpUVuEOv0EA0VCIMLG/7N+4KzETmZizDpQ7QWA2VJjEfNe4fqlgaD
	 YFEiRm07wOilKdLinDJyZkGpD2eaKC+LbDtDbCs96UID7vDMZRNyW3HB3PXjOPda0B
	 5M6B2bAxMBphQ==
Date: Fri, 24 Apr 2026 13:14:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: hx711: refactor to per-chip
 hx711_chip_info structure
Message-ID: <20260424131401.707ba1cd@jic23-huawei>
In-Reply-To: <20260422175910.1258579-3-piyushpatle228@gmail.com>
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
	<20260422175910.1258579-3-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 23:29:09 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Introduce hx711_chip_info to hold per-variant static configuration:
> device name, IIO channel spec, channel count, and iio_info pointer.
> Store a chip_info pointer in hx711_data and populate indio_dev fields
> from it at probe instead of hardcoding them.
> 
> Pass trailing pulse count directly to hx711_read() instead of
> computing it inside the function, and change hx711_reset_read() to
> take a const struct iio_chan_spec * instead of an integer channel
> index so callers can pass the full channel descriptor.
> 
> Use device_get_match_data() to look up the chip_info from the
> of_device_id table. No functional change for existing HX711 users.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Couple of things sashiko raised on this...

One about hx711_gain_to_scale() is an existing driver bug.
Need to take a per instance copy of that so as to support
more than one sensor.  Ideally fix that whilst you are touching the
driver (as a precursor patch - maybe we'll backport it) but if you
want to leave it for another day then just say that in the cover letter.

The other one about matching via non DT routes is an interesting corner
that i suspect applies to other drivers.  The module alias in this
driver is also rather odd.


>  
> @@ -571,7 +602,6 @@ static struct platform_driver hx711_driver = {
>  module_platform_driver(hx711_driver);
>  
>  MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> +MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:hx711-gpio");
So Sashiko thinks (and it's plausible) that this module alias is a problem
as if the driver match is against it might be possible to probe the
driver without the match data getting set.  I think it's referring to
the final driver match fallback path
https://elixir.bootlin.com/linux/v7.0/source/drivers/base/platform.c#L1370

Whilst unlikely anyone would get to this, I guess the fix is to ensure
we get a match by having a platform_device_id table for legacy matching
and making sure that covers such a match and provides data.

We don't (I think) currently have an equivalent of the catch all matching
functions that exist for i2c and spi.
Bit ugly for platform data as I think you need to get it via
platform_get_device_id()

Maybe we just check if device_get_match_data() returns NULL and fail instead.

> -

