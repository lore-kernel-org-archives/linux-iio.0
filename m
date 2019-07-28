Return-Path: <SRS0=mPuB=VZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493DBC433FF
	for <linux-iio@archiver.kernel.org>; Sun, 28 Jul 2019 07:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187ED2085A
	for <linux-iio@archiver.kernel.org>; Sun, 28 Jul 2019 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564300754;
	bh=AA3U1UloStNCK9tMo1K1YVYBHZBNjIRjQUJIOjn+XAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=euZO6OZnQi9+nC9D0imjfQUK+99iOXxqboHl6ZGqKVCKn0Em1O/Dum+PvV+id/kAD
	 XOyJTJ/q1ul1C3Qe+Ag/bZJdMFPm/6Sl21k/8NWkEskAXQk2t1lgjwnYPWu9JvrC7Q
	 HC7SMbIJwNmSSc/yV/8HAKNmRefUVGtMd4l43egw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfG1H7N (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 28 Jul 2019 03:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfG1H7N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 03:59:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A07E12085A;
        Sun, 28 Jul 2019 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564300752;
        bh=AA3U1UloStNCK9tMo1K1YVYBHZBNjIRjQUJIOjn+XAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NG1MRLvR7sfssfCmEk7gXD0polSZYJjH5Xb/QWiYFlUiH0JVJl4/FzpXLQ0+0wNe/
         Vj/xfcHu2zzEjsOmuyAqCbvawJmjNxyMH2O9nV2YWmh/xL/75ivgLFGCOufG0HWHrj
         eZrd/fWb8qjAV0rT2GFsnOBye0E9pMMs8g2lc3TE=
Date:   Sun, 28 Jul 2019 08:57:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 3/5] iio: adc: ad7606: Allow reconfigration after reset
Message-ID: <20190728085758.3398d06b@archlinux>
In-Reply-To: <20190718062734.17306-3-beniamin.bia@analog.com>
References: <20190718062734.17306-1-beniamin.bia@analog.com>
        <20190718062734.17306-3-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 09:27:32 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> According to datasheet, ad7616 require at least 15ms after a restart
> to fully reconfigure and being able to receive new commands via spi.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Applied.

Thanks,

J

> ---
> Changes in v2:
> -nothing changed
> 
>  drivers/iio/adc/ad7606.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 9eec3db01a17..a6034cf7238a 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -594,6 +594,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
>  
> +	/* AD7616 requires al least 15ms to reconfigure after a reset */
> +	if (msleep_interruptible(15))
> +		return -ERESTARTSYS;
> +
>  	st->write_scale = ad7606_write_scale_hw;
>  	st->write_os = ad7606_write_os_hw;
>  

