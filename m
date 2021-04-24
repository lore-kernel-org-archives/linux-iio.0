Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26219C433ED
	for <linux-iio@archiver.kernel.org>; Sat, 24 Apr 2021 10:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F200361466
	for <linux-iio@archiver.kernel.org>; Sat, 24 Apr 2021 10:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhDXK7S (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 24 Apr 2021 06:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhDXK7P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 06:59:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83E8614A7;
        Sat, 24 Apr 2021 10:58:28 +0000 (UTC)
Date:   Sat, 24 Apr 2021 11:59:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2 1/9] iio: adis_buffer: do not return ints in irq
 handlers
Message-ID: <20210424115909.00295234@jic23-huawei>
In-Reply-To: <20210422101911.135630-2-nuno.sa@analog.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
        <20210422101911.135630-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Apr 2021 12:19:03 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> On an IRQ handler we should not return normal error codes as 'irqreturn_t'
> is expected.
> 
> Fixes: ccd2b52f4ac69 ("staging:iio: Add common ADIS library")
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

This is an interesting one in the sense it's fixing a bug that can't actually
happen (hence why you can just drop the check ;)  As such I've applied it to
the togreg branch of iio.git and added a note that it doesn't need to
go into stable.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis_buffer.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index ac354321f63a..175af154e443 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -129,9 +129,6 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>  	struct adis *adis = iio_device_get_drvdata(indio_dev);
>  	int ret;
>  
> -	if (!adis->buffer)
> -		return -ENOMEM;
> -
>  	if (adis->data->has_paging) {
>  		mutex_lock(&adis->state_lock);
>  		if (adis->current_page != 0) {

