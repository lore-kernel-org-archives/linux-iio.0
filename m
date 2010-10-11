Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>
Date: Mon, 11 Oct 2010 16:56:25 +0100
Subject: RE: [PATCH] staging: iio: adc: ad7476 new SPI ADC driver
Message-ID: <544AC56F16B56944AEC3BD4E3D59177130943730E5@LIMKCMBX1.ad.analog.com>
References: <1286797494-13152-1-git-send-email-michael.hennerich@analog.com>
 <4CB325A2.4040308@cam.ac.uk>
In-Reply-To: <4CB325A2.4040308@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-10-11:
> On 10/11/10 12:44, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> New driver handling:         AD7475, AD7476, AD7477, AD7478, AD7466, AD7=
467,
>> AD7468, AD7495 SPI micropower and high speed 12-/10-/8-Bit ADCs
>>
>> staging: iio: adc: ad7476 apply list review feedback by Jonathan
>> Cameron
>>
>> Changes since last RFC post V1:
>>      Mainly list review feedback by Jonathan Cameron
>>
>> -Remove scan_attrs from chip info structure. -Remove name from chip
>> info structure, use new spi_device_id instead. -Allow transfer buffers
>> to live in their own cache lines, to avoid DMA/cache coherency issues.
>> -Move scan el code into the ring buffer file. -Use helper function to
>> alloc the pollfunc. -Use regulator framework and get vref_mv from the
>> regulator in case not specified by pdata. -Devices with buit-in
>> reference use vref from the chip info structure -Don't error on missing
>> platform_data
>>
>> -Make vref_mv type unsigned short
>> -Print in_scale "Vref / 2^(bits)" if fractional.
>
> Hi Michael,
>
> Trivial suggestions inline.
>
> I'm not keen on the %d/2^%d formatting for the scale.

I knew that this would start some discussion.

> We haven't
> allowed anything like that so far, so can we have that from some fixed
> point arithmetic please. (Can do this as a follow up patch if you
> like).  Ideally build the string on setting of vref and cache it for
> later reads.

Well the hardcoded 0.5 in the other ADC driver is not really better.

This should do the trick...

static ssize_t ad7476_show_scale(struct device *dev,
                                struct device_attribute *attr,
                                char *buf)
{
        /* Driver currently only support internal vref */
        struct iio_dev *dev_info =3D dev_get_drvdata(dev);
        struct ad7476_state *st =3D iio_dev_get_devdata(dev_info);
        /* Corresponds to Vref / 2^(bits) */
        unsigned int scale_uv =3D (st->int_vref_mv * 1000) >> st->chip_info=
->bits;

        return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
}

