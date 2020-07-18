Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D9C433E1
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B084B20734
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595087342;
	bh=pEl8KODEFgHV8GmG/W/YsfjCB8esG6jeHPpKHcUUqrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=f8fRhWbRHkc1pKhmobhGPRZbDDbB1q5EnooIBEHP+Waxin566+dBYT0kEs0r9e6KM
	 RqMTOsbciiAiWQwx/kwGmpBhEaSP5nvlAXWHgVDcXWP72bgaXUMKQNOB2nFubVW5iw
	 DZBcGzfGGZQ/hsQGaAfeKwWPldpntp930r1jy6oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgGRPtC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgGRPtC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:49:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF5F2073A;
        Sat, 18 Jul 2020 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087341;
        bh=pEl8KODEFgHV8GmG/W/YsfjCB8esG6jeHPpKHcUUqrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GnBiHFDFcfVxNT51t8vmcmt4Ot1tREesgzEOKvj5LAcWaR0ZArOWiAwikfmtM4NhM
         sOc/J2XTeLRhI7znH9hiX8MtQfSuWjVwCWj7WeS1dvBMTVVwZtluoB+0wyRYmIYVbc
         QV5j9Yyyg6tEJx6WTwTxZ6L9sQtehsxdMLAawX94=
Date:   Sat, 18 Jul 2020 16:48:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 13/30] iio: adc: at91_adc: Fix 'bad line' warning
Message-ID: <20200718164856.78c2a155@archlinux>
In-Reply-To: <20200717165538.3275050-14-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-14-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:21 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> All lines should start with ' *'.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/at91_adc.c:160: warning: bad line:                         (Interruptions registers mostly)
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied

> ---
>  drivers/iio/adc/at91_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 0368b6dc6d60a..c5ea75cd88fa8 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -157,7 +157,7 @@
>   * struct at91_adc_reg_desc - Various informations relative to registers
>   * @channel_base:	Base offset for the channel data registers
>   * @drdy_mask:		Mask of the DRDY field in the relevant registers
> -			(Interruptions registers mostly)
> + *			(Interruptions registers mostly)
>   * @status_register:	Offset of the Interrupt Status Register
>   * @trigger_register:	Offset of the Trigger setup register
>   * @mr_prescal_mask:	Mask of the PRESCAL field in the adc MR register

