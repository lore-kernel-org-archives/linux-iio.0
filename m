Return-Path: <SRS0=CopR=BT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BCCC433DF
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 17:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B79206CD
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596994606;
	bh=fqvCUxbPL0VuyK2/JldCW/ot+bbQbu5DhzCk451T4NY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P40+htggxS4Mz2PJ65jxlucRGHNzXyKGKRvxqZawooiXpTwhA/RX2FhGQql3TPNwb
	 CYRThhmGY1vidd6ZJJ3fqp1D8sxWInXmHPoeBpS0RJ4ks2fW8i3k4rQMoMzOfTc4mb
	 ZYAu41ryA5E9XRNM/3DSw4q9Y3R15EjB85azgxl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIRgq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIRgq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:36:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25CCD206C0;
        Sun,  9 Aug 2020 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596994605;
        bh=fqvCUxbPL0VuyK2/JldCW/ot+bbQbu5DhzCk451T4NY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QSnbAuNjZmkVhMqSSqpv/Td9WlYIWqeEYdhX4zMklm531AuPBNY1Oi5Q26OgXg2ZL
         zmQqsVqo23XwfnjMeAWOvMrJCkdjx+AdwNfsA1n19avZyBpOo79G1D6XiX4eIs6Vpo
         Qw4FAjIeidNURGl7Lc3OBKaoisNX9jSOoWHqxY2g=
Date:   Sun, 9 Aug 2020 18:36:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>
Subject: Re: [PATCH v3 21/27] iio:adc:ti-adc084s021 Fix alignment and data
 leak issues.
Message-ID: <20200809183641.44a22a39@archlinux>
In-Reply-To: <20200722155103.979802-22-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-22-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:57 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv().
>=20
> This data is allocated with kzalloc so no data can leak apart from
> previous readings.
>=20
> The force alignment of ts is not strictly necessary in this case
> but reduces the fragility of the code.
>=20
> Fixes: 3691e5a69449 ("iio: adc: add driver for the ti-adc084s021 chip")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: M=C3=A5rten Lindahl <martenli@axis.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied and marked for stable.

thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-adc084s021.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s=
021.c
> index 9017e1e24273..dfba34834a57 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -26,6 +26,11 @@ struct adc084s021 {
>  	struct spi_transfer spi_trans;
>  	struct regulator *reg;
>  	struct mutex lock;
> +	/* Buffer used to align data */
> +	struct {
> +		__be16 channels[4];
> +		s64 ts __aligned(8);
> +	} scan;
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache line.
> @@ -141,14 +146,13 @@ static irqreturn_t adc084s021_buffer_trigger_handle=
r(int irq, void *pollfunc)
>  	struct iio_poll_func *pf =3D pollfunc;
>  	struct iio_dev *indio_dev =3D pf->indio_dev;
>  	struct adc084s021 *adc =3D iio_priv(indio_dev);
> -	__be16 data[8] =3D {0}; /* 4 * 16-bit words of data + 8 bytes timestamp=
 */
> =20
>  	mutex_lock(&adc->lock);
> =20
> -	if (adc084s021_adc_conversion(adc, &data) < 0)
> +	if (adc084s021_adc_conversion(adc, adc->scan.channels) < 0)
>  		dev_err(&adc->spi->dev, "Failed to read data\n");
> =20
> -	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
>  					   iio_get_time_ns(indio_dev));
>  	mutex_unlock(&adc->lock);
>  	iio_trigger_notify_done(indio_dev->trig);

