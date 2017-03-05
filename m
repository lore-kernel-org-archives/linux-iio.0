Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59749 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbdCEL0A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 06:26:00 -0500
Subject: Re: [PATCH v2] staging: iio: accel: Rename source files and update
 Makefile
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
References: <1488651002-18415-1-git-send-email-narcisaanamaria12@gmail.com>
 <1488656592-15251-1-git-send-email-narcisaanamaria12@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9bf1042d-1dcf-91f8-31ce-19a1e6106d7b@kernel.org>
Date: Sun, 5 Mar 2017 11:25:57 +0000
MIME-Version: 1.0
In-Reply-To: <1488656592-15251-1-git-send-email-narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/17 19:43, Narcisa Ana Maria Vasile wrote:
> Rename adis162xx_core.c files to adis162xx.c because
> these are the only source files for these drivers.
> 
> Update Makefile to correspond to the new file names.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Great thanks.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> 
>  rename drivers/staging/iio/accel/{adis16201_core.c => adis16201.c} (100%)
>  rename drivers/staging/iio/accel/{adis16203_core.c => adis16203.c} (100%)
>  rename drivers/staging/iio/accel/{adis16209_core.c => adis16209.c} (100%)
>  rename drivers/staging/iio/accel/{adis16240_core.c => adis16240.c} (100%)
> 
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
> index febb137..5d8ad21 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -2,14 +2,7 @@
>  # Makefile for industrial I/O accelerometer drivers
>  #
>  
> -adis16201-y             := adis16201_core.o
>  obj-$(CONFIG_ADIS16201) += adis16201.o
> -
> -adis16203-y             := adis16203_core.o
>  obj-$(CONFIG_ADIS16203) += adis16203.o
> -
> -adis16209-y             := adis16209_core.o
>  obj-$(CONFIG_ADIS16209) += adis16209.o
> -
> -adis16240-y             := adis16240_core.o
>  obj-$(CONFIG_ADIS16240) += adis16240.o
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201.c
> similarity index 100%
> rename from drivers/staging/iio/accel/adis16201_core.c
> rename to drivers/staging/iio/accel/adis16201.c
> diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203.c
> similarity index 100%
> rename from drivers/staging/iio/accel/adis16203_core.c
> rename to drivers/staging/iio/accel/adis16203.c
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209.c
> similarity index 100%
> rename from drivers/staging/iio/accel/adis16209_core.c
> rename to drivers/staging/iio/accel/adis16209.c
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240.c
> similarity index 100%
> rename from drivers/staging/iio/accel/adis16240_core.c
> rename to drivers/staging/iio/accel/adis16240.c
> 

