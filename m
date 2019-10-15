Return-Path: <SRS0=9pL2=YI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39852ECE58C
	for <linux-iio@archiver.kernel.org>; Tue, 15 Oct 2019 20:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0159220854
	for <linux-iio@archiver.kernel.org>; Tue, 15 Oct 2019 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571170342;
	bh=ISc+2X2k54eakg+ko+Wp0btFvZNCdnW6EQneCYE5tGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rNdEZTEWF8N3ryNDBHnuU6uBvdCDjfovcn0GG7xMzNMu0eQ9iJAOFhzz84VALJ6BD
	 YprFzzp4cg7wEyuKHAEO2BsOcJm6C7CMUSi5JC2/C933rOIgxAokLp9FmK4nSG+B8E
	 xJ/A5ZIGILsCb/mCyKjKHnhXVSpK4dR9inZfAxC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfJOUMV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfJOUMV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Oct 2019 16:12:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207C82083B;
        Tue, 15 Oct 2019 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571170340;
        bh=ISc+2X2k54eakg+ko+Wp0btFvZNCdnW6EQneCYE5tGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GKr/gioaPIJU8damTbt8j0mDsmnnjoxS+IAw9wMyK5oK+JbE8JCh4ZQo+nrIFcWcL
         W++VnMUPbTu4fyqQN+bTnTfujqHIxXVPcNwTzYBoYVTdthWo9mv0rIiaphihhnEqDM
         bm8eH0RbSxi5+bwrh1D7hqxECvY1E9KoUA4w7z54=
Date:   Tue, 15 Oct 2019 21:12:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] iio: light: adux1020: Drop an unwanted semicolon.
Message-ID: <20191015211215.1c78c8a5@archlinux>
In-Reply-To: <20191013173852.2265620-1-jic23@kernel.org>
References: <20191013173852.2265620-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Oct 2019 18:38:52 +0100
jic23@kernel.org wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Suggested by coccinelle
> 
> CHECK   drivers/iio/light/adux1020.c
> drivers/iio/light/adux1020.c:747:2-3: Unneeded semicolon
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
0-day sent me the same patch as well.

I've rolled it into the original code as that was still on 
testing only which was getting rebased anyway.

Thanks,

Jonathan

> ---
>  drivers/iio/light/adux1020.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index 830e5e95d58f..b07797ac10d7 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -744,7 +744,7 @@ static int adux1020_chip_init(struct adux1020_data *data)
>  	if ((val & ADUX1020_CHIP_ID_MASK) != ADUX1020_CHIP_ID) {
>  		dev_err(&client->dev, "invalid chip id 0x%04x\n", val);
>  		return -ENODEV;
> -	};
> +	}
>  
>  	dev_dbg(&client->dev, "Detected ADUX1020 with chip id: 0x%04x\n", val);
>  

