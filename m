Return-Path: <SRS0=BQmo=DG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AECC4727C
	for <linux-iio@archiver.kernel.org>; Tue, 29 Sep 2020 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E4E20773
	for <linux-iio@archiver.kernel.org>; Tue, 29 Sep 2020 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601394916;
	bh=4c2Mck50Zj5krpxUPD1w5OVZoalSARiXRgZ617swfN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zSmb+eWT0UXinjGnNAt94uaGzrISOu/p++Xt42bt4VQtJ1fe8+hZyE+L2GGh5amtt
	 27/rfF7+NPBxD2Dri5CsxTXbsF1Dd+Umcs2KWA/L9XWyOtkpkU9X0V16oYHyJUedzv
	 Qj/ryvH8I1Jkh6bVFTD1pGF6/9p1yN/We/eNTXFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgI2PzP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 29 Sep 2020 11:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2PzP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 11:55:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4615C20739;
        Tue, 29 Sep 2020 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601394914;
        bh=4c2Mck50Zj5krpxUPD1w5OVZoalSARiXRgZ617swfN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ixMC0WYZ+l7Y9GX6J+s6soNUSKyUWbmrnTn8QrbzgM3voyyfMkihAalHIGLMtc4Hk
         5PHgIB0kbxo6Ivf7CDzxC9qF8KAjhLTzoKQj6cMLhsfsBSlylNc/We3mFoLfy0LQkn
         0r6a2yh5gK11aMm6kL4iPR3tiUEKvjKhes9je+go=
Date:   Tue, 29 Sep 2020 16:55:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 2/2] iio: adc: at91_adc: const-ify some driver data
Message-ID: <20200929165510.1e609883@archlinux>
In-Reply-To: <20200928125424.35921-2-alexandru.ardelean@analog.com>
References: <20200928125424.35921-1-alexandru.ardelean@analog.com>
        <20200928125424.35921-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 15:54:24 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The main intent is to get rid of the cast for the void-pointer returned by
> of_device_get_match_data().
> 
> This requires const-ifying the 'caps' and 'registers' references on the
> at91_adc_state struct.
> 
> The caps can be obtained also from the old platform_data (in the
> at91_adc_probe_pdata() function), but that cast is not touched in this
> patch, since the old platform_data should be removed/cleaned-away.
> Also, that cast deals with converting a kernel_ulong_t type to a pointer.
> So, updating that cast doesn't yield any benefit.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Good change. I'll pick this up when patch 1 is ready.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index c9ec0a4a357e..7d846a2852a5 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -202,7 +202,7 @@ struct at91_adc_state {
>  	struct mutex		lock;
>  	u8			num_channels;
>  	void __iomem		*reg_base;
> -	struct at91_adc_reg_desc *registers;
> +	const struct at91_adc_reg_desc *registers;
>  	u32			startup_time;
>  	u8			sample_hold_time;
>  	bool			sleep_mode;
> @@ -214,7 +214,7 @@ struct at91_adc_state {
>  	u32			res;		/* resolution used for convertions */
>  	bool			low_res;	/* the resolution corresponds to the lowest one */
>  	wait_queue_head_t	wq_data_avail;
> -	struct at91_adc_caps	*caps;
> +	const struct at91_adc_caps	*caps;
>  
>  	/*
>  	 * Following ADC channels are shared by touchscreen:
> @@ -550,7 +550,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *idev = iio_trigger_get_drvdata(trig);
>  	struct at91_adc_state *st = iio_priv(idev);
> -	struct at91_adc_reg_desc *reg = st->registers;
> +	const struct at91_adc_reg_desc *reg = st->registers;
>  	u32 status = at91_adc_readl(st, reg->trigger_register);
>  	int value;
>  	u8 bit;
> @@ -876,7 +876,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
>  	if (!node)
>  		return -EINVAL;
>  
> -	st->caps = (struct at91_adc_caps *)of_device_get_match_data(&pdev->dev);
> +	st->caps = of_device_get_match_data(&pdev->dev);
>  
>  	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
>  

