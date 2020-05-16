Return-Path: <SRS0=+dIK=66=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB18C433E0
	for <linux-iio@archiver.kernel.org>; Sat, 16 May 2020 17:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C916D206D4
	for <linux-iio@archiver.kernel.org>; Sat, 16 May 2020 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589649650;
	bh=aTUSYRNg1AIN3df6ElQSFIwBjTcgJ60HMWA94BnEMIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dr8n+8vS74rEreyYOhKRhgwgW5DebsZ5uP+w+fH3JB6llhNCs2/Y7iW/ydBu8Lsbq
	 LEtJ4OTtYLacBkd6noEceG3ukXje/6y6UsF/N3qEP1OyaJ2rq6+D5S3lf8dJ08AUDx
	 j94Y0LuGL+8WbtUIlVSZ6NC7UbfA+L+GTDxenq8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgEPRUu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 May 2020 13:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgEPRUu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 13:20:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD06207D4;
        Sat, 16 May 2020 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589649649;
        bh=aTUSYRNg1AIN3df6ElQSFIwBjTcgJ60HMWA94BnEMIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=slPnHaD4n6jUrADNzVFJyfZeQgAXJHcT2NZQmV9SyUP+6SJmZdWy3lUIKwsuFlXMe
         8pE+MnMxuBhUgxWjnjnrD7qgo+z4fZQwlvvADD69hmeHPEPue69NFQB1gap3n0EHEY
         0yfZgAhdfekHmT8/Mx+PIIF4bfxLa3eCmxO9TVlk=
Date:   Sat, 16 May 2020 18:20:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <ak@it-klinger.de>
Subject: Re: [PATCH v2 4/8] iio: stm32-dfsdm-adc: pass iio device as arg for
 the interrupt handler
Message-ID: <20200516182044.373adf4b@archlinux>
In-Reply-To: <20200514131710.84201-5-alexandru.ardelean@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
        <20200514131710.84201-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 16:17:06 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This changes the argument for the interrupt handler to be the IIO device
> instead of the state-struct.
> Since there will be some changes to how iio_priv_to_dev() is implemented,
> it could be that the helper becomes a bit slower, as it will be hidden away
> in the IIO core.
> 
> The iio_priv() call will still be fast enough, as it will return a void
> pointer from the public IIO device structure. So it's better to switch the
> order.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Whilst this one looks fine to me. I'd definitely like an Ack from
one of the stm people in case I'm missing something.

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 76a60d93fe23..28ef02887bd3 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1313,8 +1313,8 @@ static const struct iio_info stm32_dfsdm_info_adc = {
>  
>  static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
>  {
> -	struct stm32_dfsdm_adc *adc = arg;
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = arg;
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	unsigned int status, int_en;
>  
> @@ -1603,7 +1603,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  		return irq;
>  
>  	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
> -			       0, pdev->name, adc);
> +			       0, pdev->name, iio);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to request IRQ\n");
>  		return ret;

