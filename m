Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837DCC433F5
	for <linux-iio@archiver.kernel.org>; Sun,  5 Sep 2021 11:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BE060FE6
	for <linux-iio@archiver.kernel.org>; Sun,  5 Sep 2021 11:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhIELxM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Sep 2021 07:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhIELxL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:53:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A52D60FBF;
        Sun,  5 Sep 2021 11:52:04 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:55:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <alex.dewar90@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: iio: adc: Add the binding
 documentation for NXP IMX8QXP ADC
Message-ID: <20210905125527.1782ba86@jic23-huawei>
In-Reply-To: <20210830172140.414-5-caihuoqing@baidu.com>
References: <20210830172140.414-1-caihuoqing@baidu.com>
        <20210830172140.414-5-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 01:21:38 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add the binding
> documentation for NXP IMX8QXP ADC
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> new file mode 100644
> index 000000000000..542329e6a785
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/nxp,imx8qxp-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP IMX8QXP ADC bindings
> +
> +maintainers:
> +  - Cai Huoqing <caihuoqing@baidu.com>
> +
> +description:
> +  Supports the ADC found on the IMX8QXP SoC.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx8qxp-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: per
> +      - const: ipg
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clocks-rate:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  status:
> +    const: disable
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupts-parent
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-rates
> +  - power-domains
> +  - state
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +	 adc@5a880000 {
Clearly some indentation issues here.
> +            compatible = "nxp,imx8qxp-adc";
> +            reg = <0x0 0x5a880000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk IMX_SC_R_ADC_0>,
> +                     <&clk IMX_ADMA_LPCG_ADC_0_IPG_CLK>;
> +            clock-names = "per", "ipg";
> +            assigned-clocks = <&clk IMX_SC_R_ADC_0>;
> +            assigned-clock-rates = <24000000>;
> +            power-domains = <&pm, IMX_SC_R_ADC_0>;
> +            status = "disabled";

Don't mark the example disabled.

> +            #io-channel-cells = <1>
> +	 };
> +    };
> +...

