Return-Path: <SRS0=diYI=OZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F91C43387
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 11:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712AA217FB
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544958404;
	bh=u3jAVTSZipPtN4rzyCLOx/ISE2Ku/CvEe1CPt7kxmyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wcShp/WZqBrMF+qNGXqYwDIjPR+zpvLk299oH39V3C1mWFbnD7/UECDlllOBALjpt
	 IKhB79JlKdvLeX6CqzHyzB/Lda8CfcsuGMH2/VPzBFbC99hZDjXDUyEDzDJcdcqSwU
	 aLAAQ6ht4HjhXOC3q1S9+BLme0HaTI2y4VPSPq84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbeLPLGn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbeLPLGn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Dec 2018 06:06:43 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39AA0217FB;
        Sun, 16 Dec 2018 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544958403;
        bh=u3jAVTSZipPtN4rzyCLOx/ISE2Ku/CvEe1CPt7kxmyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Sr3N/0JRnKiAoxiKa2fnmtClKzLC6vc1XzXa8WeFrCnhJflj0cvqOXKJfJjgnkwt
         oZ36QWaFrUsYj7pFZ+Hm/Dh8goSN85BZ1BrPlxsdQxjZ2rXPvJqyf+Zbxn2ik6CuEr
         SX4XDA/TFZfdQuegU77mkdr+pwfBVTDfFh9lUc+I=
Date:   Sun, 16 Dec 2018 11:06:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] iio: ti-ads8688: Update buffer allocation for
 timestamps
Message-ID: <20181216110639.3eb2e7b9@archlinux>
In-Reply-To: <20181211191207.21900-3-dmurphy@ti.com>
References: <20181211191207.21900-1-dmurphy@ti.com>
        <20181211191207.21900-3-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Dec 2018 13:12:06 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Per Jonathan Cameron, the buffer needs to allocate room for a
> 64 bit timestamp as well as the channels.  Change the buffer
> to allocate this additional space.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
Same question around data types as in the previous patch.

If you can track down the original patch that introduced the bug and add
add a fixes tag, that would be great as well.  This one should go into
stable.

Thanks,

Jonathan
> ---
> 
> v2 - New patch suggested change by maintainer - https://lore.kernel.org/patchwork/patch/1021048/
> 
>  drivers/iio/adc/ti-ads8688.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 184d686ebd99..3597bc0697ee 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -385,7 +385,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> -	u16 buffer[8];
> +	unsigned short buffer[8 + sizeof(s64)/sizeof(short)];
Why change from a well defined size of data to one that is only
defined by the c spec to be no more than the size of an int?

>  	int i, j = 0;
>  
>  	for (i = 0; i < indio_dev->masklength; i++) {

