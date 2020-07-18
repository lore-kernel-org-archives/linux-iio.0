Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF17C433E0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAF12076A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595084495;
	bh=gxH/xToLjTC3LMvZ+tQz8IzUaNEmHWP2nLAYUtM600o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=haTSeP4cLWVoPxM/ZSlayJmkr3AM6wYpkRBt3T77ErdzynocwaCzexCr/Z6fatA5P
	 kYZCLDlaXC4fVDszTa2HFXbOnpJt6K43uFOJv1yfYiwXCeBQZ1oPSlr0YaCgb0i1/9
	 Wg3bV6p81WnvDG5dmJXtc9/cW/eEbALGq4LG4jZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGRPBf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRPBf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:01:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E51A2065D;
        Sat, 18 Jul 2020 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084494;
        bh=gxH/xToLjTC3LMvZ+tQz8IzUaNEmHWP2nLAYUtM600o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o4wGFm9mDJiWP9mqG0uy85JzZXWAY6k/ZVV4N89iev5okfpeCMX6S6bMTxum7mefj
         bNTFn7uKs5iIzY/Thh0UUc+Q/hj3S1uBa02z/zmcIcCD4Vmmzs2H+iYNuuH4FHG/NK
         aVUsVJPeCS9cZj5EG+ZVbVQjw+qa+aLtKBIDHcWg=
Date:   Sat, 18 Jul 2020 16:01:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 16/30] iio: adc: ad7887: Demote seemingly unintentional
 kerneldoc header
Message-ID: <20200718160130.71f12545@archlinux>
In-Reply-To: <20200716135928.1456727-17-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-17-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:14 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> This is the only use of function related kerneldoc in the sourcefile
> and no descriptions are provided.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/ad7887.c:119: warning: Function parameter or member 'irq' not described in 'ad7887_trigger_handler'
>  drivers/iio/adc/ad7887.c:119: warning: Function parameter or member 'p' not described in 'ad7887_trigger_handler'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7887.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index c6a3428e950a9..bbaa0a3daea3c 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -109,7 +109,7 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
>  	return spi_sync(st->spi, &st->msg[AD7887_CH0]);
>  }
>  
> -/**
> +/*
>   * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
>   *
>   * Currently there is no option in this driver to disable the saving of

