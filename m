Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F738F4A;
	Wed, 27 May 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903292; cv=none; b=LrxKTKStl8peIj2hwqkZ0jPsd1Fbsc2FuF6gRV0eX2q4kV8EuOhI9Sfo3gV2m+HgvXcFxRmCX3sG1sk6i9kiSBabn14JocwRbZykABuPdYnLUPhEo5JCgwMiKjxzbPCETlgEkbJktucUDr3dI9g6v/gpvyZ8ZaB9ms8tSX+/SI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903292; c=relaxed/simple;
	bh=LWmtmkaZDD76w3VR0GRbBpLjfE5KsPcK2kBUj5emgV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyfp0FylAqvZBVpK/f3uz7B7kgxEDZvSHTC+kmRAGoTntrMHotzw02SIYpheJ20bk1DaCy7wAD4gz5AxyemUvKowjOkq4UKTpTAIgru9hyo3O4Ckr8LhavjOZn/eDU81I3/2L4Ib6dB/6kTWMJrRqN9GWUpgT/CcnpmcX1pjreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie9xyXh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie9xyXh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51511F000E9;
	Wed, 27 May 2026 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779903290;
	bh=vM1+PttVKtPHmfuS8RkSEz+rxIK/6C3brodgeRllBPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ie9xyXh/oyy8rw44adDkeKJLUlhlA2TOKWBHHaoF75c86pYCBmRQStJ6TXUT+gTlK
	 DZENIHgNxQinyX8s/qWocelp/Ek0g1YVRinhaknvjFhmbh5TO3R3Fn5rCAHIHwzgrX
	 oG2c0DwRg5F2ztcU78Q0KBQsQx9hrsou3fJWCVjIgx5QRUcJVKthslKRDqmVOmeuCI
	 d+llCkjne7XstYj8C0VIMvWEHpU/79I+RKyAAPxI7p3kl4FkgFF/OlWZfpuAYD2b7o
	 MaFu6KMpzaAVy25LH+5+Dxx1xjMHnQfr12eb/+sudFd33HMQJkQCaxEk39Yl4jqubT
	 kCHUIs7j5Awow==
Date: Wed, 27 May 2026 18:34:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ak@it-klinger.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 02/11] dt-bindings: iio: adc: hx711: add VSUP supply
 property
Message-ID: <20260527183441.4854e597@jic23-huawei>
In-Reply-To: <20260525105127.180156-3-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
	<20260525105127.180156-3-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 16:21:18 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Document the optional VSUP supply used by the HX711 on-chip regulator.

Commit message and patch title are out of sync with the patch.
Update them appropriately.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/iio/adc/avia-hx711.yaml     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index 1ea60dff98d5..0baf620e9057 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -33,6 +33,19 @@ properties:
>      description:
>        Analog supply voltage (AVDD).
>  
> +  vsup-supply:
> +    description:
> +      Supply voltage for the on-chip regulator (VSUP).
> +
> +  dvdd-supply:
> +    description:
> +      Digital supply voltage (DVDD). On the HX711, DVDD is a
> +      board-supplied digital rail; it was missing from the original
> +      binding. On the HX710B, DVDD must be greater than or equal to
> +      AVDD; when DVDD is a battery rail and AVDD is a regulated supply,
> +      one channel monitors the DVDD-AVDD difference for battery level
> +      detection.
> +
>    clock-frequency:
>      description:
>        Controls the SCK bit-bang timing. The value is used to derive the

