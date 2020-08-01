Return-Path: <SRS0=1Shn=BL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF7C433DF
	for <linux-iio@archiver.kernel.org>; Sat,  1 Aug 2020 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A4B207FB
	for <linux-iio@archiver.kernel.org>; Sat,  1 Aug 2020 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596294405;
	bh=BHg3chiPoxQ/27EGS+plLWHJ5NrAl3ON9q1ebHGA7/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X5hE+kp33+3rBNHYF0eK06tx3nYzgwVHXlHOjEOsCluSfnJ+q9Hb+Mw3+p/hoDv66
	 MYXpEiQ8Hkh9lY0EYKoBYMrhyShU/Y+fuMGDoCwK3esuvVwNPGhVsNaZzCg9NJS3IV
	 yKzUmgrMBIrWdSyT0n5CVH738ge/o/doaNKZKJxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgHAPGo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 Aug 2020 11:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHAPGo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 11:06:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 384C7207BC;
        Sat,  1 Aug 2020 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596294403;
        bh=BHg3chiPoxQ/27EGS+plLWHJ5NrAl3ON9q1ebHGA7/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vOkDUCZP4Gwlk14aphgZ9psj9O2YHgeS+SijCd5eM0JoBr2VfFMcSQ5IgMcvVVb9K
         1jVuzEc/svwW9+PYxJYRFb2Ls8wnjBhvrhUtWLyYpLj1xMhakOnNDcIiJoiGtcX4B+
         cX8YGHDNYqCNxMcguseVS5HD9vn3E9HxhXr386i0=
Date:   Sat, 1 Aug 2020 16:06:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310
 sensor
Message-ID: <20200801160639.1410944e@archlinux>
In-Reply-To: <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
References: <20200731164853.3020946-1-campello@chromium.org>
        <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 10:48:38 -0600
Daniel Campello <campello@chromium.org> wrote:

> Adds device tree bandings for sx9310 sensor.
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> [swboyd@chromium.org: Add both regulators and make them optional]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes in v3: None
> Changes in v2:
>  - Added #io-channel-cells as a required property
> 
>  .../iio/proximity/semtech,sx9310.yaml         | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> new file mode 100644
> index 00000000000000..5739074d3592fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech's SX9310 capacitive proximity sensor
> +
> +maintainers:
> +  - Daniel Campello <campello@chromium.org>
> +
> +description: |
> +  Semtech's SX9310/SX9311 capacitive proximity/button solution.
> +
> +  Specifications about the devices can be found at:
> +  https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
> +
> +properties:
> +  compatible:
> +    enum:
> +      - semtech,sx9310
> +      - semtech,sx9311
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The sole interrupt generated by the device used to announce the
> +      preceding reading request has finished and that data is
> +      available or that a close/far proximity event has happened.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Main power supply
> +
> +  svdd-supply:
> +    description: Host interface power supply
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#io-channel-cells"

Missed this in earlier review (only noticed when I saw whilst santity
checking earlier versions.

Fairly sure we should only need #io-channel-cells if we have
a consumer of a channel somewhere else in DT.  So it's not
required as far as I can see.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      proximity@28 {
> +        compatible = "semtech,sx9310";
> +        reg = <0x28>;
> +        interrupt-parent = <&pio>;
> +        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
> +        vdd-supply = <&pp3300_a>;
> +        svdd-supply = <&pp1800_prox>;
> +        #io-channel-cells = <1>;
> +      };
> +    };