>
> Other than that one issue, I'm happy. So on basis it will be fixed in
> follow up (or if you put a fix in this time round)
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk> ---
>>  drivers/staging/iio/adc/Kconfig       |   11 ++
>>  drivers/staging/iio/adc/Makefile      |    4 +
>>  drivers/staging/iio/adc/ad7476.h      |   79 +++++++++
>>  drivers/staging/iio/adc/ad7476_core.c |  298
>> +++++++++++++++++++++++++++++++++
>> drivers/staging/iio/adc/ad7476_ring.c |  207 +++++++++++++++++++++++
>>  5 files changed, 599 insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/staging/iio/adc/ad7476.h  create mode 100644
>> drivers/staging/iio/adc/ad7476_core.c
>>  create mode 100644 drivers/staging/iio/adc/ad7476_ring.c
>> diff --git a/drivers/staging/iio/adc/Kconfig
>> b/drivers/staging/iio/adc/Kconfig index 3ea4da8..71713ee 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -46,3 +46,14 @@ config AD799X_RING_BUFFER
>>      help
>>        Say yes here to include ring buffer support in the AD799X
>>        ADC driver.
>> + +config AD7476 +   tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 an=
d
>> AD7495 ADC driver" + depends on SPI +        help +    Say yes here to b=
uild
>> support for Analog Devices AD7475/6/7/8, +     AD7466/7/8 and AD7495 ADC
>> driver.
> Trivial point. Plase list the names of the parts out in full in here.
> Makes grepping easier.  Obviously people can still grep the whole tree
> to find the id table entries, but it's easier if the names are in
> plain text in the Kconfig files as well.
>> +      If unsure, say N (but it's safe to say "Y").
>> +
>> +      To compile this driver as a module, choose M here: the
>> +      module will be called ad7476.
>> diff --git a/drivers/staging/iio/adc/Makefile
>> b/drivers/staging/iio/adc/Makefile
>> index 2094dbd..b62c319 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -10,3 +10,7 @@ obj-$(CONFIG_MAX1363) +=3D max1363.o  ad799x-y :=3D
>> ad799x_core.o
>>  ad799x-$(CONFIG_AD799X_RING_BUFFER) +=3D ad799x_ring.o
>>  obj-$(CONFIG_AD799X) +=3D ad799x.o
>> + +ad7476-y :=3D ad7476_core.o +ad7476-$(CONFIG_IIO_RING_BUFFER) +=3D
>> ad7476_ring.o +obj-$(CONFIG_AD7476) +=3D ad7476.o diff --git
>> a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
>> new file mode 100644 index 0000000..6e4a85b --- /dev/null +++
>> b/drivers/staging/iio/adc/ad7476.h @@ -0,0 +1,79 @@ +/* + *
>> AD7476/5/7/8 (A) SPI ADC driver + * + * Copyright 2010 Analog Devices
>> Inc. + * + * Licensed under the GPL-2 or later. + */ +#ifndef
>> IIO_ADC_AD7476_H_ +#define IIO_ADC_AD7476_H_ + +#define
>> RES_MASK(bits)       ((1 << (bits)) - 1) + +/* + * TODO: struct
>> ad7476_platform_data needs to go into +include/linux/iio  */ + +struct
>> ad7476_platform_data { +     u16                             vref_mv; +}=
; + +struct ad7476_chip_info
>> { +  u8                              bits; + u8                         =
     storagebits; +  u8                              res_shift; +    char  =
                          sign;
>> +    u16                             int_vref_mv; +}; + +struct ad7476_s=
tate { +     struct
>> iio_dev                      *indio_dev; +   struct spi_device          =
     *spi; + const struct
>> ad7476_chip_info     *chip_info; +   struct regulator                *re=
g; + struct
>> work_struct          poll_work; +    atomic_t                        pro=
tect_ring;
>> +    u16                             int_vref_mv; +  struct spi_transfer=
             xfer; + struct
>> spi_message          msg; +  /* +     * DMA (thus cache coherency mainte=
nance)
>> requires the +        * transfer buffers to live in their own cache line=
s. +
>> */ + unsigned char                   data[2] ____cacheline_aligned; +}; =
+ +enum
>> ad7476_supported_device_ids { +      ID_AD7466, +    ID_AD7467, +    ID_=
AD7468,
>> +    ID_AD7475, +    ID_AD7476, +    ID_AD7477, +    ID_AD7478, +    ID_=
AD7495 +}; +
>> +#ifdef CONFIG_IIO_RING_BUFFER +int ad7476_scan_from_ring(struct
>> ad7476_state *st); int +ad7476_register_ring_funcs_and_init(struct
>> iio_dev *indio_dev); +void ad7476_ring_cleanup(struct iio_dev
>> *indio_dev); #else /* +CONFIG_IIO_RING_BUFFER */ static inline ssize_t
>> +ad7476_scan_from_ring(struct device *dev, +                            =
          struct
>> device_attribute *attr, +                                         char *=
buf) +{ +    return 0; +} +
>> +static inline int +ad7476_register_ring_funcs_and_init(struct iio_dev
>> *indio_dev) { +      return 0; +} + +static inline void
>> ad7476_ring_cleanup(struct iio_dev *indio_dev) { } +#endif /*
>> CONFIG_IIO_RING_BUFFER */ #endif /* IIO_ADC_AD7476_H_ */ diff --git
>> a/drivers/staging/iio/adc/ad7476_core.c
>> b/drivers/staging/iio/adc/ad7476_core.c new file mode 100644 index
>> 0000000..bbd72a6 --- /dev/null +++
>> b/drivers/staging/iio/adc/ad7476_core.c @@ -0,0 +1,298 @@ +/* + *
>> AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver + * + * Copyright 2010
>> Analog Devices Inc. + * + * Licensed under the GPL-2 or later. + */ +
>> +#include <linux/interrupt.h> +#include <linux/workqueue.h> +#include
>> <linux/device.h> +#include <linux/kernel.h> +#include <linux/slab.h>
>> +#include <linux/sysfs.h> +#include <linux/list.h> +#include
>> <linux/spi/spi.h> +#include <linux/regulator/consumer.h> #include
>> <linux/err.h> + +#include "../iio.h" +#include "../sysfs.h" +#include
>> "../ring_generic.h" +#include "adc.h" + +#include "ad7476.h" + +static
>> int ad7476_scan_direct(struct ad7476_state *st) { Cleaner to just put
>> st->spi in the call as it is only used the once. +   struct spi_device
>> *spi =3D st->spi; +    int ret; + +    ret =3D spi_sync(spi, &st->msg); =
+        if
>> (ret) +              return ret; + + return (st->data[0] << 8) | st->dat=
a[1]; } +
>> +static ssize_t ad7476_scan(struct device *dev, +                       =
 struct
>> device_attribute *attr, +                        char *buf) +{ +     str=
uct iio_dev
>> *dev_info =3D dev_get_drvdata(dev); +  struct ad7476_state *st =3D
>> dev_info->dev_data; +        int ret; + +    mutex_lock(&dev_info->mlock=
); + if
>> (iio_ring_enabled(dev_info)) +               ret =3D ad7476_scan_from_ri=
ng(st); +      else
>> +            ret =3D ad7476_scan_direct(st); + mutex_unlock(&dev_info->m=
lock); +
>> +    if (ret < 0) +          return ret; + + return sprintf(buf, "%d\n",=
 (ret >>
>> st->chip_info->res_shift) & +                       RES_MASK(st->chip_in=
fo->bits)); }
>> static +IIO_DEV_ATTR_IN_RAW(0, ad7476_scan, 0); + +static ssize_t
>> ad7476_show_scale(struct device *dev, +                              str=
uct device_attribute
>> *attr, +                             char *buf) +{ + /* Driver currently=
 only support internal
>> vref */ +    struct iio_dev *dev_info =3D dev_get_drvdata(dev); +      s=
truct
>> ad7476_state *st =3D iio_dev_get_devdata(dev_info); +  /* Corresponds to
>> Vref / 2^(bits) */ + +       if ((1 << (st->chip_info->bits + 1)) >
>> st->int_vref_mv) +           return sprintf(buf, "%d/2^%d\n",
> Not keen on that approach.  It's not trivially machine readable.
> Perhaps a spot of fixed point arithmetic for this?
>
>> +                           st->int_vref_mv, st->chip_info->bits); + els=
e +          return
>> sprintf(buf, "%d\n", +                              st->int_vref_mv >>
>> st->chip_info->bits); } static +IIO_DEVICE_ATTR(in_scale, S_IRUGO,
>> ad7476_show_scale, NULL, 0); + +static ssize_t ad7476_show_name(struct
>> device *dev, +                                struct device_attribute *a=
ttr, +                                char *buf) +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev); +      struct
>> ad7476_state *st =3D iio_dev_get_devdata(dev_info); + +        return
>> sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name); +} +static
>> IIO_DEVICE_ATTR(name, S_IRUGO, ad7476_show_name, NULL, 0); + +static
>> struct attribute *ad7476_attributes[] =3D {
>> +    &iio_dev_attr_in0_raw.dev_attr.attr,
>> +    &iio_dev_attr_in_scale.dev_attr.attr,
>> +    &iio_dev_attr_name.dev_attr.attr, +     NULL, +}; + +static const s=
truct
>> attribute_group ad7476_attribute_group =3D { + .attrs =3D
>> ad7476_attributes, +}; + +static const struct ad7476_chip_info
>> ad7476_chip_info_tbl[] =3D { + [ID_AD7466] =3D { +               .bits =
=3D 12,
>> +            .storagebits =3D 16, +            .res_shift =3D 0, +      =
         .sign =3D
>> IIO_SCAN_EL_TYPE_UNSIGNED, + }, +    [ID_AD7467] =3D { +               .=
bits =3D 10,
>> +            .storagebits =3D 16, +            .res_shift =3D 2, +      =
         .sign =3D
>> IIO_SCAN_EL_TYPE_UNSIGNED, + }, +    [ID_AD7468] =3D { +               .=
bits =3D 8,
>> +            .storagebits =3D 16, +            .res_shift =3D 4, +      =
         .sign =3D
>> IIO_SCAN_EL_TYPE_UNSIGNED, + }, +    [ID_AD7475] =3D { +               .=
bits =3D 12,
>> +            .storagebits =3D 16, +            .res_shift =3D 0, +      =
         .sign =3D
>> IIO_SCAN_EL_TYPE_UNSIGNED, + }, +    [ID_AD7476] =3D { +               .=
bits =3D 12,
>> +            .storagebits =3D 16, +            .res_shift =3D 0, +      =
         .sign =3D
>> IIO_SCAN_EL_TYPE_UNSIGNED, + }, +    [ID_AD7477] =3D { +               .=
bits =3D 10,
>> +            .storagebits =3D 16, +            .res_shift =3D 2, +      =
         .sign =3D
>> IIO_SCAN_EL_TYPE_UNSIGNED, + }, +    [ID_AD7478] =3D { +               .=
bits =3D 8,
>> +            .storagebits =3D 16, +            .res_shift =3D 4, +      =
         .sign =3D
>> IIO_SCAN_EL_TYPE_UNSIGNED, + }, +    [ID_AD7495] =3D { +               .=
bits =3D 12,
>> +            .storagebits =3D 16, +            .res_shift =3D 0, +      =
         .int_vref_mv =3D 2500,
>> +            .sign =3D IIO_SCAN_EL_TYPE_UNSIGNED, +    }, +}; + +static =
int __devinit
>> ad7476_probe(struct spi_device *spi) { +     struct ad7476_platform_data
>> *pdata =3D spi->dev.platform_data; +   struct ad7476_state *st; +      i=
nt ret,
>> voltage_uv =3D 0; + +  st =3D kzalloc(sizeof(*st), GFP_KERNEL); +       =
 if (st =3D=3D
>> NULL) { +            ret =3D -ENOMEM; +                goto error_ret; +=
       } + +   st->reg =3D
>> regulator_get(&spi->dev, "vcc"); +   if (!IS_ERR(st->reg)) { +          =
     ret =3D
>> regulator_enable(st->reg); +         if (ret) +                      got=
o error_put_reg; +
>> +            voltage_uv =3D regulator_get_voltage(st->reg); +  } + +   s=
t->chip_info =3D
>> +            &ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];=
 + + if
