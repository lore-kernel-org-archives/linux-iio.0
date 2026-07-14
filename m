Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E941E6A3
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069096; cv=none; b=KMG7dAdOccawH+V1sG7n91c4od/2JcEnWDc4AERvPUwHLX4P9gIe4nu58pQAd4F5ko9+jYOOriyMwpfptJgFZ3yqJZkKO2NTaCmNTUyx8gHTKFb/BCzRkBtssZPD293csXWbtIEihSlKt1ksMt6SqUd/qIv51kWXJ7AbSSjDOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069096; c=relaxed/simple;
	bh=IWg7h/nT9ksI40PAZL2tVSUITPB/X+Xz/LaQbTYLczY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xovwsl6lRJsNDSxQhWnKsQjBe0dTPG5QGNTY9TKdXp9BYdo7u8GC116N/knE6FGzF4rb2NhBd6nkzYEYjLuNpKcGXuC/4RJUsb3/YBqkiEAoWjN+DRWPEGgzStBTA4vrt8js4NZoMwz05FsBRMyNJgHpEr8khKyEJw7M/xb57RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=b6sPPMWh; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="b6sPPMWh"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44cc65b0a7fso64410fac.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784069088; x=1784673888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bwb2dneFZMtuZJko5tDWoxwvXN4zsuxJo4rgCNZwx1w=;
        b=b6sPPMWhGBw7MQHZYm2ghYZdKY1hL3kkYH7/TIWqlbQUXVnfI2v+RkYOVJN61AgOd8
         sY29psEjY2Vh7eRM5l/Hd5Wbm6dyX08TWW5t4sIWfqxgBcHnbZMFoJlCrann5C+IXe7r
         mkkz9IVXKCvaRi/aF6bQTWi+FR2yFhbYg+n9zxqGRz+QqIJkwpiixWiXmMykGlECzR7M
         uEOkaSU92DZUhfmw4cmAj7kR/aV8beWhGrm9zwB/GwGSHhsBGzcuZGtV/HO4jVkm3u5x
         flJM2hEYvIsP4HCIA+mmhIXD9XP5JwncssdlNP07g+ZeD4Sw0bphhHpCW865Ff+4y0cV
         GcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069088; x=1784673888;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwb2dneFZMtuZJko5tDWoxwvXN4zsuxJo4rgCNZwx1w=;
        b=F4nAYEdbbTGEvBIO4UDXvDlfddRwailNqo2GCsxn+G2fzZSbSC5vBFSODRe5qwiape
         tKMVnN/Zfc9qFEEq6u29avOChhLknWlaGGACvpoZNPnAhIxlAjiuNOOB8pKo47jzZ+Vw
         luDuM1H+Eay/VSUrQS0z+WafY4kPQNaeFkPjEQ3vixhpe0IZEUKQubnkMkO5A8RQ20f9
         kY7ZEOOgdEpRsiwaPdmz1eYb+kzgiu4WUcrp5tAb9gHfbxl1le9XxqQNcOzRyFf21hA0
         NHC2n+HHtWp2yMtAgon1nozii72YNbitwDLSlp1qPZ8GrZNqDPW2C2BLJoeH1O5yH0yT
         0A6A==
X-Forwarded-Encrypted: i=1; AFNElJ9mJoanPTwDyxkKr7Pzc1/tG5KPC9JpmKzNApeudEPGLNyShFot27ClBSpc7KL6uQ3U86425L6WRCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwCL3BaHkFGkIbsud0aUfq+23KOOka3gLfG68N2dWz8Ja1melT
	5qgXyXTidl2J0iDwgCHHTSzbDqqWiEZEmG+IDj5ycQeSnvfiRNuUOOfJxq1XINGwdFI=
X-Gm-Gg: AfdE7ckj4Rof5i5G8wjRMNmL+0kEuxCG/E/n/auUCx+2oLm6Re6qDlVBEWNiEfF4XRp
	Ndu9wQLEHpXPfpl4WD6+OuV5F6b3+x8iJy9sZPvh63WtYqSyeODHEF8kTLL6OPlYJKPjkMzhNSa
	y87OFuCacjZkx3DcWYsfLtLClC0wDNdLFPOiAUfgmumuty5KVMSuwT9K5L4POAA07a3kApYm5Hq
	u3IZK61mVMZxU7qfydbDAi8vbY3pNADaLq2067iNk9YBl4xvLk8cZ3h2cZzjW8TgE7bCJa+UD94
	gLlagYwjXr6tC47+BQrsZCzQkffVrDm0bqh2QZI9VrmXPK1CV7nkD4PLDbisKcjirkE/tkiZIId
	fQDUCTHL/ZDGskVEE2PINIB5cTmqz2ZN4khunVjw5lzY2ts5Du8ghwdtBxIRfUVyJBNE44tw6Fw
	KUtSwS56uuDM5ijd9Yf5TnJ/NsFFQu1XCsefsiYPlDnX7SD8HlIOABpFjm4xSlrBQ=
