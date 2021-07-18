Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07460C636C8
	for <linux-iio@archiver.kernel.org>; Sun, 18 Jul 2021 15:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90E0611AE
	for <linux-iio@archiver.kernel.org>; Sun, 18 Jul 2021 15:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhGRPQu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 18 Jul 2021 11:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhGRPQu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 11:16:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398A6611AB;
        Sun, 18 Jul 2021 15:13:50 +0000 (UTC)
Date:   Sun, 18 Jul 2021 16:16:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio: accel: sca3000: Use sign_extend32() instead of
 opencoding sign extension.
Message-ID: <20210718161612.2b9ffb41@jic23-huawei>
In-Reply-To: <20210603164729.3584702-1-jic23@kernel.org>
References: <20210603164729.3584702-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Jun 2021 17:47:29 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Whilst nice to get rid of this non obvious code, this also clears a
> static checker warning:
> 
> drivers/iio/accel/sca3000.c:734 sca3000_read_raw()
> warn: no-op. '((*val) << 19) >> 19'
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If someone could give this a quick sanity check that would be great.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3000.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index cb753a43533c..0692ccb80293 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -731,8 +731,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>  				return ret;
>  			}
>  			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
> -			*val = ((*val) << (sizeof(*val) * 8 - 13)) >>
> -				(sizeof(*val) * 8 - 13);
> +			*val = sign_extend32(*val, 13);
>  		} else {
>  			/* get the temperature when available */
>  			ret = sca3000_read_data_short(st,

