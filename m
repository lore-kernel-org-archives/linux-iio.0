Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D56C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B966D222C4
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 15:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfCXPMo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:12:44 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38106 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfCXPMo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2019 11:12:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 24BA59E7727;
        Sun, 24 Mar 2019 15:12:42 +0000 (GMT)
Date:   Sun, 24 Mar 2019 15:12:41 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 4/5] iio: imu: adis16400: rename adis16400_core.c ->
 adi16400.c
Message-ID: <20190324151241.500d9778@archlinux>
In-Reply-To: <20190322204442.4035-4-ardeleanalex@gmail.com>
References: <20190322204442.4035-1-ardeleanalex@gmail.com>
        <20190322204442.4035-4-ardeleanalex@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Mar 2019 22:44:41 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> This change does a simple 1-to-1 rename of the adis16400_core.c file. Now
> that the `adis16400_buffer.c` file was removed, everything can be moved
> into a single driver file.
> But first, this rename.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/Makefile                          | 1 -
>  drivers/iio/imu/{adis16400_core.c => adis16400.c} | 0
>  2 files changed, 1 deletion(-)
>  rename drivers/iio/imu/{adis16400_core.c => adis16400.c} (100%)
> 
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index c9f85126fbe1..4a6958865504 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -4,7 +4,6 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> -adis16400-y             := adis16400_core.o
>  obj-$(CONFIG_ADIS16400) += adis16400.o
>  obj-$(CONFIG_ADIS16460) += adis16460.o
>  obj-$(CONFIG_ADIS16480) += adis16480.o
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400.c
> similarity index 100%
> rename from drivers/iio/imu/adis16400_core.c
> rename to drivers/iio/imu/adis16400.c

