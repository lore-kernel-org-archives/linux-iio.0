Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9300C433E0
	for <linux-iio@archiver.kernel.org>; Sun, 24 Jan 2021 14:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F74922DBF
	for <linux-iio@archiver.kernel.org>; Sun, 24 Jan 2021 14:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbhAXOZk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Jan 2021 09:25:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbhAXOZj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 09:25:39 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CE822DBF;
        Sun, 24 Jan 2021 14:24:57 +0000 (UTC)
Date:   Sun, 24 Jan 2021 14:24:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: st_sensors: fix typo in comment
Message-ID: <20210124142452.4739795b@archlinux>
In-Reply-To: <20210121153945.5499-1-a.fatoum@pengutronix.de>
References: <20210121153945.5499-1-a.fatoum@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 16:39:44 +0100
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> s/timetamping/timestamping/
> 
> Cc: trivial@kernel.org
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index eee30130ae23..802f9ae04cf4 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -57,7 +57,7 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
>  	s64 timestamp;
>  
>  	/*
> -	 * If we do timetamping here, do it before reading the values, because
> +	 * If we do timestamping here, do it before reading the values, because
>  	 * once we've read the values, new interrupts can occur (when using
>  	 * the hardware trigger) and the hw_timestamp may get updated.
>  	 * By storing it in a local variable first, we are safe.

