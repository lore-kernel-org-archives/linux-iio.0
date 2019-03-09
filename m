Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1931EC43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE30420815
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155476;
	bh=8kwepMScvQGwU3XpzKtvJL/RVd9cK9y4E829vbPrxbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=c3mpaT4WWCHisRqpwbeJEkh8+Xl5Qwz0bA/VIxhnVuY4KFjREiNVzpOfgTmq8bOD6
	 mDH2gdoiWwW5Wtt/zwQ58IkQ6K/1JJbBOhpdN/Ldx4CSaZKOkXAWB1if7sVynBKMkt
	 zqHyTH/BUUOX0t3liAkA7ZOu0tysOgJuv1nGK34E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCISR4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:17:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfCISR4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Mar 2019 13:17:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 015E4206DF;
        Sat,  9 Mar 2019 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552155475;
        bh=8kwepMScvQGwU3XpzKtvJL/RVd9cK9y4E829vbPrxbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2Gv6xs3MhXs3QJ7jsElL7n/WZ81+T7RHrqsyiEV8Wnw8wJui0UE+CkszsZvYxuTL+
         qIfOHeuSwDyRTICj44hjtNOR72EzJFM1GQIWDKFCZ7Ixz8zF8IWRR+DIrAU5cGN24B
         leLgRGxK1Be3hh1S+RdGnTk+tqmoWRqW8VnfEOyI=
Date:   Sat, 9 Mar 2019 18:17:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads8688: Update the module author
 email address
Message-ID: <20190309181750.10c8922e@archlinux>
In-Reply-To: <20190305073627.6880-1-sean@geanix.com>
References: <20190305073627.6880-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Mar 2019 08:36:26 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> Update the module author to the current email address.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads8688.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 8b4568edd5cb..f9461070a74a 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -523,6 +523,6 @@ static struct spi_driver ads8688_driver = {
>  };
>  module_spi_driver(ads8688_driver);
>  
> -MODULE_AUTHOR("Sean Nyekjaer <sean.nyekjaer@prevas.dk>");
> +MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.dk>");
>  MODULE_DESCRIPTION("Texas Instruments ADS8688 driver");
>  MODULE_LICENSE("GPL v2");

