Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80F1C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AFA2147A
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550677435;
	bh=bi+qanXOjDom+VxJq86nTdeOq1T/hkl2sy2A0pVsXEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PqOOcXMP7L+cfdAVRYV5YddVwzaNPr0nwrOfoVO5HHB4Fq5mHAz7bHhGwS8Ar6xDD
	 NI7YME9IZa866HNB+TLt6qgUZ5grf3ZZOlTKrSq6XxjYNPPS1pfdUZZn72rf9Yi1CG
	 vYmwvOdCQfgoCxp7HEOCehxteryHxm53gZuclexQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfBTPnz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfBTPnz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 10:43:55 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0752086D;
        Wed, 20 Feb 2019 15:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550677434;
        bh=bi+qanXOjDom+VxJq86nTdeOq1T/hkl2sy2A0pVsXEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1JB3JZ0VDvVnCwy9iLbDL1B4kwg6n+4RyfuOPjvJXLDBpXZI4C2dVBlOb63NyFRRe
         bIFcqeT+FmfuYYjJQTRemuLsSblcyXEU9e08rmW949PiXZMmz1gfaBTCJrd1h4KK8P
         amLUQPqNxLW1UyTIUlKYLmTY8vPDwsvhBITyitps=
Date:   Wed, 20 Feb 2019 15:43:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [V2 PATCH] iio: Fix scan mask selection
Message-ID: <20190220154349.15a8c8cb@archlinux>
In-Reply-To: <20190220151132.10791-1-alexandru.ardelean@analog.com>
References: <20190220151132.10791-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Feb 2019 17:11:32 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Fixes commit 057ac1acdfc4 ("iio: Use kmalloc_array() in
> iio_scan_mask_set()").
> 
> The trialmask is expected to have all bits set to 0 after allocation.
> Currently kmalloc_array() is used which does not zero the memory and so
> random bits are set. This results in random channels being enabled when
> they shouldn't. Replace kmalloc_array() with kcalloc() which has the same
> interface but zeros the memory.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied with a bit of tidying as the fixes tag should be down here.

I also added a note to observe that the fixes tag isn't entirely accurate
as the bug was there before that one, it's just that a different fix will
be necessary to backport further.

Added stable tag.

Thanks,

Jonathan

> ---
> 
> Changelog V1->V2:
> * added `Fixes commit 057ac1acdfc4 ("iio: Use kmalloc_array() in
>   iio_scan_mask_set()").` comment
> 
>  drivers/iio/industrialio-buffer.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index cd5bfe39591b..dadd921a4a30 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -320,9 +320,8 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = kmalloc_array(BITS_TO_LONGS(indio_dev->masklength),
> -				  sizeof(*trialmask),
> -				  GFP_KERNEL);
> +	trialmask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> +			    sizeof(*trialmask), GFP_KERNEL);
>  	if (trialmask == NULL)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {

