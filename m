Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C1C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 17:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B732148D
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 17:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCXRvu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:51:50 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39238 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXRvu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2019 13:51:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 987769E7723;
        Sun, 24 Mar 2019 17:51:48 +0000 (GMT)
Date:   Sun, 24 Mar 2019 17:51:46 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH] iio: ad_sigma_delta: select channel when reading
 register
Message-ID: <20190324175146.0fd060d8@archlinux>
In-Reply-To: <20190319104700.28357-1-alexandru.ardelean@analog.com>
References: <20190319104700.28357-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Mar 2019 12:47:00 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> The desired channel has to be selected in order to correctly fill the
> buffer with the corresponding data.
> The `ad_sd_write_reg()` already does this, but for the
> `ad_sd_read_reg_raw()` this was omitted.
> 
> Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index ff5f2da2e1b1..54d9978b2740 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -121,6 +121,7 @@ static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
>  	if (sigma_delta->info->has_registers) {
>  		data[0] = reg << sigma_delta->info->addr_shift;
>  		data[0] |= sigma_delta->info->read_mask;
> +		data[0] |= sigma_delta->comm;
>  		spi_message_add_tail(&t[0], &m);
>  	}
>  	spi_message_add_tail(&t[1], &m);

