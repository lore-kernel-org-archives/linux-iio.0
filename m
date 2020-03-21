Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB57C4332B
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 17:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252620767
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584811459;
	bh=3Pi4OVN8CJsJXWDZNHWftqE6deVqqyCDiF2VLw/BK9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s2kkrQ8JdqZFLanKTwhZnzvhfD3hGiTf3+YRq24gjRkkLb7fATzccND7lPAwHOk20
	 5d0Ejru3ncRGR2ppQMLYaChX3OPsNELi7+pgYNkYJSABOifWzcwreYL2MfIHPEbGxk
	 kcATKTBYFaPbNsAG4DGYhORcgVkskNRap0l0VzS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCURYS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgCURYS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 13:24:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AEEC20724;
        Sat, 21 Mar 2020 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584811458;
        bh=3Pi4OVN8CJsJXWDZNHWftqE6deVqqyCDiF2VLw/BK9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tbheHoyKU2q4YTD82KWjUebugmErIlDm+tNGj6NOrujCMsbyD8mS5iTPrJk2t9Hrz
         XI45WAiyK8zD1yZhHuqNdAxWsgIzcIlWChJvaLtkIp1k3DxIwh0xFJAtUqrZvFGKDO
         UKFyS8nXp5FNAQR+vZ1OFJZM8IHgY3GyXsQL0kvI=
Date:   Sat, 21 Mar 2020 17:24:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <Laszlo.Nagy@analog.com>, <Andrei.Grozav@analog.com>,
        <Michael.Hennerich@analog.com>, <Istvan.Csomortani@analog.com>,
        <Adrian.Costina@analog.com>, <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v11 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Message-ID: <20200321172413.2d70d14a@archlinux>
In-Reply-To: <20200321085315.11030-9-alexandru.ardelean@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
        <20200321085315.11030-9-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 10:53:15 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds the binding doc for the AD9467 ADC.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied thanks. 

Great to have the first of these high speed devices upstream :)

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/adi,ad9467.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> new file mode 100644
> index 000000000000..c4f57fa6aad1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad9467.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9467 High-Speed ADC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> +
> +description: |
> +  The AD9467 is a 16-bit, monolithic, IF sampling analog-to-digital
> +  converter (ADC).
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9467
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: adc-clk
> +
> +  powerdown-gpios:
> +    description:
> +      Pin that controls the powerdown mode of the device.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Reset pin for the device.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +          compatible = "adi,ad9467";
> +          reg = <0>;
> +          clocks = <&adc_clk>;
> +          clock-names = "adc-clk";
> +        };
> +    };
> +...

