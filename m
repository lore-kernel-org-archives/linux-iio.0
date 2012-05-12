Return-Path: <jic23@kernel.org>
Message-ID: <4FAEAA02.7060500@kernel.org>
Date: Sat, 12 May 2012 19:20:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] staging:iio:dac: Remove unused dac.h includes
References: <1336755862-24184-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1336755862-24184-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/11/2012 06:04 PM, Lars-Peter Clausen wrote:
> None of these drivers use anything from dac.h, so remove the include.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5064.c      |    1 -
>  drivers/staging/iio/dac/ad5360.c      |    1 -
>  drivers/staging/iio/dac/ad5380.c      |    2 --
>  drivers/staging/iio/dac/ad5421.c      |    1 -
>  drivers/staging/iio/dac/ad5446.c      |    1 -
>  drivers/staging/iio/dac/ad5504.c      |    2 +-
>  drivers/staging/iio/dac/ad5624r_spi.c |    2 +-
>  drivers/staging/iio/dac/ad5686.c      |    1 -
>  drivers/staging/iio/dac/ad5764.c      |    1 -
>  drivers/staging/iio/dac/ad5791.c      |    2 +-
>  10 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
> index 2394f05..276af02 100644
> --- a/drivers/staging/iio/dac/ad5064.c
> +++ b/drivers/staging/iio/dac/ad5064.c
> @@ -18,7 +18,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
>  
>  #define AD5064_MAX_DAC_CHANNELS			8
>  #define AD5064_MAX_VREFS			4
> diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
> index 26cac42..0304079 100644
> --- a/drivers/staging/iio/dac/ad5360.c
> +++ b/drivers/staging/iio/dac/ad5360.c
> @@ -18,7 +18,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
>  
>  #define AD5360_CMD(x)				((x) << 22)
>  #define AD5360_ADDR(x)				((x) << 16)
> diff --git a/drivers/staging/iio/dac/ad5380.c b/drivers/staging/iio/dac/ad5380.c
> index 7a35cc6..5dfb445 100644
> --- a/drivers/staging/iio/dac/ad5380.c
> +++ b/drivers/staging/iio/dac/ad5380.c
> @@ -20,8 +20,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
> -
>  
>  #define AD5380_REG_DATA(x)	(((x) << 2) | 3)
>  #define AD5380_REG_OFFSET(x)	(((x) << 2) | 2)
> diff --git a/drivers/staging/iio/dac/ad5421.c b/drivers/staging/iio/dac/ad5421.c
> index ffbd4c2..ea2f83b 100644
> --- a/drivers/staging/iio/dac/ad5421.c
> +++ b/drivers/staging/iio/dac/ad5421.c
> @@ -19,7 +19,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> -#include "dac.h"
>  #include "ad5421.h"
>  
>  
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index b6b7eec..f769b74 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -20,7 +20,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
>  
>  #include "ad5446.h"
>  
> diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
> index 19e65e1..07b31f4 100644
> --- a/drivers/staging/iio/dac/ad5504.c
> +++ b/drivers/staging/iio/dac/ad5504.c
> @@ -19,7 +19,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> -#include "dac.h"
> +
>  #include "ad5504.h"
>  
>  static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
> diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
> index 2ce0544..ef6a320 100644
> --- a/drivers/staging/iio/dac/ad5624r_spi.c
> +++ b/drivers/staging/iio/dac/ad5624r_spi.c
> @@ -18,7 +18,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
> +
>  #include "ad5624r.h"
>  
>  static int ad5624r_spi_write(struct spi_device *spi,
> diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
> index a3881d7..cf833c9 100644
> --- a/drivers/staging/iio/dac/ad5686.c
> +++ b/drivers/staging/iio/dac/ad5686.c
> @@ -18,7 +18,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
>  
>  #define AD5686_DAC_CHANNELS			4
>  
> diff --git a/drivers/staging/iio/dac/ad5764.c b/drivers/staging/iio/dac/ad5764.c
> index 03dbd93..ffce304 100644
> --- a/drivers/staging/iio/dac/ad5764.c
> +++ b/drivers/staging/iio/dac/ad5764.c
> @@ -18,7 +18,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
>  
>  #define AD5764_REG_SF_NOP			0x0
>  #define AD5764_REG_SF_CONFIG			0x1
> diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
> index ad33725..4e955ed 100644
> --- a/drivers/staging/iio/dac/ad5791.c
> +++ b/drivers/staging/iio/dac/ad5791.c
> @@ -19,7 +19,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dac.h"
> +
>  #include "ad5791.h"
>  
>  static int ad5791_spi_write(struct spi_device *spi, u8 addr, u32 val)
