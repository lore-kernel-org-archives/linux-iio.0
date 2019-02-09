Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FD4C282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BDA21928
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549723748;
	bh=QUovf9nd0IaKHb1PIH8+hyiaFw5xI3Ml30L7hie+BBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=b9l+L8WzI+LGNo6pARKz4U44BxrC14t9+6y2tbgOi5H85L2GFtOdtnvbEX9SHazRr
	 zdjHOFNuxETpYyP2DM9BxNIs3dk6EwC15uT9UgpiSzt7taWl6sSXyNLWSrP+/xSXfD
	 Z+kKODeAvjxOdCgJXcFkXj/d+LiUJVZCa9kUn/Jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBIOtH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 09:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfBIOtH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 09:49:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33B120863;
        Sat,  9 Feb 2019 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549723746;
        bh=QUovf9nd0IaKHb1PIH8+hyiaFw5xI3Ml30L7hie+BBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=khDoSfNOmQczx7Lsa191Keb/7jhIsiJrlOk0qlG9N7Y8WYoiLh2ZJ0YB1kBaLSYVb
         1baA9ZVmQVBZNif+BYInXTF40wdUXFg+TAxwjaA3auY23j3yqQtQXvsBSu0OiQYxvM
         ELiyBy/ulVyJ5ekL8uTWauzu12gM00lknB7uat0E=
Date:   Sat, 9 Feb 2019 14:49:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iio:bmi160: add SPDX identifiers
Message-ID: <20190209144901.4c3f42ea@archlinux>
In-Reply-To: <20190202215601.20275-2-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
        <20190202215601.20275-2-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  2 Feb 2019 13:55:56 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Add SPDX identifiers (GPL 2) for the BMI160 driver. bmi160.h had an
> identifier, but the other files did not.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
Applied to the togreg branch of iio.git and pushed out as
testing to hopefully be ignored.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 5 +----
>  drivers/iio/imu/bmi160/bmi160_i2c.c  | 5 +----
>  drivers/iio/imu/bmi160/bmi160_spi.c  | 4 +---
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index b10330b0f93f..ce61026d84c3 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * BMI160 - Bosch IMU (accel, gyro plus external magnetometer)
>   *
>   * Copyright (c) 2016, Intel Corporation.
>   *
> - * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> - * directory of this archive for more details.
> - *
>   * IIO core driver for BMI160, with support for I2C/SPI busses
>   *
>   * TODO: magnetometer, interrupts, hardware FIFO
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index 5b1f7e6af651..e36f5e82d400 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * BMI160 - Bosch IMU, I2C bits
>   *
>   * Copyright (c) 2016, Intel Corporation.
>   *
> - * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> - * directory of this archive for more details.
> - *
>   * 7-bit I2C slave address is:
>   *      - 0x68 if SDO is pulled to GND
>   *      - 0x69 if SDO is pulled to VDDIO
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index e521ad14eeac..c19e3df35559 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -1,11 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * BMI160 - Bosch IMU, SPI bits
>   *
>   * Copyright (c) 2016, Intel Corporation.
>   *
> - * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> - * directory of this archive for more details.
>   */
>  #include <linux/acpi.h>
>  #include <linux/module.h>