X-Received: by 2002:a4a:e90c:0:b0:6a1:60cd:9860 with SMTP id 006d021491bc7-6a39bc3ec33mr7163339eaf.10.1784069088561;
        Tue, 14 Jul 2026 15:44:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bc0d0sm16137864a34.19.2026.07.14.15.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 15:44:48 -0700 (PDT)
Message-ID: <7b8973fd-385d-4532-8213-bb0a811081ae@baylibre.com>
Date: Tue, 14 Jul 2026 17:44:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: iio: proximity: move LIDAR-Lite out of
 trivial-devices
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mranostay@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260714215433.41259-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260714215433.41259-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 4:30 PM, Rodrigo Gobbi wrote:
> The PulsedLight LIDAR-Lite v2 is currently described as a trivial device,
> but it is not one: besides the I2C interface it exposes a power-enable pin
> and a mode-control pin (the latter also used for the PWM distance output).

IIRC, we are not adding the mode-control pin to the DT bindings because
it would be an alternative to the I2C bus and not likely to be used (would
require something like a PWM controller with a non-cyclic, bidirectional
channel).

We should explain that in the commit message.

> 
> Move it to a dedicated binding file.

And add we are adding the missing properties, so should mention that too.


> While at it, document the LIDAR-Lite
> v3: it is sold by Garmin, which acquired PulsedLight, and is
> pin-compatible with the v2, so add it with "pulsedlight,lidar-lite-v2"
> as a fallback compatible.

This is a separate change, so deserves a separate patch.

The complaint in v3 was just that the removing .txt and adding .yaml should
be in the same patch.

> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Hi, all,
> This was on my plate and I didn't have a chance to send this before.
> 
> The vendor change is not a typo: see the discussion at [1].
> Tks and regards.

Ideally, this would be explained well enough in the commit message that
we don't need the link.

> 
> [1] https://lore.kernel.org/all/c39a2980-f5e5-44aa-9fd3-20e0658f62dc@gmail.com/
> 
> Changelog:
> v4: unify patches rather than using a series to keep the tree bisectable;
>     rewrite the commit msg, naming the devices explicitly;

We lost the IIO driver patch though. The change adding a new compatible
won't be accepted without it.

> v3: https://lore.kernel.org/all/20251102221643.9966-1-rodrigo.gobbi.7@gmail.com/
> v2: https://lore.kernel.org/all/20250801224112.135918-1-rodrigo.gobbi.7@gmail.com/
> v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/
> ---
>  .../proximity/pulsedlight,lidar-lite-v2.yaml  | 54 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> new file mode 100644
> index 000000000000..60e60b7769ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Pulsedlight LIDAR-Lite v2 range-finding sensor

Could make the title more general:

	Pulsedlight/Garmin LIDAR-Lite range-finding sensors

> +
> +maintainers:
> +  - Matt Ranostay <mranostay@gmail.com>
> +
> +description: |

> +  Support for LIDAR-Lite v2 and v3 laser rangefinders. These devices

The title already says this.

> +  can use a simple I2C communication bus or can operate in a PWM mode using a
> +  mode control pin to trigger acquisitions and return the measured distance.

Probably worth mentioning the bindings are just for I2C usage for now.

Links to datasheets are also useful.

> +  They also have a power enable pin, which can be used to shut off the device.

We can see this in the properties, so don't need to say it here.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - grmn,lidar-lite-v3
> +          - const: pulsedlight,lidar-lite-v2
> +      - const: pulsedlight,lidar-lite-v2
> +
> +  reg:
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    description: GPIO that can be driven low to shut off power to the device.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +

interrupts:
  description: 
    Mode control pin can be used as a status output to provide interrupt.
  maxItems: 1

Mode control pin can also be clock output, so we could add:

'#clock-cells':
  const: 0

if:
  required:
    interrupts
then:
  '#clock-cells': false

I only checked Lidar Lite v3 docs, so we should see if these are available
on v2 as well.

> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        lidar@62 {
> +            compatible = "grmn,lidar-lite-v3", "pulsedlight,lidar-lite-v2";
> +            reg = <0x62>;
> +            vdd-supply = <&vdd_5v0>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 435c4baab436..74b640c48598 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -396,8 +396,6 @@ properties:
>            - onnn,adt7462
>              # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
>            - plx,pex8648
> -            # Pulsedlight LIDAR range-finding sensor
> -          - pulsedlight,lidar-lite-v2
>              # Renesas HS3001 Temperature and Relative Humidity Sensors
>            - renesas,hs3001
>              # Renesas ISL29501 time-of-flight sensor

