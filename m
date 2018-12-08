Return-Path: <SRS0=HNOD=OR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D421C04EB8
	for <linux-iio@archiver.kernel.org>; Sat,  8 Dec 2018 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E641320868
	for <linux-iio@archiver.kernel.org>; Sat,  8 Dec 2018 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544267260;
	bh=4jvK4nxg7BGfaKewCrAdDdCVIRhR/+4aV9CiM5U7bzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eZ6HeYuxrjTB9QFVcuqbuFbDaTDHxMx4gDvczEJ7YkL+KewZSJS9TEJxMhQ58gt0B
	 x/fV4IRwxLupqXaB+mKfOjppWUrbdfww7lc23iOh/WxGdiL+bLMPZKJxc7w8ZJGYKj
	 kQ3SWXXtnEKUhReNGDGlauQGTGz5vWSKfO+sKuYo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E641320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLHLHj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:07:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLHLHj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Dec 2018 06:07:39 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80ED20700;
        Sat,  8 Dec 2018 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544267258;
        bh=4jvK4nxg7BGfaKewCrAdDdCVIRhR/+4aV9CiM5U7bzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g3nNLjfKdyBu3utXdbLDc0lUFyCDDueoX1lnbqalq41C38+2CUMY1Yg0Ym5HvSLRX
         vAllaB6rX/O6ngDErYbm9Dz3xw+4PhkUyzrCpR72CfeIYWrmfQTqzmrSfvnwrMZCDO
         69iUTFs4L8I8GRcY4b49JKxofg7kHfYmtTBnTmWU=
Date:   Sat, 8 Dec 2018 11:07:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andi Shyti <andi@etezian.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: core: check 'info' value before registering the
 device
Message-ID: <20181208110735.5da28a29@archlinux>
In-Reply-To: <20181202183031.2471-1-andi@etezian.org>
References: <20181202183031.2471-1-andi@etezian.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  2 Dec 2018 20:30:31 +0200
Andi Shyti <andi@etezian.org> wrote:

> When the 'info' structure inside indio_dev is left uninitialized,
> a segmentation fault occurs.
> 
> Check the 'info' value before using it and if it is equal to
> NULL, return with -EINVAL.
> 
> Signed-off-by: Andi Shyti <andi@etezian.org>

Hmm. It would be an impressive level of bug if that one got through
in a driver but paranoia does no harm I suppose.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a062cfddc5af..4f5cd9f60870 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1671,6 +1671,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (!indio_dev->info)
> +		return -EINVAL;
> +
>  	/* configure elements for the chrdev */
>  	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
>  

