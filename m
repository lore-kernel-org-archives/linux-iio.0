Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB72C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9F120C01
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550664162;
	bh=I4PrmJNQ40Pqds2gUWCcsmKdJPKS20j00uXWdXeLw9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hpyX6osg062U6TIllDRKtmTBJ1TEfeOQLWjzxMZZgZEhBZvhiVOCriV+AOrwS3KZc
	 QGjrz6LpWB1kUQWuUfTBCgdm6SK9q9cneNHcwpB2zc9mYQs1uhE/tFQJEoQWPjDqEE
	 bcnljA7Rls9hJvwK8nqdUabJP1emli2JGjriiBFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfBTMCm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfBTMCm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 07:02:42 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8F22083B;
        Wed, 20 Feb 2019 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550664161;
        bh=I4PrmJNQ40Pqds2gUWCcsmKdJPKS20j00uXWdXeLw9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fiOc71InK9ggnZqtnZGDCbTCPp6JdmJYhxVxmCpfRJtMoTWJPlaTTUIWSoG4a6UZV
         lKal98OmKGu9l5qTjjyE733K3HsMhhdLNSw+NRUBcN3CrIYMQqVcayGekHQc4n7KeG
         DH7QzGuNt0yP2YIvPw3F7xi7ad4SHbnqiR5gymWk=
Date:   Wed, 20 Feb 2019 12:02:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Leonard Pollak <leonardp@tr-host.de>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, Michael.hennerich@analog.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: meter: fixed iio_attr_ipeak pointing to
 vpeak register
Message-ID: <20190220120236.55c59fc3@archlinux>
In-Reply-To: <20190212221157.8677-1-leonardp@tr-host.de>
References: <20190212221157.8677-1-leonardp@tr-host.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Feb 2019 23:11:57 +0100
Leonard Pollak <leonardp@tr-host.de> wrote:

Hi Leonard,

If you send two versions of a patch for some reason and want
one to be ignored, please make sure to send a quick reply saying
that as save people looking at the wrong one!

Thanks,

Jonathan


> ---
>  drivers/staging/iio/meter/ade7854.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 029c3bf42d4d..07774c000c5a 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -269,7 +269,7 @@ static IIO_DEV_ATTR_VPEAK(0644,
>  static IIO_DEV_ATTR_IPEAK(0644,
>  		ade7854_read_32bit,
>  		ade7854_write_32bit,
> -		ADE7854_VPEAK);
> +		ADE7854_IPEAK);
>  static IIO_DEV_ATTR_APHCAL(0644,
>  		ade7854_read_16bit,
>  		ade7854_write_16bit,

