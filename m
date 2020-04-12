Return-Path: <SRS0=GqNd=54=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F23DC2BA2B
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 10:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F720709
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586686421;
	bh=Km3t+lTTTiSV9AJxSvLGxQM3QWc8v3EtPhvy9GxYp78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rH4ZvEOWiloLQTUNFfQ2ktftjBvjTpfQbSs5Qw+bnLrSrKUGHy843c1KFgANCu7Su
	 N/2MyPTOAsp8qxE+NIEd6yxdEgDm2O54pRGZwtqQi//c+tfTldB/R9iAXRE5jFG4Ry
	 Imgjd7atFrFCkse1y62BKhC8rB5SGYoimXRaT3UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDLKNj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Apr 2020 06:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDLKNj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 06:13:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C37206DA;
        Sun, 12 Apr 2020 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586686419;
        bh=Km3t+lTTTiSV9AJxSvLGxQM3QWc8v3EtPhvy9GxYp78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qzml9lHLuO8FdM9NYT7jYkBqWHM6OLkPUa8ELk6Sf1wwaRdUqyubGjC7KWZSte/46
         Ffjlrk8ffBoBUlVAjOIN5rrAfmDym//KFhTZIaemZ0nVggKQJMq8h8ZqpSXj4Me+oh
         AtPgDLjtkkuEM4tJ7/lOsxzLGYeq2UgD3HsuUkJs=
Date:   Sun, 12 Apr 2020 11:13:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aishwarya R <aishwaryarj100@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
Message-ID: <20200412111334.46fccd20@archlinux>
In-Reply-To: <20200409151125.32677-1-aishwaryarj100@gmail.com>
References: <20200409151125.32677-1-aishwaryarj100@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  9 Apr 2020 20:41:23 +0530
Aishwarya R <aishwaryarj100@gmail.com> wrote:

> Use the helper function that wraps the calls to
> platform_get_resource() and devm_ioremap_resource()
> together.
> 
> Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
Hi Aishwarya R,

Thanks for the patch.  Good to add a little more detail to the description
and note that I do prefer one patch per driver for IIO drivers.

One other thing.  Please use full name for the signed-off-by.
I see you use a longer form in your email later in the thread.
The DCO is a formal legal statement 
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
so we tend to be fussy!

Thanks,

Jonathan


> ---
>  drivers/iio/adc/at91_adc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index abe99856c823..0368b6dc6d60 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1152,7 +1152,6 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	int ret;
>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;
> -	struct resource *res;
>  	u32 reg;
>  
>  	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
> @@ -1182,9 +1181,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	if (st->irq < 0)
>  		return -ENODEV;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	st->reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(st->reg_base))
>  		return PTR_ERR(st->reg_base);
>  

