Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD92CC433E1
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D72F20829
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595087545;
	bh=ig+qNnytQc4w1Ina0WQwcxtbbNuRzlveqifsUneeQDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1uIGkiEULT8NYYQeODCZYIm1H1Vu2PXXKI/E/Fbhs5xzWM8+NyYWCzml+W7SqV54J
	 GD3goJxpoMeCZx4/ZyukloiFg8yQFUF5jyzDbzP/ScOa8awsL+wEHYqGAhubUfGPHp
	 w5rCDcH8nU2WM7kBmYW3nD6HI8aWvw136+Rn+HFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGRPwZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPwY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:52:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79C72076A;
        Sat, 18 Jul 2020 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087544;
        bh=ig+qNnytQc4w1Ina0WQwcxtbbNuRzlveqifsUneeQDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=otYoOccUuPJLWT/gIXQIoXlmVD8BJDcd5WrUYtF6n1uUOiC+Dmjbp31ySO/rWuOzz
         +UisCM8f9d7rjIMuyWj1CWyGc7pQ4EckOhDKZcq5ox8M0koUBLgXr+ZIZb6D5Vzi1s
         VLlD3u9lhpcmwk8HIbnLJYOOQQ5uw0LPqk6VFQkU=
Date:   Sat, 18 Jul 2020 16:52:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 17/30] iio: gyro: adxrs450: Change ordering of compiler
 attribute macro
Message-ID: <20200718165219.318398a1@archlinux>
In-Reply-To: <20200717165538.3275050-18-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-18-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:25 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc gets confused if the variable does not follow the
> type/attribute definitions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/gyro/adxrs450.c:79: warning: Function parameter or member '____cacheline_aligned' not described in 'adxrs450_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Holding this one for the conversation about whether we should be fixing
the code or the tool.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/adxrs450.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
> index b00c0eb442493..e00b97e30cf9d 100644
> --- a/drivers/iio/gyro/adxrs450.c
> +++ b/drivers/iio/gyro/adxrs450.c
> @@ -73,7 +73,7 @@ enum {
>  struct adxrs450_state {
>  	struct spi_device	*us;
>  	struct mutex		buf_lock;
> -	__be32			tx ____cacheline_aligned;
> +	__be32 ____cacheline_aligned tx;
>  	__be32			rx;
>  
>  };

