Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34954 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165568AbdD3QlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 12:41:10 -0400
Subject: Re: [PATCH 1/7] hwmon: twl4030-madc: drop driver
To: Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>, J Keerthy <j-keerthy@ti.com>,
        linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170427153012.32310-2-sebastian.reichel@collabora.co.uk>
 <20170427165159.GB30189@roeck-us.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <567f0680-abe9-790e-aea7-65c98ae0698a@kernel.org>
Date: Sun, 30 Apr 2017 17:41:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170427165159.GB30189@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/17 17:51, Guenter Roeck wrote:
> On Thu, Apr 27, 2017 at 05:30:06PM +0200, Sebastian Reichel wrote:
>> This driver is no longer needed:
>>
>>  * It has no mainline users
>>  * It has no DT support and OMAP is DT only
>>  * iio-hwmon can be used for madc, which also works with DT
>>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> ... assuming this will be pushed through the same tree as the rest
> of the series. Let me know if I should queue it up in hwmon for v4.12.
We are too late for the series to go through IIO for the 4.12 cycle, so I guess it
makes sense to take this one through hwmon if you still have time.

I can then pick up the rest once I have acks from Wolfram
(who should have been cc'd as we are hoovering up things from the
i2c directories in this series) + power supply side of things.

Jonathan
> 
> Thanks,
> Guenter
> 
>> ---
>>  drivers/hwmon/Kconfig              |  10 ----
>>  drivers/hwmon/Makefile             |   1 -
>>  drivers/hwmon/twl4030-madc-hwmon.c | 118 -------------------------------------
>>  3 files changed, 129 deletions(-)
>>  delete mode 100644 drivers/hwmon/twl4030-madc-hwmon.c
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 0649d53f3d16..776d1ac2bfee 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1643,16 +1643,6 @@ config SENSORS_TMP421
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called tmp421.
>>  
>> -config SENSORS_TWL4030_MADC
>> -	tristate "Texas Instruments TWL4030 MADC Hwmon"
>> -	depends on TWL4030_MADC
>> -	help
>> -	If you say yes here you get hwmon support for triton
>> -	TWL4030-MADC.
>> -
>> -	This driver can also be built as a module. If so it will be called
>> -	twl4030-madc-hwmon.
>> -
>>  config SENSORS_VEXPRESS
>>  	tristate "Versatile Express"
>>  	depends on VEXPRESS_CONFIG
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 5509edf6186a..c05530d6cb6e 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -157,7 +157,6 @@ obj-$(CONFIG_SENSORS_TMP103)	+= tmp103.o
>>  obj-$(CONFIG_SENSORS_TMP108)	+= tmp108.o
>>  obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
>>  obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
>> -obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
>>  obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress-hwmon.o
>>  obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
>>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>> diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
>> deleted file mode 100644
>> index b5caf7fdb487..000000000000
>> --- a/drivers/hwmon/twl4030-madc-hwmon.c
>> +++ /dev/null
>> @@ -1,118 +0,0 @@
>> -/*
>> - *
>> - * TWL4030 MADC Hwmon driver-This driver monitors the real time
>> - * conversion of analog signals like battery temperature,
>> - * battery type, battery level etc. User can ask for the conversion on a
>> - * particular channel using the sysfs nodes.
>> - *
>> - * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
>> - * J Keerthy <j-keerthy@ti.com>
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License
>> - * version 2 as published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - * General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> - * 02110-1301 USA
>> - *
>> - */
>> -#include <linux/init.h>
>> -#include <linux/module.h>
>> -#include <linux/kernel.h>
>> -#include <linux/i2c/twl.h>
>> -#include <linux/device.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/i2c/twl4030-madc.h>
>> -#include <linux/hwmon.h>
>> -#include <linux/hwmon-sysfs.h>
>> -#include <linux/stddef.h>
>> -#include <linux/sysfs.h>
>> -#include <linux/err.h>
>> -#include <linux/types.h>
>> -
>> -/*
>> - * sysfs hook function
>> - */
>> -static ssize_t madc_read(struct device *dev,
>> -			 struct device_attribute *devattr, char *buf)
>> -{
>> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> -	struct twl4030_madc_request req = {
>> -		.channels = 1 << attr->index,
>> -		.method = TWL4030_MADC_SW2,
>> -		.type = TWL4030_MADC_WAIT,
>> -	};
>> -	long val;
>> -
>> -	val = twl4030_madc_conversion(&req);
>> -	if (val < 0)
>> -		return val;
>> -
>> -	return sprintf(buf, "%d\n", req.rbuf[attr->index]);
>> -}
>> -
>> -/* sysfs nodes to read individual channels from user side */
>> -static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, madc_read, NULL, 0);
>> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, madc_read, NULL, 1);
>> -static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, madc_read, NULL, 2);
>> -static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, madc_read, NULL, 3);
>> -static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, madc_read, NULL, 4);
>> -static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, madc_read, NULL, 5);
>> -static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, madc_read, NULL, 6);
>> -static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, madc_read, NULL, 7);
>> -static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, madc_read, NULL, 8);
>> -static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, madc_read, NULL, 9);
>> -static SENSOR_DEVICE_ATTR(curr10_input, S_IRUGO, madc_read, NULL, 10);
>> -static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, madc_read, NULL, 11);
>> -static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, madc_read, NULL, 12);
>> -static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);
>> -
>> -static struct attribute *twl4030_madc_attrs[] = {
>> -	&sensor_dev_attr_in0_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
>> -	&sensor_dev_attr_in2_input.dev_attr.attr,
>> -	&sensor_dev_attr_in3_input.dev_attr.attr,
>> -	&sensor_dev_attr_in4_input.dev_attr.attr,
>> -	&sensor_dev_attr_in5_input.dev_attr.attr,
>> -	&sensor_dev_attr_in6_input.dev_attr.attr,
>> -	&sensor_dev_attr_in7_input.dev_attr.attr,
>> -	&sensor_dev_attr_in8_input.dev_attr.attr,
>> -	&sensor_dev_attr_in9_input.dev_attr.attr,
>> -	&sensor_dev_attr_curr10_input.dev_attr.attr,
>> -	&sensor_dev_attr_in11_input.dev_attr.attr,
>> -	&sensor_dev_attr_in12_input.dev_attr.attr,
>> -	&sensor_dev_attr_in15_input.dev_attr.attr,
>> -	NULL
>> -};
>> -ATTRIBUTE_GROUPS(twl4030_madc);
>> -
>> -static int twl4030_madc_hwmon_probe(struct platform_device *pdev)
>> -{
>> -	struct device *hwmon;
>> -
>> -	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev,
>> -						       "twl4030_madc", NULL,
>> -						       twl4030_madc_groups);
>> -	return PTR_ERR_OR_ZERO(hwmon);
>> -}
>> -
>> -static struct platform_driver twl4030_madc_hwmon_driver = {
>> -	.probe = twl4030_madc_hwmon_probe,
>> -	.driver = {
>> -		   .name = "twl4030_madc_hwmon",
>> -		   },
>> -};
>> -
>> -module_platform_driver(twl4030_madc_hwmon_driver);
>> -
>> -MODULE_DESCRIPTION("TWL4030 ADC Hwmon driver");
>> -MODULE_LICENSE("GPL");
>> -MODULE_AUTHOR("J Keerthy");
>> -MODULE_ALIAS("platform:twl4030_madc_hwmon");
>> -- 
>> 2.11.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

