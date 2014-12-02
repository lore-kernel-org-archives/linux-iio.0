Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <547E4180.9020505@linux.intel.com>
Date: Tue, 02 Dec 2014 14:47:28 -0800
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hartmut Knaack <knaack.h@gmx.de>
CC: Jonathan Cameron <jic23@kernel.org>, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 1/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
References: <cover.1410839445.git.sathyanarayanan.kuppuswamy@linux.intel.com>	 <57863472cd3b76c4b36ca99404e34ba03af4857d.1410839445.git.sathyanarayanan.kuppuswamy@linux.intel.com>	 <5419F3B5.50803@gmx.de> <5419F614.6040805@linux.intel.com>	 <541EC9F3.6080505@kernel.org> <5429D687.6020001@linux.intel.com>	 <5434486D.2070607@linux.intel.com> <5436E15B.3030402@kernel.org>	 <1413039420.3745.10.camel@spandruv-hsb-test>	 <543D5188.7070409@linux.intel.com> <543D5FA8.5070807@kernel.org>	 <545A4C14.4010807@kernel.org> <545AB227.3060601@gmx.de>	 <1415275752.3056.3.camel@spandruv-hsb-test> <545EA848.4040805@gmx.de>	 <1415640933.2043.26.camel@spandruv-desktop.jf.intel.com>	 <5479A57F.6070209@gmx.de> <1417453091.2043.256.camel@spandruv-desktop.jf.intel.com>
In-Reply-To: <1417453091.2043.256.camel@spandruv-desktop.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/01/2014 08:58 AM, Srinivas Pandruvada wrote:
> On Sat, 2014-11-29 at 11:52 +0100, Hartmut Knaack wrote:
>> Srinivas Pandruvada schrieb am 10.11.2014 um 18:35:
>>> On Sun, 2014-11-09 at 00:33 +0100, Hartmut Knaack wrote:
>>>> Srinivas Pandruvada schrieb am 06.11.2014 13:09:
>>>>> On Thu, 2014-11-06 at 00:26 +0100, Hartmut Knaack wrote:
>>>>>> Jonathan Cameron schrieb am 05.11.2014 17:11:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I'm a bit embarrassed.
>>>>>>>
>>>>>>> I can't remember at all where we were with this driver!
>>>>>>> Is everyone happy with it in it's current form or do
>>>>>>> people feel there are changes outstanding?
>>>>>>>
>>>>>>> Jonathan
>>>>>>>
>>>>>> Well, I think I lost a bit track by just reading the follow-ups, but not putting my focus on everything related. I'm not really into power management, so correct me, if I'm wrong.
>>>>>> My expectation is, that whenever a suspend is triggered, all registered .suspend functions are called. The one for this driver calls in turn jsa1212_power_off(), which, after doing the mutex_lock, puts the device in low power mode. But since _read_raw() also locks the same mutex before activating, reading and deactivating the device, and then unlocks it again, there should not be a need for the suspend function to power down the device (and for the resume function to conditionally power it back on), as the device should be in low power state anyway.
>>>>>> That said, shouldn't it be just necessary to put a mutex_lock() into _suspend(), and a mutex_unlock() into _resume() to make sure that no device access (and thus power up) happens during a suspend call?
>>>>>>
>>>>> As I explained before, suspend/resume happens in totally on a different
>>>>> thread. With autosuspend feature and with config preempt options even
>>>>> context switch can happen while processing system call.
>>>>> So only safe way is to prevent suspend to complete or poweroff in
>>>>> suspend.
>>>>>
>>>>> Thanks,
>>>>> Srinivas
I agree with Srinivas comment's. In suspend/resume path, Its safer to 
put the device in the desired state explicitly than expecting it to be 
in the given state.

