Return-Path: <SRS0=cqhh=3Z=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2737EC35247
	for <linux-iio@archiver.kernel.org>; Wed,  5 Feb 2020 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E784B21741
	for <linux-iio@archiver.kernel.org>; Wed,  5 Feb 2020 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580927104;
	bh=hOydfYfzrCn/LQuDT+PO7LxII0NusccR2HEa5F4UbXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=joj+7NRhPLTb3KTKolCGHxoOSJ1TuiTuWp+EiEiKXEtAs5JTy41Z7pgYBmi8rjzrr
	 8prM5ckesjGb2BL28lEYdqK/dids/K0Etxy8tzRcgQzS0E44cyOkxnPj2fU+E7Z9I/
	 qCNtOrINHRKRR7GZAVVo9qchx7R24xms0Xi1AkEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgBESZD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:25:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54147 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBESZD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 13:25:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so3546603wmh.3;
        Wed, 05 Feb 2020 10:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RSc09GihEjzTvjEtlsohVROecxEidcvCpfVJp0d2hyg=;
        b=OL01PjhL8lArlCSpnIEW67h6dMLLx9G4WLrulFtk6Fo4cKMnBCTvFaOsmUpro31WkP
         uL/OuQLIpha2DeOY3svk4Ev3YedRAiWjGIHtS2qn2gmi9gBchJgu8l3hauu0gnIOyxv4
         9TF1W6g/noLnaorNFLxVHmxlhPLC/fZ2YxsFa6Jq2Ad+aRpYQvoyr+tSy0mTlt0CNB3J
         h63Cxyx2l2H3MMN7xRTUiGM/N4uiBLxhqkfHSCoanxBOVsbmy6JnK/plGeg6B7sIZvjZ
         ccq6WOEHWQFgfsOMBziCsQBT+VMf9A8IJbkjzJS+GIJMummvbVDGX/U6hGRHD7BNdSno
         SEng==
X-Gm-Message-State: APjAAAUHjZgwBIV4ApITYkyHuL1RpXyent8SMsJAWKI7W6LHfm6NqRKm
        NAD7CJxkmHPf+XowXjioHhFC0hKE8A==
X-Google-Smtp-Source: APXvYqz0OyKZaZUIEl0dvOgaLfULo7tApC3jXaas0FpSmwEYGD2eRs91jZJjw844MT9OsUXRg2U24A==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr7626555wmc.185.1580927100515;
        Wed, 05 Feb 2020 10:25:00 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id b21sm459441wmd.37.2020.02.05.10.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 10:24:59 -0800 (PST)
Received: (nullmailer pid 22918 invoked by uid 1000);
        Wed, 05 Feb 2020 18:24:58 -0000
Date:   Wed, 5 Feb 2020 18:24:58 +0000
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ekigwana@gmail.com, jic23@kernel.org,
        lars@metafoo.de
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: frequency: Add docs for ADF4360
 PLL
Message-ID: <20200205182458.GA14182@bogus>
References: <20200128111302.24359-1-alexandru.ardelean@analog.com>
 <20200128111302.24359-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128111302.24359-2-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 28, 2020 at 01:13:01PM +0200, Alexandru Ardelean wrote:
> From: Edward Kigwana <ekigwana@gmail.com>
> 
> This change adds the device-tree bindings documentation for the ADF4360
> family of PLLs.
> 
> Signed-off-by: Edward Kigwana <ekigwana@gmail.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4360.yaml   | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> new file mode 100644
> index 000000000000..895e2cb2b300
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2019-2020 Edward Kigwana
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf4360.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADF4360 PLL device driver
> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +  - Edward Kigwana <ekigwana@gmail.com>
> +
> +description: |
> +  Bindings for the Analog Devices ADF4360 family of clock generator phase-locked
> +  loop (PLL) devices with an integrated voltage-controlled oscillator (VCO).
> +  Each of the parts in the family supports a specific frequency range.
> +  Datasheets can be found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-0.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-2.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-3.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-4.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-5.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-6.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-7.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-8.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-9.pdf
> +
> +properties:
> +  compatible:
> +    pattern: '^adi,adf4360-[0-9]$'
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: clkin
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  adi,loop-filter-pfd-frequency-hz:
> +    description: |
> +      The phase-frequency-detector frequency that the external loop filter was
> +      designed for.
> +    allOf:
> +      - minimum: 25000
> +      - maximum: 8000000
> +    maxItems: 1

You're mixing array and scalar properties. Drop 'maxItems' and min/max 
don't need to be under 'allOf'.

> +
> +  adi,loop-filter-charger-pump-current-microamp:
> +    description: |
> +      The charge pump current that the external loop filter was designed for.
> +      The provided value is clamped to the closest enumerated value.
> +    enum: [ 310, 620, 930, 1250, 1560, 1870, 2180, 2500 ]
> +
> +  adi,vco-minimum-frequency-hz:
> +    description: |
> +      Required for ADF4360-7, ADF4360-8 and ADF4360-9. Minimum VCO frequency
> +      that can be supported by the tuning range set by the external inductor.
> +    maxItems: 1
> +
> +  adi,vco-maximum-frequency-hz:
> +    description: |
> +      Required for ADF4360-7, ADF4360-8 and ADF4360-9. Maximum VCO frequency
> +      that can be supported by the tuning range set by the external inductor.
> +    maxItems: 1
> +
> +  adi,loop-filter-inverting:
> +    description: Indicates that the external loop filter is an inverting filter.
> +    type: boolean
> +
> +  adi,power-up-frequency-hz:
> +    description: |
> +      PLL tunes to the set frequency on probe or defaults to either the minimum
> +      for the part or value set using adi,vco-minimum-frequency-hz.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |
> +      vdd supply is used to enable or disable chip when regulator power down
> +      mode is set. Other power down modes are used to mitigate the case of a
> +      shared regulator.
> +
> +  enable-gpios:
> +    description: |
> +      Chip enable gpio is used to enable or disable chip when chip enable power
> +      down mode is set.
> +    maxItems: 1
> +
> +  adi,muxout-gpios:
> +    description: |
> +      MUX out gpio is used to detect chip and test pll lock state on read when
> +      muxout control is set to lock detect.
> +    maxItems: 1
> +
> +  adi,power-out-level-microamp:
> +    description: |
> +      Chip support setting of output power level. This property is optional.
> +      If it is not provided by default 11000 uA will be set.
> +    enum: [ 3500, 5000, 7500, 11000 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - adi,loop-filter-charge-pump-current
> +  - adi,loop-filter-pfd-frequency-hz
> +
> +examples:
> +  - |
> +      spi0 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pll@0 {
> +                  compatible = "adi,adf4360-7";
> +                  reg = <0>;
> +                  spi-max-frequency = <2000000>;
> +                  clocks = <&ref_clock>;
> +                  #clock-cells = <0>;
> +                  clock-names = "clkin";
> +                  clock-output-names = "adf4360-7";
> +
> +                  adi,loop-filter-charge-pump-current = <5>;
> +                  adi,loop-filter-pfd-frequency-hz = <2500000>;
> +                  adi,vco-minimum-frequency-hz = <700000000>;
> +                  adi,vco-maximum-frequency-hz = <840000000>;
> +          };
> +      };
> +...
> -- 
> 2.20.1
> 
