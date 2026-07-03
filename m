Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE530F526;
	Fri,  3 Jul 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072159; cv=none; b=hcQQdn/ZDdljDwqHZd5BPojh7eE1nFe8HKrA9UZ2138xT5DTItzLdtz8zJfjg1T07LQRdEe5v3DTdTkQta5ZvLMo97bMDpG35gu+LvHBrLJKseJPPIgt7QVGylk+D62InrAfEP9EETsK4BzCbfjhEzmOyJFYb/tZi9Zlf2SN2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072159; c=relaxed/simple;
	bh=QgrHbaYgP/JeUUnhnF8GhRLxXyk/jEb35LJHnHD+BcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAbDPbO8RTI7+Buaas/XmK5BcYIwtJxBEWZRh4p528PVvIv+X6VYOyHVkzbxUmcB02FFEZR7nQjOcNUPL6GcW0CJbvSQuMB4klTXcZqapJqEOW7QTCbRomoCy4r3F6BwYLX31U/+3hoWfgOD24K5aLbn0nHZPuVqGuadbq+zkUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jraEe4ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jraEe4ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F761F000E9;
	Fri,  3 Jul 2026 09:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072155;
	bh=TbsIW8A8QV+QRdEo3sVmZwQGoZ0T+VvR1pXly6UWHO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jraEe4ezfUrBu8c5arE/ttedlAbJe8UgGD1hI9VVAUNsV+7mtMP+oa6Zs8CqXCGej
	 dPLbBRrOXqogFlY4pn8oL72XZqIR5zfcNO9VcdWTBK9j4YSlbXlQQ+0gEXpCdiT/n5
	 fZ62nzdpF9dv9h+flM0XQ61BT4zJGwufqN/V2Ep4InjfK6ydM9GTa63SND9yR1a9fO
	 cKd1avCYbTxzFkjkKj2oGQqHpB1wNP782n6OwGTMfdyThBUD86YdwBKCc5SBGxZnKA
	 viZ8FNzVkQDrzY3LTr+MioRdt1z/xA9gc9DHbhbM3HRPbghSBIc7qSOTY7a/El36OX
	 5Q3DZQraooSYw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfaWG-00000000hvY-3m36;
	Fri, 03 Jul 2026 11:49:12 +0200
Date: Fri, 3 Jul 2026 11:49:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 01/14] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-2-clamor95@gmail.com>

On Wed, Jun 17, 2026 at 11:00:18AM +0300, Svyatoslav Ryhel wrote:
> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@36 {
> +            compatible = "ti,lm3533";
> +            reg = <0x36>;
> +
> +            enable-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
> +            vin-supply = <&vdd_3v3_bat>;
> +
> +            ti,boost-ovp-microvolt = <24000000>;
> +            ti,boost-freq-hz = <500000>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            backlight@0 {
> +                compatible = "ti,lm3533-backlight";
> +                reg = <0>;
> +
> +                default-brightness = <113>;
> +
> +                led-max-microamp = <23400>;
> +                led-sources = <0 1>;
> +            };
> +
> +            led@2 {
> +                compatible = "ti,lm3533-leds";
> +                reg = <2>;
> +
> +                led-max-microamp = <23400>;
> +                led-sources = <0 1>;
> +            };
> +
> +            led@4 {
> +                compatible = "ti,lm3533-leds";
> +                reg = <4>;
> +
> +                led-max-microamp = <23400>;
> +                led-sources = <2>;
> +            };
> +
> +            led@5 {
> +                compatible = "ti,lm3533-leds";
> +                reg = <5>;
> +
> +                led-max-microamp = <23400>;
> +                led-sources = <3 4>;
> +            };
> +
> +            light-sensor {

Doesn't the binding (or dts) checker complain about this node not having
an address?

> +                compatible = "ti,lm3533-als";
> +
> +                interrupt-parent = <&gpio>;
> +                interrupts = <80 IRQ_TYPE_LEVEL_LOW>;
> +
> +                ti,pwm-mode;
> +            };
> +        };
> +    };
> +...

Johan
