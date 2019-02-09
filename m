Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609E8C282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC321919
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549725864;
	bh=koHmtyp66+mPOIjR2AK1VEr0bO04/1Jp2hFr3aWPWds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wRbUf4DwoP41iXCy8b5aOn4nL7dqZJwS6TSbsAC+FSMh9X4YX1gid8LOwOVkkm+tp
	 SpDSRGBFrXdqrcZC1PTjHdjU8Hrl/oI6s84VunDG3Otm4YCOs0dLWwCEH2fnNluGyB
	 DCkNOZZfCpaL2p11p5+LVfSIhC555DY4MqYZ2QG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfBIPYX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:24:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfBIPYX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 10:24:23 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5ADF218D2;
        Sat,  9 Feb 2019 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549725862;
        bh=koHmtyp66+mPOIjR2AK1VEr0bO04/1Jp2hFr3aWPWds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0kDyzLpfegruWUhDcGTleMnHmYUH+W+gtt4yzFNf3XCkQFw3LAG813oQRvS3Jgf3b
         5gIegb3+XQhYVXd3ljONZwiJvtBTNbwfKuBMGkiUfb/nIgNSfXvRzeKiKsbO7o5mgN
         OIHWCScw25Km1YhvNrClvaP9e87Nu7egnuKvoi7g=
Date:   Sat, 9 Feb 2019 15:24:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio:bmi160: use iio_pollfunc_store_time
Message-ID: <20190209152416.535cb74b@archlinux>
In-Reply-To: <20190202215601.20275-6-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
        <20190202215601.20275-6-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  2 Feb 2019 13:56:00 -0800
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
> Do this by using iio_pollfunc_store_time as other drivers do.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
There is one small quirk here I'd forgotten about, but seems unlikely to
cause too many problems.  There are triggers that only call
iio_trigger_poll_chained (which is badly named) and as a result
only end up calling the thread part.  That would result in no
timestamp.

It's a hole we really ought to figure out a reliable fix for that
effects lots of drivers.

Anyhow, I doubt anyone is using this device with that set of triggers
so should be fine whilst we think about a more general solution.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 007f7c532ac4..f3c5b86a281e 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -425,8 +425,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  		buf[j++] = sample;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	return IRQ_HANDLED;
> @@ -834,7 +833,8 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bmi160_info;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
>  					      bmi160_trigger_handler, NULL);
>  	if (ret < 0)
>  		return ret;

