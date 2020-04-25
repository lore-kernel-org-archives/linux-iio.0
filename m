Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91966C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 14:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4652072B
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587825362;
	bh=hIDOPeVK2bxBEQPG3LPsQ62VI8nArFVT9+7/rYGVCDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dxMotu2oBGjD97KDxHZiF+JrxpkOikawDxSPoN/aW0Sjdpxbh8gEMz5z2ABs8KV7+
	 gEvIzyZdSp0RGOV+37tjaH8ofJmDdMWcgThDpnYx/w7VFXvIoOxhn+Uk8SkmzAruqQ
	 EN9yiI+iNiaH9wQV4snLHlGnSDWrzYPZ3+L2HAhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDYOgB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYOgB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 10:36:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BA720714;
        Sat, 25 Apr 2020 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587825361;
        bh=hIDOPeVK2bxBEQPG3LPsQ62VI8nArFVT9+7/rYGVCDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gGyTuYmoh6FYnXOcVnoH0QHs0rYviht96VkKKy+PH80xexUwl3k/DGpvJizWjEiLQ
         19V4f5CdN7LlUHE+GT+7LFMnH0EldBGOF30eB9ZRX0zx+eV/BDH+3iGPNgzpxPjX6q
         GrShKcqF3uppap9YErGL6vquQ3baAm9j+K0eMv/Q=
Date:   Sat, 25 Apr 2020 15:35:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.Ardelean@analog.com
Subject: Re: [PATCH 1/3] iio: accel: dmard06: Use mod_devicetable.h and drop
 of_match_ptr macro
Message-ID: <20200425153557.7bf03b2a@archlinux>
In-Reply-To: <20200424224439.5601-2-nish.malpani25@gmail.com>
References: <20200424224439.5601-1-nish.malpani25@gmail.com>
        <20200424224439.5601-2-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 04:14:37 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Enables ACPI DSDT to probe via PRP0001 and the compatible property.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/dmard06.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
> index 2bf210fa4ba6..ef89bded7390 100644
> --- a/drivers/iio/accel/dmard06.c
> +++ b/drivers/iio/accel/dmard06.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  
> @@ -226,7 +227,7 @@ static struct i2c_driver dmard06_driver = {
>  	.id_table = dmard06_id,
>  	.driver = {
>  		.name = DMARD06_DRV_NAME,
> -		.of_match_table = of_match_ptr(dmard06_of_match),
> +		.of_match_table = dmard06_of_match,
>  		.pm = DMARD06_PM_OPS,
>  	},
>  };

