Return-Path: <SRS0=ElSe=5U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD82C4332B
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F82206E6
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586019374;
	bh=UF4azqKmc4DVGtBy9aE/k2vQDQ5mrUXEby578UnCuLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=A6FLZKYA+IEtvQcQA9mM0zKfe/7UxbIrlICh3cYcQvHGeetP22VdSStuyTos+dUnN
	 sLw7g4oay+vISQFyiMfo6WfjGztZdXJA8ioFty3K9oufwWIg6jsVR9ACXGX5R1nx3t
	 sirVfr9CQCqJ3+vA7Ir951ivzGn1TnvdHYEkAI7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDDQ4O (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 4 Apr 2020 12:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDDQ4N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 12:56:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96580206D4;
        Sat,  4 Apr 2020 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586019373;
        bh=UF4azqKmc4DVGtBy9aE/k2vQDQ5mrUXEby578UnCuLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GIWhJSAc+Vx2b+DoSTggrekGvFM8g6ihKUqdlRyRP5KW7drFAvAKh0QL/+nGkr22x
         akzDKS1tudGPTHEyZBcBHVa0TaCIlF9/Gx/uorcv6jQRxhQGbJsWG+Ew9E/hs1OznB
         nwExH6RsRIao6mRONS3JQVhETHtE9C+XPdx6UAqs=
Date:   Sat, 4 Apr 2020 17:56:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: adc: Add MAX1241 bindings
Message-ID: <20200404175608.71f81e34@archlinux>
In-Reply-To: <20200403121323.1742-2-alazar@startmail.com>
References: <20200403121323.1742-1-alazar@startmail.com>
        <20200403121323.1742-2-alazar@startmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Apr 2020 15:13:22 +0300
Alexandru Lazar <alazar@startmail.com> wrote:

> Add device-tree bindings documentation for the MAX1241 device driver.
> 
> Signed-off-by: Alexandru Lazar <alazar@startmail.com>
One trivial thing inline.   I'll fix that up and apply, but not
in a form that can't be rebased - so I can add DT review if Rob wants
to take another look.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/maxim,max1241.yaml       | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> new file mode 100644
> index 000000000000..7da9e4153ac1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Alexandru Lazar
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max1241.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX1241 12-bit, single-channel analog to digital converter
> +
> +maintainers:
> +  - Alexandru Lazar <alazar@startmail.com>
> +
> +description: |
> +  Bindings for the max1241 12-bit, single-channel ADC device. Datasheet
> +  can be found at:
> +    https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max1241
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Device tree identifier of the regulator that powers the ADC.
> +
> +  vref-supply:
> +    description:
> +      Device tree identifier of the regulator that provides the external
> +      reference voltage.

I believe this is always one anyway so not needed.

> +    maxItems: 1
> +
> +  shutdown-gpios:
> +    description:
> +      GPIO spec for the GPIO pin connected to the ADC's /SHDN pin. If
> +      specified, the /SHDN pin will be asserted between conversions,
> +      thus enabling power-down mode.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vref-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "maxim,max1241";
> +            reg = <0>;
> +            vdd-supply = <&adc_vdd>;
> +            vref-supply = <&adc_vref>;
> +            spi-max-frequency = <1000000>;
> +            shutdown-gpios = <&gpio 26 1>;
> +        };
> +    };

