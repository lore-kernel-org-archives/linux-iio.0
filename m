Return-Path: <svarbanov@mm-sol.com>
Message-ID: <540CDF5B.7040708@mm-sol.com>
Date: Mon, 08 Sep 2014 01:42:35 +0300
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 1/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
References: <1409919274-13419-1-git-send-email-svarbanov@mm-sol.com> <1409919274-13419-2-git-send-email-svarbanov@mm-sol.com> <alpine.DEB.2.01.1409051418520.13940@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1409051418520.13940@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Peter,

Thanks for the comments!

On 09/05/2014 03:46 PM, Peter Meerwald wrote:
> 
>> The voltage ADC is peripheral of Qualcomm SPMI PMIC chips. It has
>> 15bits resolution and register space inside PMIC accessible across
>> SPMI bus.
>>
>> The vadc driver registers itself through IIO interface.
> 
> several trivial comments below
> 
> there plenty of device-specific sysfs attributes which need to be 
> documented (in ABI/testing/sysfs-bus-iio-xxx)

sure, will document the attributes.by you

>  
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
>> ---
>>  drivers/iio/adc/Kconfig                       |   11 +
>>  drivers/iio/adc/Makefile                      |    1 +
>>  drivers/iio/adc/qcom-spmi-vadc.c              | 1275 +++++++++++++++++++++++++
>>  include/dt-bindings/iio/qcom,spmi-pmic-vadc.h |  119 +++
>>  4 files changed, 1406 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/iio/adc/qcom-spmi-vadc.c
>>  create mode 100644 include/dt-bindings/iio/qcom,spmi-pmic-vadc.h
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 11b048a..e652d40 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -279,4 +279,15 @@ config XILINX_XADC
>>  	  The driver can also be build as a module. If so, the module will be called
>>  	  xilinx-xadc.
>>  
>> +config QCOM_SPMI_VADC
> 
> alphabetic order please

OK.

> 
>> +	tristate "Qualcomm SPMI PMIC voltage ADC"
>> +	depends on SPMI
>> +	help
>> +	  Say yes here if you want support for the Qualcomm SPMI PMIC voltage ADC.
>> +
>> +	  The driver supports reading the HKADC, XOADC through the ADC AMUX arbiter.
>> +	  The VADC includes support for the conversion sequencer. The driver
>> +	  supports reading the ADC through the AMUX channels for external pull-ups
>> +	  simultaneously.
>> +
>>  endmenu
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index ad81b51..050cc96 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -30,3 +30,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
>> +obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
>> new file mode 100644
>> index 0000000..0c500df
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
>> @@ -0,0 +1,1275 @@
>> +/*
>> + * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/completion.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mutex.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/log2.h>
> 
> log2 needed?

is_power_of_2()

> 
>> +
>> +#include <dt-bindings/iio/qcom,spmi-pmic-vadc.h>
>> +
>> +/* QPNP VADC register and bit definition */
> 
> what is QPNP?

This is leftover from downstream driver and I shouldn't be here.

Here is a brief explanation from Josh:

http://lkml.iu.edu/hypermail/linux/kernel/1401.1/05060.html

> 
>> +#define VADC_REVISION2				0x1
> 
> PREFIX should probably be QCOM_SPMI_VADC_

I'd prefer to keep as is. With proposed by you prefix the references of
defines could break the code indentation and IMO the file name
qcom-spmi-vadc is enough.

<snip>

I agree with all of your comments and will update the code in next version.

regards,
Stan
