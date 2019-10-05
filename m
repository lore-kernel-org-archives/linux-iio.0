Return-Path: <SRS0=SkP8=X6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEDDC3E8AB
	for <linux-iio@archiver.kernel.org>; Sat,  5 Oct 2019 12:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A94222C8
	for <linux-iio@archiver.kernel.org>; Sat,  5 Oct 2019 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570279514;
	bh=SCfBHByOpV5yuOAZ4VRTKGrs7TIfXmVC7jxB8JqIFAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AHKTdEX9gCg3/csftHhKVGptCv6L56DrwYLV1addpEP3I1cKukwMBzbSipkWcJDiQ
	 mmr1AT2BNuyxHKqrlaEqZlIUorEreKe/aozMvWFiO2F4ikegmx8nnWq1O3a2z6Ee4v
	 a0RoZz7uHTWHm89eESmeCjP/xlqb5ZAoX3AFJXi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfJEMpN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Oct 2019 08:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJEMpN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 08:45:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0697E2133F;
        Sat,  5 Oct 2019 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570279512;
        bh=SCfBHByOpV5yuOAZ4VRTKGrs7TIfXmVC7jxB8JqIFAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tifi3ONZb+5cYWkbjmU4pcuaAVu3h904w9PzSVSCq3ugx7MmWQnbq7qgDRFqeMQc+
         6DeNXEHeYDRTfBuR504aVcnlGfry9JjMtC9K7alPIBzdo97W6/4B22rruwIMK/Xxz9
         AnhWRtlwgDzRjLX+B5buP1OpshoCq3CYdVcRlx+U=
Date:   Sat, 5 Oct 2019 13:45:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: adis16130: remove mlock usage
Message-ID: <20191005134508.27361c46@archlinux>
In-Reply-To: <20190917161023.3176-1-alexandru.ardelean@analog.com>
References: <20190917161023.3176-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Sep 2019 19:10:23 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The use of indio_dev's mlock is discouraged. The driver already defines
> it's own `bus_lock` in `adis16130_spi_read()`, so using the mlock is
> redundant.
> 
> The parts supported by this chip are obsoleted anyway, so for now we just
> remove mlock as part of a general cleanup, until the driver gets removed.
Hmm. Removing a device driver like this which isn't in staging is going
to be controversial.  There may well be long term supported devices out
there using it.  We have no way of knowing, so my inclination will be
to leave it there unless it is a significant maintenance burden.

The drivers in staging are a different matter as we never made any
'promise' of supporting those!

I'll hazard a guess that mlock here was cut and paste from another driver
and that driver supported buffered modes.  In those cases it would need
to move to the utility functions to ensure we are not in buffered mode.

Here your fix is right though given the driver only support sysfs reads.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/gyro/adis16130.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
> index de3f66f89496..79e63c8a2ea8 100644
> --- a/drivers/iio/gyro/adis16130.c
> +++ b/drivers/iio/gyro/adis16130.c
> @@ -76,9 +76,7 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		/* Take the iio_dev status lock */
> -		mutex_lock(&indio_dev->mlock);
>  		ret = adis16130_spi_read(indio_dev, chan->address, &temp);
> -		mutex_unlock(&indio_dev->mlock);
>  		if (ret)
>  			return ret;
>  		*val = temp;

