Return-Path: <SRS0=1voA=6C=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B6CC3A5A0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Apr 2020 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9463A2223F
	for <linux-iio@archiver.kernel.org>; Sat, 18 Apr 2020 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587225198;
	bh=ez2k39xLHi5LnhGPdODOtlKv7929LfkcIu5m1qslZic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VnCbT6ahljm8xBcfvcDR9LFhZUgM+aZLS1WKB2dPwTs7wG0nh7PCIU+56RRDza/h5
	 AG7BPh+KHG7jSXaBtOsrm/Vd60anum3mwa8X3fMGKUvJJyUi2UgVstncERqDhH7rC3
	 PjfrcZz95nGPvKn4byldrcYCLxS6kkZrKcorhq24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgDRPxS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgDRPxR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 11:53:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E071921973;
        Sat, 18 Apr 2020 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587225197;
        bh=ez2k39xLHi5LnhGPdODOtlKv7929LfkcIu5m1qslZic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I7NWwn3RJ0/mAlfY9NH/nqne0w7WJBn4OBY/+zCQMk9zW/agu3WpWvRLXO3P/LK2g
         1qIxGtV/P9qLPWStj82rg/AuQ5cYJQ7RAHtPIbLFIZPeGHvTqmMFL+kWD4ARtaRipj
         2L4Sb6J6bzM8BypsTTNVU3hecmUVXZ+IFVUrdK9Y=
Date:   Sat, 18 Apr 2020 16:53:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v4 3/3] iio/dac: convert ltc2632.txt to
 lltc,ltc2632.yaml
Message-ID: <20200418165312.5ed6ddb8@archlinux>
In-Reply-To: <20200416012016.21422-4-chris.ruehl@gtsys.com.hk>
References: <20200416012016.21422-1-chris.ruehl@gtsys.com.hk>
        <20200416012016.21422-4-chris.ruehl@gtsys.com.hk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 09:20:11 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> Conversion of the ltc2632 to yaml format and name the file 'lltc,ltc2632.yaml'.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
> V1-V4 patch set, no changes
> 
>  .../bindings/iio/dac/lltc,ltc2632.yaml        | 78 +++++++++++++++++++
>  .../devicetree/bindings/iio/dac/ltc2632.txt   | 49 ------------
>  2 files changed, 78 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> new file mode 100644
> index 000000000000..314bf700d934
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +# Copyright 2020 Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>

Surely we can stich someone at analog up with this one rather than me?

Alex / Michael, who should we land this one on?

> +
> +description: |
> +  Bindings for the Linear Technology LTC2632/2634/2636 DAC
> +  Datasheet can be found here: https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc2632-l12
> +      - lltc,ltc2632-l10
> +      - lltc,ltc2632-l8
> +      - lltc,ltc2632-h12
> +      - lltc,ltc2632-h10
> +      - lltc,ltc2632-h8
> +      - lltc,ltc2634-l12
> +      - lltc,ltc2634-l10
> +      - lltc,ltc2634-l8
> +      - lltc,ltc2634-h12
> +      - lltc,ltc2634-h10
> +      - lltc,ltc2634-h8
> +      - lltc,ltc2636-l12
> +      - lltc,ltc2636-l10
> +      - lltc,ltc2636-l8
> +      - lltc,ltc2636-h12
> +      - lltc,ltc2636-h10
> +      - lltc,ltc2636-h8
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +  vref-supply:
> +    description:
> +	  Phandle to the external reference voltage supply. This should
> +      only be set if there is an external reference voltage connected to the VREF
> +      pin. If the property is not set the internal reference is used.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply

No it isn't.  See internal reference comment above...

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    vref: regulator-vref {
> +        compatible = "regulator-fixed";
> +        regulator-name = "vref-ltc2632";
> +        regulator-min-microvolt = <1250000>;
> +        regulator-max-microvolt = <1250000>;
> +        regulator-always-on;
> +    };
> +
> +    spi_master {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dac: ltc2632@0 {
> +        compatible = "lltc,ltc2632";
> +        reg = <0>;    /* CS0 */
> +        spi-max-frequency = <1000000>;
> +        vref-supply = <&vref>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> deleted file mode 100644
> index 1ab9570cf219..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Linear Technology LTC2632/2634/2636 DAC
> -
> -Required properties:
> - - compatible: Has to contain one of the following:
> -	lltc,ltc2632-l12
> -	lltc,ltc2632-l10
> -	lltc,ltc2632-l8
> -	lltc,ltc2632-h12
> -	lltc,ltc2632-h10
> -	lltc,ltc2632-h8
> -	lltc,ltc2634-l12
> -	lltc,ltc2634-l10
> -	lltc,ltc2634-l8
> -	lltc,ltc2634-h12
> -	lltc,ltc2634-h10
> -	lltc,ltc2634-h8
> -	lltc,ltc2636-l12
> -	lltc,ltc2636-l10
> -	lltc,ltc2636-l8
> -	lltc,ltc2636-h12
> -	lltc,ltc2636-h10
> -	lltc,ltc2636-h8
> -
> -Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
> -apply. In particular, "reg" and "spi-max-frequency" properties must be given.
> -
> -Optional properties:
> -	- vref-supply: Phandle to the external reference voltage supply. This should
> -	  only be set if there is an external reference voltage connected to the VREF
> -	  pin. If the property is not set the internal reference is used.
> -
> -Example:
> -
> -	vref: regulator-vref {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vref-ltc2632";
> -		regulator-min-microvolt = <1250000>;
> -		regulator-max-microvolt = <1250000>;
> -		regulator-always-on;
> -	};
> -
> -	spi_master {
> -		dac: ltc2632@0 {
> -			compatible = "lltc,ltc2632-l12";
> -			reg = <0>; /* CS0 */
> -			spi-max-frequency = <1000000>;
> -			vref-supply = <&vref>; /* optional */
> -		};
> -	};

