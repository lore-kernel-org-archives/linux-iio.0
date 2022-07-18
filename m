Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C35DC43334
	for <linux-iio@archiver.kernel.org>; Mon, 18 Jul 2022 16:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiGRQew (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiGRQeq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 12:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777B2A960;
        Mon, 18 Jul 2022 09:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6445161461;
        Mon, 18 Jul 2022 16:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984D6C341CB;
        Mon, 18 Jul 2022 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658162084;
        bh=JpTUhopLLculR7MFkgoqIIIjOt4EnxA4CtvKPiKeBto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hs7smEnD/qRWdtrtfbqJivxCA7Yf3YFMfvFqbueuv6pOd9lXLpZukBY6rAxUz0e8/
         4CjjePqss9CXY58XLWfiJHrpT3/0OiKLeRyZKcNwXjKQNqAWk7SwLl6zD0gjZ+DVtp
         pOF5M/iu5i48S2h8MgpcCqvvV8ywFzwgaleDdB5AcgYlHeCUKasDwWKRYXDM2DbjOg
         fsLfiAdq5u/C41MFvGihvB3aHcQEo3aM3FYnPmrA6LBGPQsu7DfRSQ88PYyhdg6kRJ
         3veL9AI58qFb23ahLZ4fYPdRw5JMnZlKQQvYmonTTiQen5eqPjNscuOurbmQSRajqZ
         gdHdBisIMOP1g==
Date:   Mon, 18 Jul 2022 17:44:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Be consistent with allocation result tests.
Message-ID: <20220718174441.7967830c@jic23-huawei>
In-Reply-To: <20220718020348.32047-1-joetalbott@gmail.com>
References: <20220718020348.32047-1-joetalbott@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Jul 2022 22:03:48 -0400
Joe Simmons-Talbott <joetalbott@gmail.com> wrote:

> Make both allocation result tests use the same format
> 
>     if (!ptr)
> 
> Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
If you post two patches to the list that will cause each other to not
apply, please base one on top of the other and say so in the
patch description.

Anyhow, fixed up and applied by hand.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index f504ed351b3e..e22c47f20b4d 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -369,7 +369,7 @@ struct iio_poll_func
>  	struct iio_poll_func *pf;
>  
>  	pf = kmalloc(sizeof *pf, GFP_KERNEL);
> -	if (pf == NULL)
> +	if (!pf)
>  		return NULL;
>  	va_start(vargs, fmt);
>  	pf->name = kvasprintf(GFP_KERNEL, fmt, vargs);

