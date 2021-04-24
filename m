Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C66C433B4
	for <linux-iio@archiver.kernel.org>; Sat, 24 Apr 2021 10:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1782661494
	for <linux-iio@archiver.kernel.org>; Sat, 24 Apr 2021 10:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhDXK3I (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 24 Apr 2021 06:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234416AbhDXK3G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 06:29:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CC1613DB;
        Sat, 24 Apr 2021 10:28:27 +0000 (UTC)
Date:   Sat, 24 Apr 2021 11:29:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        lars@metafoo.de, Nuno.Sa@analog.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: accel: fxls8962af: add
 bindings
Message-ID: <20210424112908.2a835f54@jic23-huawei>
In-Reply-To: <20210423101951.2876009-2-sean@geanix.com>
References: <20210423101951.2876009-1-sean@geanix.com>
        <20210423101951.2876009-2-sean@geanix.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Apr 2021 12:19:51 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Add devicetree binding for the NXP FXLS8962AF/FXLS8964AF
> accelerometer sensor.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Trivial comment inline, but otherwise looks good to me.

Thanks,

Jonathan

> ---
> Changes for v2:
>  - removed requirement for interrupt
> 
>  .../bindings/iio/accel/nxp,fxls8962af.yaml    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> new file mode 100644
> index 000000000000..d8ac25402979
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/nxp,fxls8962af.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP FXLS8962AF/FXLS8964AF Accelerometer driver
> +
> +maintainers:
> +  - Sean Nyekjaer <sean@geanix.com>
> +
> +description: |
> +  NXP FXLS8962AF/FXLS8964AF Accelerometer driver that supports
> +  SPI and I2C interface.
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,fxls8962af
> +      - nxp,fxls8964af
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: phandle to the regulator that provides power to the accelerometer
> +
> +  spi-max-frequency: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a I2C device node */
> +        accelerometer@62 {
> +            compatible = "nxp,fxls8962af";
> +            reg = <0x62>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>

Fair sure we don't need the gpio.h header here though it does
no real harm.

> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a SPI device node */
> +        accelerometer@0 {
> +            compatible = "nxp,fxls8962af";
> +            reg = <0>;
> +            spi-max-frequency = <4000000>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };

