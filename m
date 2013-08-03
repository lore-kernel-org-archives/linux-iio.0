Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38368 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab3HCRBC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 13:01:02 -0400
Message-ID: <51FD4564.6040109@kernel.org>
Date: Sat, 03 Aug 2013 19:01:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, s.nawrocki@samsun.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 2/2] iio: lps331ap: Modify in_temp_scale calculation way
References: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com> <1372760003-32090-3-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1372760003-32090-3-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/13 11:13, Jacek Anaszewski wrote:
> This patch modifies the way how the in_temp_scale output value is
> calculated. With this implementation it is more clear how the value
> is obtained.
> 
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

The fix (patch 1) has worked it's way through now to IIOs upstream so
this patch has now been added to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/st_pressure_core.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 89eb40a..09d94a6 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -31,6 +31,9 @@
>  #define ST_PRESS_LSB_PER_MBAR			4096UL
>  #define ST_PRESS_KPASCAL_NANO_SCALE		(100000000UL / \
>  						 ST_PRESS_LSB_PER_MBAR)
> +#define ST_PRESS_LSB_PER_CELSIUS		480UL
> +#define ST_PRESS_CELSIUS_NANO_SCALE		(1000000000UL / \
> +						 ST_PRESS_LSB_PER_CELSIUS)
>  #define ST_PRESS_NUMBER_DATA_CHANNELS		1
>  
>  /* DEFAULT VALUE FOR SENSORS */
> @@ -53,8 +56,8 @@
>  #define ST_PRESS_1_FS_ADDR			0x23
>  #define ST_PRESS_1_FS_MASK			0x30
>  #define ST_PRESS_1_FS_AVL_1260_VAL		0x00
> -#define ST_PRESS_1_FS_AVL_TEMP_GAIN		2083000
>  #define ST_PRESS_1_FS_AVL_1260_GAIN		ST_PRESS_KPASCAL_NANO_SCALE
> +#define ST_PRESS_1_FS_AVL_TEMP_GAIN		ST_PRESS_CELSIUS_NANO_SCALE
>  #define ST_PRESS_1_BDU_ADDR			0x20
>  #define ST_PRESS_1_BDU_MASK			0x04
>  #define ST_PRESS_1_DRDY_IRQ_ADDR		0x22
> 
