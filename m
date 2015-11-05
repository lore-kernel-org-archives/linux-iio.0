Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:60589 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750842AbbKEFY4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Nov 2015 00:24:56 -0500
Subject: Re: IIO device indexing issue
To: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <5637AFC5.7080007@gmail.com> <5639D22D.3050901@metafoo.de>
 <563A5412.4030102@gmail.com> <563AB014.4030401@electromag.com.au>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <563AE81F.5050700@electromag.com.au>
Date: Thu, 5 Nov 2015 13:24:47 +0800
MIME-Version: 1.0
In-Reply-To: <563AB014.4030401@electromag.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 5/11/2015 9:25 AM, Phil Reid wrote:
> On 5/11/2015 2:53 AM, Vesa Jääskeläinen wrote:
>> On 04/11/15 11:38, Lars-Peter Clausen wrote:
>>> On 11/02/2015 07:47 PM, Vesa Jääskeläinen wrote:
>>>> Hi,
>>>>
>>>> When we were using kernel 3.2 and with that board files we just got 
>>>> IIO
>>>> devices with static order so that we knew exactly what iio:device0 is.
>>>>
>>>> Now with device tree that order is not so static anymore especially 
>>>> when
>>>> using device overlays (have not yet tried that thou). If there 
>>>> would be
>>>> deferred probe for the device then if we have multiple iio:device's 
>>>> then
>>>> those could in theory be in any order.
>>>>
>>>> In example libiio uses iio device index to open the IIO device. So the
>>>> problem is to know what iio:device is what.
>>>>
>>>> If we look files under /sys/bus/iio/iio:deviceX. They do not reveal 
>>>> what
>>>> device this is (especially if there are multiple device of same 
>>>> type). There
>>>> does not seem to be a way to give custom name for the iio device 
>>>> from device
>>>> tree that could have been used as a cue.
>>>>
>>>> Device tree aliases kinda sounded a good idea to try. Eg. define 
>>>> adc0 alias
>>>> and then link it to actual device node in tree.
>>>>
>>>> Aliases could be found under /proc/device-tree/aliases. Looking at 
>>>> it shows
>>>> what device tree node it is. However there does not seem to be 
>>>> actual link
>>>> from any /proc/device-tree entries to kernel drivers exposed under 
>>>> sysfs.
>>>> And even the path components in device tree are not in same format 
>>>> as in
>>>> sysfs. So there is no 1:1 mapping possible here.
>>>>
>>>> IIO devices in /sys/bus/iio/iio:deviceX seem to be symlinks to actual
>>>> devices under /sys/devices and from there is physical path to the 
>>>> device and
>>>> under that the IIO device with the same name as is under /sys/bus/iio.
>>>>
>>>> So in theory we could make a mapping configuration file that specifies
>>>> logical name for iio device and then physical parent path for the 
>>>> device and
>>>> then find under it iio:device* files to determine what is the iio 
>>>> device
>>>> index for this physical device. Then open IIO device with that 
>>>> index in
>>>> example with libiio. Sounds a bit complex?
>>>>
>>>> So did we miss something on how this should be defined/accessed or 
>>>> is there
>>>> a slight issue here on how to identify iio devices?
>>>>
>>>> Don't know how device tree overlays affect this if we first load 
>>>> device tree
>>>> overlay with some configuration and then unload it and load another 
>>>> one with
>>>> different configuration.
>>> Hi,
>>>
>>> Yes, excellent analysis. This is a real issue. As you said there is no
>>> guarantee that the IIO device numbers are stable, they are assigned 
>>> in the
>>> order the devices are registered. If the device are registered in a
>>> different order for whatever reason the numbers will change. You can 
>>> use
>>> readlink on the IIO device in /sys/bus/iio/devices to get its 
>>> position in
>>> the global device topology and be able to tell what the parent 
>>> device is,
>>> but this path might not be completely stable either though. E.g. if 
>>> your
>>> device is on a I2C bus and the number of the I2C bus is dynamically 
>>> assigned
>>> it might change when the probe order changes.
>>>
>>> Alias seem to be one way to solve this issue. The big question 
>>> remains is
>>> how to communicate the alias to userspace. For other device classes the
>>> alias index is used as the device index e.g. a device with alias 
>>> i2c0 ends
>>> up being the i2c adapter with index 0. But with IIO where we support 
>>> a wide
>>> range of different devices that does not really work. E.g. what to 
>>> do if you
>>> have adc0 and dac0 as aliases for different devices. So you'd need a
>>> different way to expose the alias.
>>>
>>> Some bindings also use the "label" property to assign a unique name 
>>> to node.
>>> But again the same issue how to expose that information to 
>>> applications.
>>>
>> To continue from this "label" property idea I was wondering if we 
>> would add it as new optional(?) file node for IIO devices.
>>
>> One could then specify it like:
>>
>> tscadc: tscadc@44e0d000 {
>>     compatible = "ti,am3359-tscadc";
>> ...
>>     am335x_adc: adc {
>>         compatible = "ti,am3359-adc";
>> ...
>>         label = "Port A";
>>     };
>> };
>>
>> And this would generate file /sys/bus/iio/iio:deviceX/label with 
>> contents of "Port A".
>>
>> Then during the application startup it would just need to scan all 
>> devices under /sys/bus/iio and determine what labelled device it 
>> wants to use.
>>
>> It would be up to device's developer to determine what labels to use 
>> in their designs. This would not break ABI and would be just an 
>> extension for it.
>>
>> One could also auto-assign label "am335x_adc" in this case too. But 
>> if you include existing arch device tree then changing label in top 
>> level is kinda a bit annoying as you would then need to duplicate all 
>> properties with another label and disable arch device tree's 
>> settings. Could cause also conflict if there are references elsewhere 
>> to existing arch nodes.
>>
>> Having following in device's device tree file would allow one to 
>> override label or just only specify that.
>>
>> #include "am33xx.dtsi"
>>
>> &tscadc {
>>     status = "okay";
>>
>>     adc {
>>         ti,adc-channels = <4 5 6 7>;
>>
>>         label = "Port A";
>>     };
>> };
>>
>> I think this "label" model would be simple to understand.
>>
>> Whether this needs to be implemented as per device driver feature or 
>> could be implemented as generic IIO functionality I do not know.
>>
>> Thanks,
>> Vesa Jääskeläinen
> This would be a very useful feature as I'm encountering this problem 
> at the moment.
> The label concept is simple and easy to use.
Thinking a bit more how would this work if accessing the device via the 
network interface.
Currently it show the device (chip) name (eg max5541) but there can be 
multiple devices like that.
Needs to be published thru libiio as well?

Regards
Phil