>> (st->chip_info->int_vref_mv) +               st->int_vref_mv =3D
>> st->chip_info->int_vref_mv; +        else if (pdata && pdata->vref_mv)
>> +            st->int_vref_mv =3D pdata->vref_mv; +     else if (voltage_=
uv)
>> +            st->int_vref_mv =3D voltage_uv / 1000; +  else +          d=
ev_warn(&spi->dev,
>> "reference voltage unspecified\n"); + +      spi_set_drvdata(spi, st); +
>> +    atomic_set(&st->protect_ring, 0); +     st->spi =3D spi; + +      s=
t->indio_dev
>> =3D iio_allocate_device(); +   if (st->indio_dev =3D=3D NULL) { +       =
   ret =3D
>> -ENOMEM; +           goto error_disable_reg; +       } + +   /* Estabili=
sh that the
>> iio_dev is a child of the i2c device */ +    st->indio_dev->dev.parent =
=3D
>> &spi->dev; + st->indio_dev->attrs =3D &ad7476_attribute_group;
>> +    st->indio_dev->dev_data =3D (void *)(st);
>> +    st->indio_dev->driver_module =3D THIS_MODULE; +   st->indio_dev->mo=
des =3D
>> INDIO_DIRECT_MODE; + +       /* Setup default message */ + + st->xfer.rx=
_buf
>> =3D &st->data; +       st->xfer.len =3D st->chip_info->storagebits / 8; =
+
>> +    spi_message_init(&st->msg); +   spi_message_add_tail(&st->xfer,
>> &st->msg); + +       ret =3D
>> ad7476_register_ring_funcs_and_init(st->indio_dev); +        if (ret) + =
             goto
