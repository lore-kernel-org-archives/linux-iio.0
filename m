Return-Path: <lars@metafoo.de>
Message-ID: <50C7932A.2030104@metafoo.de>
Date: Tue, 11 Dec 2012 21:10:18 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
CC: Jonathan Cameron <jic23@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] fixes for adt7410
References: <50032AD8.9040103@gmx.de> <50033218.7030602@metafoo.de> <20120716083428.GD30009@pengutronix.de> <5003D404.4040005@kernel.org> <50C7902C.2060804@gmx.de>
In-Reply-To: <50C7902C.2060804@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

On 12/11/2012 08:57 PM, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> On 7/16/2012 9:34 AM, Sascha Hauer wrote:
>>> On Sun, Jul 15, 2012 at 11:11:52PM +0200, Lars-Peter Clausen wrote:
>>>> On 07/15/2012 10:40 PM, Hartmut Knaack wrote:
>>>>> This patchset makes the ADT7410 usable. Main reason was the following error when trying to register one of these devices:
>>>>> [  180.945561] BUG: unable to handle kernel NULL pointer dereference at   (null)
>>>>> [  180.945592] IP: [<f84b1e80>] iio_device_register_eventset+0x380/0x3a0 [industrialio]
>>>>> This happens, since in industrialio-events.c __iio_add_event_config_attrs (which does a INIT_LIST_HEAD) is not called, if the channels attribute of the device is not set. As a result, list_for_each_entry causes those NULL pointer dereference problems. So, before trying to access those list elements, we check for their existence (also in unregister functions).
>>>>> Now the adt7410.c ended in some complex changes - my apologies for this:
>>>>>
>>>>>    * check for exact values provided through sysfs, otherwise output a verbose error/usage message for: sample mode, resolution, event mode
>>>>>    * adt7410_show_id: I don't see a point in masking out some LSBs, if they get shifted to oblivion, anyway -> no more need for ADT7410_MANUFACTORY_ID_MASK
>>>>>    * adt7410_convert_temperature: in 13 bit mode, the driver assumed the data to be stored in bits 0-12, but according to the data sheet, it is stored in bits 3-15. Temperature readings were always around 200(°C), while real temperature was something around 20(°C). Simple fix: mask out bits 0-2 in 13 bit mode and use the 16 bit routines from that point on.
>>>>>    * adt7410_set_t_bound: handle float values provided through sysfs properly. Also, simplify treatment of 13 bit values by masking out bits 0-2.
>>>>>    * adt7410_probe, adt7410_remove: fix another possible NULL pointer dereference issue, in case no platform data is provided. Sync chip->config with the config register
>>>> Hi,
>>>>
>>>> Sascha Hauer posted a couple of patches a while ago which seem to fix a
>>>> similar set of issues.
>>>>
>>>> See: http://www.spinics.net/lists/linux-iio/msg05947.html and
>>>> http://www.spinics.net/lists/linux-iio/msg05955.html
>>> Indeed, most if not all of the mentioned issues should be fixed already
>>> with these patches.
>>>
>> Just to reiterate what I said to Sascha at the time...  This driver does
>> not belong in IIO. It is very much a hardware monitoring part and so
>> wants to move to hwmon. We aren't going to take it out of staging into
>> drivers/iio and I'm rather unwilling to take any 'new' features into the
>> staging version. Someone with hardware who is interesting needs to bite
>> the bullet and convert / rewrite this driver as a hwmon device.
>>
> FYI, I created a basic hwmon driver for ADT7410, which now made it into linux 3.7.
> Take care

Ah, great, now we have two drivers which bind to the same device...

- Lars
