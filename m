Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B23F0761;
	Mon, 11 May 2026 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507806; cv=none; b=ktb6btNqESoCbwjLiSZiNgVK2A89Nz6GOAsbB7vxc7Paq1nnAx5rOu/vHcSZGJhCPdP72x+GmXXjlfrsvnsqFmTKv6ouLEdCR9AGnDf5Lozq8foHW7NbPCinroONFwbfToZmX8R1vNdaYnKGAFPvhH008FWZEOu/mI3gBIpfOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507806; c=relaxed/simple;
	bh=PW8pVcDf5k11hXFW5k0frWPb8Wcmrp6fjCFdwFXM5LM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekXhsMadUu86qbgDwCLXdCZMk3YIcom+EqeBodaYJt8lhGVcVZw08Thl4+JA56cQ09HDhGEOH8lWbTLrB7bKiAK8s09rYDtxAtrYxawHpYh0ogZcVv5oSm0uQyPnOIDlVVEaE1/ishSdep1/aiFeqy0uy8IbamQ2VdCQ/E8XljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LauFhvNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LauFhvNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CDAC2BCB0;
	Mon, 11 May 2026 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507806;
	bh=PW8pVcDf5k11hXFW5k0frWPb8Wcmrp6fjCFdwFXM5LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LauFhvNUGS+aUALp23WuMHd1NnuA/5KnmsyFOZgcvjbGHaZF/IIBINvswcvOjMnFk
	 W2nPvBPI+ecaYhhhfnYEEQ/I4i3E4ZRlMObbntO4XQLycoImIzQvhbl2O5sq5GUAl9
	 k6jFgu0uk0PB/bY9FWHWFKefASuVSHClDjKscHyRt7GYtT8t2R6i8L9/1UXMvoFgbp
	 Tn1xc34xU0X/sRjaDT3NRFYdvFwGwBNgtgJfHTGbnVw/CaUEhnEcomZAiY+95Ec7Ux
	 w3e483sPZrkgU7OQlFef7KbW/vtpdIlNawgwHXC5J/3c6+tHBhQCEyMstas3C7NBqp
	 iHoupRCZba4sg==
Date: Mon, 11 May 2026 14:56:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: iio: magnetometer: add Melexis
 MLX90393
Message-ID: <20260511145637.0aa12c30@jic23-huawei>
In-Reply-To: <20260510191010.155380-2-nikhilgtr@gmail.com>
References: <20260510191010.155380-1-nikhilgtr@gmail.com>
	<20260510191010.155380-2-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 00:40:09 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Add devicetree bindings for the Melexis MLX90393
> 3-axis magnetometer and temperature sensor.
> 
> The device supports magnetic field and temperature
> measurements over I2C and SPI interfaces.
> 
> This initial binding documents the I2C interface.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Hi Nikhil,

Add a MAINTAINERS entry as part of this patch and expand it in patch 2 to cover
the driver. That's much cleaner than doing it after the fact as a separate patch.

> ---
>  .../iio/magnetometer/melexis,mlx90393.yaml    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
> new file mode 100644
> index 000000000000..b99629ff2585
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/melexis,mlx90393.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Melexis MLX90393 magnetometer sensor
> +
> +maintainers:
> +  - Nikhil Gautam <nikhilgtr@gmail.com>
> +
> +description:
> +  Melexis MLX90393 3-axis magnetometer and temperature sensor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - melexis,mlx90393
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Definitely require some power... Looks like vdd-supply and vddio-supply

Also binding in general should be as complete as possible, even if the
driver you are sending it with only supports some stuff to start with.
So looks like there is an interrupt and a trigger pin that can possibly
be used with a GPIO.  Seems they may be the same pin from the pinout so
maybe don't bother with trig.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@c {
> +            compatible = "melexis,mlx90393";
> +            reg = <0x0c>;
> +        };
> +    };

