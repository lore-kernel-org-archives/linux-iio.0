Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B611FD4;
	Sun,  6 Sep 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788654670; cv=none; b=RqNeUthWbNteS8z8b7Z2kIPmf4FuliJrUjGAo9PAf/ty8bn8LpABG9EjrRD/Vw7Xe1t1+DKpHurlSmTmGRf3ej+ARwfvVlj3NG57whhpGrLeyUzjerqoNyXkKZdotpvpJ/MrtGYlMTo5AKWykTMc9oLZ4SG4hx03NukhCpng0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788654670; c=relaxed/simple;
	bh=LuFQ85a+/EolmqBJuS6QJ7dcOHgDNs1oh4OI9pP/lnQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=gwckjewnHfIwAaIyZqPPQ+raA5koxDcDo9PtJoIsvW/93sloV7FZZFygKRf6lFaVgXDZrsYwn0fGiFsPytNmJIqt/dJPOpBTt0POGRwVSyoLoAv9Cpj5wHqstDk6GWWVZtgEU+sP76fZ9YGNwsx8oO5lr5swVfFTZyAzw2VNLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCT6QBkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCT6QBkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8691F00A3A;
	Sun,  6 Sep 2026 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788654668;
	bh=vhGyBI64iII+6zmiH7P+DrwMdk2PJyY+9/uzYQ46ak0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OCT6QBkIkvn7TA6w6IE5PEq5NyPRC4aAxopJnEMppxvAu8cPInqwQaxGqHXptQzbT
	 MWFng39Df7sM/IqqG2xz6IPd1971UQ7gmctcAxkPvaUsLg0HCrGz8SFe8pCmp4kQik
	 UoexsF6o7oVybF/hBBmDlmTwkq3wbbGWsxWbZAkttdcsqthID7diejuofCdmTL6+it
	 PHz36QgIauj3Qaq62QXEYy2jE+Vu65XGcO9aGK1BCGyd/tFgIupA7xQWgUGQ6aVVZa
	 mUPGKvBr+HEEx/+cwQ6VgIxE4Adva7+RDTaeMfKd61MBj2d5fA1h0IxTqSxTwKzG3v
	 9lMKIxOg/CnQA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: add as7343
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <a516f5bdfaf9a2cee9e22b80c17fb42f860afdf2.1788586814.git.marcus.yu.56@gmail.com>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
 <a516f5bdfaf9a2cee9e22b80c17fb42f860afdf2.1788586814.git.marcus.yu.56@gmail.com>
Date: Sun, 06 Sep 2026 01:30:39 +0100
Message-Id: <178865463956.3402141.1659264154526882946.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4043;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=LuFQ85a+/EolmqBJuS6QJ7dcOHgDNs1oh4OI9pP/lnQ=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnLQyOB2fxC/u5RXZb4Rds7TN+2QavMssLKPlX
 z3OR/QIAsuJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapy0MhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiGmZD/0YUrfoHomHH6UxEm5tMtFPQzAjFGaHkpxyKjc+VLzDRWG
 OTHhgU3humrWhdfMzb1R121EDp7l0HwLwjpY8/3Uo1vy7I4fGbr1ExMcYR/+U2gAZPraoZwJXnU
 R10St2UzbEX8qQ1MmvNDVlOIqjdSYCKsRGeFJ9/CC+U6gNQ3D24Cv3sD6cRWV9Oqn2yd0immEzL
 3ObhydJFVjtoVBN6slcpcX+VGMFTcOEPr47svwfTKoonqbAtgkvciK/3GKCFhouVFAaB6rlUHPe
 JjVOPrOoQWUc64adLTvyi8fC2RDJwC+7PjSciks6nqt3oicuKZzlSuj5Pv9CQbrPuU5AmkC5zv9
 QGgWN3hEwEVTSX1fso0QVR/1xXLTtGDwyrOQXjjjIi+vExvRCeU6g7lUXv9iAIfFokE4/J2Fzjs
 6Z2mGsLDPDursc4Le0yh1psgI5MjscexbAWzWXhwANc4jLh1evJ2ZBsi1qKb3LdFbUT8Pw7Gott
 IS6h9ZkXxFkX6gZK91ss7QsBm+BUuZaGZseokQrS/5aHwrnBODw3AVw38GYLAQTXwgIxhcDZMec
 tgU5N9PTtTnUFxWQfoHIdWHAIdlyQkfuJkU9xH83xQBLtUx93ZTtB76XKAROK8Kwb4LVJw1bCYw
 +TsVz5lD4rZyAy0JgMupaK9oKLLUGMpmkzs3wcQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> with i2c address of 0x39.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>

Given you need to send again to include right folk for testing and
review here are a few initial things to fix up and make it a proper
v2

>
> diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> new file mode 100644
> index 000000000000..fb996160cf8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS7343 14-Channel Multi-Spectral Sensor
> +
> +maintainers:
> +  - Chang Yu <marcus.yu.56@gmail.com>
> +
> +description: |
> +  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address of 0x39.
> +  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ams,as7343
> +
> +  reg:
> +    description:
> +      I2C address of the device (0x39).
> +    maxItems: 1
> +
> +  vdd-supply: true

Power supplies that are needed in practice for a device to function
are always added to the required list (there are some historical
quirks in some bindings).  We do that even though the Linux regulator
framework will hand you a fake supply if you don't provide one via
the dt on basis the power is presumably always turned on.  The reason
for this is otherwise we can't see when we have a truely optional
power supply (common for references where there may be a number of
alternative sources such as internal voltage references).

I'd expect some binding info about whether LDR is connected to
anything or not. (LED Driver - who picked a common term like LDR
which is normally Light Dependent Resistor?!!)  We need the driver
to be able to decide to turn that on or off + set the drive
current.  Look at proximity sensors for examples of ways this might
be done.

There is also an interrupt pin that definitely wants to
be documented.  Bindings should be as full as possible.  The only
time we leave stuff out is when we have no idea how to write
the binding - that happens for sufficiently unusual corners that
aren't true for this.

The gpio is more interesting but at lest one option is to use
it as just that, so I'd expect to see binding for that.  The
sync stuff is perhaps an area where the binding design may be
less obvious and postponing that (mention it in the patch description)
might be the best path forwards.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>

Sashiko:
[Severity: Low]
Is it necessary to include irq.h here? The example does not appear to
define or use any interrupts.
-

Seems like a valid thing to clean up!
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        as73211@74 {

Should be a generic name not the part number.  If there isn't a
suitable one in the dt specification or in general use, make up
a new one.  Maybe multispectral is suitable here - I haven't really
thought about it much!

> +            compatible = "ams,as7343";
> +            reg = <0x39>;

Sashiko:
[Severity: Low]
Does the unit address (@74) mismatch the first address in the reg property
(<0x39>)? This might trigger a unit_address_vs_reg warning during
dt_binding_check and dtc compilation.

Also, should the node name use a generic functional name (such as
sensor@39) instead of referring to a different device (as73211)?
-


> +        };
> +    };

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
