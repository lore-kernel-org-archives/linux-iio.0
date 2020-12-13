Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F37CC4361B
	for <linux-iio@archiver.kernel.org>; Sun, 13 Dec 2020 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22ACE23123
	for <linux-iio@archiver.kernel.org>; Sun, 13 Dec 2020 14:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392046AbgLMOv4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Dec 2020 09:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389306AbgLMOv4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 09:51:56 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B120A23121;
        Sun, 13 Dec 2020 14:51:14 +0000 (UTC)
Date:   Sun, 13 Dec 2020 14:51:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20201213145111.42adf00f@archlinux>
In-Reply-To: <20201208131957.34381-1-cristian.pop@analog.com>
References: <20201208131957.34381-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Dec 2020 15:19:55 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> This adds device tree bindings for the AD5766 DAC.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  Changes in v3:
> 	- Fix errors
>  .../bindings/iio/dac/adi,ad5766.yaml          | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> new file mode 100644
> index 000000000000..25ec5bc0a6c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5766.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5766 DAC device driver
> +
> +maintainers:
> +  - Cristian Pop <cristian.pop@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD5766 current DAC device. Datasheet can be
> +  found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad5766-5767.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5766
> +      - adi,ad5767
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  spi-cpol: true
> +
> +  reset-gpios:
> +    description: GPIO spec for the RESET pin. If specified, it will be
> +      asserted during driver probe.
> +    maxItems: 1

Given we've recently been bitten by this in another driver I took a look at the datasheet.
This is an active low pin (not reset) so document it as such and set logic
as appropriate in the driver.

> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          
> +          ad5766@0 {
> +              compatible = "adi,ad5766";
> +              reg = <0>;
> +              spi-cpol;
> +              spi-max-frequency = <1000000>;
> +              reset-gpios = <&gpio 22 0>;
> +            };
> +      };

