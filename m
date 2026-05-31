Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00AD38E5FE
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780249490; cv=none; b=P4oVWO0ol7XoOR+VlRyIzq3C720PkGSBSSc8QSIV2+EJI7UfmF1UinTH5gNYTZQkHPyWsk9FAc3l8z+F43bOlb3+tP/QPEEeMKHhG/GwJ+E2CvczlZmeYnHoa2xY32ulX2iDFoU5aI/agRaFNxvsK2ukqWVi2hl/fEdMwrxdVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780249490; c=relaxed/simple;
	bh=Xd/FwvTv5dh3MYxFn2DCgqgMqt62UPZ7nq/ZmFI1P9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARO3Q6JGT3jx07IUL+bbbedcD+bgtAoIz3UwdequiUfODOAhCFa8Lw55VhJEUTISJEEUUA5+u0Q8csi8OxZtb/CxZL8YT0RoG2dSLJWXWwsBNzls/se5Rk7tAWKfNK6ix7I1WUUwKqgMga+eUMsuhxn5EqZbfAFUsZ4iZI+t7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/AbNNkn; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/AbNNkn"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6c4a2458683so658206137.1
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780249488; x=1780854288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISFXBkZkZECisL/zJWlMQKvCNsNkkqN/b3igeJTiU3k=;
        b=m/AbNNknmc/rkjgGXNhqV3FiIIqJr3BfzvSxG7KOxg9J0CRypEOj1Jdiu4VioERSaG
         89Wjtcv3woqcHypHcL0MToLRBzj59dB51rU4tTUIQf3EAVMnKGQplN4Gvd6hMus1Dfjg
         nNHjTCgMuSA03DmMSQQ+GHVU73rew17Sw9FoHUe+9gojnVnnOkEeoUQE6UG0JiYwAKUe
         knQ7Ne2O1pZjs0rsVxhqppOx/s1eIcJKMF7Zv4lsJjDjcS4QooqHGofxoh1tyiyHb7lq
         0xUz/BXRHXfzVqOKJ/W40EcWtw47bjXeLFK4nUyoolPSoDErCsmk+/gTk5JfkR6G9SWe
         AyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780249488; x=1780854288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISFXBkZkZECisL/zJWlMQKvCNsNkkqN/b3igeJTiU3k=;
        b=mNGPwOvDXk1KfSvEUSmssmyp62wNQhZsH8oOXBS2e4jxnpAu6+BfPneT9j96oqOQzd
         z6bR95GzwSnjflBs02vev7H3+bhVPhQhSqU5ZO87et79pElZpbZPRPrqRKTSaSekk82u
         12qzYwhcADdW+JPmjl1LhhcoFkHVr+nWLcFd+UxEYf8xD10ChXp0eYr4AX/b9HKINzij
         CWhnXe+RTWj4eZhD4TcQC6EbsN4GhcdLdRlsA3r7ZFNznJhjSRPp9g664rW9/QG9KML6
         L/gw9pp8C41G4tXyQRgCZbNLVod9uJo20V0k8hhvOh6H2Bk6f4oxc+vv1BKYZRGS+z8W
         EGfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2trM0MBnqfJzT28OaTxGiE+uMBIeFGEVfn3pwbabPtLFOxmrhrQuduPK1PREv0w/xUnVwA38u67I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDh5nkdiwvh01oAY03dW7RTNjuFD9yh0VMoNnLV2VqRIS+Veg
	llYemz56c1NThMH6hIhaJY0qou6v1lWBcf8TpuwL1behxt531eoS6qsozlKJ8ANG
X-Gm-Gg: Acq92OFiFrNKB8D4XeFHY/X8vbwGCXDJ63vCcvA1icVkwstk4Q9iVKstgqvcg9NMvgY
	HFDXp+uer2CxMerA7bl5WvqOuSB1MsMqawi36zDSruUAUp/SNvl4OLdOu+hbdxeOEzgJAfzfcZU
	cMhtHOfN0Tt83X+GwC5H/RcJG2fS1DjiQR8wIbUjma2i1cwRmd4M9miCr6zrQvrtGCSCjo0aXwu
	Xt5Rrz2p7T8JcgSQTR1OMCsLxXHUaSFIYc8OkydUHcMBwKa+PKHQ5669gcEEEzSD1NFb5cRw//A
	JhlCuwOlu2rEXJdcurWRgtl8damR2NThgKHeNfT5nt8rRI06umwHns6JvR0QyXndAR34nwSk3Nd
	FBUtF0+wJc8noGS69fPghUj8bUpdgtTq3US+671SDrEdCkpAWJIkWTWaArMIPYO5iEf7btM9fE+
	UAL46aMakPL/cnksEjBQKgfXCm/lYEMYNzQW3bYpdecuQ=
X-Received: by 2002:a05:6102:c13:b0:66a:4052:3e20 with SMTP id ada2fe7eead31-6c6a850a490mr2615546137.26.1780249487642;
        Sun, 31 May 2026 10:44:47 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-963aba8b912sm4199223241.5.2026.05.31.10.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:44:45 -0700 (PDT)
Date: Sun, 31 May 2026 14:45:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <ahxzpBcqN6o6q4a4@debian-BULLSEYE-live-builder-AMD64>
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530205435.37326-3-wafgo01@gmail.com>

Hello Wadim,

The dt doc looks good to me.
A couple of minor comments inline.

On 05/30, Wadim Mueller wrote:
> Document the bindings for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  The family currently covers the
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> 
> The driver auto-detects the variant from the product-information
> register at probe time; the per-variant compatible strings exist
> for documentation and dt_binding_check purposes.
> 
> The active calibration medium (water / IPA) is runtime-switchable
> via the in_volumeflow_medium sysfs attribute and therefore not a
> DT property.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  .../bindings/iio/flow/sensirion,slf3s.yaml    | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> new file mode 100644
> index 000000000..dc41120e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/flow/sensirion,slf3s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SLF3S liquid flow sensor
> +
> +maintainers:
> +  - Wadim Mueller <wafgo01@gmail.com>
> +
> +description:
> +  Family of digital liquid-flow sensors from Sensirion with I2C
> +  interface.  All family members share the same register map; sub-types
> +  differ only in the flow scale factor and the calibrated measurement
> +  range, both of which are detected at probe time via the
> +  product-information register.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,slf3s-0600f
> +      - sensirion,slf3s-1300f
> +      - sensirion,slf3s-4000b
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true

We could add a mention to the IRQ pin to make the doc more complete.

  interrupts:
    maxItems: 1

Though, I see the chip has an unused pin. If future designs implement an
aditional IRQ signaling on that unused pin, we would need to add extra
properties to the dt-doc to specify the number of interrupts each design has.
Anyway, documenting the IRQ now is probably okay even if we have to update it
in the future.

> +
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
> +
> +        flow-sensor@8 {
> +            compatible = "sensirion,slf3s-0600f";
> +            reg = <0x08>;
> +            vdd-supply = <&reg_3v3>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06a8c7457..222a03b6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24187,6 +24187,14 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
>  F:	drivers/iio/chemical/sgp40.c
>  
> +SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
> +M:	Wadim Mueller <wafgo01@gmail.com>
> +R:	Maxwell Doose <m32285159@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> +F:	drivers/iio/flow/slf3s.c
The driver file is added in patch 2 so the above line would be introduced in the
second patch.

With the MAINTAINERS entry adjustment,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> +
>  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> -- 
> 2.52.0
> 
> 
