Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40831 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab3GPHvl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 03:51:41 -0400
Message-ID: <51E4FB8C.1000609@kernel.org>
Date: Tue, 16 Jul 2013 08:51:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, s.nawrocki@samsun.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 1/2] iio: lps331ap: Fix wrong in_pressure_scale output
 value
References: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com> <1372760003-32090-2-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1372760003-32090-2-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2013 11:13 AM, Jacek Anaszewski wrote:
> This patch fixes improper in_pressure_scale output that is
> returned by the lps331ap barometer sensor driver. According
> to the documentation the pressure after applying the scale has to
> be expressed in kilopascal units. With erroneous implementation
> the scale value larger by two orders of magnitude is returned -
> 2441410 instead of 24414.
> 
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Applied to the fixes-togreg branch of iio.git

Patch 2 doesn't want to go in as a fix so I may end up holding that
one for a while until I can apply it without a whole pile of merge
conflicts.

Jonathan
> ---
>  drivers/iio/pressure/st_pressure_core.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index aacea2a..89eb40a 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -28,7 +28,9 @@
>  #include <linux/iio/common/st_sensors.h>
>  #include "st_pressure.h"
>  
> -#define ST_PRESS_MBAR_TO_KPASCAL(x)		(x * 10)
> +#define ST_PRESS_LSB_PER_MBAR			4096UL
> +#define ST_PRESS_KPASCAL_NANO_SCALE		(100000000UL / \
> +						 ST_PRESS_LSB_PER_MBAR)
>  #define ST_PRESS_NUMBER_DATA_CHANNELS		1
>  
>  /* DEFAULT VALUE FOR SENSORS */
> @@ -51,8 +53,8 @@
>  #define ST_PRESS_1_FS_ADDR			0x23
>  #define ST_PRESS_1_FS_MASK			0x30
>  #define ST_PRESS_1_FS_AVL_1260_VAL		0x00
> -#define ST_PRESS_1_FS_AVL_1260_GAIN		ST_PRESS_MBAR_TO_KPASCAL(244141)
>  #define ST_PRESS_1_FS_AVL_TEMP_GAIN		2083000
> +#define ST_PRESS_1_FS_AVL_1260_GAIN		ST_PRESS_KPASCAL_NANO_SCALE
>  #define ST_PRESS_1_BDU_ADDR			0x20
>  #define ST_PRESS_1_BDU_MASK			0x04
>  #define ST_PRESS_1_DRDY_IRQ_ADDR		0x22
> 
