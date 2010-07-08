Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277914075-14762-2-git-send-email-jic23@cam.ac.uk>
References: <1277914075-14762-1-git-send-email-jic23@cam.ac.uk>
	<1277914075-14762-2-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 8 Jul 2010 17:37:36 +0800
Message-ID: <AANLkTiknA_De-zqjjOS_1d8Fkm_PXMJCiZjurGEMpQsk@mail.gmail.com>
Subject: Re: [PATCH 5/5 v2] staging:iio:adis16209 use iio_sw_ring_helper_state
	and funcs
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 1, 2010 at 12:07 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> =C2=A0Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Thanks very much. Has this one been tested? If so,
Acked-by: Barry Song <21cnbao@gmail.com>.
And I will send related patches for other drivers too.
-barry
> ---
>
> =C2=A0The get element fuction should return how much of the buffer it has
> =C2=A0used. =C2=A0Now it actually does this.
>
> =C2=A0drivers/staging/iio/accel/adis16209.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A07 ++-
> =C2=A0drivers/staging/iio/accel/adis16209_core.c =C2=A0 =C2=A0| =C2=A0 54=
 +++++++++++----------
> =C2=A0drivers/staging/iio/accel/adis16209_ring.c =C2=A0 =C2=A0| =C2=A0 65=
 ++++++-------------------
