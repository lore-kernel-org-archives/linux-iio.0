Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277485024-10726-3-git-send-email-jic23@cam.ac.uk>
References: <1277485024-10726-1-git-send-email-jic23@cam.ac.uk>
	<1277485024-10726-2-git-send-email-jic23@cam.ac.uk> <1277485024-10726-3-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Jun 2010 14:34:09 +0800
Message-ID: <AANLkTilsodt3Wzir6tNNSG8Y98JQhLe7sh51IIfmVoWM@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging:iio: Add stubs for iio_ring_buffer_[un]register
	and equivalent driver stubs
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry.Song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Acked-by: Barry Song <21cnbao@gmail.com>

On Sat, Jun 26, 2010 at 12:57 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> ---
> =C2=A0drivers/staging/iio/accel/adis16209.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
11 -----------
> =C2=A0drivers/staging/iio/accel/adis16209_core.c | =C2=A0 =C2=A07 ++++---
> =C2=A0drivers/staging/iio/accel/adis16209_ring.c | =C2=A0 10 ----------
> =C2=A0drivers/staging/iio/accel/adis16240.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
11 -----------
> =C2=A0drivers/staging/iio/accel/adis16240_core.c | =C2=A0 =C2=A07 ++++---
> =C2=A0drivers/staging/iio/accel/adis16240_ring.c | =C2=A0 =C2=A09 -------=
--
> =C2=A0drivers/staging/iio/accel/lis3l02dq.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
=C2=A09 ---------
> =C2=A0drivers/staging/iio/accel/lis3l02dq_core.c | =C2=A0 =C2=A07 ++++---
> =C2=A0drivers/staging/iio/accel/lis3l02dq_ring.c | =C2=A0 10 ----------
> =C2=A0drivers/staging/iio/adc/max1363.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 13 -------------
> =C2=A0drivers/staging/iio/adc/max1363_core.c =C2=A0 =C2=A0 | =C2=A0 =C2=
=A04 ++--
> =C2=A0drivers/staging/iio/adc/max1363_ring.c =C2=A0 =C2=A0 | =C2=A0 10 --=
--------
> =C2=A0drivers/staging/iio/gyro/adis16260.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
11 -----------
> =C2=A0drivers/staging/iio/gyro/adis16260_core.c =C2=A0| =C2=A0 10 ++++---=
---
> =C2=A0drivers/staging/iio/gyro/adis16260_ring.c =C2=A0| =C2=A0 10 -------=
---
> =C2=A0drivers/staging/iio/imu/adis16300_core.c =C2=A0 | =C2=A0 =C2=A07 ++=
++---
> =C2=A0drivers/staging/iio/imu/adis16300_ring.c =C2=A0 | =C2=A0 =C2=A09 --=
-------
> =C2=A0drivers/staging/iio/imu/adis16350.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 20 --------------------
> =C2=A0drivers/staging/iio/imu/adis16350_core.c =C2=A0 | =C2=A0 =C2=A07 ++=
++---
> =C2=A0drivers/staging/iio/imu/adis16350_ring.c =C2=A0 | =C2=A0 =C2=A09 --=
-------
> =C2=A0drivers/staging/iio/imu/adis16400.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 11 -----------
> =C2=A0drivers/staging/iio/imu/adis16400_core.c =C2=A0 | =C2=A0 =C2=A07 ++=
++---
> =C2=A0drivers/staging/iio/imu/adis16400_ring.c =C2=A0 | =C2=A0 10 -------=
---
> =C2=A0drivers/staging/iio/ring_generic.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 11 +++++++++++
> =C2=A024 files changed, 41 insertions(+), 189 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/=
accel/adis16209.h
> index 877fd2a..a0f9efe 100644
> --- a/drivers/staging/iio/accel/adis16209.h
> +++ b/drivers/staging/iio/accel/adis16209.h
> @@ -150,8 +150,6 @@ ssize_t adis16209_read_data_from_ring(struct device *=
dev,
> =C2=A0int adis16209_configure_ring(struct iio_dev *indio_dev);
> =C2=A0void adis16209_unconfigure_ring(struct iio_dev *indio_dev);
>
> -int adis16209_initialize_ring(struct iio_ring_buffer *ring);
> -void adis16209_uninitialize_ring(struct iio_ring_buffer *ring);
> =C2=A0#else /* CONFIG_IIO_RING_BUFFER */
>
> =C2=A0static inline void adis16209_remove_trigger(struct iio_dev *indio_d=
ev)
> @@ -180,14 +178,5 @@ static inline void adis16209_unconfigure_ring(struct=
 iio_dev *indio_dev)
> =C2=A0{
> =C2=A0}
>
> -static inline int adis16209_initialize_ring(struct iio_ring_buffer *ring=
)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> -static inline void adis16209_uninitialize_ring(struct iio_ring_buffer *r=
ing)
> -{
> -}
> -
> =C2=A0#endif /* CONFIG_IIO_RING_BUFFER */
> =C2=A0#endif /* SPI_ADIS16209_H_ */
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging=
/iio/accel/adis16209_core.c
> index c696160..6c6923f 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -20,6 +20,7 @@
>
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> +#include "../ring_generic.h"
> =C2=A0#include "accel.h"
> =C2=A0#include "inclinometer.h"
> =C2=A0#include "../gyro/gyro.h"
> @@ -520,7 +521,7 @@ static int __devinit adis16209_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_initialize_ring(st->indio_dev->r=
ing);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "f=
ailed to initialize the ring\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> @@ -552,7 +553,7 @@ error_unregister_line:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(st->indio_dev, 0);
> =C2=A0error_uninitialize_ring:
> - =C2=A0 =C2=A0 =C2=A0 adis16209_uninitialize_ring(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0error_unreg_ring_funcs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16209_unconfigure_ring(st->indio_dev);
> =C2=A0error_free_dev:
> @@ -581,7 +582,7 @@ static int adis16209_remove(struct spi_device *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(indio_dev, 0);
>
> - =C2=A0 =C2=A0 =C2=A0 adis16209_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16209_unconfigure_ring(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging=
/iio/accel/adis16209_ring.c
> index 53a7677..0ed647f 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -224,13 +224,3 @@ error_iio_sw_rb_free:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_sw_rb_free(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> -
> -int adis16209_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> -}
> -
> -void adis16209_uninitialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> -}
> diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/=
accel/adis16240.h
> index dcff43c..a087697 100644
> --- a/drivers/staging/iio/accel/adis16240.h
> +++ b/drivers/staging/iio/accel/adis16240.h
> @@ -175,8 +175,6 @@ ssize_t adis16240_read_data_from_ring(struct device *=
dev,
> =C2=A0int adis16240_configure_ring(struct iio_dev *indio_dev);
> =C2=A0void adis16240_unconfigure_ring(struct iio_dev *indio_dev);
>
> -int adis16240_initialize_ring(struct iio_ring_buffer *ring);
> -void adis16240_uninitialize_ring(struct iio_ring_buffer *ring);
> =C2=A0#else /* CONFIG_IIO_RING_BUFFER */
>
> =C2=A0static inline void adis16240_remove_trigger(struct iio_dev *indio_d=
ev)
> @@ -205,14 +203,5 @@ static inline void adis16240_unconfigure_ring(struct=
 iio_dev *indio_dev)
> =C2=A0{
> =C2=A0}
>
> -static inline int adis16240_initialize_ring(struct iio_ring_buffer *ring=
)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> -static inline void adis16240_uninitialize_ring(struct iio_ring_buffer *r=
ing)
> -{
> -}
> -
> =C2=A0#endif /* CONFIG_IIO_RING_BUFFER */
> =C2=A0#endif /* SPI_ADIS16240_H_ */
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging=
/iio/accel/adis16240_core.c
> index ba336cb..3e9531d 100644
> --- a/drivers/staging/iio/accel/adis16240_core.c
> +++ b/drivers/staging/iio/accel/adis16240_core.c
> @@ -20,6 +20,7 @@
>
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> +#include "../ring_generic.h"
> =C2=A0#include "accel.h"
> =C2=A0#include "../adc/adc.h"
>
> @@ -502,7 +503,7 @@ static int __devinit adis16240_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_initialize_ring(st->indio_dev->r=
ing);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "f=
ailed to initialize the ring\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> @@ -534,7 +535,7 @@ error_unregister_line:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(st->indio_dev, 0);
> =C2=A0error_uninitialize_ring:
> - =C2=A0 =C2=A0 =C2=A0 adis16240_uninitialize_ring(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0error_unreg_ring_funcs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16240_unconfigure_ring(st->indio_dev);
> =C2=A0error_free_dev:
> @@ -563,7 +564,7 @@ static int adis16240_remove(struct spi_device *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(indio_dev, 0);
>
> - =C2=A0 =C2=A0 =C2=A0 adis16240_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16240_unconfigure_ring(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging=
/iio/accel/adis16240_ring.c
> index 88269a0..72ff2d3 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -213,12 +213,3 @@ error_iio_sw_rb_free:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> -int adis16240_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> -}
> -
> -void adis16240_uninitialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> -}
> diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/=
accel/lis3l02dq.h
> index 0ffa0bb..ffaeb9a 100644
> --- a/drivers/staging/iio/accel/lis3l02dq.h
> +++ b/drivers/staging/iio/accel/lis3l02dq.h
> @@ -195,8 +195,6 @@ ssize_t lis3l02dq_read_accel_from_ring(struct device =
*dev,
> =C2=A0int lis3l02dq_configure_ring(struct iio_dev *indio_dev);
> =C2=A0void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev);
>
> -int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring);
> -void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring);
> =C2=A0#else /* CONFIG_IIO_RING_BUFFER */
>
> =C2=A0static inline void lis3l02dq_remove_trigger(struct iio_dev *indio_d=
ev)
> @@ -222,12 +220,5 @@ static int lis3l02dq_configure_ring(struct iio_dev *=
indio_dev)
> =C2=A0static inline void lis3l02dq_unconfigure_ring(struct iio_dev *indio=
_dev)
> =C2=A0{
> =C2=A0}
> -static inline int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring=
)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -static inline void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *r=
ing)
> -{
> -}
> =C2=A0#endif /* CONFIG_IIO_RING_BUFFER */
> =C2=A0#endif /* SPI_LIS3L02DQ_H_ */
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging=
/iio/accel/lis3l02dq_core.c
> index 6b5577d..2ee8fbf 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -27,6 +27,7 @@
>
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> +#include "../ring_generic.h"
> =C2=A0#include "accel.h"
>
> =C2=A0#include "lis3l02dq.h"
> @@ -790,7 +791,7 @@ static int __devinit lis3l02dq_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D lis3l02dq_initialize_ring(st->indio_dev->r=
ing);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "f=
ailed to initialize the ring\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> @@ -834,7 +835,7 @@ error_unregister_line:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->modes & INDIO_RING_TRIGGERE=
D)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(st->indio_dev, 0);
> =C2=A0error_uninitialize_ring:
> - =C2=A0 =C2=A0 =C2=A0 lis3l02dq_uninitialize_ring(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0error_unreg_ring_funcs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0lis3l02dq_unconfigure_ring(st->indio_dev);
> =C2=A0error_free_dev:
> @@ -895,7 +896,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq && gpio_is_valid(irq_to_gpio(spi-=
>irq)) > 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(indio_dev, 0);
>
> - =C2=A0 =C2=A0 =C2=A0 lis3l02dq_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0lis3l02dq_unconfigure_ring(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging=
/iio/accel/lis3l02dq_ring.c
> index 28d95ed..a506dab 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -559,15 +559,5 @@ error_iio_sw_rb_free:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> -int lis3l02dq_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> -}
> -
> -void lis3l02dq_uninitialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> -}
> -
>
>
> diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/=
max1363.h
> index 6da468b..332a999 100644
> --- a/drivers/staging/iio/adc/max1363.h
> +++ b/drivers/staging/iio/adc/max1363.h
> @@ -230,26 +230,13 @@ int max1363_single_channel_from_ring(long mask, str=
uct max1363_state *st);
> =C2=A0int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)=
;
> =C2=A0void max1363_ring_cleanup(struct iio_dev *indio_dev);
>
> -int max1363_initialize_ring(struct iio_ring_buffer *ring);
> -void max1363_uninitialize_ring(struct iio_ring_buffer *ring);
> -
> =C2=A0#else /* CONFIG_MAX1363_RING_BUFFER */
>
> -static inline void max1363_uninitialize_ring(struct iio_ring_buffer *rin=
g)
> -{
> -}
> -
> -static inline int max1363_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> =C2=A0int max1363_single_channel_from_ring(long mask, struct max1363_stat=
e *st)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> =C2=A0}
>
> -
> =C2=A0static inline int
> =C2=A0max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> =C2=A0{
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio=
/adc/max1363_core.c
> index fc98014..e9cb0dd 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -991,7 +991,7 @@ static int __devinit max1363_probe(struct i2c_client =
*client,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_cleanup=
_ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
> - =C2=A0 =C2=A0 =C2=A0 ret =3D max1363_initialize_ring(st->indio_dev->rin=
g);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_cleanup=
_ring;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> @@ -1021,7 +1021,7 @@ static int max1363_remove(struct i2c_client *client=
)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct max1363_state *st =3D i2c_get_clientdat=
a(client);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D st->indio_dev;
> - =C2=A0 =C2=A0 =C2=A0 max1363_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0max1363_ring_cleanup(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->indio_dev->available_scan_masks);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio=
/adc/max1363_ring.c
> index 1e0ad9d..71d990c 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -223,13 +223,3 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(indio_dev->pollfunc);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_sw_rb_free(indio_dev->ring);
> =C2=A0}
> -
> -void max1363_uninitialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> -}
> -
> -int max1363_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> -}
> diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/g=
yro/adis16260.h
> index f19efb4..d4b07d0 100644
> --- a/drivers/staging/iio/gyro/adis16260.h
> +++ b/drivers/staging/iio/gyro/adis16260.h
> @@ -132,8 +132,6 @@ ssize_t adis16260_read_data_from_ring(struct device *=
dev,
> =C2=A0int adis16260_configure_ring(struct iio_dev *indio_dev);
> =C2=A0void adis16260_unconfigure_ring(struct iio_dev *indio_dev);
>
> -int adis16260_initialize_ring(struct iio_ring_buffer *ring);
> -void adis16260_uninitialize_ring(struct iio_ring_buffer *ring);
> =C2=A0#else /* CONFIG_IIO_RING_BUFFER */
>
> =C2=A0static inline void adis16260_remove_trigger(struct iio_dev *indio_d=
ev)
> @@ -162,14 +160,5 @@ static inline void adis16260_unconfigure_ring(struct=
 iio_dev *indio_dev)
> =C2=A0{
> =C2=A0}
>
> -static inline int adis16260_initialize_ring(struct iio_ring_buffer *ring=
)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> -static inline void adis16260_uninitialize_ring(struct iio_ring_buffer *r=
ing)
> -{
> -}
> -
> =C2=A0#endif /* CONFIG_IIO_RING_BUFFER */
> =C2=A0#endif /* SPI_ADIS16260_H_ */
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/=
iio/gyro/adis16260_core.c
> index f0246a4..134dfaa 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -20,6 +20,7 @@
>
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> +#include "../ring_generic.h"
> =C2=A0#include "../adc/adc.h"
> =C2=A0#include "gyro.h"
>
> @@ -555,8 +556,7 @@ static int __devinit adis16260_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
> -
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16260_initialize_ring(st->indio_dev->r=
ing);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "f=
ailed to initialize the ring\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> @@ -588,7 +588,7 @@ error_unregister_line:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(st->indio_dev, 0);
> =C2=A0error_uninitialize_ring:
> - =C2=A0 =C2=A0 =C2=A0 adis16260_uninitialize_ring(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0error_unreg_ring_funcs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16260_unconfigure_ring(st->indio_dev);
> =C2=A0error_free_dev:
> @@ -622,15 +622,13 @@ static int adis16260_remove(struct spi_device *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(indio_dev, 0);
>
> - =C2=A0 =C2=A0 =C2=A0 adis16260_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16260_unconfigure_ring(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->rx);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st);
>
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -
> =C2=A0err_ret:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/=
iio/gyro/adis16260_ring.c
> index 59f1beb..d6ca0e5 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -214,13 +214,3 @@ error_iio_sw_rb_free:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_sw_rb_free(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> -
> -int adis16260_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> -}
> -
> -void adis16260_uninitialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> -}
> diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/i=
io/imu/adis16300_core.c
> index 28667e8..f1950d5 100644
> --- a/drivers/staging/iio/imu/adis16300_core.c
> +++ b/drivers/staging/iio/imu/adis16300_core.c
> @@ -20,6 +20,7 @@
>
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> +#include "../ring_generic.h"
> =C2=A0#include "../accel/accel.h"
> =C2=A0#include "../accel/inclinometer.h"
> =C2=A0#include "../gyro/gyro.h"
> @@ -644,7 +645,7 @@ static int __devinit adis16300_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16300_initialize_ring(st->indio_dev->r=
ing);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "f=
ailed to initialize the ring\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> @@ -676,7 +677,7 @@ error_unregister_line:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(st->indio_dev, 0);
> =C2=A0error_uninitialize_ring:
> - =C2=A0 =C2=A0 =C2=A0 adis16300_uninitialize_ring(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0error_unreg_ring_funcs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16300_unconfigure_ring(st->indio_dev);
> =C2=A0error_free_dev:
> @@ -710,7 +711,7 @@ static int adis16300_remove(struct spi_device *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(indio_dev, 0);
>
> - =C2=A0 =C2=A0 =C2=A0 adis16300_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16300_unconfigure_ring(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/i=
io/imu/adis16300_ring.c
> index 64f02f5..5c8771c 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -240,12 +240,3 @@ error_iio_sw_rb_free:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> -int adis16300_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> -}
> -
> -void adis16300_uninitialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> -}
> diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/im=
u/adis16350.h
> index 334b18a..ecbce9f 100644
> --- a/drivers/staging/iio/imu/adis16350.h
> +++ b/drivers/staging/iio/imu/adis16350.h
> @@ -150,8 +150,6 @@ ssize_t adis16350_read_data_from_ring(struct device *=
dev,
> =C2=A0int adis16350_configure_ring(struct iio_dev *indio_dev);
> =C2=A0void adis16350_unconfigure_ring(struct iio_dev *indio_dev);
>
> -int adis16350_initialize_ring(struct iio_ring_buffer *ring);
> -void adis16350_uninitialize_ring(struct iio_ring_buffer *ring);
> =C2=A0#else /* CONFIG_IIO_RING_BUFFER */
>
> =C2=A0static inline void adis16350_remove_trigger(struct iio_dev *indio_d=
ev)
> @@ -171,23 +169,5 @@ adis16350_read_data_from_ring(struct device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> -static int adis16350_configure_ring(struct iio_dev *indio_dev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> -static inline void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
> -{
> -}
> -
> -static inline int adis16350_initialize_ring(struct iio_ring_buffer *ring=
)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> -static inline void adis16350_uninitialize_ring(struct iio_ring_buffer *r=
ing)
> -{
> -}
> -
> =C2=A0#endif /* CONFIG_IIO_RING_BUFFER */
> =C2=A0#endif /* SPI_ADIS16350_H_ */
> diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/i=
io/imu/adis16350_core.c
> index 0bb19a9..1575b7b 100644
> --- a/drivers/staging/iio/imu/adis16350_core.c
> +++ b/drivers/staging/iio/imu/adis16350_core.c
> @@ -20,6 +20,7 @@
>
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> +#include "../ring_generic.h"
> =C2=A0#include "../accel/accel.h"
> =C2=A0#include "../adc/adc.h"
> =C2=A0#include "../gyro/gyro.h"
> @@ -619,7 +620,7 @@ static int __devinit adis16350_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16350_initialize_ring(st->indio_dev->r=
ing);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "f=
ailed to initialize the ring\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> @@ -651,7 +652,7 @@ error_unregister_line:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(st->indio_dev, 0);
> =C2=A0error_uninitialize_ring:
> - =C2=A0 =C2=A0 =C2=A0 adis16350_uninitialize_ring(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0error_unreg_ring_funcs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16350_unconfigure_ring(st->indio_dev);
> =C2=A0error_free_dev:
> @@ -685,7 +686,7 @@ static int adis16350_remove(struct spi_device *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(indio_dev, 0);
>
> - =C2=A0 =C2=A0 =C2=A0 adis16350_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16350_unconfigure_ring(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/i=
io/imu/adis16350_ring.c
> index f817bfd..1372725 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -245,12 +245,3 @@ error_iio_sw_rb_free:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> -int adis16350_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> -}
> -
> -void adis16350_uninitialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> -}
> diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/im=
u/adis16400.h
> index 04bae36..10ea9a9 100644
> --- a/drivers/staging/iio/imu/adis16400.h
> +++ b/drivers/staging/iio/imu/adis16400.h
> @@ -180,8 +180,6 @@ ssize_t adis16400_read_data_from_ring(struct device *=
dev,
> =C2=A0int adis16400_configure_ring(struct iio_dev *indio_dev);
> =C2=A0void adis16400_unconfigure_ring(struct iio_dev *indio_dev);
>
> -int adis16400_initialize_ring(struct iio_ring_buffer *ring);
> -void adis16400_uninitialize_ring(struct iio_ring_buffer *ring);
> =C2=A0#else /* CONFIG_IIO_RING_BUFFER */
>
> =C2=A0static inline void adis16400_remove_trigger(struct iio_dev *indio_d=
ev)
> @@ -210,14 +208,5 @@ static inline void adis16400_unconfigure_ring(struct=
 iio_dev *indio_dev)
> =C2=A0{
> =C2=A0}
>
> -static inline int adis16400_initialize_ring(struct iio_ring_buffer *ring=
)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -
> -static inline void adis16400_uninitialize_ring(struct iio_ring_buffer *r=
ing)
> -{
> -}
> -
> =C2=A0#endif /* CONFIG_IIO_RING_BUFFER */
> =C2=A0#endif /* SPI_ADIS16400_H_ */
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/i=
io/imu/adis16400_core.c
> index a668a90..31c33af 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -27,6 +27,7 @@
>
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> +#include "../ring_generic.h"
> =C2=A0#include "../accel/accel.h"
> =C2=A0#include "../adc/adc.h"
> =C2=A0#include "../gyro/gyro.h"
> @@ -641,7 +642,7 @@ static int __devinit adis16400_probe(struct spi_devic=
e *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16400_initialize_ring(st->indio_dev->r=
ing);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "f=
ailed to initialize the ring\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> @@ -682,7 +683,7 @@ error_unregister_line:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (st->indio_dev->modes & INDIO_RING_TRIGGERE=
D)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(st->indio_dev, 0);
> =C2=A0error_uninitialize_ring:
> - =C2=A0 =C2=A0 =C2=A0 adis16400_uninitialize_ring(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0error_unreg_ring_funcs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16400_unconfigure_ring(st->indio_dev);
> =C2=A0error_free_dev:
> @@ -717,7 +718,7 @@ static int adis16400_remove(struct spi_device *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq && gpio_is_valid(irq_to_gpio(spi-=
>irq)) > 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_unregister_int=
errupt_line(indio_dev, 0);
>
> - =C2=A0 =C2=A0 =C2=A0 adis16400_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0adis16400_unconfigure_ring(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/i=
io/imu/adis16400_ring.c
> index e7881a0..1a1f2ca 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -251,13 +251,3 @@ error_iio_sw_rb_free:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_sw_rb_free(indio_dev->ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> -
> -int adis16400_initialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> -}
> -
> -void adis16400_uninitialize_ring(struct iio_ring_buffer *ring)
> -{
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> -}
> diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/rin=
g_generic.h
> index 0e44375..dbf11e1 100644
> --- a/drivers/staging/iio/ring_generic.h
> +++ b/drivers/staging/iio/ring_generic.h
> @@ -11,6 +11,8 @@
> =C2=A0#define _IIO_RING_GENERIC_H_
> =C2=A0#include "iio.h"
>
> +#ifdef CONFIG_IIO_RING_BUFFER
> +
> =C2=A0struct iio_handler;
> =C2=A0struct iio_ring_buffer;
> =C2=A0struct iio_dev;
> @@ -287,5 +289,14 @@ ssize_t iio_show_ring_enable(struct device *dev,
> =C2=A0#define IIO_RING_ENABLE_ATTR DEVICE_ATTR(ring_enable, S_IRUGO | S_I=
WUSR, \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_show=
_ring_enable, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_stor=
e_ring_enable)
> +#else /* CONFIG_IIO_RING_BUFFER */
> +static inline int iio_ring_buffer_register(struct iio_ring_buffer *ring,=
 int id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +};
> +static inline void iio_ring_buffer_unregister(struct iio_ring_buffer *ri=
ng)
> +{};
> +
> +#endif /* CONFIG_IIO_RING_BUFFER */
>
> =C2=A0#endif /* _IIO_RING_GENERIC_H_ */
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
