Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A12C433FE
	for <linux-iio@archiver.kernel.org>; Sun, 13 Dec 2020 12:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7262250E
	for <linux-iio@archiver.kernel.org>; Sun, 13 Dec 2020 12:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405720AbgLMMaF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Dec 2020 07:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405427AbgLMMaF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 07:30:05 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067A52250E;
        Sun, 13 Dec 2020 12:29:23 +0000 (UTC)
Date:   Sun, 13 Dec 2020 12:29:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <tduszyns@gmail.com>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] iio: chemical: pms7003: convert comma to
 semicolon
Message-ID: <20201213122918.121fd048@archlinux>
In-Reply-To: <20201211085700.3037-1-zhengyongjun3@huawei.com>
References: <20201211085700.3037-1-zhengyongjun3@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Dec 2020 16:57:00 +0800
Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Applied to the togreg branch of iio.git and pushed out as testing because
of other things in that tree.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/pms7003.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
> index e9d4405654bc..e9857d93b307 100644
> --- a/drivers/iio/chemical/pms7003.c
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -282,7 +282,7 @@ static int pms7003_probe(struct serdev_device *serdev)
>  	state->serdev = serdev;
>  	indio_dev->info = &pms7003_info;
>  	indio_dev->name = PMS7003_DRIVER_NAME;
> -	indio_dev->channels = pms7003_channels,
> +	indio_dev->channels = pms7003_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(pms7003_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->available_scan_masks = pms7003_scan_masks;

