Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296C8C4320A
	for <linux-iio@archiver.kernel.org>; Sun, 25 Jul 2021 09:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120DE60E09
	for <linux-iio@archiver.kernel.org>; Sun, 25 Jul 2021 09:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhGYIei convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 25 Jul 2021 04:34:38 -0400
Received: from aposti.net ([89.234.176.197]:41262 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhGYIeh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 04:34:37 -0400
Date:   Sun, 25 Jul 2021 10:14:57 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/5]  dt-bindings: iio/adc: add an INGENIC_ADC_AUX0
 entry
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <X0NSWQ.S00VIWHJBD1O1@crapouillou.net>
In-Reply-To: <20210724190449.221894-3-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
        <20210724190449.221894-3-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le sam., juil. 24 2021 at 21:04:46 +0200, Christophe Branchereau 
<cbranchereau@gmail.com> a écrit :
> The JZ4760(B) socs have 3 AUX inputs, add an entry to prepare 
> including the one named AUX in the sadc driver.
> Leaving the rest untouched as it's ABI.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h 
> b/include/dt-bindings/iio/adc/ingenic,adc.h
> index 4627a00e369e..a6ccc031635b 100644
> --- a/include/dt-bindings/iio/adc/ingenic,adc.h
> +++ b/include/dt-bindings/iio/adc/ingenic,adc.h
> @@ -13,5 +13,6 @@
>  #define INGENIC_ADC_TOUCH_YN	6
>  #define INGENIC_ADC_TOUCH_XD	7
>  #define INGENIC_ADC_TOUCH_YD	8
> +#define INGENIC_ADC_AUX0	9
> 
>  #endif
> --
> 2.30.2
> 


