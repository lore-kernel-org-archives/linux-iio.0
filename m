Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD5C10F11
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 10:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288D520874
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 10:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555929804;
	bh=Ws2eMrEeL6EDLjYUiwzG39GBgKjKFN1PakCSnc3kJ60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U+qvz41AlRKphbHHq6qKgFuWn+Ql6MCrR+aS2oDmJTVslTYpEvNnoY3lr+5ssRrN+
	 j3E86M+iwZyQKV9NLJyxAnltuV4GgMDQg7yXVFnx4Q4C71nFZ3iuQMbD2rytLBV/4p
	 5w0AJu5Rw4pXd2d5cogkVOp+xsme7Qt/+QtqLark=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfDVKnX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfDVKnX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Apr 2019 06:43:23 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734F420811;
        Mon, 22 Apr 2019 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555929802;
        bh=Ws2eMrEeL6EDLjYUiwzG39GBgKjKFN1PakCSnc3kJ60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n4O+fUGChJy5Tqwcn7UhIVHswQQlKLfBBUmPaLaAMr5gQreMTBVNylrrg5sfbxVmT
         ZO8in+rbh39EU/YzTDBEYMSANmB9dDaNyf0CxpJ+vPO8KRAOAkXSH/Em8eYjqa/uGf
         13zU001vLbesStvgvyrcDUQD4fzYLvAS53nGiYfE=
Date:   Mon, 22 Apr 2019 11:43:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: accel: Switch hardcoded function name
 with a reference to __func__ making the code more maintainable
Message-ID: <20190422114317.3304426c@archlinux>
In-Reply-To: <1555663011-8401-1-git-send-email-mohankumar718@gmail.com>
References: <1555663011-8401-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Apr 2019 11:36:51 +0300
Mohan Kumar <mohankumar718@gmail.com> wrote:

> It fixes the following checkpatch.pl warning:
> 
> WARNING: Prefer using '"%s...", __func__' to using function's name, in a
> string
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
Patch is good, but please check other patches for the area
git log --oneline -- drivers/iio to get the standard formatting
for descriptions.  The patch title is also a bit to long.

I've edited that and applied the patch to the togreg branch
of iio.git and pushed out as testing for the autobuilders to
play with it.

Thanks

Jonathan

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 2 +-
>  drivers/iio/accel/kxcjk-1013.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index b4e2d9b..44d7c49 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -394,7 +394,7 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  
>  	if (ret < 0) {
>  		dev_err(dev,
> -			"Failed: bmc150_accel_set_power_state for %d\n", on);
> +			"Failed: %s for %d\n", __func__, on);
>  		if (on)
>  			pm_runtime_put_noidle(dev);
>  
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index a5c9d3d..cbcf3ee0 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -451,7 +451,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  	}
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
> -			"Failed: kxcjk1013_set_power_state for %d\n", on);
> +			"Failed: %s for %d\n", __func__, on);
>  		if (on)
>  			pm_runtime_put_noidle(&data->client->dev);
>  		return ret;

