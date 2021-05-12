Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF9C433ED
	for <linux-iio@archiver.kernel.org>; Wed, 12 May 2021 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571A861961
	for <linux-iio@archiver.kernel.org>; Wed, 12 May 2021 15:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhELPCx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 May 2021 11:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhELPAV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 11:00:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27576157F;
        Wed, 12 May 2021 14:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620831422;
        bh=hSJx+OD9FI8n0Hc9srVzxzujZM7Mb2AQa5TQ85I5l0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cMEAGsGDRlrrxYtdBHtXGoXVrFYjipJ79KHOdTdyQEBQg+xxiQ52z1kvR3Oc6s8lO
         CE6Buh7OIgejNbEnNx9o1Ph0pq5i+Ia8QmOMI/CBmahiA2UvN41XyQMjPEL3cStk02
         XUSp5OgIx0NTc6vn0mXUpU1ZC0pt+LG5HI+2sdUoC4qmb2nfOaUlngkmH3jT4mZ9d4
         EKt+TjURKzlerKEq7F+LiUZuAmjAXCVJruO+6LDS3Ptnvy8fOUZaYa2zPMQSV3Rjs7
         IGfA+vp6by20bN2Z3QceF4HvpOagRfc5ki1yzcSCw30K589daZNiZM4jYyjbrZZMBT
         HUPowQNwKFpIw==
Date:   Wed, 12 May 2021 16:56:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 26/28] iio: prox: pulsed-light-v2: Switch
 pm_runtime_resume_and_get()
Message-ID: <20210512165657.1dd3f6e2@coco.lan>
In-Reply-To: <20210509113354.660190-27-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-27-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:52 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using this new call makes it easy to handle any errors as a result
> of runtime resume as it exits without leaving the reference count
> elevated.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index c685f10b5ae4..ca8dc5cc209a 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -154,7 +154,9 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>  	int tries = 10;
>  	int ret;
>  
> -	pm_runtime_get_sync(&client->dev);
> +	ret = pm_runtime_resume_and_get(&client->dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* start sample */
>  	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);

There's a return just after this that it is missing a call to
pm_runtime_put_autosuspend():

	if (ret < 0) {
                dev_err(&client->dev, "cannot send start measurement command");
                return ret;
        }

Perhaps the best here would be to add a goto and a label before
the return logic.


Thanks,
Mauro