>> error_free_device; + +       ret =3D iio_device_register(st->indio_dev);=
 +     if
>> (ret) +              goto error_free_device; + +     ret =3D
>> iio_ring_buffer_register(st->indio_dev->ring, 0); +  if (ret) +         =
     goto
>> error_cleanup_ring; +        return 0; + +error_cleanup_ring:
>> +    ad7476_ring_cleanup(st->indio_dev);
>> +    iio_device_unregister(st->indio_dev); +error_free_device:
>> +    iio_free_device(st->indio_dev); +error_disable_reg: +   if
>> (!IS_ERR(st->reg)) +         regulator_disable(st->reg); +error_put_reg:=
 +   if
>> (!IS_ERR(st->reg)) +         regulator_put(st->reg); +       kfree(st); =
+error_ret:
>> +    return ret; +} + +static int ad7476_remove(struct spi_device *spi) =
{
>> +    struct ad7476_state *st =3D spi_get_drvdata(spi); +       struct ii=
o_dev
>> *indio_dev =3D st->indio_dev;
>> +    iio_ring_buffer_unregister(indio_dev->ring);
>> +    ad7476_ring_cleanup(indio_dev); +       iio_device_unregister(indio=
_dev);
>> +    if (!IS_ERR(st->reg)) { +               regulator_disable(st->reg);
>> +            regulator_put(st->reg); +       } +     kfree(st); +    ret=
urn 0; +} + +static
>> const struct spi_device_id ad7476_id[] =3D { + {"ad7466", ID_AD7466},
>> +    {"ad7467", ID_AD7467}, +        {"ad7468", ID_AD7468}, +        {"a=
d7475",
>> ID_AD7475}, +        {"ad7476", ID_AD7476}, +        {"ad7476a", ID_AD74=
76},
>> +    {"ad7477", ID_AD7477}, +        {"ad7477a", ID_AD7477}, +       {"a=
d7478",
>> ID_AD7478}, +        {"ad7478a", ID_AD7478}, +       {"ad7495", ID_AD749=
5}, +        {} +};
>> + +static struct spi_driver ad7476_driver =3D { +      .driver =3D { +  =
         .name   =3D
>> "ad7476", +          .bus    =3D &spi_bus_type, +              .owner  =
=3D THIS_MODULE, +        },
>> +    .probe          =3D ad7476_probe, +       .remove         =3D __dev=
exit_p(ad7476_remove),
>> +    .id_table       =3D ad7476_id, +}; + +static int __init ad7476_init=
(void) {
>> +    return spi_register_driver(&ad7476_driver); +}
>> +module_init(ad7476_init); + +static void __exit ad7476_exit(void) {
>> +    spi_unregister_driver(&ad7476_driver); +} +module_exit(ad7476_exit)=
;
>> + +MODULE_AUTHOR("Michael Hennerich
>> +<hennerich@blackfin.uclinux.org>"); +MODULE_DESCRIPTION("Analog
>> Devices AD7475/6/7/8(A) AD7466/7/8 +ADC"); MODULE_LICENSE("GPL v2");
>> MODULE_ALIAS("spi:ad7476"); diff --git
>> a/drivers/staging/iio/adc/ad7476_ring.c
>> b/drivers/staging/iio/adc/ad7476_ring.c new file mode 100644 index
>> 0000000..85de142 --- /dev/null +++
>> b/drivers/staging/iio/adc/ad7476_ring.c @@ -0,0 +1,207 @@ +/* + *
>> Copyright 2010 Analog Devices Inc. + * Copyright (C) 2008 Jonathan
>> Cameron + * + * Licensed under the GPL-2 or later. + * + *
>> ad7476_ring.c + */ + +#include <linux/interrupt.h> +#include
>> <linux/gpio.h> +#include <linux/workqueue.h> +#include <linux/device.h>
>> +#include <linux/kernel.h> +#include <linux/slab.h> +#include
>> <linux/sysfs.h> +#include <linux/list.h> +#include <linux/spi/spi.h> +
>> +#include "../iio.h" +#include "../ring_generic.h" +#include
>> "../ring_sw.h" +#include "../trigger.h" +#include "../sysfs.h" +
>> +#include "ad7476.h" + +static IIO_SCAN_EL_C(in0, 0, 0, NULL); +
>> +static ssize_t ad7476_show_type(struct device *dev, +                  =
             struct
>> device_attribute *attr, +                            char *buf) +{ + str=
uct iio_ring_buffer
>> *ring =3D dev_get_drvdata(dev); +      struct iio_dev *indio_dev =3D
>> ring->indio_dev; +   struct ad7476_state *st =3D indio_dev->dev_data; +
>> +    return sprintf(buf, "%c%d/%d>>%d\n", st->chip_info->sign, +
>> st->chip_info->bits, st->chip_info->storagebits, +
>> st->chip_info->res_shift); } static +IIO_DEVICE_ATTR(in_type, S_IRUGO,
>> ad7476_show_type, NULL, 0); + +static struct attribute
>> *ad7476_scan_el_attrs[] =3D { +        &iio_scan_el_in0.dev_attr.attr,
>> +    &iio_const_attr_in0_index.dev_attr.attr,
>> +    &iio_dev_attr_in_type.dev_attr.attr, +  NULL, +}; + +static struct
>> attribute_group ad7476_scan_el_group =3D { +   .name =3D "scan_elements"=
,
>> +    .attrs =3D ad7476_scan_el_attrs, +}; + +int
>> ad7476_scan_from_ring(struct ad7476_state *st) { +   struct
>> iio_ring_buffer *ring =3D st->indio_dev->ring; +       int ret; +      u=
8
>> *ring_data; + +      ring_data =3D
>> kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL); +       if
>> (ring_data =3D=3D NULL) { +              ret =3D -ENOMEM; +             =
   goto error_ret; +       } +     ret =3D
>> ring->access.read_last(ring, ring_data); +   if (ret) +              got=
o
>> error_free_ring_data; + +    ret =3D (ring_data[0] << 8) | ring_data[1];=
 +
>> +error_free_ring_data: +     kfree(ring_data); +error_ret: + return ret;=
 +}
