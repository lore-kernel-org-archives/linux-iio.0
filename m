Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551EDC7EE24
	for <linux-iio@archiver.kernel.org>; Sat,  3 Jun 2023 11:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjFCLXF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 3 Jun 2023 07:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFCLXE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jun 2023 07:23:04 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B38180
        for <linux-iio@vger.kernel.org>; Sat,  3 Jun 2023 04:23:03 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 0009081d-0201-11ee-abf4-005056bdd08f;
        Sat, 03 Jun 2023 14:23:01 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 14:23:01 +0300
To:     inv.git-commit@tdk.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 4/4] iio: imu: inv_mpu6050: use the common inv_sensors
 timestamp module
Message-ID: <ZHsilSKR4I5daSLs@surfacebook>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
 <20230531142513.48507-5-inv.git-commit@tdk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531142513.48507-5-inv.git-commit@tdk.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Wed, May 31, 2023 at 02:25:13PM +0000, inv.git-commit@tdk.com kirjoitti:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Replace timestamping by the new common inv_sensors timestamp
> module.

...

>  #include <linux/irq.h>
>  #include <linux/interrupt.h>

>  #include <linux/iio/iio.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>

While at it, can you split it to a separate group of headers that may be
located after generic linux/* ?

Also would be nice to keep them in order.

>  #include <linux/acpi.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>

>  #include <linux/mutex.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/kfifo_buf.h>

Same.

This actually a mess, but it's another story.

...

>  #include <linux/interrupt.h>
>  #include <linux/poll.h>
>  #include <linux/math64.h>

+ Blank line

> +#include <linux/iio/common/inv_sensors_timestamp.h>

+ Blank line.

>  #include "inv_mpu_iio.h"

-- 
With Best Regards,
Andy Shevchenko


