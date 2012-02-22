Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57045 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab2BVGYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2012 01:24:54 -0500
Received: by vbjk17 with SMTP id k17so4727387vbj.19
        for <linux-iio@vger.kernel.org>; Tue, 21 Feb 2012 22:24:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1329763025-29730-1-git-send-email-lars@metafoo.de>
References: <1329763025-29730-1-git-send-email-lars@metafoo.de>
Date: Wed, 22 Feb 2012 11:54:53 +0530
Message-ID: <CAM=Q2cvf0cdaNnM5+foT5hnrf4RuTcQ8Scf19dLd2se-ifaJ4Q@mail.gmail.com>
Subject: Re: [PATCH] staging:iio: Use dev_pm_ops
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,


On Tue, Feb 21, 2012 at 12:07 AM, Lars-Peter Clausen <lars@metafoo.de> =
wrote:
> Use dev_pm_ops instead of legacy suspend/resume callbacks for IIO dri=
vers.
>
> Note that this patch introduces a few new #ifdef CONFIG_PM_SLEEP arou=
nd the
> suspend and resume callbacks to avoid warnings of unused functions if
> CONFIG_PM_SLEEP is not defined.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
> Mostly only compile tested (With CONFIG_PM_SLEEP and without CONFIG_P=
M_SLEEP
> though).
> ---
> =A0drivers/staging/iio/addac/adt7316-i2c.c =A0 =A0| =A0 18 +---------=
--------
> =A0drivers/staging/iio/addac/adt7316-spi.c =A0 =A0| =A0 18 +---------=
--------
> =A0drivers/staging/iio/addac/adt7316.c =A0 =A0 =A0 =A0| =A0 11 ++++++=
-----
> =A0drivers/staging/iio/addac/adt7316.h =A0 =A0 =A0 =A0| =A0 =A09 ++++=
++---
> =A0drivers/staging/iio/dac/max517.c =A0 =A0 =A0 =A0 =A0 | =A0 18 ++++=
++++++++------
> =A0drivers/staging/iio/light/tsl2563.c =A0 =A0 =A0 =A0| =A0 26 ++++++=
++++++++++----------
> =A0drivers/staging/iio/light/tsl2583.c =A0 =A0 =A0 =A0| =A0 17 ++++++=
+++++------
> =A0drivers/staging/iio/magnetometer/hmc5843.c | =A0 20 +++++++++++++-=
------
> =A08 files changed, 66 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/stagin=
g/iio/addac/adt7316-i2c.c
> index 2c03a39..9e128dd 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -125,30 +125,14 @@ static const struct i2c_device_id adt7316_i2c_i=
d[] =3D {
>
> =A0MODULE_DEVICE_TABLE(i2c, adt7316_i2c_id);
>
> -#ifdef CONFIG_PM
> -static int adt7316_i2c_suspend(struct i2c_client *client, pm_message=
_t message)
> -{
> - =A0 =A0 =A0 return adt7316_disable(&client->dev);
> -}
> -
> -static int adt7316_i2c_resume(struct i2c_client *client)
> -{
> - =A0 =A0 =A0 return adt7316_enable(&client->dev);
> -}
> -#else
> -# define adt7316_i2c_suspend NULL
> -# define adt7316_i2c_resume =A0NULL
> -#endif
> -
> =A0static struct i2c_driver adt7316_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "adt7316",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D ADT7316_PM_OPS,
Could  we use simple dev pm ops here?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =3D adt7316_i2c_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adt7316_i2c_remove),
> - =A0 =A0 =A0 .suspend =3D adt7316_i2c_suspend,
> - =A0 =A0 =A0 .resume =3D adt7316_i2c_resume,
> =A0 =A0 =A0 =A0.id_table =3D adt7316_i2c_id,
> =A0};
> =A0module_i2c_driver(adt7316_driver);
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/stagin=
g/iio/addac/adt7316-spi.c
> index 1ea3cd0..985f7d8 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -133,30 +133,14 @@ static const struct spi_device_id adt7316_spi_i=
d[] =3D {
>
> =A0MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
>
> -#ifdef CONFIG_PM
> -static int adt7316_spi_suspend(struct spi_device *spi_dev, pm_messag=
e_t message)
> -{
> - =A0 =A0 =A0 return adt7316_disable(&spi_dev->dev);
> -}
> -
> -static int adt7316_spi_resume(struct spi_device *spi_dev)
> -{
> - =A0 =A0 =A0 return adt7316_enable(&spi_dev->dev);
> -}
> -#else
> -# define adt7316_spi_suspend NULL
> -# define adt7316_spi_resume =A0NULL
> -#endif
> -
> =A0static struct spi_driver adt7316_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "adt7316",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D ADT7316_PM_OPS,

Could  we use simple dev pm ops here?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =3D adt7316_spi_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adt7316_spi_remove),
> - =A0 =A0 =A0 .suspend =3D adt7316_spi_suspend,
> - =A0 =A0 =A0 .resume =3D adt7316_spi_resume,
> =A0 =A0 =A0 =A0.id_table =3D adt7316_spi_id,
> =A0};
> =A0module_spi_driver(adt7316_driver);
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/ii=
o/addac/adt7316.c
> index 13c3929..fd6a454 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2089,24 +2089,25 @@ static struct attribute_group adt7516_event_a=
ttribute_group =3D {
> =A0 =A0 =A0 =A0.name =3D "events",
> =A0};
>
> -#ifdef CONFIG_PM
> -int adt7316_disable(struct device *dev)
> +#ifdef CONFIG_PM_SLEEP
> +static int adt7316_disable(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> =A0 =A0 =A0 =A0struct adt7316_chip_info *chip =3D iio_priv(dev_info);
>
> =A0 =A0 =A0 =A0return _adt7316_store_enabled(chip, 0);
> =A0}
> -EXPORT_SYMBOL(adt7316_disable);
>
> -int adt7316_enable(struct device *dev)
> +static int adt7316_enable(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> =A0 =A0 =A0 =A0struct adt7316_chip_info *chip =3D iio_priv(dev_info);
>
> =A0 =A0 =A0 =A0return _adt7316_store_enabled(chip, 1);
> =A0}
> -EXPORT_SYMBOL(adt7316_enable);
> +
> +SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
> +EXPORT_SYMBOL_GPL(adt7316_pm_ops);
> =A0#endif
>
> =A0static const struct iio_info adt7316_info =3D {
> diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/ii=
o/addac/adt7316.h
> index d34bd67..4d3efff 100644
> --- a/drivers/staging/iio/addac/adt7316.h
> +++ b/drivers/staging/iio/addac/adt7316.h
> @@ -10,6 +10,7 @@
> =A0#define _ADT7316_H_
>
> =A0#include <linux/types.h>
> +#include <linux/pm.h>
>
> =A0#define ADT7316_REG_MAX_ADDR =A0 =A0 =A0 =A0 =A0 0x3F
>
> @@ -23,9 +24,11 @@ struct adt7316_bus {
> =A0 =A0 =A0 =A0int (*multi_write) (void *client, u8 first_reg, u8 cou=
nt, u8 *data);
> =A0};
>
> -#ifdef CONFIG_PM
> -int adt7316_disable(struct device *dev);
> -int adt7316_enable(struct device *dev);
> +#ifdef CONFIG_PM_SLEEP
> +extern const struct dev_pm_ops adt7316_pm_ops;
> +#define ADT7316_PM_OPS (&adt7316_pm_ops)
> +#else
> +#define ADT7316_PM_OPS NULL
> =A0#endif
> =A0int adt7316_probe(struct device *dev, struct adt7316_bus *bus, con=
st char *name);
> =A0int adt7316_remove(struct device *dev);
> diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/d=
ac/max517.c
> index a4df6d7..41483c7 100644
> --- a/drivers/staging/iio/dac/max517.c
> +++ b/drivers/staging/iio/dac/max517.c
> @@ -179,20 +179,27 @@ static struct attribute_group max518_attribute_=
group =3D {
> =A0 =A0 =A0 =A0.attrs =3D max518_attributes,
> =A0};
>
> -static int max517_suspend(struct i2c_client *client, pm_message_t me=
sg)
> +#ifdef CONFIG_PM_SLEEP
> +static int max517_suspend(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0u8 outbuf =3D COMMAND_PD;
>
> - =A0 =A0 =A0 return i2c_master_send(client, &outbuf, 1);
> + =A0 =A0 =A0 return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
> =A0}
>
> -static int max517_resume(struct i2c_client *client)
> +static int max517_resume(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0u8 outbuf =3D 0;
>
> - =A0 =A0 =A0 return i2c_master_send(client, &outbuf, 1);
> + =A0 =A0 =A0 return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
> =A0}
>
> +static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resum=
e);
> +#define MAX517_PM_OPS (&max517_pm_ops)
> +#else
> +#define MAX517_PM_OPS NULL
> +#endif
> +
> =A0static const struct iio_info max517_info =3D {
> =A0 =A0 =A0 =A0.attrs =3D &max517_attribute_group,
> =A0 =A0 =A0 =A0.driver_module =3D THIS_MODULE,
> @@ -273,11 +280,10 @@ MODULE_DEVICE_TABLE(i2c, max517_id);
> =A0static struct i2c_driver max517_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D MAX517_DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D MAX517_=
PM_OPS,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D max517_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D max517_remove,
> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D max517_suspend,
> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D max517_resume,
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D max517_id,
> =A0};
> =A0module_i2c_driver(max517_driver);
> diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/ii=
o/light/tsl2563.c
> index ffca85e..aca1e03 100644
> --- a/drivers/staging/iio/light/tsl2563.c
> +++ b/drivers/staging/iio/light/tsl2563.c
> @@ -118,7 +118,7 @@ struct tsl2563_chip {
> =A0 =A0 =A0 =A0struct delayed_work =A0 =A0 poweroff_work;
>
> =A0 =A0 =A0 =A0/* Remember state for suspend and resume functions */
> - =A0 =A0 =A0 pm_message_t =A0 =A0 =A0 =A0 =A0 =A0state;
> + =A0 =A0 =A0 bool suspended;
>
> =A0 =A0 =A0 =A0struct tsl2563_gainlevel_coeff const *gainlevel;
>
> @@ -315,7 +315,7 @@ static int tsl2563_get_adc(struct tsl2563_chip *c=
hip)
> =A0 =A0 =A0 =A0int retry =3D 1;
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> - =A0 =A0 =A0 if (chip->state.event !=3D PM_EVENT_ON)
> + =A0 =A0 =A0 if (chip->suspended)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> =A0 =A0 =A0 =A0if (!chip->int_enabled) {
> @@ -810,9 +810,10 @@ static int tsl2563_remove(struct i2c_client *cli=
ent)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int tsl2563_suspend(struct i2c_client *client, pm_message_t s=
tate)
> +#ifdef CONFIG_PM_SLEEP
> +static int tsl2563_suspend(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct tsl2563_chip *chip =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct tsl2563_chip *chip =3D i2c_get_clientdata(to_i2c=
_client(dev));
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0mutex_lock(&chip->lock);
> @@ -821,16 +822,16 @@ static int tsl2563_suspend(struct i2c_client *c=
lient, pm_message_t state)
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 chip->state =3D state;
> + =A0 =A0 =A0 chip->suspended =3D true;
>
> =A0out:
> =A0 =A0 =A0 =A0mutex_unlock(&chip->lock);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static int tsl2563_resume(struct i2c_client *client)
> +static int tsl2563_resume(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct tsl2563_chip *chip =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct tsl2563_chip *chip =3D i2c_get_clientdata(to_i2c=
_client(dev));
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0mutex_lock(&chip->lock);
> @@ -843,13 +844,19 @@ static int tsl2563_resume(struct i2c_client *cl=
ient)
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 chip->state.event =3D PM_EVENT_ON;
> + =A0 =A0 =A0 chip->suspended =3D false;
>
> =A0out:
> =A0 =A0 =A0 =A0mutex_unlock(&chip->lock);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +static SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend, tsl2563_re=
sume);
> +#define TSL2563_PM_OPS (&tsl2563_pm_ops)
> +#else
> +#define TSL2563_PM_OPS NULL
> +#endif
> +
> =A0static const struct i2c_device_id tsl2563_id[] =3D {
> =A0 =A0 =A0 =A0{ "tsl2560", 0 },
> =A0 =A0 =A0 =A0{ "tsl2561", 1 },
> @@ -862,9 +869,8 @@ MODULE_DEVICE_TABLE(i2c, tsl2563_id);
> =A0static struct i2c_driver tsl2563_i2c_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0=3D "tsl2563",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D TSL2563_PM_OPS,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D tsl2563_suspend,
> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D tsl2563_resume,
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D tsl2563_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(tsl2563_remove=
),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D tsl2563_id,
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/ii=
o/light/tsl2583.c
> index 5b6455a..9fe9a67 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -884,9 +884,10 @@ fail2:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static int taos_suspend(struct i2c_client *client, pm_message_t stat=
e)
> +#ifdef CONFIG_PM_SLEEP
> +static int taos_suspend(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct iio_dev *indio_dev =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c=
_client(dev));
> =A0 =A0 =A0 =A0struct tsl2583_chip *chip =3D iio_priv(indio_dev);
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> @@ -901,9 +902,9 @@ static int taos_suspend(struct i2c_client *client=
, pm_message_t state)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static int taos_resume(struct i2c_client *client)
> +static int taos_resume(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct iio_dev *indio_dev =3D i2c_get_clientdata(client=
);
> + =A0 =A0 =A0 struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c=
_client(dev));
> =A0 =A0 =A0 =A0struct tsl2583_chip *chip =3D iio_priv(indio_dev);
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> @@ -916,6 +917,11 @@ static int taos_resume(struct i2c_client *client=
)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
> +#define TAOS_PM_OPS (&taos_pm_ops)
> +#else
> +#define TAOS_PM_OPS NULL
> +#endif
>
> =A0static int __devexit taos_remove(struct i2c_client *client)
> =A0{
> @@ -937,10 +943,9 @@ MODULE_DEVICE_TABLE(i2c, taos_idtable);
> =A0static struct i2c_driver taos_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "tsl2583",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D TAOS_PM_OPS,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.id_table =3D taos_idtable,
> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D taos_suspend,
> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D taos_resume,
> =A0 =A0 =A0 =A0.probe =3D taos_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(taos_remove),
> =A0};
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/sta=
ging/iio/magnetometer/hmc5843.c
> index f2e85a9..d24992c 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -588,19 +588,26 @@ static int hmc5843_remove(struct i2c_client *cl=
ient)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int hmc5843_suspend(struct i2c_client *client, pm_message_t m=
esg)
> +#ifdef CONFIG_PM_SLEEP
> +static int hmc5843_suspend(struct device *dev)
> =A0{
> - =A0 =A0 =A0 hmc5843_configure(client, MODE_SLEEP);
> + =A0 =A0 =A0 hmc5843_configure(to_i2c_client(dev), MODE_SLEEP);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int hmc5843_resume(struct i2c_client *client)
> +static int hmc5843_resume(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct hmc5843_data *data =3D i2c_get_clientdata(client=
);
> - =A0 =A0 =A0 hmc5843_configure(client, data->operating_mode);
> + =A0 =A0 =A0 struct hmc5843_data *data =3D i2c_get_clientdata(to_i2c=
_client(dev));
> + =A0 =A0 =A0 hmc5843_configure(to_i2c_client(dev), data->operating_m=
ode);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops, hmc5843_suspend, hmc5843_re=
sume);
> +#define HMC5843_PM_OPS (&hmc5843_pm_ops)
> +#else
> +#define HMC5843_PM_OPS NULL
> +#endif
> +
> =A0static const struct i2c_device_id hmc5843_id[] =3D {
> =A0 =A0 =A0 =A0{ "hmc5843", 0 },
> =A0 =A0 =A0 =A0{ }
> @@ -610,14 +617,13 @@ MODULE_DEVICE_TABLE(i2c, hmc5843_id);
> =A0static struct i2c_driver hmc5843_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "hmc5843",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D HMC5843_PM_OPS,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D hmc5843_id,
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D hmc5843_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D hmc5843_remove,
> =A0 =A0 =A0 =A0.detect =A0 =A0 =A0 =A0 =3D hmc5843_detect,
> =A0 =A0 =A0 =A0.address_list =A0 =3D normal_i2c,
> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D hmc5843_suspend,
> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D hmc5843_resume,
> =A0};
> =A0module_i2c_driver(hmc5843_driver);
>
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
