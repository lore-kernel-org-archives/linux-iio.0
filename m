Return-Path: <SRS0=X6NE=27=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0DC33CA3
	for <linux-iio@archiver.kernel.org>; Fri, 10 Jan 2020 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D107B2077C
	for <linux-iio@archiver.kernel.org>; Fri, 10 Jan 2020 14:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgAJOaL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:30:11 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:59329 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgAJOaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jan 2020 09:30:11 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5C95724001B;
        Fri, 10 Jan 2020 14:30:01 +0000 (UTC)
Date:   Fri, 10 Jan 2020 15:30:01 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, lee.jones@linaro.org, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 11/16] dt-bindings: atmel,at91rm9200-rtc: add
 microchip,sam9x60-rtc
Message-ID: <20200110143001.GE1027187@piout.net>
References: <1578488123-26127-1-git-send-email-claudiu.beznea@microchip.com>
 <1578488123-26127-12-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578488123-26127-12-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 08/01/2020 14:55:18+0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-rtc to DT bindings documentation.

This will have to be rebased on top of
https://lore.kernel.org/linux-rtc/20191229204421.337612-2-alexandre.belloni@bootlin.com/

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
> index 5d3791e789c6..35eab9138d0b 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
> @@ -1,7 +1,8 @@
>  Atmel AT91RM9200 Real Time Clock
>  
>  Required properties:
> -- compatible: should be: "atmel,at91rm9200-rtc" or "atmel,at91sam9x5-rtc"
> +- compatible: should be: "atmel,at91rm9200-rtc", "atmel,at91sam9x5-rtc" or
> +  "microchip,sam9x60-rtc"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: rtc alarm/event interrupt
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
