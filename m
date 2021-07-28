Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF76C4338F
	for <linux-iio@archiver.kernel.org>; Wed, 28 Jul 2021 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321CB6101E
	for <linux-iio@archiver.kernel.org>; Wed, 28 Jul 2021 17:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhG1RyL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231287AbhG1RyK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Jul 2021 13:54:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B4B60C3E;
        Wed, 28 Jul 2021 17:54:05 +0000 (UTC)
Date:   Wed, 28 Jul 2021 18:56:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Siddharth Manthan <siddharth_manthan@outlook.com>
Cc:     robh+dt@kernel.org, ktsai@capellamicro.com, lars@metafoo.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, nikita@trvn.ru
Subject: Re: [PATCH 2/2] drivers: iio: light: cm3323: Add device tree
 support
Message-ID: <20210728185641.7ea37875@jic23-huawei>
In-Reply-To: <SG2PR02MB38141E2560616F0514CF9A768FEA9@SG2PR02MB3814.apcprd02.prod.outlook.com>
References: <20210728122216.22849-1-siddharth_manthan@outlook.com>
        <SG2PR02MB38141E2560616F0514CF9A768FEA9@SG2PR02MB3814.apcprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Jul 2021 17:52:16 +0530
Siddharth Manthan <siddharth_manthan@outlook.com> wrote:

> Add Device Tree support for Capella cm3323 Ambient Light Sensor
> 
> Signed-off-by: Siddharth Manthan <siddharth_manthan@outlook.com>
It 'should' have worked without the explicit of_device_id table,
via the fallback that I2C has to use the i2c_device_id table.

I'm fine with making it explicit though as that route doesn't
use the vendor ID at all, so we 'might' get a clash.

I'll change the patch title when applying to something like
iio:light:cm3323: Add of_device_id table

Note also drop the drivers bit as we don't normally have that for
IIO devices.

Jonathan

> ---
>  drivers/iio/light/cm3323.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 6d1b0ffd1..fd9a8c27d 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -256,9 +256,16 @@ static const struct i2c_device_id cm3323_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, cm3323_id);
>  
> +static const struct of_device_id cm3323_of_match[] = {
> +	{ .compatible = "capella,cm3323", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, cm3323_of_match);
> +
>  static struct i2c_driver cm3323_driver = {
>  	.driver = {
>  		.name = CM3323_DRV_NAME,
> +		.of_match_table = cm3323_of_match,
>  	},
>  	.probe		= cm3323_probe,
>  	.id_table	= cm3323_id,

