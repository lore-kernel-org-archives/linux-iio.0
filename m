Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF51C433ED
	for <linux-iio@archiver.kernel.org>; Sat, 24 Apr 2021 17:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A8461131
	for <linux-iio@archiver.kernel.org>; Sat, 24 Apr 2021 17:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhDXRWT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 24 Apr 2021 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhDXRWT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Apr 2021 13:22:19 -0400
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D85C061574
        for <linux-iio@vger.kernel.org>; Sat, 24 Apr 2021 10:21:40 -0700 (PDT)
Received: from [81.101.6.87] (port=48810 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1laLyN-00041p-9O; Sat, 24 Apr 2021 18:21:39 +0100
Date:   Sat, 24 Apr 2021 18:22:20 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:accel:stk8312: Add lowercase i2c device id
Message-ID: <20210424182208.768e7467@jic23-huawei>
In-Reply-To: <20210401144226.225928-1-jic23@kernel.org>
References: <20210401144226.225928-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Apr 2021 15:42:26 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These are never upper case.  Chances are that all users of this driver
> were using the ACPI binding but just in case keep the uppercase version
> but mark it deprecated.
> 
> Whilst here tidy up some spacing.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I'm not going to pester anyone about reviewing this given how trivial it is.

Hence applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it and prove it's not as trivial as I'm assuming ;(

Jonathan

> ---
>  drivers/iio/accel/stk8312.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index 157d8faefb9e..60aecfa9fd92 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -635,13 +635,15 @@ static SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend, stk8312_resume);
>  #endif
>  
>  static const struct i2c_device_id stk8312_i2c_id[] = {
> -	{"STK8312", 0},
> +	/* Deprecated in favour of lowercase form */
> +	{ "STK8312", 0 },
> +	{ "stk8312", 0 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
>  
>  static const struct acpi_device_id stk8312_acpi_id[] = {
> -	{"STK8312", 0},
> +	{ "STK8312", 0 },
>  	{}
>  };
>  

