Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAC6C433E3
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBDC2080D
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595087389;
	bh=W96QVLmUrwdDzuZ+3SqRNc7HL9yRRN8t8XTKde8uQLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QcsqzIEzVVSzTVbb2hNUg7hksOyg13OTCCNW2ki94qT17HWVQuHf3ahUBzNGtgZIs
	 Dl3W6YDZC6vR3yd/oGqv10PKhOKkPJffW9xz2yj5roau2uvCZ5yJRoDdx++Ei5igT+
	 XloNJxldEFLGLmq3ZORdLBbiq5MBzgqeHYeV5l8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGRPtt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRPts (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:49:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4532073A;
        Sat, 18 Jul 2020 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087388;
        bh=W96QVLmUrwdDzuZ+3SqRNc7HL9yRRN8t8XTKde8uQLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uohpt1uhFsW+fNn3Q8Uh/yzAqAIKTcQEXePbclsTTX6HTur/MlP1kBu9fgQ6tM0FB
         15zMrT77AO3j6iaVSVkyLc6zoFyfFadHZgS2et0Q2j8nHDOEwHf8zsjD7F46EfGbVq
         mkaE0heUfzrczJjoi1VvszAH6TqWDV0i0zZbBgJ4=
Date:   Sat, 18 Jul 2020 16:49:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 14/30] iio: adc: at91-sama5d2_adc: Struct kerneldoc
 titles need to start with 'struct '
Message-ID: <20200718164943.79305dff@archlinux>
In-Reply-To: <20200717165538.3275050-15-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-15-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:22 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/at91-sama5d2_adc.c:360: warning: cannot understand function prototype: 'struct at91_adc_dma '
>  drivers/iio/adc/at91-sama5d2_adc.c:379: warning: cannot understand function prototype: 'struct at91_adc_touch '
> 
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 9abbbdcc74200..c7fe749419b28 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -347,7 +347,7 @@ struct at91_adc_trigger {
>  };
>  
>  /**
> - * at91_adc_dma - at91-sama5d2 dma information struct
> + * struct at91_adc_dma - at91-sama5d2 dma information struct
>   * @dma_chan:		the dma channel acquired
>   * @rx_buf:		dma coherent allocated area
>   * @rx_dma_buf:		dma handler for the buffer
> @@ -369,7 +369,7 @@ struct at91_adc_dma {
>  };
>  
>  /**
> - * at91_adc_touch - at91-sama5d2 touchscreen information struct
> + * struct at91_adc_touch - at91-sama5d2 touchscreen information struct
>   * @sample_period_val:		the value for periodic trigger interval
>   * @touching:			is the pen touching the screen or not
>   * @x_pos:			temporary placeholder for pressure computation

