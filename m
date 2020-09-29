Return-Path: <SRS0=BQmo=DG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5B4C4727C
	for <linux-iio@archiver.kernel.org>; Tue, 29 Sep 2020 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C797620773
	for <linux-iio@archiver.kernel.org>; Tue, 29 Sep 2020 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601394506;
	bh=6SKwS3C1V5S09Uxcad3TrXPJvtELClUCeuRhFQpI8U4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tU61QKaa7IEiAkxjlPDuUD7zcwY3h8geZ+Beev4i4P6mYbr2uz2pCToiivTpieAAv
	 wzSsKSFjVoUVXFpchOAKDx4J9rspWy7TFMhvmrIsnScMZOyx+mgZohSzRCdwHSGaAX
	 iTPobqZieRPL2JfbRY9R/dWqvdd2R371ysUHBmuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgI2Ps0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 29 Sep 2020 11:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2PsZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 11:48:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C091206D9;
        Tue, 29 Sep 2020 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601394505;
        bh=6SKwS3C1V5S09Uxcad3TrXPJvtELClUCeuRhFQpI8U4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gguhhg/0Dzsf1E0GiaI0TKxmkTqjVcMLRg1Cs2898cjucdqEyAuGjnyN00CzyzI6k
         8vLLDHz1Ca+t+ySzc+akeZ6lUTbGx+KChbu57BEw6OHVAT5uN1IMDEJMnH+Y3M7aov
         8bvo8KPmcBRz33dR+wHFjNr8GM/lMbHpCokGMNU8=
Date:   Tue, 29 Sep 2020 16:48:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 4/5] dt-bindings:iio:adc:adi,ad7768-1: Add
 documentation for channel label
Message-ID: <20200929164821.49f83061@archlinux>
In-Reply-To: <20200928090959.88842-4-cristian.pop@analog.com>
References: <20200928090959.88842-1-cristian.pop@analog.com>
        <20200928090959.88842-4-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 12:09:58 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> Optional attribute for better identification of the channels.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
Dt-bindings should be cc'd to Rob + the dt list.
+CC

> ---
> Changes in v7:
>  - Add "additionalProperties: false" for channel child nodes.
>  - Fix "reg" spelling.
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index d3733ad8785a..6be43bf5c1e0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -29,6 +29,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>    vref-supply:
>      description:
>        ADC reference voltage supply
> @@ -61,6 +67,24 @@ required:
>    - spi-cpha
>    - adi,sync-in-gpios
>  
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the device.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number.
> +
> +      label:
> +        description: |
> +          Unique name to identify which channel this is.
> +    required:
> +      - reg
> +    additionalProperties: false
> +
>  additionalProperties: false
>  
>  examples:
> @@ -84,6 +108,14 @@ examples:
>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
>              clocks = <&ad7768_mclk>;
>              clock-names = "mclk";
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                label = "channel_0";
> +            };
>          };
>      };
>  ...

