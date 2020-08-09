Return-Path: <SRS0=CopR=BT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E11C433DF
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 17:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7172206CD
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596993653;
	bh=veYGBwzTZ9nHbNRA0MUoq8udSz5Nx1PGeSnuEMsHeak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uHkFJs8AN6eh7wIXfK4+mwoxf52GqKXPGbNIIPsqaQhhrjReu4ZdnvDaT3Nki5Me6
	 fEpK7ICkpALFXXGvxjJeiPOxHIvCFA4n3x8cekLJnajn69MFsDGv26eJDlnq52D7c3
	 qg7/2oodRODtfxRmJmINr4HliECNGM5/OEi2Ig+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgHIRUx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIRUx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:20:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E98B206C3;
        Sun,  9 Aug 2020 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596993652;
        bh=veYGBwzTZ9nHbNRA0MUoq8udSz5Nx1PGeSnuEMsHeak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=09N4BEankR9R7beHoBRbNATYBiqF49YRG6wb5OEDA5N3IIZcWtl5MMeLxXF3QOgVz
         nJnj5EMFPOIa4G/MTv3k7Q0clDUv779pE7fuTnaf450Eq0iSstWVKvE3fTWpwa7iFl
         IcbkIxsUJaeAh5pPPjaeLSj4YlXzIa+DiyIV1D/Y=
Date:   Sun, 9 Aug 2020 18:20:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: Re: [PATCH v3 06/27] iio:proximity:mb1232: Fix timestamp alignment
 and prevent data leak.
Message-ID: <20200809182048.58213fe8@archlinux>
In-Reply-To: <20200722155103.979802-7-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-7-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:42 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 16 byte s16 array on the stack   As Lars also noted
> this anti pattern can involve a leak of data to userspace and that
> indeed can happen here.  We close both issues by moving to
> a suitable structure in the iio_priv() data with alignment
> ensured by use of an explicit c structure.  This data is allocated
> with kzalloc so no data can leak appart from previous readings.
> 
> In this case the forced alignment of the ts is necessary to ensure
> correct padding on x86_32 where the s64 would only be 4 byte aligned.
> 
> Fixes: 16b05261537e ("mb1232.c: add distance iio sensor with i2c")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Andreas Klinger <ak@it-klinger.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/mb1232.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> index 654564c45248..ad4b1fb2607a 100644
> --- a/drivers/iio/proximity/mb1232.c
> +++ b/drivers/iio/proximity/mb1232.c
> @@ -40,6 +40,11 @@ struct mb1232_data {
>  	 */
>  	struct completion	ranging;
>  	int			irqnr;
> +	/* Ensure correct alignment of data to push to IIO buffer */
> +	struct {
> +		s16 distance;
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  static irqreturn_t mb1232_handle_irq(int irq, void *dev_id)
> @@ -113,17 +118,13 @@ static irqreturn_t mb1232_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct mb1232_data *data = iio_priv(indio_dev);
> -	/*
> -	 * triggered buffer
> -	 * 16-bit channel + 48-bit padding + 64-bit timestamp
> -	 */
> -	s16 buffer[8] = { 0 };
>  
> -	buffer[0] = mb1232_read_distance(data);
> -	if (buffer[0] < 0)
> +	data->scan.distance = mb1232_read_distance(data);
> +	if (data->scan.distance < 0)
>  		goto err;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +					   pf->timestamp);
>  
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);

