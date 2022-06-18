Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26E3C43334
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jun 2022 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiFRPbK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jun 2022 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiFRPbJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 11:31:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58B410FE8;
        Sat, 18 Jun 2022 08:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41B72CE02BE;
        Sat, 18 Jun 2022 15:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36268C3411A;
        Sat, 18 Jun 2022 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655566265;
        bh=1/JqD0jrLT+kJuKDhRHBaxwfNIV3cVZwTcjFBPk6sRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DRq5DP/dXx2lZQB31tll4Avibx0zKqv+18F1YRmohciCwpMSmDstNj2rGgr9lMIpq
         5I67qkw05iQlp4a3C2eANCMYfKAUqCVNKRrSFNwTdRUTolPAmpSJvBRXnlhXPvxmRj
         2zh2q7lPoUpn1LUZLSNPDY3Yr9f6cOBxTRsWDm1NbtQ+gwOjYLpf+qUciUAj8gbjX+
         al4dQTuBNOiGZtnonm2uQu9mtuHwBbCwRIyOIjVRCinc6kscmPf0kbbSTYzxHdkSQp
         RYXT9EtqwMpi1yFK2Cisf5UPiWS81Dc/lEcxTjrNdoVsHujBbUF1bYqXyAg8QLT9uN
         85xg3ealaIvyw==
Date:   Sat, 18 Jun 2022 16:40:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Fix typo in comment
Message-ID: <20220618164023.51b3080f@jic23-huawei>
In-Reply-To: <20220616141522.2238-1-wangxiang@cdjrlc.com>
References: <20220616141522.2238-1-wangxiang@cdjrlc.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jun 2022 22:15:22 +0800
Xiang wangx <wangxiang@cdjrlc.com> wrote:

> Delete the redundant word 'in'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Applied, but with patch title changed to reflect the driver in question.

iio: gyro: bmg160: ...

> ---
>  drivers/iio/gyro/bmg160_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 81a6d09788bd..cedd9f02ea21 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -766,7 +766,7 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
>  		return 0;
>  	}
>  	/*
> -	 * We will expect the enable and disable to do operation in
> +	 * We will expect the enable and disable to do operation
>  	 * in reverse order. This will happen here anyway as our
>  	 * resume operation uses sync mode runtime pm calls, the
>  	 * suspend operation will be delayed by autosuspend delay

