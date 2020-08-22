Return-Path: <SRS0=leo/=CA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D85C433E1
	for <linux-iio@archiver.kernel.org>; Sat, 22 Aug 2020 10:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8320B2078A
	for <linux-iio@archiver.kernel.org>; Sat, 22 Aug 2020 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598093846;
	bh=BqxYd2pOokGPeK4LyapSM4x47jhdQWKuct76BNr8mIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KK+wDxzvtgpmXVw1G1jqZXrdQdIqsxRJR274ZhF8YZxh8CYu3C4WwZEl8h3ozsDIk
	 j1wM+Bo81oxAd+nxiWliw3XauMWRtydxAkobAY05nHClRpJnVU/OmUXQ+xBR6tAbBv
	 x/9hfy2j9VtI1yxicti03Zs9KSAeP079O07dnN3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgHVK5Y (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Aug 2020 06:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgHVK5C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Aug 2020 06:57:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13392067C;
        Sat, 22 Aug 2020 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598093821;
        bh=BqxYd2pOokGPeK4LyapSM4x47jhdQWKuct76BNr8mIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KCE5cT2m3bt54RR8mfuyBOBzCYm9tlrUYymZbKgaCgKyPLtp3qhH4mZZFff1Xp61x
         QhGBRFCkeZLTy4UX/i+UuuzVGrrNuHKgo+lDWgxu2PJitsVvrp2EwmmU/c7Jlli82s
         zN9hWOcmruSVKMoE9P/3uGRmEsa++M2UnqAykypk=
Date:   Sat, 22 Aug 2020 11:56:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        michal.simek@xilinx.com, git@xilinx.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anandash@xilinx.com
Subject: Re: [PATCH] iio: Fixed IIO_VAL_FRACTIONAL calcuation for negative
 values
Message-ID: <20200822115654.0d7f716f@archlinux>
In-Reply-To: <1597946984-25844-1-git-send-email-anand.ashok.dumbre@xilinx.com>
References: <1597946984-25844-1-git-send-email-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Aug 2020 11:09:44 -0700
Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

> This patch fixes IIO_VAL_FRACTIONAL calculation for negative
> values where the exponent is 0.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Hi,

I would thrown in an example for this description. 
Also useful to know if there is a existing driver that is broken
and hence we need to backport this.
If that is the case, please try to figure out an appropriate fixes
tag.

Comments inline + the email footer issue needs sorting out.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f72c2dc..cd43b17 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -554,6 +554,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  {
>         unsigned long long tmp;
>         int tmp0, tmp1;
> +       s64 tmp2;
>         bool scale_db = false;
> 
>         switch (type) {
> @@ -576,10 +577,13 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>                 else
>                         return snprintf(buf, len, "%d.%09u", vals[0], vals[1]);
>         case IIO_VAL_FRACTIONAL:
> -               tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> +               tmp2 = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>                 tmp1 = vals[1];
> -               tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
> -               return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +               tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
> +               if ((tmp2 < 0) && (tmp0 == 0))
> +                       return snprintf(buf, len, "-%d.%09u", tmp0, abs(tmp1));

Given tmp0 == 0, this might be clearer as
			  return snprintf(buf, len, "-0.%09u", abs(tmp1));

> +               else
> +                       return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>         case IIO_VAL_FRACTIONAL_LOG2:
>                 tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
>                 tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

As Andy said, this footer is a problem...  
