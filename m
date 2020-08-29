Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FCBC433E6
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBA720CC7
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598719732;
	bh=oStdbXzIEINY68GBdcZq2e4qRczvBTpiM+H0TZy4H8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Hzb7LGVByXoSfKHvWUKn3x65hZoDYO8mDuJ4RxMAL7//r59sXcUvSPp8U8qeiaT9h
	 9HjFxSjQnNQp+viDHUrc6ispqV8JkSpajZBRJLW5bcDzCDrlHRQfRFBL/S43uvGVUb
	 xNpFpvTZjXLgaPDwgD0hs9FT1vnW+oAEemW4rfLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgH2Qsu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgH2Qsu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 12:48:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8780320791;
        Sat, 29 Aug 2020 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598719729;
        bh=oStdbXzIEINY68GBdcZq2e4qRczvBTpiM+H0TZy4H8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N8eo6hWlyndWhlkSpFhr0xRXj51Z2n9sFYXzJcHGk4l+XYV99lQ4no85bQi1Hmbsh
         gmJQCENTlbFXO+iyt3On6VWPak1wUXI6+jrSGg3/gJnMUVtrguOL77Sik8mgm8LrFE
         NRbrYkTjeJb0cDP/bIQgci8BdRtV6av8VRAOC1xI=
Date:   Sat, 29 Aug 2020 17:48:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     robh+dt@kernel.org, dragos.bogdan@analog.com,
        darius.berghe@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: gyro: adxrs290: Add required
 interrupts property
Message-ID: <20200829174845.7fae971d@archlinux>
In-Reply-To: <20200825124711.11455-3-nish.malpani25@gmail.com>
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
        <20200825124711.11455-3-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Aug 2020 18:17:10 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Append 'interrupts' as a required property and provide a suitable example
> for using a GPIO interrupt line.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Hi Nishant,

I don't understand why the interrupt is 'required'.  Also note you should
never be adding required properties to an existing binding.  It's possible
someone already used the binding as it stands and shipped a board with
it burnt in a firmware. (bit unlikely but you never know!)

Jonathan

> ---
>  .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml   | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> index 61adb2c2454b..cae593dd1ba7 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> @@ -28,17 +28,23 @@ properties:
>  
>    spi-cpha: true
>  
> +  interrupts:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>    - spi-max-frequency
>    - spi-cpol
>    - spi-cpha
> +  - interrupts

Why?  Device works fine without one being supplied. 
It's not uncommon on embedded boards to not wire up interrupts
due to a lack of pins and just rely on polling.

>  
>  additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      spi {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -48,6 +54,8 @@ examples:
>                     spi-max-frequency = <5000000>;
>                     spi-cpol;
>                     spi-cpha;
> +                   interrupt-parent = <&gpio>;
> +                   interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>          };
>      };
>  ...