>> + +/** + * ad7476_ring_preenable() setup the parameters of the ring
>> before +enabling + * + * The complex nature of the setting of the nuber
>> of bytes per +datum is due + * to this driver currently ensuring that
>> the timestamp is stored +at an 8 + * byte boundary. + **/ +static int
>> ad7476_ring_preenable(struct iio_dev *indio_dev) { + struct
>> ad7476_state *st =3D indio_dev->dev_data; +    size_t d_size; + +      i=
f
>> (indio_dev->ring->access.set_bytes_per_datum) { +            d_size =3D
>> st->chip_info->storagebits / 8 + sizeof(s64); +              if (d_size =
% 8)
>> +                    d_size +=3D 8 - (d_size % 8);
>> +            indio_dev->ring->access.set_bytes_per_datum(indio_dev- ring=
,
>> +                                                        d_size); +  } +=
 +   return 0; +} + +/** + *
>> ad7476_poll_func_th() th of trigger launched polling to ring +buffer +
>> * + * As sampling only occurs on i2c comms occuring, leave
>> +timestamping until + * then.  Some triggers will generate their own
>> time stamp. +Currently + * there is no way of notifying them when no
>> one cares. + **/ +static void ad7476_poll_func_th(struct iio_dev
>> *indio_dev, s64 +time) { +   struct ad7476_state *st =3D
>> indio_dev->dev_data; + +     schedule_work(&st->poll_work); +        ret=
urn; +}
>> +/** + * ad7476_poll_bh_to_ring() bh of trigger launched polling to
>> ring buffer + * @work_s:     the work struct through which this was
>> scheduled + * + * Currently there is no option in this driver to
>> disable the +saving of + * timestamps within the ring. + * I think the
>> one copy of this at a time was to avoid problems if +the + * trigger
>> was set far too high and the reads then locked up the computer. + **/
>> +static void ad7476_poll_bh_to_ring(struct work_struct *work_s) {
>> +    struct ad7476_state *st =3D container_of(work_s, struct ad7476_stat=
e,
>> +                                              poll_work); + struct iio_=
dev *indio_dev =3D st->indio_dev;
>> +    struct iio_sw_ring_buffer *sw_ring =3D iio_to_sw_ring(indio_dev- ri=
ng);
>> +    s64 time_ns; +  __u8 *rxbuf; +  int b_sent; +   size_t d_size; + + =
     /*
>> Ensure the timestamp is 8 byte aligned */ +  d_size =3D
>> st->chip_info->storagebits / 8 + sizeof(s64); +      if (d_size %
>> sizeof(s64)) +               d_size +=3D sizeof(s64) - (d_size % sizeof(=
s64)); + +     /*
>> Ensure only one copy of this function running at a time */ + if
>> (atomic_inc_return(&st->protect_ring) > 1) +         return; + +     rxb=
uf =3D
>> kzalloc(d_size,      GFP_KERNEL); +  if (rxbuf =3D=3D NULL) +           =
 return; + +     b_sent
>> =3D spi_read(st->spi, rxbuf, st->chip_info->storagebits / 8); +        i=
f
>> (b_sent < 0) +               goto done; + +  time_ns =3D iio_get_time_ns=
(); +
>> +    memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns)); +
>> +    indio_dev->ring->access.store_to(&sw_ring->buf, rxbuf, time_ns);
>> +done: +     kfree(rxbuf); + atomic_dec(&st->protect_ring); +} + +int
>> ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev) {
>> +    struct ad7476_state *st =3D indio_dev->dev_data; +        int ret =
=3D 0; +
>> +    indio_dev->ring =3D iio_sw_rb_allocate(indio_dev); +      if
>> (!indio_dev->ring) { +               ret =3D -ENOMEM; +                g=
oto error_ret; +       } +     /*
>> Effectively select the ring buffer implementation */
>> +    iio_ring_sw_register_funcs(&indio_dev->ring->access); + ret =3D
>> iio_alloc_pollfunc(indio_dev, NULL, &ad7476_poll_func_th); + if (ret)
>> +            goto error_deallocate_sw_rb; + +        /* Ring buffer func=
tions - here
>> trigger setup related */ + + indio_dev->ring->preenable =3D
>> &ad7476_ring_preenable; +    indio_dev->ring->postenable =3D
>> &iio_triggered_ring_postenable; +    indio_dev->ring->predisable =3D
>> &iio_triggered_ring_predisable; +    indio_dev->ring->scan_el_attrs =3D
>> &ad7476_scan_el_group; + +   INIT_WORK(&st->poll_work,
>> &ad7476_poll_bh_to_ring); + +        /* Flag that polled ring buffering =
is
>> possible */ +        indio_dev->modes |=3D INDIO_RING_TRIGGERED; +     r=
eturn 0;
>> +error_deallocate_sw_rb: +   iio_sw_rb_free(indio_dev->ring); +error_ret=
:
>> +    return ret; +} + +void ad7476_ring_cleanup(struct iio_dev *indio_de=
v)
>> { +  /* ensure that the trigger has been detached */ +       if
>> (indio_dev->trig) { +                iio_put_trigger(indio_dev->trig);
>> +            iio_trigger_dettach_poll_func(indio_dev->trig, +
>> indio_dev->pollfunc); +      } +     kfree(indio_dev->pollfunc);
>> +    iio_sw_rb_free(indio_dev->ring); +}

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
