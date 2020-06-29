Return-Path: <SRS0=WQji=AK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CABC433DF
	for <linux-iio@archiver.kernel.org>; Mon, 29 Jun 2020 19:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB25020874
	for <linux-iio@archiver.kernel.org>; Mon, 29 Jun 2020 19:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgF2Tt2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:49:28 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:46070 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388209AbgF2Tt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jun 2020 15:49:27 -0400
X-Greylist: delayed 2420 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 15:49:26 EDT
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 033753B0AB2
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2020 07:25:01 +0000 (UTC)
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8549E240008;
        Mon, 29 Jun 2020 07:24:40 +0000 (UTC)
Date:   Mon, 29 Jun 2020 09:28:09 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 10/23] iio:adc:max11100: Drop of_match_ptr protection /
 add mod_devicetable.h include
Message-ID: <20200629072809.fk2vve5ycdiwnkyk@uno.localdomain>
References: <20200628123654.32830-1-jic23@kernel.org>
 <20200628123654.32830-11-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200628123654.32830-11-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
On Sun, Jun 28, 2020 at 01:36:41PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Allows use of driver with ACPI PRP0001 base binding.
> Mostly this is about trying to avoid cut and paste of this into new
> drivers (it is a frequent review comment) rather than any
> thought that this driver might get used on an ACPI platform.
>
> The mod_devicetable.h include is to encourage best practice of including
> any header directly used within the code (here for of_match_id)
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  drivers/iio/adc/max11100.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> index 57734f9742f6..77fcee1dddf7 100644
> --- a/drivers/iio/adc/max11100.c
> +++ b/drivers/iio/adc/max11100.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>

If we want to keep the inclusion order alphabetically sorted,
shouldn't mod_devicetable. come before module.h ?

That apart:
Acked-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>
> @@ -161,7 +162,7 @@ MODULE_DEVICE_TABLE(of, max11100_ids);
>  static struct spi_driver max11100_driver = {
>  	.driver = {
>  		.name	= "max11100",
> -		.of_match_table = of_match_ptr(max11100_ids),
> +		.of_match_table = max11100_ids,
>  	},
>  	.probe		= max11100_probe,
>  	.remove		= max11100_remove,
> --
> 2.27.0
>
