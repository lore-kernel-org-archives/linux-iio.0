Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18212C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 14:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75AF2072B
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587825392;
	bh=RymmMr3QtTuOnEuGAPR5MAduE5CgSJFGqxuCesCbXbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=09empbEP/nPffjzEx6djC28jQy+5CKjUeQbQySboMwMbf8Da99IFlU1WdyaomRkHQ
	 AdC/iet/m26ZQlalRyTUEqYV5lQikwLBWD6X7+7q/EtzV2K92Tdf6Pr7lEVFtYDZkH
	 cDPRyGV0uFwKEOUgotyyAEE7SBd8ADyp5qJznINg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDYOgc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYOgb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 10:36:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084B320714;
        Sat, 25 Apr 2020 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587825391;
        bh=RymmMr3QtTuOnEuGAPR5MAduE5CgSJFGqxuCesCbXbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gHGSw757u0vDpftzLmU199rxhZsQv/znQAXN4Fr79ULcYmsprZmsDbp4/A1EKCJOF
         WsyuLWdm7TY+EEMjltcvy7GQuuLkGES3jvdVFiLh04pMOL96hP4Zf9w6TaoeZC8tZ5
         DkMZPxh92JgnFNC4XVZ4KuzTkoG8phNX6I14FJ+4=
Date:   Sat, 25 Apr 2020 15:36:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.Ardelean@analog.com
Subject: Re: [PATCH 2/3] iio: accel: kxsd9-i2c: Use mod_devicetable.h and
 drop of_match_ptr macro
Message-ID: <20200425153627.668870ee@archlinux>
In-Reply-To: <20200424224439.5601-3-nish.malpani25@gmail.com>
References: <20200424224439.5601-1-nish.malpani25@gmail.com>
        <20200424224439.5601-3-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 04:14:38 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Enables ACPI DSDT to probe via PRP0001 and the compatible property. Also
> removes the ifdef protections for CONFIG_OF.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/kxsd9-i2c.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index b6f3de7ef8ea..b580d605f848 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -2,6 +2,7 @@
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> @@ -36,15 +37,11 @@ static int kxsd9_i2c_remove(struct i2c_client *client)
>  	return kxsd9_common_remove(&client->dev);
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id kxsd9_of_match[] = {
>  	{ .compatible = "kionix,kxsd9", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, kxsd9_of_match);
> -#else
> -#define kxsd9_of_match NULL
> -#endif
>  
>  static const struct i2c_device_id kxsd9_i2c_id[] = {
>  	{"kxsd9", 0},
> @@ -55,7 +52,7 @@ MODULE_DEVICE_TABLE(i2c, kxsd9_i2c_id);
>  static struct i2c_driver kxsd9_i2c_driver = {
>  	.driver = {
>  		.name	= "kxsd9",
> -		.of_match_table = of_match_ptr(kxsd9_of_match),
> +		.of_match_table = kxsd9_of_match,
>  		.pm = &kxsd9_dev_pm_ops,
>  	},
>  	.probe		= kxsd9_i2c_probe,

