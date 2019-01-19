Return-Path: <SRS0=JcFl=P3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EACC61CE8
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6242087E
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547917392;
	bh=ABTfCy+ybHCfegXKSTjJ+uwqzIxi0vCHqrGLVxxTxSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FdEMoV+wr+60NWMk+J1066iDLvO9uhqDKR633HAckyZUbdBI4zJ2kLi4I/Q78sWJg
	 6e/PEov4JqLd2dqQxcqDJDrpjLFtfesjnlLfBBlyqs2b8P6b1tPxJS8FpOhbm5gG4m
	 T9vb34To+7FfUdIZQGu1mH3eCSFQV7UlSz8sJtIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfASRDM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfASRDM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Jan 2019 12:03:12 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E8392084F;
        Sat, 19 Jan 2019 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547917390;
        bh=ABTfCy+ybHCfegXKSTjJ+uwqzIxi0vCHqrGLVxxTxSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ekug9gj+/bCMMQqAb4DZIek3UvbOZHFO9X7crrvM6NlZFJ59aeewk7w7h3nFLX66q
         1+lln+XR9718RdU/rAkrFfKLKG36LPoVII99og+J/ks6MZ+wyfkW9c2IXT6VRHI6cB
         Wkp7cIeQxT5RsyODREq+RTBvwS7/YdVuL5k7wm8M=
Date:   Sat, 19 Jan 2019 17:03:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/5] iio:bmi160: add SPDX identifiers
Message-ID: <20190119170305.7b391c55@archlinux>
In-Reply-To: <20190114035621.5252-2-martin@martingkelly.com>
References: <20190114035621.5252-1-martin@martingkelly.com>
        <20190114035621.5252-2-martin@martingkelly.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Jan 2019 19:56:17 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Add SPDX identifiers (GPL 2) for the BMI160 driver. bmi160.h had an
> identifier, but the other files did not.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>

This is fine, but for anything (even SPDX) that touches licenses
I ideally like to get an Ack from the main author.  
cc'd Daniel.

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

