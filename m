Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DFE36EA8C;
	Fri, 27 Feb 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189306; cv=none; b=Sv7zlqUeDHU+F5/e658XUsCtVtPBGc2JWWoObaAtelM5cibPXW2lDAbqZiFLxsz8w7Abw6GJ/ous6xMh6HoI7cCkHswijhDV1dtVz8qq26PlPhMpl/yWQFGy3Wpleps4wFoN1WjKWaCXBzpdfPcsqD4TVayIWxXM6fwnd4s5pUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189306; c=relaxed/simple;
	bh=FToMxHmHFwCggEpSR+c8vfaHDWcvy8bRbfx0FGJfcx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp2wjf/GVwlKgprezfVSqVVtuLM56fXbaVJ3Yw7qrHWH0PdWOC7VmWvF3AHDrKkC48uwPSaAww6TU9j515gWiSZOeSRWAHDieXzD3Zav4lgxsHhQ81AN5hkKta1yt/nlnlKlluCMG266z8TS+jDWZ+H9OTPK9Fi98YngBAXOnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR8gz26M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR8gz26M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C643C116C6;
	Fri, 27 Feb 2026 10:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772189306;
	bh=FToMxHmHFwCggEpSR+c8vfaHDWcvy8bRbfx0FGJfcx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MR8gz26M6OBen79lKso9KNxgSDO2YKY5hLRHmzkHmZZKoLr4+h/zIMmqb47pBcOx9
	 3icozpfLIVDho2WqDwpGeRhQd2vE+UF4Skg/IY8+NL4yQOrJLZhvNy3R1CojrtfjsX
	 79OBZj8CnXTTv7wXfXKQ0vFpFghAwlqVIPb6wwCGV8Ig3HyQZm4WEqaJQ0sXC2IigE
	 HRh3XALbkt6DDnYRMMSV0jTrjU0LiYY6/aPB1qoZLXdeVXFXiQH/Lr5ookUo9kQu/7
	 mbbTaOMZEA3CmeZ/bLbXetIQoyB8h5zsDaeTwrAf0/TPinPtHLPoIZgajMveia6QtW
	 FlwZzA5BtT67g==
Date: Fri, 27 Feb 2026 11:48:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Message-ID: <20260227-sceptical-nondescript-owl-de25a6@quoll>
References: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
 <20260226163041.169786-2-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260226163041.169786-2-johnerasmusmari.geronimo@analog.com>

On Fri, Feb 27, 2026 at 12:30:40AM +0800, John Erasmus Mari Geronimo wrote:
> +
> +maintainers:
> +  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> +
> +description: |
> +  The MAX30210 operates from 1.7V to 2.0V supply voltage, and is a low-p=
ower,
> +  high-accuracy digital temperature sensor with =C2=B10.1=C2=B0C accurac=
y from +20=C2=B0C to
> +  +50=C2=B0C and =C2=B10.15=C2=B0C accuracy from -20=C2=B0C to +85=C2=B0=
C.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ma=
x30210.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max30210
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |

Do not need '|' unless you need to preserve formatting. Same in other
places.

> +      Analog Supply Voltage Input. Must have values in the interval (1.7=
V; 5.5V)
> +      in order for the device to function correctly.
> +
> +  powerdown-gpios:
> +    description: |
> +      GPIO spec for CVT/PDB pin. Should be configured with GPIO_ACTIVE_L=
OW.

Should be configured depending on wiring, because the flag includes any
inverters. Just say it is active low,


> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Connected to INT pin. Should be configured with type IRQ_TYPE_EDGE=
_BOTH.

No, just say it is interrupt triggered by raising and falling edges.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - powerdown-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/pwm/pwm.h>

Where do you use this header?

> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        status =3D "okay";

Drop.

> +
> +        temperature-sensor@40 {
> +            compatible =3D "adi,max30210";
> +            reg =3D <0x40>;
> +            vdd-supply =3D <&vdd>;
> +            powerdown-gpios =3D <&gpio 12 GPIO_ACTIVE_LOW>;
> +
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };
> +...
> --=20
> 2.34.1
>=20
