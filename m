Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8818CBE1;
	Mon, 13 Jul 2026 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907685; cv=none; b=D49OnNpMa3MvcaM8UufY53lEnxvebiJGN2mz6Q4c/qhzRhgcYXAdz/YJoau9jedhkVgrLnN7Rke0yV3MGwovy/IyYWK0oVZO5JPsZLSCdtoazs5Pt2vSn/OjSKjJ1CWvFIYYrUb4+VDApHK/BTcj2K9SMsipWUgWWXpR25zwTno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907685; c=relaxed/simple;
	bh=L/FpPgijcZloF7W8bTyrgqfYFgZ1ESHCEJ5g05DuLZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTZ3P1ImxwGQfCCe6ecYPtMQsPT0gbHxLZI5pvfW2m5T+q8I7Jn30gmQvFlZEWgyRTqQG5BfY+75RhLQzltxIWVCwTXpgh2qLtNlgrro1yu+zkz2xwTZpumTkwoQPzVaX3KHiiymZpdDGLEoHAjQ2oeqdZUaR2ORX/PPfr7HRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELFsS52k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELFsS52k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930831F000E9;
	Mon, 13 Jul 2026 01:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783907683;
	bh=5pLTiUlgj2vJ9jmF4RIQCshUIwwudoMqfoKVrCw5gcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ELFsS52kLH4m2fdK7vW3D7I8qiqajz/j3Zq5oYUJjoExQcf/sLcOb/LcftEHTgibK
	 VJINsLky8pmDoRjRzDyFK2cln0PZj06lY6wX1Isg6J6p22sB29FHObRiE3aUjiZo4g
	 +0U18zFbwVJa00azm+xaGd7PyqYtapbOirxElmmsOFabnEydgbxpo/F0EKwQuGklCI
	 wstBmF6h6GZnKG6uwwDbXUVw+IMENpMKD3Y5pswzYvpBi+MHm3zsNyojCVGO4DbhDc
	 3kn1xz3DYO/PCbIuYJkxM5jwiRe/Uw7J7nVOZhGnJ1QJIN7sjco4vx8cw/nfoLfjVg
	 wMUNaLIm0HF9Q==
Date: Mon, 13 Jul 2026 02:54:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260713025439.5c95862f@jic23-huawei>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-5-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
	<20260710-iio-adc-ti-ads122c14-v3-5-746d52cbf1d0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 17:50:38 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add new bindings for ti,ads122c14 and similar devices.
> 
> This is an ADC that is primarily intended for use with temperature
> sensors.

I'd avoid stating that - if nothing else because it then sounds like
it should be a hwmon sensor.   There are a bunch of other use cases of
these that definitely aren't hwmon territory. E.g. pressure, strain and
flow sensors.   At very least refer to some of those other sensor types.

> There are a few unusual properties because of this. In
> particular, the reference voltage source and current output requirements
> can be different for each measurement, so these are included in the
> channel bindings.
> 
> The REFP/REFN reference voltage is usually just connected to a resistor
> that is being driven by the ADC's current outputs, so there is special
> property for this case rather than requiring a regulator to be defined
> to represent that.
> 
> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> have preferred an enum of strings).

Sashiko calls out you aren't using this so commit message needs an update.
Otherwise just that potential mismatch in ordering between interrupts
descriptions and interrupt-names you called out in the earlier version.
That's common enough I think we are fine with it, but dt bindings maintainers
can comment on that if they like.

> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v3 changes:
> * Fixed channel@ pattern.
> * Adapted to input-chopping property rename.
> * Made sure to use items: on array properties.
> * Added reg to required list.
> * Fixed missing space in example comment.
> 
> v2 changes:
> * Added ti, vendor prefix when appropriate.
> * Others are now standardized properties from adc.yaml.
> * Moved top-level unevaluatedProperties.
> * Fixed some issues with the channel@ matching and reg property.
> * Dropped description on bipolar property.
> * Renamed current-chopping to input-channel-rotation.
> * Drop header file and use string enum instead for reference-sources.
> * Added burn-out-current-nanoamp property.
> * Drop allOf: and just use oneOf: directly.
> * Fix inconsistent indentation in the examples.
> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 207 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 213 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> new file mode 100644
> index 000000000000..a2ee473c8e61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> @@ -0,0 +1,207 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ADS112C14 and similar ADC chips
> +
> +description: |
> +  Supports the following Texas Instruments' ADC chips:
> +  - ADS112C14 (16-bit)
> +  - ADS122C14 (24-bit)
> +
> +  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
> +
> +  These chips are primarily designed for use with temperature sensors such as
> +  RTDs and thermocouples. The channel bindings reflect this in that each channel
> +  represents the conditions required to make a measurement rather than strictly
> +  just the physical input channels.

Similar to above. I'd broaden this to cover a few other sensor types.  The datasheet
is less committed to temperature sensors than this text!  E.g. Section 9.2.3
(It has both a wheatstone bridge and a thermistor, so still some temperature
aspects!)

Otherwise binding looks fine to me. 
