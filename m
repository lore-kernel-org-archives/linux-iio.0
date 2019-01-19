Return-Path: <SRS0=JcFl=P3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61F5C61CE4
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 17:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C932087E
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547918971;
	bh=DwUtINT9UdnwZEL00Y4ZodmXXx/FBT6JSWd0skq1dGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rExc9bR9wYCfo3rmKLRHVIeyz2zfiM93mxEy6EXsgOzSeVliILv4zAA29vBccpXU8
	 gmE+9jdpOw6am07YNH5mGSOOOOXVbVAdtdALCbO+ko1pCvbhaKH8W4xAOjcXs239QU
	 uK9BhwJr45d4vbAxBfQ264rQUMmI2SsEjceOoeFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfASR3b (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbfASR3a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Jan 2019 12:29:30 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BE92086D;
        Sat, 19 Jan 2019 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547918970;
        bh=DwUtINT9UdnwZEL00Y4ZodmXXx/FBT6JSWd0skq1dGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qj9v76+IV4YkH1Tc+xWch7Gq9Rzpxg4m+fDZHhghwu/TqVEce1dHDaPxyZY+UyLhc
         KTvLBYhnD9MSHDuintZpgKEZWnTqjH7yGuJnUGfyJDCPHKkx1RS6m8cINmR7c7NKQh
         fbzgMlekxYcU5/JXCup/F591clIzYa16Rpa2F79w=
Date:   Sat, 19 Jan 2019 17:29:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 5/5] iio:bmi160:snap timestamp closer to event
Message-ID: <20190119172925.6dafec11@archlinux>
In-Reply-To: <20190114035621.5252-6-martin@martingkelly.com>
References: <20190114035621.5252-1-martin@martingkelly.com>
        <20190114035621.5252-6-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Jan 2019 19:56:21 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Currently, we snap the timestamp after reading from the buffer and
> processing the event. When the IIO poll function is triggered by an
> interrupt,  we can get a slightly more accurate timestamp by snapping it
> prior to reading the data, since the data was already generated prior to
> entering the trigger handler. This is not going to make a huge difference,
> but we might as well improve slightly.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
Could do better by using the standard iio_pollfunc_store_time
to grab the timestamp in the interrupt handler itself rather than in
it's thread.

There is some argument that we should only do that if we know it's
'our' trigger. If we are triggered by someone else, we might report
a time before when the sample we then read was actually captured.

Still most of the time people will use the devices own trigger, or
be running slowly enough they won't care.

Anyhow, if we are going to argue this makes any sense use the
iio_pollfunc_store_time approach please.

As you will probably guess, this isn't the first device with a
dataready interrupt!
 :)

Jonathan

> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index e119965e64a3..4b4456af0971 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -408,6 +408,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> +	s64 ts = iio_get_time_ns(indio_dev);
>  	struct bmi160_data *data = iio_priv(indio_dev);
>  	__le16 buf[16];
>  	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
> @@ -423,8 +424,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  		buf[j++] = sample;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, ts);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	return IRQ_HANDLED;

