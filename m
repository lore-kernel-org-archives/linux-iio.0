Return-Path: <adriana.reus@intel.com>
Subject: Re: [PATCH v1 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
To: Crt Mori <cmo@melexis.com>
References: <1454425338-17674-1-git-send-email-adriana.reus@intel.com>
 <1454425338-17674-5-git-send-email-adriana.reus@intel.com>
 <CAKv63uvB90LaT=QK_p9ekjZMCREcyM8dXG=vgL4gRGo-SRQD2g@mail.gmail.com>
 <CAKv63uvm1j_b8j+qFfT3ZQyHxcnF7LHPXDYy=3_NA+orV7DDiw@mail.gmail.com>
Cc: Johnathan Iain Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 ggao@invensense.com
From: Adriana Reus <adriana.reus@intel.com>
Message-ID: <56B0CFD4.4000801@intel.com>
Date: Tue, 2 Feb 2016 17:48:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv63uvm1j_b8j+qFfT3ZQyHxcnF7LHPXDYy=3_NA+orV7DDiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Right, there's now going to be a common part, an i2c specific part and 
an spi one.

On a different note I just saw that I did not delete the "mpu6050" from 
the spi_device_id table - I'll do so in the next version.

On 02.02.2016 17:34, Crt Mori wrote:
> Nevermind, saw the trick with other patches (3/4) and I get the point.
> You just split up the spi and i2c parts, but retained the rest.
>
>
> On 2 February 2016 at 16:29, Crt Mori <cmo@melexis.com> wrote:
>> As far as I understand regmap, you do not need to add a separate file
>> like that - but you can combine them all together with just passing
>> i2c or spi device to them depending on the connection type (can be
>> linked to dt).
>>
>> Is there a reason for this kind of change?
>>
>>
>> On 2 February 2016 at 16:02, Adriana Reus <adriana.reus@intel.com> wrote:
>>> The only difference between the MPU6000 and the
>>> MPU6050 is that the first also supports SPI.
>>> Add SPI driver for this chip.
>>>
>>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>>> ---
>>>   Changes since initial version:
>>>   * Modified Kconfig so that the SPI component selects the core component
>>>     instead of the other way around.
>>>
>>>   drivers/iio/imu/inv_mpu6050/Kconfig       |  7 +++
>>>   drivers/iio/imu/inv_mpu6050/Makefile      |  3 ++
>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h |  1 +
>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 80 +++++++++++++++++++++++++++++++
>>>   4 files changed, 91 insertions(+)
>>>   create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> index 483f52d..6f6a419 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
>>> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> @@ -25,3 +25,10 @@ config INV_MPU6050_I2C
>>>            This driver can be built as a module. The module will be called
>>>            inv-mpu6050-i2c.
>>>
>>> +config INV_MPU6050_SPI
>>> +       tristate "Invensense MPU6050 devices"
>>> +       select INV_MPU6050_IIO
>>> +       select REGMAP_SPI
>>> +       help
>>> +         This driver can be built as a module. The module will be called
>>> +         inv-mpu6050-spi.
>>> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
>>> index ca4941d..734af5e 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/Makefile
>>> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
>>> @@ -7,3 +7,6 @@ inv-mpu6050-objs := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
>>>
>>>   obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
>>>   inv-mpu6050-i2c-objs := inv_mpu_i2c.o inv_mpu_acpi.o
>>> +
>>> +obj-$(CONFIG_INV_MPU6050_SPI) += inv-mpu6050-spi.o
>>> +inv-mpu6050-spi-objs := inv_mpu_spi.o
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> index af406a3..758fe2b 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> @@ -62,6 +62,7 @@ struct inv_mpu6050_reg_map {
>>>   enum inv_devices {
>>>          INV_MPU6050,
>>>          INV_MPU6500,
>>> +       INV_MPU6000,
>>>          INV_NUM_PARTS
>>>   };
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>>> new file mode 100644
>>> index 0000000..484171e
>>> --- /dev/null
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>>> @@ -0,0 +1,80 @@
>>> +/*
>>> +* Copyright (C) 2015 Intel Corporation Inc.
>>> +*
>>> +* This software is licensed under the terms of the GNU General Public
>>> +* License version 2, as published by the Free Software Foundation, and
>>> +* may be copied, distributed, and modified under those terms.
>>> +*
>>> +* This program is distributed in the hope that it will be useful,
>>> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +* GNU General Public License for more details.
>>> +*/
>>> +#include <linux/module.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/iio/iio.h>
>>> +#include "inv_mpu_iio.h"
>>> +
>>> +static const struct regmap_config inv_mpu_regmap_config = {
>>> +       .reg_bits = 8,
>>> +       .val_bits = 8,
>>> +};
>>> +
>>> +static int inv_mpu_probe(struct spi_device *spi)
>>> +{
>>> +       struct regmap *regmap;
>>> +       const struct spi_device_id *id = spi_get_device_id(spi);
>>> +       const char *name = id ? id->name : NULL;
>>> +
>>> +       regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
>>> +       if (IS_ERR(regmap)) {
>>> +               dev_err(&spi->dev, "Failed to register spi regmap %d\n",
>>> +                       (int)PTR_ERR(regmap));
>>> +               return PTR_ERR(regmap);
>>> +       }
>>> +
>>> +       return inv_mpu_core_probe(regmap, spi->irq, name);
>>> +}
>>> +
>>> +static int inv_mpu_remove(struct spi_device *spi)
>>> +{
>>> +       return inv_mpu_core_remove(&spi->dev);
>>> +}
>>> +
>>> +/*
>>> + * device id table is used to identify what device can be
>>> + * supported by this driver
>>> + */
>>> +static const struct spi_device_id inv_mpu_id[] = {
>>> +       {"mpu6050", INV_MPU6050},
>>> +       {"mpu6000", INV_MPU6000},
>>> +       {}
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(spi, inv_mpu_id);
>>> +
>>> +static const struct acpi_device_id inv_acpi_match[] = {
>>> +       {"INVN6000", 0},
>>> +       { },
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
>>> +
>>> +static struct spi_driver inv_mpu_driver = {
>>> +       .probe          =       inv_mpu_probe,
>>> +       .remove         =       inv_mpu_remove,
>>> +       .id_table       =       inv_mpu_id,
>>> +       .driver = {
>>> +               .owner  =       THIS_MODULE,
>>> +               .acpi_match_table = ACPI_PTR(inv_acpi_match),
>>> +               .name   =       "inv-mpu6050 spi driver",
>>> +               .pm     =       &inv_mpu_pmops,
>>> +       },
>>> +};
>>> +
>>> +module_spi_driver(inv_mpu_driver);
>>> +
>>> +MODULE_AUTHOR("Adriana Reus <adriana.reus@intel.com>");
>>> +MODULE_DESCRIPTION("Invensense device MPU6050 driver");
>>> +MODULE_LICENSE("GPL");
>>> --
>>> 1.9.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
