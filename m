Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43028 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942046AbdAHJsi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:38 -0500
Subject: Re: [PATCH 07/11] iio:kfifo_buf header include push down.
To: linux-iio@vger.kernel.org
References: <20170102192834.26546-1-jic23@kernel.org>
 <20170102192834.26546-8-jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9121d0d5-52df-4423-d6f5-e39627f28b77@kernel.org>
Date: Sat, 7 Jan 2017 16:52:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170102192834.26546-8-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/17 14:28, Jonathan Cameron wrote:
> As a precursor to splitting buffer.h, lets make sure all drivers
> include the relevant headers rather than relying on picking them
> up from kfifo_buf.h.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
slight mess up in this one. Kfifo_buf.c needs to include buffer.h for now
or it won't build.

Fixed up during applying.
> ---
>  drivers/iio/accel/ssp_accel_sensor.c        | 1 +
>  drivers/iio/adc/ina2xx-adc.c                | 2 ++
>  drivers/iio/common/ssp_sensors/ssp_iio.c    | 1 +
>  drivers/iio/dummy/iio_simple_dummy_buffer.c | 1 +
>  drivers/iio/gyro/ssp_gyro_sensor.c          | 1 +
>  drivers/staging/iio/meter/ade7758_ring.c    | 1 +
>  include/linux/iio/kfifo_buf.h               | 5 ++---
>  7 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
> index 31db00970fa0..6b54008e29c7 100644
> --- a/drivers/iio/accel/ssp_accel_sensor.c
> +++ b/drivers/iio/accel/ssp_accel_sensor.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/iio/common/ssp_sensors.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 59b7d76e1ad2..3263231276ca 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -22,6 +22,8 @@
>  
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/kthread.h>
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> index a3ae165f8d9f..645f2e3975db 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> @@ -14,6 +14,7 @@
>   */
>  
>  #include <linux/iio/common/ssp_sensors.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index b383892a5193..26bddb2464b7 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
>  
>  #include "iio_simple_dummy.h"
> diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
> index 1f25f406c545..33a7f0a94ce5 100644
> --- a/drivers/iio/gyro/ssp_gyro_sensor.c
> +++ b/drivers/iio/gyro/ssp_gyro_sensor.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/iio/common/ssp_sensors.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> index 57c213dfadcc..6d7444d6e880 100644
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ b/drivers/staging/iio/meter/ade7758_ring.c
> @@ -13,6 +13,7 @@
>  #include <asm/unaligned.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include "ade7758.h"
> diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
> index 1683bc710d14..027cfa9c3703 100644
> --- a/include/linux/iio/kfifo_buf.h
> +++ b/include/linux/iio/kfifo_buf.h
> @@ -1,9 +1,8 @@
>  #ifndef __LINUX_IIO_KFIFO_BUF_H__
>  #define __LINUX_IIO_KFIFO_BUF_H__
>  
> -#include <linux/kfifo.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/buffer.h>
> +struct iio_buffer;
> +struct device;
>  
>  struct iio_buffer *iio_kfifo_allocate(void);
>  void iio_kfifo_free(struct iio_buffer *r);
> 