>>>> I must admit, that I don't feel like understanding your comments completely. That's why I gathered some informations about the phases during suspend (and resume). It is mainly based on a presentation of Rafael J. Wysocki [1] and some documentation in the kernel tree [2].
>>>> So, in short, this is what happens during suspend: 1. Call Notifiers -> 2. Freeze Tasks -> 3. Device Suspend (call if defined: .prepare(), .suspend(), .suspend_late(), .suspend_noirq()) -> 4. Nonboot CPU Offline -> 5. System Core Offline -> 6. Turn Off Power.
>>>> This means, that until step 4, multiple threads can be active.
>>>> The purpose of .suspend() is defined as: The suspend methods should quiesce the device to stop it from performing I/O. They also may save the device registers and put it into the appropriate
>>>> low-power state, depending on the bus type the device is on, and they may enable wakeup events.
>>>> In case of this driver in its current state, _read_raw() can still be called, after .suspend() has been called - which means performing I/O and possibly leaving it in high power state when the system turns off power.
>>>> So, the most simple solution I could propose (as before) would be to just put the mutex_lock(&data->lock) into .suspend() and the corresponding mutex_unlock(&data->lock) into .resume - thus .suspend() will wait for a potential _read_raw() in progress to finish and power down, as well as preventing _read_raw() from from accessing the device until .resume() has finished.
>>>> Any comments and pointers to better information welcome.
>>>>
>>> Your analysis is correct. My original comment is to whether
>>> suspend/resume is required when read raw does power on and power-off for
>>> each read. So my comment was why suspend/resume is required as it is on
>>> a parallel thread. But I prefer power-off as someone can do a crazy SMI
>>> handler in turn on ALS (OEMs implement fancy things in SMI), so atleast
>>> next suspend will fix this in low power platforms. We have seen many
>>> crazy stuff in SMI. But I am not particular about power off.
>>>
>>> Thanks,
>>> Srinivas
>>>
>> Any progress on this? Maybe add a suspend flag, which gets set by .suspend() and cleared by .resume(), so _read_raw() knows when it should not access the device - basically a mutex?
>>
> As I said on x86 there can be a parallel world with SMI handler, so
> power down is the safest option. So IMO, this driver is doing correctly.
> ALS is utilized for making power decision, so manufacturers can be
> creative.
>
> Thanks,
> Srinivas
>
>>>> [1]https://events.linuxfoundation.org/sites/events/files/slides/kernel_PM_plain.pdf
>>>> [2]Documentation/power/devices.txt
>>>>
>>>>>> Hartmut
>>>>>>
>>>>>>> On 14/10/14 18:38, Jonathan Cameron wrote:
>>>>>>>> On 14/10/14 17:38, sathyanarayanan kuppuswamy wrote:
>>>>>>>>> Thanks for your comments Srinivas.
>>>>>>>>>
>>>>>>>>> Jonathan,
>>>>>>>>>
>>>>>>>>> If you agree with Srinivas comment. I think we don't need to remove the suspend
>>>>>>>>> call backs from the driver.
>>>>>>>> Yes.
>>>>>>>>>
>>>>>>>>> On 10/11/2014 07:57 AM, Srinivas Pandruvada wrote:
>>>>>>>>>> On Thu, 2014-10-09 at 20:26 +0100, Jonathan Cameron wrote:
>>>>>>>>>>> On 07/10/14 21:09, sathyanarayanan kuppuswamy wrote:
>>>>>>>>>>>> Hi Jonathan,
>>>>>>>>>>>>
>>>>>>>>>>>> On 09/29/2014 03:00 PM, sathyanarayanan kuppuswamy wrote:
>>>>>>>>>>>>> Hi Jonathan,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 09/21/2014 05:52 AM, Jonathan Cameron wrote:
>>>>>>>>>>>>>> On 17/09/14 21:59, sathyanarayanan kuppuswamy wrote:
>>>>>>>>>>>>>>> Hi Hartmut,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 09/17/2014 01:48 PM, Hartmut Knaack wrote:
>>>>>>>>>>>>>>>> Kuppuswamy Sathyanarayanan schrieb, Am 16.09.2014 05:54:
>>>>>>>>>>>>>>>>> This patch adds a new driver for solteam opto JSA1212 proximity and
>>>>>>>>>>>>>>>>> ambient light sensor.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Basic details of the chip can be found here.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> http://www.solteamopto.com.tw/detail.php?ms=3&po_unit=2&pt_unit=29&p_unit=120
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>> after your explanation of the power states, I now wonder, why you would
>>>>>>>>>>>>>>>> need
>>>>>>>>>>>>>>>> to power-down the device in jsa1212_suspend() and check, which parts
>>>>>>>>>>>>>>>> need to
>>>>>>>>>>>>>>>> be powered-up in jsa1212_resume(). The way I understand it, you only access
>>>>>>>>>>>>>>>> the device to read data, after initialization. Therefor you power up the
>>>>>>>>>>>>>>>> device, wait, read data and power down. All secured by a mutex. So, as
>>>>>>>>>>>>>>>> long as
>>>>>>>>>>>>>>>> no data is read, the device will always remain in low-power state.
>>>>>>>>>>>>>>> Yes, What you mentioned is true for current use case. But once we implement
>>>>>>>>>>>>>>> interrupt & IIO event support, We will have scenarios where the device is on
>>>>>>>>>>>>>>> when suspend is triggered. I have just added the power management code with
>>>>>>>>>>>>>>> that
>>>>>>>>>>>>>>> scenario in mind.
>>>>>>>>>>>>>> Please drop this for now and reintroduce it as and when it becomes relevant.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> If this had been part of a series that added support needing it in a later
>>>>>>>>>>>>>> patch then it probably wouldn't have mattered (although it would still have
>>>>>>>>>>>>>> been more correct in the patch that needed it).  Right now it adds complexity
>>>>>>>>>>>>>> for no obvious gain.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Also, once you have interrupt support etc you'll probably need to make
>>>>>>>>>>>>>> changes
>>>>>>>>>>>>>> to the current locations where you power up and down the chip anyway so it
>>>>>>>>>>>>>> will
>>>>>>>>>>>>>> fit in well then.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Otherwise, a nice little driver.
>>>>>>>>>>>>> When I answered Hartmut, I missed to consider the scenario where suspend to
>>>>>>>>>>>>> ram gets triggered in the middle
>>>>>>>>>>>>> of the read_raw() function.  When it happens our device might be "on" and
>>>>>>>>>>>>> system might be trying to suspend.
>>>>>>>>>>>>> So I think we still need the suspend/resume call to cover these cases.
>>>>>>>>>>>> Do you agree with above comment ? If yes, I think there is no need to change
>>>>>>>>>>>> this driver any more. Let me know.
>>>>>>>>>>> Sorry, misread that as you'd identified an issue (which I hadn't noticed!)
>>>>>>>>>>> and were going to fix and repost.
>>>>>>>>>>>
>>>>>>>>>>> Hmm. I'm not sure what the semantics of a suspend are.  I'd like to think it
>>>>>>>>>>> would
>>>>>>>>>>> require no other function calls to be in flight, but not certain.
>>>>>>>>>>>
>>>>>>>>>>> Anyone else happen to know?
>>>>>>>>>>>
>>>>>>>>>> Suspend can happen asynchronously, so if it can happen before read raw
>>>>>>>>>> can complete. There are OSs where suspend is automatically triggered, if
>>>>>>>>>> no one blocks it using special locks, without even user process
>>>>>>>>>> triggering suspend. Some users also define CONFIG_PREEMPT_VOLUNTARY.
>>>>>>>>>> So Sathya do need to make sure that it power down in suspend callback or
>>>>>>>>>> atleast prevent suspend to finish before read raw finishes the power
>>>>>>>>>> down by using some mutexes.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Srinivas
>>>>>>>>>>
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Jonathan
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Signed-off-by: Kuppuswamy Sathyanarayanan
>>>>>>>>>>>>>>>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>>>>>>>>>>>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>      drivers/iio/light/Kconfig   |  10 +
>>>>>>>>>>>>>>>>>      drivers/iio/light/Makefile  |   1 +
>>>>>>>>>>>>>>>>>      drivers/iio/light/jsa1212.c | 471
>>>>>>>>>>>>>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>>>>>      3 files changed, 482 insertions(+)
>>>>>>>>>>>>>>>>>      create mode 100644 drivers/iio/light/jsa1212.c
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>>>>>>>>>>>>>>>>> index bf05ca5..b81d8a3 100644
>>>>>>>>>>>>>>>>> --- a/drivers/iio/light/Kconfig
>>>>>>>>>>>>>>>>> +++ b/drivers/iio/light/Kconfig
>>>>>>>>>>>>>>>>> @@ -99,6 +99,16 @@ config HID_SENSOR_PROX
>>>>>>>>>>>>>>>>>            To compile this driver as a module, choose M here: the
>>>>>>>>>>>>>>>>>            module will be called hid-sensor-prox.
>>>>>>>>>>>>>>>>>      +config JSA1212
>>>>>>>>>>>>>>>>> +    tristate "JSA1212 ALS and proximity sensor driver"
>>>>>>>>>>>>>>>>> +    depends on I2C
>>>>>>>>>>>>>>>>> +    help
>>>>>>>>>>>>>>>>> +     Say Y here if you want to build a IIO driver for JSA1212
>>>>>>>>>>>>>>>>> +     proximity & ALS sensor device.
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +     To compile this driver as a module, choose M here:
>>>>>>>>>>>>>>>>> +     the module will be called jsa1212.
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>      config SENSORS_LM3533
>>>>>>>>>>>>>>>>>          tristate "LM3533 ambient light sensor"
>>>>>>>>>>>>>>>>>          depends on MFD_LM3533
>>>>>>>>>>>>>>>>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>>>>>>>>>>>>>>>>> index 8b8c09f..23c6aa9 100644
>>>>>>>>>>>>>>>>> --- a/drivers/iio/light/Makefile
>>>>>>>>>>>>>>>>> +++ b/drivers/iio/light/Makefile
>>>>>>>>>>>>>>>>> @@ -11,6 +11,7 @@ obj-$(CONFIG_GP2AP020A00F)    += gp2ap020a00f.o
>>>>>>>>>>>>>>>>>      obj-$(CONFIG_HID_SENSOR_ALS)    += hid-sensor-als.o
>>>>>>>>>>>>>>>>>      obj-$(CONFIG_HID_SENSOR_PROX)    += hid-sensor-prox.o
>>>>>>>>>>>>>>>>>      obj-$(CONFIG_ISL29125)        += isl29125.o
>>>>>>>>>>>>>>>>> +obj-$(CONFIG_JSA1212)        += jsa1212.o
>>>>>>>>>>>>>>>>>      obj-$(CONFIG_SENSORS_LM3533)    += lm3533-als.o
>>>>>>>>>>>>>>>>>      obj-$(CONFIG_LTR501)        += ltr501.o
>>>>>>>>>>>>>>>>>      obj-$(CONFIG_SENSORS_TSL2563)    += tsl2563.o
>>>>>>>>>>>>>>>>> diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
>>>>>>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>>>>>>> index 0000000..29de7e7
>>>>>>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>>>>>>> +++ b/drivers/iio/light/jsa1212.c
>>>>>>>>>>>>>>>>> @@ -0,0 +1,471 @@
>>>>>>>>>>>>>>>>> +/*
>>>>>>>>>>>>>>>>> + * JSA1212 Ambient Light & Proximity Sensor Driver
>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>> + * Copyright (c) 2014, Intel Corporation.
>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>> + * This program is free software; you can redistribute it and/or
>>>>>>>>>>>>>>>>> modify it
>>>>>>>>>>>>>>>>> + * under the terms and conditions of the GNU General Public License,
>>>>>>>>>>>>>>>>> + * version 2, as published by the Free Software Foundation.
>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>> + * This program is distributed in the hope it will be useful, but WITHOUT
>>>>>>>>>>>>>>>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>>>>>>>>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>>>>>>>>>>>>>>>>> License for
>>>>>>>>>>>>>>>>> + * more details.
>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>> + * JSA1212 I2C slave address: 0x44(ADDR tied to GND), 0x45(ADDR tied
>>>>>>>>>>>>>>>>> to VDD)
>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>> + * TODO: Interrupt support, thresholds, range support.
>>>>>>>>>>>>>>>>> + */
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +#include <linux/kernel.h>
>>>>>>>>>>>>>>>>> +#include <linux/slab.h>
>>>>>>>>>>>>>>>>> +#include <linux/module.h>
>>>>>>>>>>>>>>>>> +#include <linux/delay.h>
>>>>>>>>>>>>>>>>> +#include <linux/i2c.h>
>>>>>>>>>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>>>>>>>>>> +#include <linux/acpi.h>
>>>>>>>>>>>>>>>>> +#include <linux/regmap.h>
>>>>>>>>>>>>>>>>> +#include <linux/iio/iio.h>
>>>>>>>>>>>>>>>>> +#include <linux/iio/sysfs.h>
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* JSA1212 reg address */
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_REG        0x01
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_REG            0x02
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_LT_REG        0x03
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_HT_REG        0x04
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH1_REG        0x05
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH2_REG        0x06
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH3_REG        0x07
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_DATA_REG        0x08
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_DT1_REG        0x09
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_DT2_REG        0x0A
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_RNG_REG        0x0B
>>>>>>>>>>>>>>>>> +#define JSA1212_MAX_REG            0x0C
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* JSA1212 reg masks */
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_MASK        0xFF
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_MASK        0xFF
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_LT_MASK        0xFF
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_HT_MASK        0xFF
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH1_MASK        0xFF
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH2_LT_MASK        0x0F
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH2_HT_MASK        0xF0
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH3_MASK        0xFF
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_DATA_MASK        0xFF
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_DATA_MASK        0x0FFF
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_DT1_MASK        0xFF
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_DT2_MASK        0x0F
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_RNG_MASK        0x07
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* JSA1212 CONF REG bits */
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_MASK        0x80
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_ENABLE        0x80
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_DISABLE    0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_ALS_MASK        0x04
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_ALS_ENABLE        0x04
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_ALS_DISABLE    0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_IRDR_MASK        0x08
>>>>>>>>>>>>>>>>> +/* Proxmity sensing IRDR current sink settings */
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_IRDR_200MA        0x08
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_IRDR_100MA        0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_MASK    0x70
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_0MS    0x70
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_12MS    0x60
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_50MS    0x50
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_75MS    0x40
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_100MS    0x30
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_200MS    0x20
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_400MS    0x10
>>>>>>>>>>>>>>>>> +#define JSA1212_CONF_PXS_SLP_800MS    0x00
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* JSA1212 INT REG bits */
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_CTRL_MASK        0x01
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_CTRL_EITHER        0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_CTRL_BOTH        0x01
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_ALS_PRST_MASK    0x06
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_ALS_PRST_1CONV    0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_ALS_PRST_4CONV    0x02
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_ALS_PRST_8CONV    0x04
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_ALS_PRST_16CONV    0x06
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_ALS_FLAG_MASK    0x08
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_ALS_FLAG_CLR    0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_PXS_PRST_MASK    0x60
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_PXS_PRST_1CONV    0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_PXS_PRST_4CONV    0x20
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_PXS_PRST_8CONV    0x40
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_PXS_PRST_16CONV    0x60
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_PXS_FLAG_MASK    0x80
>>>>>>>>>>>>>>>>> +#define JSA1212_INT_PXS_FLAG_CLR    0x00
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* JSA1212 ALS RNG REG bits */
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_RNG_0_2048        0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_RNG_0_1024        0x01
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_RNG_0_512        0x02
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_RNG_0_256        0x03
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_RNG_0_128        0x04
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* JSA1212 INT threshold range */
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH_MIN    0x0000
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_TH_MAX    0x0FFF
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_TH_MIN    0x00
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_TH_MAX    0xFF
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +#define JSA1212_ALS_DELAY_MS    200
>>>>>>>>>>>>>>>>> +#define JSA1212_PXS_DELAY_MS    100
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +#define JSA1212_DRIVER_NAME    "jsa1212"
>>>>>>>>>>>>>>>>> +#define JSA1212_REGMAP_NAME    "jsa1212_regmap"
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +enum jsa1212_op_mode {
>>>>>>>>>>>>>>>>> +    JSA1212_OPMODE_ALS_EN,
>>>>>>>>>>>>>>>>> +    JSA1212_OPMODE_PXS_EN,
>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +struct jsa1212_data {
>>>>>>>>>>>>>>>>> +    struct i2c_client *client;
>>>>>>>>>>>>>>>>> +    struct mutex lock;
>>>>>>>>>>>>>>>>> +    u8 als_rng_idx;
>>>>>>>>>>>>>>>>> +    bool als_en; /* ALS enable status */
>>>>>>>>>>>>>>>>> +    bool pxs_en; /* proximity enable status */
>>>>>>>>>>>>>>>>> +    struct regmap *regmap;
>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* ALS range idx to val mapping */
>>>>>>>>>>>>>>>>> +static const int jsa1212_als_range_val[] = {2048, 1024, 512, 256, 128,
>>>>>>>>>>>>>>>>> +                        128, 128, 128};
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* Enables or disables ALS function based on status */
>>>>>>>>>>>>>>>>> +static int jsa1212_als_enable(struct jsa1212_data *data, u8 status)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = regmap_update_bits(data->regmap, JSA1212_CONF_REG,
>>>>>>>>>>>>>>>>> +                JSA1212_CONF_ALS_MASK,
>>>>>>>>>>>>>>>>> +                status);
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    data->als_en = !!status;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    return 0;
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +/* Enables or disables PXS function based on status */
>>>>>>>>>>>>>>>>> +static int jsa1212_pxs_enable(struct jsa1212_data *data, u8 status)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = regmap_update_bits(data->regmap, JSA1212_CONF_REG,
>>>>>>>>>>>>>>>>> +                JSA1212_CONF_PXS_MASK,
>>>>>>>>>>>>>>>>> +                status);
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    data->pxs_en = !!status;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    return 0;
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static int jsa1212_read_als_data(struct jsa1212_data *data,
>>>>>>>>>>>>>>>>> +                unsigned int *val)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>>>> +    __le16 als_data;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = jsa1212_als_enable(data, JSA1212_CONF_ALS_ENABLE);
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    /* Delay for data output */
>>>>>>>>>>>>>>>>> +    msleep(JSA1212_ALS_DELAY_MS);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    /* Read 12 bit data */
>>>>>>>>>>>>>>>>> +    ret = regmap_bulk_read(data->regmap, JSA1212_ALS_DT1_REG,
>>>>>>>>>>>>>>>>> &als_data, 2);
>>>>>>>>>>>>>>>>> +    if (ret < 0) {
>>>>>>>>>>>>>>>>> +        dev_err(&data->client->dev, "als data read err\n");
>>>>>>>>>>>>>>>>> +        goto als_data_read_err;
>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    *val = le16_to_cpu(als_data);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +als_data_read_err:
>>>>>>>>>>>>>>>>> +    return jsa1212_als_enable(data, JSA1212_CONF_ALS_DISABLE);
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static int jsa1212_read_pxs_data(struct jsa1212_data *data,
>>>>>>>>>>>>>>>>> +                unsigned int *val)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>>>> +    unsigned int pxs_data;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = jsa1212_pxs_enable(data, JSA1212_CONF_PXS_ENABLE);
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    /* Delay for data output */
>>>>>>>>>>>>>>>>> +    msleep(JSA1212_PXS_DELAY_MS);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    /* Read out all data */
>>>>>>>>>>>>>>>>> +    ret = regmap_read(data->regmap, JSA1212_PXS_DATA_REG, &pxs_data);
>>>>>>>>>>>>>>>>> +    if (ret < 0) {
>>>>>>>>>>>>>>>>> +        dev_err(&data->client->dev, "pxs data read err\n");
>>>>>>>>>>>>>>>>> +        goto pxs_data_read_err;
>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    *val = pxs_data & JSA1212_PXS_DATA_MASK;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +pxs_data_read_err:
>>>>>>>>>>>>>>>>> +    return jsa1212_pxs_enable(data, JSA1212_CONF_PXS_DISABLE);
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static int jsa1212_read_raw(struct iio_dev *indio_dev,
>>>>>>>>>>>>>>>>> +                struct iio_chan_spec const *chan,
>>>>>>>>>>>>>>>>> +                int *val, int *val2, long mask)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>>>> +    struct jsa1212_data *data = iio_priv(indio_dev);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    switch (mask) {
>>>>>>>>>>>>>>>>> +    case IIO_CHAN_INFO_RAW:
>>>>>>>>>>>>>>>>> +        mutex_lock(&data->lock);
>>>>>>>>>>>>>>>>> +        switch (chan->type) {
>>>>>>>>>>>>>>>>> +        case IIO_LIGHT:
>>>>>>>>>>>>>>>>> +            ret = jsa1212_read_als_data(data, val);
>>>>>>>>>>>>>>>>> +            break;
>>>>>>>>>>>>>>>>> +        case IIO_PROXIMITY:
>>>>>>>>>>>>>>>>> +            ret = jsa1212_read_pxs_data(data, val);
>>>>>>>>>>>>>>>>> +            break;
>>>>>>>>>>>>>>>>> +        default:
>>>>>>>>>>>>>>>>> +            ret = -EINVAL;
>>>>>>>>>>>>>>>>> +            break;
>>>>>>>>>>>>>>>>> +        }
>>>>>>>>>>>>>>>>> +        mutex_unlock(&data->lock);
>>>>>>>>>>>>>>>>> +        return ret < 0 ? ret : IIO_VAL_INT;
>>>>>>>>>>>>>>>>> +    case IIO_CHAN_INFO_SCALE:
>>>>>>>>>>>>>>>>> +        switch (chan->type) {
>>>>>>>>>>>>>>>>> +        case IIO_LIGHT:
>>>>>>>>>>>>>>>>> +            *val = jsa1212_als_range_val[data->als_rng_idx];
>>>>>>>>>>>>>>>>> +            *val2 = BIT(12); /* Max 12 bit value */
>>>>>>>>>>>>>>>>> +            return IIO_VAL_FRACTIONAL;
>>>>>>>>>>>>>>>>> +        default:
>>>>>>>>>>>>>>>>> +            break;
>>>>>>>>>>>>>>>>> +        }
>>>>>>>>>>>>>>>>> +        break;
>>>>>>>>>>>>>>>>> +    default:
>>>>>>>>>>>>>>>>> +        break;
>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    return -EINVAL;
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static const struct iio_chan_spec jsa1212_channels[] = {
>>>>>>>>>>>>>>>>> +    {
>>>>>>>>>>>>>>>>> +        .type = IIO_LIGHT,
>>>>>>>>>>>>>>>>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>>>>>>>>>>>>>> +            BIT(IIO_CHAN_INFO_SCALE),
>>>>>>>>>>>>>>>>> +    },
>>>>>>>>>>>>>>>>> +    {
>>>>>>>>>>>>>>>>> +        .type = IIO_PROXIMITY,
>>>>>>>>>>>>>>>>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static const struct iio_info jsa1212_info = {
>>>>>>>>>>>>>>>>> +    .driver_module        = THIS_MODULE,
>>>>>>>>>>>>>>>>> +    .read_raw        = &jsa1212_read_raw,
>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static int jsa1212_chip_init(struct jsa1212_data *data)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = regmap_write(data->regmap, JSA1212_CONF_REG,
>>>>>>>>>>>>>>>>> +                (JSA1212_CONF_PXS_SLP_50MS |
>>>>>>>>>>>>>>>>> +                JSA1212_CONF_IRDR_200MA));
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = regmap_write(data->regmap, JSA1212_INT_REG,
>>>>>>>>>>>>>>>>> +                JSA1212_INT_ALS_PRST_4CONV);
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    data->als_rng_idx = JSA1212_ALS_RNG_0_2048;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    return 0;
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static bool jsa1212_is_volatile_reg(struct device *dev, unsigned int reg)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    switch (reg) {
>>>>>>>>>>>>>>>>> +    case JSA1212_PXS_DATA_REG:
>>>>>>>>>>>>>>>>> +    case JSA1212_ALS_DT1_REG:
>>>>>>>>>>>>>>>>> +    case JSA1212_ALS_DT2_REG:
>>>>>>>>>>>>>>>>> +    case JSA1212_INT_REG:
>>>>>>>>>>>>>>>>> +        return true;
>>>>>>>>>>>>>>>>> +    default:
>>>>>>>>>>>>>>>>> +        return false;
>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static struct regmap_config jsa1212_regmap_config = {
>>>>>>>>>>>>>>>>> +    .name =  JSA1212_REGMAP_NAME,
>>>>>>>>>>>>>>>>> +    .reg_bits = 8,
>>>>>>>>>>>>>>>>> +    .val_bits = 8,
>>>>>>>>>>>>>>>>> +    .max_register = JSA1212_MAX_REG,
>>>>>>>>>>>>>>>>> +    .cache_type = REGCACHE_RBTREE,
>>>>>>>>>>>>>>>>> +    .volatile_reg = jsa1212_is_volatile_reg,
>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static int jsa1212_probe(struct i2c_client *client,
>>>>>>>>>>>>>>>>> +             const struct i2c_device_id *id)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    struct jsa1212_data *data;
>>>>>>>>>>>>>>>>> +    struct iio_dev *indio_dev;
>>>>>>>>>>>>>>>>> +    struct regmap *regmap;
>>>>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    if (!i2c_check_functionality(client->adapter,
>>>>>>>>>>>>>>>>> I2C_FUNC_SMBUS_BYTE_DATA))
>>>>>>>>>>>>>>>>> +        return -ENODEV;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>>>>>>>>>>>>>>>> +    if (!indio_dev)
>>>>>>>>>>>>>>>>> +        return -ENOMEM;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    regmap = devm_regmap_init_i2c(client, &jsa1212_regmap_config);
>>>>>>>>>>>>>>>>> +    if (IS_ERR(regmap)) {
>>>>>>>>>>>>>>>>> +        dev_err(&client->dev, "Regmap initialization failed.\n");
>>>>>>>>>>>>>>>>> +        return PTR_ERR(regmap);
>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    data = iio_priv(indio_dev);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    i2c_set_clientdata(client, indio_dev);
>>>>>>>>>>>>>>>>> +    data->client = client;
>>>>>>>>>>>>>>>>> +    data->regmap = regmap;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    mutex_init(&data->lock);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = jsa1212_chip_init(data);
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    indio_dev->dev.parent = &client->dev;
>>>>>>>>>>>>>>>>> +    indio_dev->channels = jsa1212_channels;
>>>>>>>>>>>>>>>>> +    indio_dev->num_channels = ARRAY_SIZE(jsa1212_channels);
>>>>>>>>>>>>>>>>> +    indio_dev->name = JSA1212_DRIVER_NAME;
>>>>>>>>>>>>>>>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    indio_dev->info = &jsa1212_info;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = iio_device_register(indio_dev);
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        dev_err(&client->dev, "%s: register device failed\n", __func__);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    return ret;
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> + /* power off the device */
>>>>>>>>>>>>>>>>> +static int jsa1212_power_off(struct jsa1212_data *data)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    mutex_lock(&data->lock);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    ret = regmap_update_bits(data->regmap, JSA1212_CONF_REG,
>>>>>>>>>>>>>>>>> +                JSA1212_CONF_ALS_MASK |
>>>>>>>>>>>>>>>>> +                JSA1212_CONF_PXS_MASK,
>>>>>>>>>>>>>>>>> +                JSA1212_CONF_ALS_DISABLE |
>>>>>>>>>>>>>>>>> +                JSA1212_CONF_PXS_DISABLE);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    if (ret < 0)
>>>>>>>>>>>>>>>>> +        dev_err(&data->client->dev, "power off cmd failed\n");
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    mutex_unlock(&data->lock);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    return ret;
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static int jsa1212_remove(struct i2c_client *client)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>>>>>>>>>>>>>>>> +    struct jsa1212_data *data = iio_priv(indio_dev);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    iio_device_unregister(indio_dev);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    return jsa1212_power_off(data);
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +#ifdef CONFIG_PM_SLEEP
>>>>>>>>>>>>>>>>> +static int jsa1212_suspend(struct device *dev)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    struct jsa1212_data *data;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    return jsa1212_power_off(data);
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static int jsa1212_resume(struct device *dev)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +    int ret = 0;
>>>>>>>>>>>>>>>>> +    struct jsa1212_data *data;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    mutex_lock(&data->lock);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    if (data->als_en) {
>>>>>>>>>>>>>>>>> +        ret = jsa1212_als_enable(data, JSA1212_CONF_ALS_ENABLE);
>>>>>>>>>>>>>>>>> +        if (ret < 0) {
>>>>>>>>>>>>>>>>> +            dev_err(dev, "als resume failed\n");
>>>>>>>>>>>>>>>>> +            goto unlock_and_ret;
>>>>>>>>>>>>>>>>> +        }
>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +    if (data->pxs_en) {
>>>>>>>>>>>>>>>>> +        ret = jsa1212_pxs_enable(data, JSA1212_CONF_PXS_ENABLE);
>>>>>>>>>>>>>>>>> +        if (ret < 0)
>>>>>>>>>>>>>>>>> +            dev_err(dev, "pxs resume failed\n");
>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +unlock_and_ret:
>>>>>>>>>>>>>>>>> +    mutex_unlock(&data->lock);
>>>>>>>>>>>>>>>>> +    return ret;
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend,
>>>>>>>>>>>>>>>>> jsa1212_resume);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +#define JSA1212_PM_OPS (&jsa1212_pm_ops)
>>>>>>>>>>>>>>>>> +#else
>>>>>>>>>>>>>>>>> +#define JSA1212_PM_OPS NULL
>>>>>>>>>>>>>>>>> +#endif
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static const struct acpi_device_id jsa1212_acpi_match[] = {
>>>>>>>>>>>>>>>>> +    {"JSA1212", 0},
>>>>>>>>>>>>>>>>> +    { },
>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>> +MODULE_DEVICE_TABLE(acpi, jsa1212_acpi_match);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static const struct i2c_device_id jsa1212_id[] = {
>>>>>>>>>>>>>>>>> +    { JSA1212_DRIVER_NAME, 0 },
>>>>>>>>>>>>>>>>> +    { }
>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>> +MODULE_DEVICE_TABLE(i2c, jsa1212_id);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +static struct i2c_driver jsa1212_driver = {
>>>>>>>>>>>>>>>>> +    .driver = {
>>>>>>>>>>>>>>>>> +        .name    = JSA1212_DRIVER_NAME,
>>>>>>>>>>>>>>>>> +        .pm    = JSA1212_PM_OPS,
>>>>>>>>>>>>>>>>> +        .owner    = THIS_MODULE,
>>>>>>>>>>>>>>>>> +        .acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
>>>>>>>>>>>>>>>>> +    },
>>>>>>>>>>>>>>>>> +    .probe        = jsa1212_probe,
>>>>>>>>>>>>>>>>> +    .remove        = jsa1212_remove,
>>>>>>>>>>>>>>>>> +    .id_table    = jsa1212_id,
>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>> +module_i2c_driver(jsa1212_driver);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +MODULE_AUTHOR("Sathya Kuppuswamy
>>>>>>>>>>>>>>>>> <sathyanarayanan.kuppuswamy@linux.intel.com>");
>>>>>>>>>>>>>>>>> +MODULE_DESCRIPTION("JSA1212 proximity/ambient light sensor driver");
>>>>>>>>>>>>>>>>> +MODULE_LICENSE("GPL v2");
>>>>>>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