> =C2=A0drivers/staging/iio/accel/adis16209_trigger.c | =C2=A0 =C2=A08 ++-
> =C2=A04 files changed, 53 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/=
accel/adis16209.h
> index 92daf6f..84e1a2f 100644
> --- a/drivers/staging/iio/accel/adis16209.h
> +++ b/drivers/staging/iio/accel/adis16209.h
> @@ -113,16 +113,17 @@
> =C2=A0* @buf_lock: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex to protect tx =
and rx
> =C2=A0**/
> =C2=A0struct adis16209_state {
> + =C2=A0 =C2=A0 =C2=A0 struct iio_sw_ring_helper_state help;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *us;
> - =C2=A0 =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0work_trigger_to_ring;
> - =C2=A0 =C2=A0 =C2=A0 s64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_timestamp;
> - =C2=A0 =C2=A0 =C2=A0 struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*indio_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_trigger =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0*trig;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*tx;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*rx;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_lock;
> =C2=A0};
>
> +#define adis16209_h_to_s(_h) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 container_of(_h, struct adis16209_state, help)
> +
> =C2=A0int adis16209_set_irq(struct device *dev, bool enable);
>
> =C2=A0#ifdef CONFIG_IIO_RING_BUFFER
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging=
/iio/accel/adis16209_core.c
> index 6c6923f..9c7aafe 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -21,6 +21,7 @@
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> =C2=A0#include "../ring_generic.h"
> +#include "../ring_sw.h"
> =C2=A0#include "accel.h"
> =C2=A0#include "inclinometer.h"
> =C2=A0#include "../gyro/gyro.h"
> @@ -44,7 +45,8 @@ static int adis16209_spi_write_reg_8(struct device *dev=
,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> - =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata=
(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_sw_ring_helper_state *h =3D iio_dev_get=
_devdata(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D adis16209_h_to_s(h)=
;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&st->buf_lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->tx[0] =3D ADIS16209_WRITE_REG(reg_address)=
;
> @@ -70,7 +72,8 @@ static int adis16209_spi_write_reg_16(struct device *de=
v,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message msg;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> - =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata=
(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_sw_ring_helper_state *h =3D iio_dev_get=
_devdata(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D adis16209_h_to_s(h)=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer xfers[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.tx_buf =3D st->tx,
> @@ -115,7 +118,8 @@ static int adis16209_spi_read_reg_16(struct device *d=
ev,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_message msg;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> - =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata=
(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_sw_ring_helper_state *h =3D iio_dev_get=
_devdata(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D adis16209_h_to_s(h)=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer xfers[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> @@ -355,7 +359,7 @@ err_ret:
> =C2=A0static int adis16209_initial_setup(struct adis16209_state *st)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> - =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D &st->indio_dev->dev;
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D &st->help.indio_dev->dev;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Disable IRQ */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D adis16209_set_irq(dev, false);
> @@ -498,30 +502,30 @@ static int __devinit adis16209_probe(struct spi_dev=
ice *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->us =3D spi;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&st->buf_lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* setup the industrialio driver allocated ele=
ments */
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev =3D iio_allocate_device();
> - =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev =3D iio_allocate_device();
> + =C2=A0 =C2=A0 =C2=A0 if (st->help.indio_dev =3D=3D NULL) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOMEM;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_free_tx=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->dev.parent =3D &spi->dev;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->num_interrupt_lines =3D 1;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->event_attrs =3D &adis16209_event_at=
tribute_group;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->attrs =3D &adis16209_attribute_grou=
p;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->dev_data =3D (void *)(st);
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->driver_module =3D THIS_MODULE;
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->modes =3D INDIO_DIRECT_MODE;
> + =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev->dev.parent =3D &spi->dev;
> + =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev->num_interrupt_lines =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev->event_attrs =3D &adis16209_eve=
nt_attribute_group;
> + =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev->attrs =3D &adis16209_attribute=
_group;
> + =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev->dev_data =3D (void *)(&st->hel=
p);
> + =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev->driver_module =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev->modes =3D INDIO_DIRECT_MODE;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_configure_ring(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_configure_ring(st->help.indio_de=
v);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_free_de=
v;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D iio_device_register(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_device_register(st->help.indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regdone =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->indio_dev->ri=
ng, 0);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_ring_buffer_register(st->help.indio_de=
v->ring, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "f=
ailed to initialize the ring\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreg_r=
ing_funcs;
> @@ -529,14 +533,14 @@ static int __devinit adis16209_probe(struct spi_dev=
ice *spi)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_regist=
er_interrupt_line(spi->irq,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->indio_dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->help.indio_dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IRQF_TRIGGER_RISING,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"adis16209");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto error_uninitialize_ring;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_prob=
e_trigger(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_prob=
e_trigger(st->help.indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto error_unregister_line;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -548,19 +552,19 @@ static int __devinit adis16209_probe(struct spi_dev=
ice *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> =C2=A0error_remove_trigger:
> - =C2=A0 =C2=A0 =C2=A0 adis16209_remove_trigger(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 adis16209_remove_trigger(st->help.indio_dev);
> =C2=A0error_unregister_line:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spi->irq)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_unregister_interru=
pt_line(st->indio_dev, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_unregister_interru=
pt_line(st->help.indio_dev, 0);
> =C2=A0error_uninitialize_ring:
> - =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(st->help.indio_dev->rin=
g);
> =C2=A0error_unreg_ring_funcs:
> - =C2=A0 =C2=A0 =C2=A0 adis16209_unconfigure_ring(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 adis16209_unconfigure_ring(st->help.indio_dev);
> =C2=A0error_free_dev:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (regdone)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(=
st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(=
st->help.indio_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_free_device(st->in=
dio_dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_free_device(st->he=
lp.indio_dev);
> =C2=A0error_free_tx:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(st->tx);
> =C2=A0error_free_rx:
> @@ -574,7 +578,7 @@ error_ret:
> =C2=A0static int adis16209_remove(struct spi_device *spi)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16209_state *st =3D spi_get_drvdata=
(spi);
> - =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->help.indio_dev;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_scheduled_work();
>
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging=
/iio/accel/adis16209_ring.c
> index 25fde65..bb2389e 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -55,17 +55,6 @@ static struct attribute_group adis16209_scan_el_group =
=3D {
> =C2=A0};
>
> =C2=A0/**
> - * adis16209_poll_func_th() top half interrupt handler called by trigger
> - * @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> - **/
> -static void adis16209_poll_func_th(struct iio_dev *indio_dev, s64 time)
> -{
> - =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D iio_dev_get_devdata=
(indio_dev);
> - =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D time;
> - =C2=A0 =C2=A0 =C2=A0 schedule_work(&st->work_trigger_to_ring);
> -}
> -
> -/**
> =C2=A0* adis16209_read_ring_data() read data registers which will be plac=
ed into ring
> =C2=A0* @dev: device associated with child of actual device (iio_dev or i=
io_trig)
> =C2=A0* @rx: somewhere to pass back the value read
> @@ -107,44 +96,20 @@ static int adis16209_read_ring_data(struct device *d=
ev, u8 *rx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> -/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to =
device
> - * specific to be rolled into the core.
> - */
> -static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
> +static int adis16209_get_ring_element(struct iio_sw_ring_helper_state *h=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 *buf)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D container_of(work_=
s, struct adis16209_state,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0work_trigger_to_ring);
> -
> - =C2=A0 =C2=A0 =C2=A0 int i =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 s16 *data;
> - =C2=A0 =C2=A0 =C2=A0 size_t datasize =3D st->indio_dev
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ring->access.get_bpd=
(st->indio_dev->ring);
> -
> - =C2=A0 =C2=A0 =C2=A0 data =3D kmalloc(datasize , GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (data =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&st->us->dev, =
"memory alloc failed in ring bh");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev->scan_count)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adis16209_read_rin=
g_data(&st->indio_dev->dev, st->rx) >=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (; i < st->indio_dev->scan_count; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D be16_to_cpup(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (__be16 *)&(=
st->rx[i*2]));
> -
> - =C2=A0 =C2=A0 =C2=A0 /* Guaranteed to be aligned with 8 byte boundary *=
/
> - =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev->scan_timestamp)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((s64 *)(data + ((i +=
 3)/4)*4)) =3D st->last_timestamp;
> + =C2=A0 =C2=A0 =C2=A0 int i, ret;
> + =C2=A0 =C2=A0 =C2=A0 s16 *data =3D (s16 *)buf;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D adis16209_h_to_s(h)=
;
>
> - =C2=A0 =C2=A0 =C2=A0 st->indio_dev->ring->access.store_to(st->indio_dev=
->ring,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (u8 *)data,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 st->last_timestamp);
> -
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_notify_done(st->indio_dev->trig);
> - =C2=A0 =C2=A0 =C2=A0 kfree(data);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_read_ring_data(&h->indio_dev->de=
v, st->rx);
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < h->indio_dev->scan_count; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D be16_to_cp=
up((__be16 *)&(st->rx[i*2]));
>
> - =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 return i*sizeof(data[0]);
> =C2=A0}
>
> =C2=A0void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
> @@ -156,11 +121,11 @@ void adis16209_unconfigure_ring(struct iio_dev *ind=
io_dev)
> =C2=A0int adis16209_configure_ring(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D indio_dev->dev_data=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_ring_buffer *ring;
> - =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&st->work_trigger_to_ring, adis16209_tri=
gger_bh_to_ring);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_sw_ring_helper_state *h =3D iio_dev_get=
_devdata(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&h->work_trigger_to_ring, iio_sw_trigger=
_bh_to_ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set default scan mode */
> -
> + =C2=A0 =C2=A0 =C2=A0 h->get_ring_element =3D &adis16209_get_ring_elemen=
t;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_scan_mask_set(indio_dev, iio_scan_el_suppl=
y.number);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_scan_mask_set(indio_dev, iio_scan_el_rot.n=
umber);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_scan_mask_set(indio_dev, iio_scan_el_accel=
_x.number);
> @@ -187,7 +152,7 @@ int adis16209_configure_ring(struct iio_dev *indio_de=
v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->predisable =3D &iio_triggered_ring_predi=
sable;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ring->owner =3D THIS_MODULE;
>
> - =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &adis1=
6209_poll_func_th);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_alloc_pollfunc(indio_dev, NULL, &iio_s=
w_poll_func_th);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_iio_sw_=
rb_free;
>
> diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/stag=
ing/iio/accel/adis16209_trigger.c
> index 1487eff..51cdf4a 100644
> --- a/drivers/staging/iio/accel/adis16209_trigger.c
> +++ b/drivers/staging/iio/accel/adis16209_trigger.c
> @@ -10,6 +10,7 @@
> =C2=A0#include "../iio.h"
> =C2=A0#include "../sysfs.h"
> =C2=A0#include "../trigger.h"
> +#include "../ring_sw.h"
> =C2=A0#include "adis16209.h"
>
> =C2=A0/**
> @@ -48,11 +49,11 @@ static int adis16209_data_rdy_trigger_set_state(struc=
t iio_trigger *trig,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bool state)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16209_state *st =3D trig->private_d=
ata;
> - =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->help.indio_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__=
, state);
> - =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_set_irq(&st->indio_dev->dev, sta=
te);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16209_set_irq(&indio_dev->dev, state);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (state =3D=3D false) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iio_remove_event_f=
rom_list(&iio_event_data_rdy_trig,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
indio_dev->interrupts[0]
> @@ -79,7 +80,8 @@ static int adis16209_trig_try_reen(struct iio_trigger *=
trig)
> =C2=A0int adis16209_probe_trigger(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> - =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D indio_dev->dev_data=
;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_sw_ring_helper_state *h =3D iio_dev_get=
_devdata(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct adis16209_state *st =3D adis16209_h_to_s(h)=
;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->trig =3D iio_allocate_trigger();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0st->trig->name =3D kasprintf(GFP_KERNEL,
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
