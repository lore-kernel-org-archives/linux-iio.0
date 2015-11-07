Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34362 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbbKGJDa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Nov 2015 04:03:30 -0500
Subject: Re: IIO device indexing issue
To: Markus Pargmann <mpa@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
References: <5637AFC5.7080007@gmail.com> <563A5412.4030102@gmail.com>
 <563BAA65.3020609@kernel.org> <5517276.dg3z7SpAvu@adelgunde>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <563DBE5E.6060307@gmail.com>
Date: Sat, 7 Nov 2015 11:03:26 +0200
MIME-Version: 1.0
In-Reply-To: <5517276.dg3z7SpAvu@adelgunde>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/15 11:49, Markus Pargmann wrote:
> Hi,
>
> On Thursday, November 05, 2015 07:13:41 PM Jonathan Cameron wrote:
>> On 04/11/15 18:53, Vesa Jääskeläinen wrote:
>>> To continue from this "label" property idea I was wondering if we
>>> would add it as new optional(?) file node for IIO devices.>
>>> One could then specify it like:
>>>
>>> tscadc: tscadc@44e0d000 {
>>>      compatible = "ti,am3359-tscadc";
>>> ...
>>>      am335x_adc: adc {
>>>          compatible = "ti,am3359-adc";
>>> ...
>>>          label = "Port A";
>>>      };
>>> };
>>>
>>> And this would generate file /sys/bus/iio/iio:deviceX/label with
>>> contents of "Port A".
>>>
>>> Then during the application startup it would just need to scan all
>>> devices under /sys/bus/iio and determine what labelled device it
>>> wants to use.
>>>
>>> It would be up to device's developer to determine what labels to use
>>> in their designs. This would not break ABI and would be just an
>>> extension for it.
>>>
>>> One could also auto-assign label "am335x_adc" in this case too. But
>>> if you include existing arch device tree then changing label in top
>>> level is kinda a bit annoying as you would then need to duplicate all
>>> properties with another label and disable arch device tree's
>>> settings. Could cause also conflict if there are references elsewhere
>>> to existing arch nodes.
>>>
>>> Having following in device's device tree file would allow one to
>>> override label or just only specify that.
>>>
>>> #include "am33xx.dtsi"
>>>
>>> &tscadc {
>>>      status = "okay";
>>>
>>>      adc {
>>>          ti,adc-channels = <4 5 6 7>;
>>>
>>>          label = "Port A";
>>>      };
>>> };
>>>
>>> I think this "label" model would be simple to understand.
>>>
>>> Whether this needs to be implemented as per device driver feature or
>>> could be implemented as generic IIO functionality I do not know.
>> The principal looks good to me.  It's not however only an IIO issue
>> so perhaps we should expand the discussion to include other subsystems
>> likely to have similar issues (though perhaps to a lesser degree) such as
>> hwmon and input?  Any others?
>>
>> We could also autobuild the label from other sources such as ACPI
>> to uniquely describe the instance of the device (afterall all we really
>> care about is that it always has the same name on the same hardware,
>> being able to assign meaningful simple names would just be the icing
>> on the cake!)
> There is a similar discussion for the new character device GPIO interface.[1]
>
> Simple labels have the problem that they could be the same for two devicetree
> overlays or chips that are connected via SPI.
>
As far as I understand the overlays, you always specify a hardware 
hierarchy where you want to add additional information to device tree. 
This means that while adding device with overlays you have full control 
what device it is and then can configure what label property device 
should have.

If you would add two SPI devices those would be unique items in the 
device tree this means that overlay adding those would be unique and 
then you can assign unique label for the devices.

When you have full control for device tree and device tree overlays 
added to your device then this should not be problem?

Problem not addressed by device tree would be dynamically configured 
buses like USB which could have user connected devices. But then again 
you probably do not configure this with device tree either? In this case 
if "label" would be read&write property then udev or such could then 
fill it with details based on your configuration.

As commented on the thread you pointed out was question should the label 
property have physical path components in there. There was comment that 
symlink (in IIO case this would be symlinks under /sys/bus/iio/) should 
have the details available if this is needed for decision.

Basically application developer could have following tools to perform 
his decision:

Scan /sys/bus/iio/ for iio:deviceN's.

- Get "name" property (driver identification).
- Do realpath for symlink to get physical address
- Get "label" property to have cue what this device is for

On other thread one idea was to have UUID for devices as a label (fstab 
+ partition UUID's was the idea behind it). How to make it stick for 
every boot is the problem here however. You could use UUID in hash mode 
(eg. version 5) and then just determine what details affect it. For USB 
devices which could be moved to other slots this is still an issue as on 
some cases it would be irrelevant on what slot it is and in some cases 
it could be relevant. There are also other properties that are device 
specific like should the UUID hash include serial number of the device 
or not? This same problem matches to other automatic label cases. So I 
suppose there is no one solution that fits for all cases.

To setup label automatically you seem to need to have local configuration.

If the process would be something like:

- Setup device tree with optional label property.
- If label is not defined in device tree leave it as empty
- When user space starts up it can have local configuration that adjusts 
labels
- If there is a daemon in system like udev and new device is inserted 
then it could have rules for configuring labels.

I think this would allow one to setup whatever identification one wants 
to use for label.

Rest would be application configuration that uses available information 
to do its magic.

Thanks,
Vesa Jääskeläinen
