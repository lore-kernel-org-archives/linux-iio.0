Return-Path: <SRS0=tzPa=5A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F01C10DCE
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 09:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B58206E9
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 09:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584263865;
	bh=M3gQDpipo5zEV/yucmJMkSori8mdYECFiTGbqY+cERQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wrHbmJ9cmx/Z+6M54+yvxhb06IbVCB5wCapNlnIlY/OYXGtm/PFIWIQP3JY7HTwje
	 dRw22Je3+ZbDIxN1sDqZK/vfreY1aAKlVCYmCgfWN1EY0KPxlNbhQf5Bo2UEJC58Rn
	 /UVVcbFz/P7p5LWOa9Mt8UX7o806xBAEgZE5dh4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgCOJRo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgCOJRo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 05:17:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5EB205ED;
        Sun, 15 Mar 2020 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584263863;
        bh=M3gQDpipo5zEV/yucmJMkSori8mdYECFiTGbqY+cERQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R0BstTd1ON4oodAY0pWQJkF40ciLG5q/ilX/Zux1zXD/wd3U+dYsUVpMe63JZNSe5
         aU6mgOLtT8+uTm8Mb3ajal7L7cvnlFSUD9VGWZtHsh9dvl9W+ZgJFJkXZLND69pGUF
         1Vtb3i6ocCZ+s56crTxbO5Rnn00XqG6ycbJ/RDh8=
Date:   Sun, 15 Mar 2020 09:17:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <stefan.popa@analog.com>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio:ad7797: Use correct attribute_group
Message-ID: <20200315091738.71f9dddf@archlinux>
In-Reply-To: <20200310141654.7188-1-yuehaibing@huawei.com>
References: <9c53e05a-294a-c2d1-8808-605b10c964a9@metafoo.de>
        <20200310141654.7188-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Mar 2020 22:16:54 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> It should use ad7797_attribute_group in ad7797_info,
> according to commit ("iio:ad7793: Add support for the ad7796 and ad7797").
> 
> Scale is fixed for the ad7796 and not programmable, hence
> should not have the scale_available attribute.
> 
> Fixes: fd1a8b912841 ("iio:ad7793: Add support for the ad7796 and ad7797")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks,

I've queued this up.  Won't push out just yet as I'm waiting for
Greg to pick up a pull request after which I'd like to fast forward
the fixes branch.

Thanks,

Jonathan

> ---
> v2: renew log as Lars-Peter's comment
> 
>  drivers/iio/adc/ad7793.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index b747db9..e5691e3 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -542,7 +542,7 @@ static const struct iio_info ad7797_info = {
>  	.read_raw = &ad7793_read_raw,
>  	.write_raw = &ad7793_write_raw,
>  	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
> -	.attrs = &ad7793_attribute_group,
> +	.attrs = &ad7797_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
>  };
>  

