Return-Path: <SRS0=13NI=3Q=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE94AC2D0DB
	for <linux-iio@archiver.kernel.org>; Mon, 27 Jan 2020 20:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32042467F
	for <linux-iio@archiver.kernel.org>; Mon, 27 Jan 2020 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580156171;
	bh=zcqkL2X1+5RZ6RD91lcWz4KcZ3RzkxAM2y0dev3Kxhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ruN4GCOJKI5GqsiuEUe0s5JZZGwRWaXyo/WaVyc7tZMj7NUT9f6BZgNgsvtuKpAed
	 F6x+aaY3dhjmhIfyYFfcQ4RmF6If31u428XfppO231T1O45ZJZWroeTB7BxPBbwvCF
	 teBaUUzxRWaRGR/Gtke4ga6iE2DuqswzqQvV0SgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgA0UQH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:16:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35812 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgA0UQH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jan 2020 15:16:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so9731903otd.2;
        Mon, 27 Jan 2020 12:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kP3meVHpRUwC+Lg41T7kI+wm6FYiDtOOiXX2HrvTBww=;
        b=BTktUi3fcS0ZkN+Kf42104r1tioKWgNlQBJG5HTd/EVu7FC9+X0MxzY1rCl+5n5gQF
         Y2tzwTGdQJBWgE7QLyIeKTxMFAaS3oJ8qqJokmIjvLfLL1LiPbp7azai86bYV4SoYTRO
         289f2h5bMC1S+BHmUODeezZW7bgt0AS3ItZz011HdV+4mjSS/Ao4SHRfVIsB/WqePVeR
         V1Y2H1cLU5AnJ1pKHFvTZ5Rv4JrDG92St1mhcwuURTuJZ2ZlZtCNZxFgtkN7fI/BDXkQ
         U4bNVtr4+GTd9SZfHwYgZAoKud8C0472hnVACNCQx8NLq6qjMbSjfBoAgLXEHlOSSAEH
         9+xg==
X-Gm-Message-State: APjAAAWiqlA7A8ISBRgt4x5Es4xSz5xoTMZtTSBBIUCKzrTu7CgjPNUq
        MtWaDK4RK63pNC3OGPKAfuL+7Yc=
X-Google-Smtp-Source: APXvYqx8cBU9dlCzp2qsiRzvx9t6DQ1OIpfXuWYpi0exeUekVr56E9j4fYVOZ8DSsuYy1LtC8Xa6xw==
X-Received: by 2002:a9d:1b26:: with SMTP id l35mr13904866otl.307.1580156166836;
        Mon, 27 Jan 2020 12:16:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m19sm5942050otn.47.2020.01.27.12.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 12:16:06 -0800 (PST)
Received: (nullmailer pid 3695 invoked by uid 1000);
        Mon, 27 Jan 2020 20:16:05 -0000
Date:   Mon, 27 Jan 2020 14:16:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, biabeniamin@outlook.com,
        knaack.h@gmx.de, mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: amplifiers: Add docs for
 HMC425A Step Attenuator
Message-ID: <20200127201605.GA9131@bogus>
References: <20200122121702.30494-1-beniamin.bia@analog.com>
 <20200122121702.30494-2-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122121702.30494-2-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 22, 2020 at 02:17:01PM +0200, Beniamin Bia wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Document support for Analog Devices MC425A Step Attenuator.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> new file mode 100644
> index 000000000000..a0afa661f4ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,hmc425a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HMC425A 6-bit Digital Step Attenuator
> +
> +maintainers:
> +- Michael Hennerich <michael.hennerich@analog.com>
> +- Beniamin Bia <beniamin.bia@analog.com>
> +
> +description: |
> +  Digital Step Attenuator IIO device with gpio interface.
> +  HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,hmc425a
> +
> +  vcc-supply:
> +    description:
> +      Digital voltage regulator (see regulator/regulator.txt)
> +    maxItems: 1

All supplies are a single entry, so drop this. Really, 
'vcc-supply: true' is sufficient.

> +
> +  ctrl-gpios:
> +    description:
> +      Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
> +      connected to the control pins V1-V6.
> +    maxItems: 6
> +
> +required:
> +  - compatible
> +  - ctrl-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    gpio {
> +      #address-cells = <1>;
> +      #size-cells = <0>;

GPIO clients are not child nodes of GPIO controllers, so you can remove 
this node.

> +      gpio_hmc425a: hmc425a {
> +        compatible = "adi,hmc425a";
> +        ctrl-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>,
> +          <&gpio 39 GPIO_ACTIVE_HIGH>,
> +          <&gpio 38 GPIO_ACTIVE_HIGH>,
> +          <&gpio 37 GPIO_ACTIVE_HIGH>,
> +          <&gpio 36 GPIO_ACTIVE_HIGH>,
> +          <&gpio 35 GPIO_ACTIVE_HIGH>;
> +
> +        vcc-supply = <&foo>;
> +      };
> +    };
> +...
> -- 
> 2.17.1
> 
