Return-Path: <SRS0=CopR=BT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20FDC433E0
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE052206CD
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596993556;
	bh=olWeJly2HPDWBriIy6/DVC8IOzx8aABeMJvXj+QWv6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Rdy6cx7l9c2YIGOHKYi9E20Jb93rXOCJEFl9NjPlG4jCL84V+/RepRZeg2/AMBZta
	 mOhQ4ZcF58Ibqam+04YdVozSGcilazyyIxvvsqAvptS3np3t309DVdQkx2koDi4PgB
	 aZK3Dhc6io2UF06PMIw+byseR2ac4pjSKEUtvaTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIRTQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIRTQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:19:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B77B206C3;
        Sun,  9 Aug 2020 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596993555;
        bh=olWeJly2HPDWBriIy6/DVC8IOzx8aABeMJvXj+QWv6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sj3a3UTNWpSNymRgkOfNa2fdu8cz+jF1VcPZPFygIU8VXXC9dEcHQNZ02ggFT1Brz
         Yh7UvQtKI4FdQjd11XPHXmN13yMzyPdxIcVBJc7j5dTA+DYajJ/AOVykzxEbKPODkt
         OxmSt2zY8HcwIqWsP0bfb+Rkb+ZWgFhnF5I+hmls=
Date:   Sun, 9 Aug 2020 18:19:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 04/27] iio:accel:mma7455: Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200809181912.59839046@archlinux>
In-Reply-To: <20200722155103.979802-5-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-5-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:40 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 16 byte u8 array on the stack   As Lars also noted
> this anti pattern can involve a leak of data to userspace and that
> indeed can happen here.  We close both issues by moving to
> a suitable structure in the iio_priv() data with alignment
> ensured by use of an explicit c structure.  This data is allocated
> with kzalloc so no data can leak appart from previous readings.
> 
> The force alignment of ts is not strictly necessary in this particularly
> case but does make the code less fragile.
> 
> Fixes: a84ef0d181d9 ("iio: accel: add Freescale MMA7455L/MMA7456L 3-axis accelerometer driver")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma7455_core.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
> index 7e99bcb3398d..922bd38ff6ea 100644
> --- a/drivers/iio/accel/mma7455_core.c
> +++ b/drivers/iio/accel/mma7455_core.c
> @@ -52,6 +52,14 @@
>  
>  struct mma7455_data {
>  	struct regmap *regmap;
> +	/*
> +	 * Used to reorganize data.  Will ensure correct alignment of
> +	 * the timestamp if present
> +	 */
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  static int mma7455_drdy(struct mma7455_data *mma7455)
> @@ -82,19 +90,19 @@ static irqreturn_t mma7455_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct mma7455_data *mma7455 = iio_priv(indio_dev);
> -	u8 buf[16]; /* 3 x 16-bit channels + padding + ts */
>  	int ret;
>  
>  	ret = mma7455_drdy(mma7455);
>  	if (ret)
>  		goto done;
>  
> -	ret = regmap_bulk_read(mma7455->regmap, MMA7455_REG_XOUTL, buf,
> -			       sizeof(__le16) * 3);
> +	ret = regmap_bulk_read(mma7455->regmap, MMA7455_REG_XOUTL,
> +			       mma7455->scan.channels,
> +			       sizeof(mma7455->scan.channels));
>  	if (ret)
>  		goto done;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &mma7455->scan,
>  					   iio_get_time_ns(indio_dev));
>  
>  done:

