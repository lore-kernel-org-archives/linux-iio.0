Return-Path: <SRS0=S/K8=DC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A054C4363D
	for <linux-iio@archiver.kernel.org>; Fri, 25 Sep 2020 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D58C21D7A
	for <linux-iio@archiver.kernel.org>; Fri, 25 Sep 2020 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601037611;
	bh=DTK6nSsH3y7Fe2xkbY4deWEsnqY2Ru+AcN7lWq/R388=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gawmgRptx7vWS7lR4Uij7HxeLEpjO5GckY983hPgxYiaJWobE7UxEHlCm+20BSBG0
	 7WErfxdJ3OYgPLp1AXBXNhl0CsIl7PI1PQDqMWWubuHOyaANqQzILbijNjjQYg4WPo
	 uPqEWkUZPBG4n2gzEQR4YC0jbL/F9SCECjgt4d4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgIYMkK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYMkK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:40:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07DBA20BED;
        Fri, 25 Sep 2020 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601037610;
        bh=DTK6nSsH3y7Fe2xkbY4deWEsnqY2Ru+AcN7lWq/R388=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GykenvZtLLZjgYflxIezKKhQvSAZS0QUDdcxrH0zdmmykNCSL5G3SpDtnpwz1h1KU
         kXHfVTeQH9ODCfJToCDVqRYvvV0BOt52nZ7qwtbbqkvRvrvakW5Zw1WwviE38stoFy
         1EoTvYBt+rRIl4zrLMxbALFR7NhIourou2yYEQ6g=
Date:   Fri, 25 Sep 2020 13:40:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: dac: ad5686: add binding
Message-ID: <20200925134005.288b1b1d@archlinux>
In-Reply-To: <20200924195215.49443-3-michael.auchter@ni.com>
References: <20200924195215.49443-1-michael.auchter@ni.com>
        <20200924195215.49443-3-michael.auchter@ni.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 14:52:14 -0500
Michael Auchter <michael.auchter@ni.com> wrote:

> Add a binding for AD5686
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
Hi Michael,

Looks good to me, but I've made many a mistake on reviewing these in the past
so good to get Rob's input if he has time.

Thanks,

Jonathan
 
> ---
> Changes since v1:
> - Keep supported device sorted
> - fix adc -> dac typo in schema path
> since v2:
> - drop address-cells and size-cells from binding doc
> - add "additionalProperties: false"
> - end with ...
> 
>  .../bindings/iio/dac/adi,ad5686.yaml          | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> new file mode 100644
> index 000000000000..8065228e5df8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5686 and similar multi-channel DACs
> +
> +maintainers:
> +  - Michael Auchter <michael.auchter@ni.com>
> +
> +description: |
> +  Binding for Analog Devices AD5686 and similar multi-channel DACs
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5311r
> +      - adi,ad5338r
> +      - adi,ad5671r
> +      - adi,ad5675r
> +      - adi,ad5691r
> +      - adi,ad5692r
> +      - adi,ad5693
> +      - adi,ad5693r
> +      - adi,ad5694
> +      - adi,ad5694r
> +      - adi,ad5695r
> +      - adi,ad5696
> +      - adi,ad5696r
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: |
> +      The regulator supply for DAC reference voltage.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ad5686: dac@0 {
> +        compatible = "adi,ad5686";
> +        reg = <0>;
> +        vcc-supply = <&dac_vref>;
> +      };
> +    };
> +...

