Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51EFC433F5
	for <linux-iio@archiver.kernel.org>; Sun,  2 Oct 2022 12:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJBMr6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Oct 2022 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJBMr4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 08:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E733E26
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 05:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F4AA60EB4
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 12:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555A3C433D7;
        Sun,  2 Oct 2022 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664714873;
        bh=tNGsrXvxA2ude5tw4gu9SwBY7ETOpo3LKLm/HyndaBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cjmMp1NwZun+U59B9DrjO+TdZFm8GoFIa7VUZ1OhG40eHR40F14/cyMwshC0xR8L6
         7DkREltCWppTZ5q26D7NJ8k4se4oaecj6U3o7H2NcQNTJ1uVL143Qtkvuf2rZFXd17
         DCmhS3NUXGBgiJZhj+tLWw8huiQUp+h8DLXGhtDI/DecuFzWzL4OFHvF/5GQfjKg2B
         qlJ2ZXd/5CpVUbheyc+5xbSCb/MkbusGRpW8Gxd9SSQqDYOktYo4FUt9onHzEwsDu+
         sNV1VhcPWF+PElHLAfVNbhq9PYwGAE0FzK6mcTJLdCYVlTxjQdEjpBfxYaWSkrOepf
         N1dMmLZBcyfRg==
Date:   Sun, 2 Oct 2022 13:48:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, <peda@axentia.se>, <lars@metafoo.de>,
        <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH -next] iio: multiplexer: Switch to use dev_err_probe()
 helper
Message-ID: <20221002134810.02d1c9ed@jic23-huawei>
In-Reply-To: <20220927064841.319291-1-yangyingliang@huawei.com>
References: <20220927064841.319291-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Sep 2022 14:48:41 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Applied to the togreg branch of iio.git. Now 6.2 material so I won't push
that branch out until I can rebase on 6.1-rc1

Jonathan

> ---
>  drivers/iio/multiplexer/iio-mux.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 93558fddfa9b..edd8c69f6d2e 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -416,11 +416,9 @@ static int mux_probe(struct platform_device *pdev)
>  	}
>  
>  	mux->control = devm_mux_control_get(dev, NULL);
> -	if (IS_ERR(mux->control)) {
> -		if (PTR_ERR(mux->control) != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get control-mux\n");
> -		return PTR_ERR(mux->control);
> -	}
> +	if (IS_ERR(mux->control))
> +		return dev_err_probe(dev, PTR_ERR(mux->control),
> +				     "failed to get control-mux\n");
>  
>  	i = 0;
>  	for (state = 0; state < all_children; state++) {

