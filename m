Return-Path: <GGao@invensense.com>
From: Ge Gao <GGao@invensense.com>
To: Adriana Reus <adriana.reus@intel.com>, Lucas De Marchi
	<lucas.de.marchi@gmail.com>
CC: "jic23@kernel.org" <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
Date: Wed, 3 Feb 2016 15:21:00 +0000
Message-ID: <BY2PR1201MB10619DC9BE5A306C711E36CFAFD00@BY2PR1201MB1061.namprd12.prod.outlook.com>
References: <1454425338-17674-1-git-send-email-adriana.reus@intel.com>
 <1454425338-17674-5-git-send-email-adriana.reus@intel.com>
 <CAKi4VA++NyD8uge=EfN2NT2F1xRgCYv-F89Q-Dpcu=56i4US+g@mail.gmail.com>
 <F5965A81-9ACE-405F-8776-7216E70AB81A@invensense.com>,<56B1C5AB.1090609@intel.com>
In-Reply-To: <56B1C5AB.1090609@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Adriana,
    Chip only gets confused when a SPI signal could simulate a I2C address.=
 Setting the bit tells chip to completely forget about I2C at all.  Without=
 setting the bit, it still works. But it might risk of triggering I2C if th=
e SPI signal accidentally simulates an I2C address that matches the chip ad=
dress and triggers a subsequent action.

Thanks.

Best Regards,

Ge Gao

________________________________________
From: Adriana Reus <adriana.reus@intel.com>
Sent: Wednesday, February 3, 2016 1:17 AM
To: Ge Gao; Lucas De Marchi
Cc: jic23@kernel.org; linux-iio@vger.kernel.org; srinivas.pandruvada@linux.=
intel.com
Subject: Re: [PATCH v1 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6=
000

Hi Lucas, Ge,


Thanks for pointing that out Lucas, I'm looking into it.

Ge, would it suffice to set the I2C_IF_DIS via an SPI transaction
(spi_write or regmap_write)?
Couldn't the chip get confused during that transaction also?


On 03.02.2016 08:42, Ge Gao wrote:
> That is a good point.  That register should be set in case chip get confu=
sed if the spi signal mimic a I2C signal
>
> Ge
>
>> On Feb 2, 2016, at 10:31 PM, Lucas De Marchi <lucas.de.marchi@gmail.com>=
 wrote:
>>
>> Hi Adriana,
>>
>>> On Tue, Feb 2, 2016 at 1:02 PM, Adriana Reus <adriana.reus@intel.com> w=
rote:
>>> The only difference between the MPU6000 and the
>>> MPU6050 is that the first also supports SPI.
>>> Add SPI driver for this chip.
>>>
>>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>>> ---
>>> Changes since initial version:
>>> * Modified Kconfig so that the SPI component selects the core component
>>>    instead of the other way around.
>>>
>>> drivers/iio/imu/inv_mpu6050/Kconfig       |  7 +++
>>> drivers/iio/imu/inv_mpu6050/Makefile      |  3 ++
>>> drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h |  1 +
>>> drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 80 ++++++++++++++++++++++++=
+++++++
>>> 4 files changed, 91 insertions(+)
>>> create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_=
mpu6050/Kconfig
>>> index 483f52d..6f6a419 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
>>> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> @@ -25,3 +25,10 @@ config INV_MPU6050_I2C
>>>           This driver can be built as a module. The module will be call=
ed
>>>           inv-mpu6050-i2c.
>>>
>>> +config INV_MPU6050_SPI
>>> +       tristate "Invensense MPU6050 devices"
>>> +       select INV_MPU6050_IIO
>>> +       select REGMAP_SPI
>>> +       help
>>> +         This driver can be built as a module. The module will be call=
ed
>>> +         inv-mpu6050-spi.
>>> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv=
_mpu6050/Makefile
>>> index ca4941d..734af5e 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/Makefile
>>> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
>>> @@ -7,3 +7,6 @@ inv-mpu6050-objs :=3D inv_mpu_core.o inv_mpu_ring.o inv=
_mpu_trigger.o
>>>
>>> obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o
>>> inv-mpu6050-i2c-objs :=3D inv_mpu_i2c.o inv_mpu_acpi.o
>>> +
>>> +obj-$(CONFIG_INV_MPU6050_SPI) +=3D inv-mpu6050-spi.o
>>> +inv-mpu6050-spi-objs :=3D inv_mpu_spi.o
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h
>>> index af406a3..758fe2b 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> @@ -62,6 +62,7 @@ struct inv_mpu6050_reg_map {
>>> enum inv_devices {
>>>         INV_MPU6050,
>>>         INV_MPU6500,
>>> +       INV_MPU6000,
>>>         INV_NUM_PARTS
>>> };
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_spi.c
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
>>> +static const struct regmap_config inv_mpu_regmap_config =3D {
>>> +       .reg_bits =3D 8,
>>> +       .val_bits =3D 8,
>>> +};
>>> +
>>> +static int inv_mpu_probe(struct spi_device *spi)
>>> +{
>>> +       struct regmap *regmap;
>>> +       const struct spi_device_id *id =3D spi_get_device_id(spi);
>>> +       const char *name =3D id ? id->name : NULL;
>>> +
>>> +       regmap =3D devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
>>> +       if (IS_ERR(regmap)) {
>>> +               dev_err(&spi->dev, "Failed to register spi regmap %d\n"=
,
>>> +                       (int)PTR_ERR(regmap));
>>> +               return PTR_ERR(regmap);
>>> +       }
>>> +
>>> +       return inv_mpu_core_probe(regmap, spi->irq, name);
>>
>> I think there's still some spi-only initialization missing. As per
>> datasheet we should disable the I2C interface when using the SPI
>> interface.
>>
>> Lucas De Marchi
