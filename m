Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33326 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753173AbcIAIft (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2016 04:35:49 -0400
Subject: Re: [PATCH v3 3/4] mfd: mfd-core: reattach mfd of_node to cells
 without of_compatible
To: Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160809134847.GJ5243@dell> <20160824063853.GB8103@lukather>
 <20160831115655.GE8649@dell>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <e01087ef-b5a3-a60f-fa7d-b05e12372f22@free-electrons.com>
Date: Thu, 1 Sep 2016 10:35:46 +0200
MIME-Version: 1.0
In-Reply-To: <20160831115655.GE8649@dell>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/2016 13:56, Lee Jones wrote:
> On Wed, 24 Aug 2016, Maxime Ripard wrote:
> 
>> Hi Lee,
>>
>> On Tue, Aug 09, 2016 at 02:48:47PM +0100, Lee Jones wrote:
>>> On Tue, 26 Jul 2016, Quentin Schulz wrote:
>>>
>>>> When an MFD cell has an of_compatible (meaning it is present in the Device
>>>> Tree), other nodes can reference it using a phandle.
>>>>
>>>> However when the MFD cell is not declared in the Device Tree, the only way
>>>> other nodes can reference it are by using a phandle to the MFD. Then when
>>>> this MFD cell tries to register itself in one framework, the registration
>>>> is denied by the framework because it is not matching the of_node of the
>>>> node which is referenced by the phandle in one of the other nodes.
>>>>
>>>> This reattaches the of_node of the MFD to the MFD cell device structure
>>>> when the MFD cell has no of_compatible.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>> ---
>>>>
>>>> We need this modification to register the thermal sensor in the thermal
>>>> framework.
>>>>
>>>> Added in v3.
>>>>
>>>>  drivers/mfd/mfd-core.c | 14 +++++++++-----
>>>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> Can you show me the DT code where this is used?
>>>
>>> Is it used by a patch in this series?
>>
>> Yes and no.
>>
>> This is not used directly by any code found in those patches.
>>
>> However, those patches are actually a rewrite of an existing driver
>> that was there before (drivers/input/touchscreen/sun4i-ts.c), that
>> already had some DT bindings and was enabled in a few DT already [1].
>>
>> The issue here is that for the new driver to be able to follow the
>> phandles as it used to (which is also already used [2]). Obviously, in
>> the usual mechanism (at least when you don't declare the mfd childs in
>> the DT), the childs won't have any of_node associated to it, and this
>> is fine in most cases.
>>
>> This is where things get messy. The MFD childs will also register to
>> their framework without, and then the whole phandle lookup goes nuts,
>> because the phandles will point to the MFD's of_node, but no one will
>> actually be registered anywhere with that of_node, which means that we
>> broke all the links expressed by the phandles.
> 
> I'm concerned that this change may have unintended side-effects for
> existing drivers.  Can you point me to the C code where this is
> causing an issue.  Perhaps we can solve the issue without changing
> subsystem core code.  By doing so we reduced the chance of
> destructive ramifications for others.
> 

I have actually a problem with this driver as well: the MFD driver is
probed thrice (once for itself and once for each of its subdrivers). I
haven't found yet why. Anyway.

In our case (Allwinner SoCs), the thermal sensor of the SoC is exposed
via the ADC. As Maxime explained, this driver is meant to replace an
existing driver
(http://lxr.free-electrons.com/source/drivers/input/touchscreen/sun4i-ts.c)
which already has its node
(http://lxr.free-electrons.com/source/arch/arm/boot/dts/sun5i.dtsi#L653)
in the DT.

The thermal driver has a node
(http://lxr.free-electrons.com/source/arch/arm/boot/dts/sun5i-a13.dtsi#L70)
in the DT which registers the ADC driver's node as a thermal sensor via
a phandle.

To avoid modifying the DT, the MFD driver is using the same node as the
existing driver but the MFD children are not added as children of that
node. This means the new ADC driver (which is a child of the MFD driver
and "node-less") which registers in thermal framework will be registered
without any of_node and thus, won't actually be used because the phandle
registered by the thermal driver in the DT does not match the of_node
(which is null) of the ADC driver registering in the thermal framework.

The function used to register in the thermal framework is
devm_thermal_zone_of_sensor_register
(http://lxr.free-electrons.com/source/drivers/thermal/of-thermal.c#L602).
It takes a device with an of_node referenced as a phandle in the DT and
any structure to pass to the get_temp function of the thermal framework
(among other parameters)
AFAIK, the device is only used for node matching between the phandle in
the thermal driver's node and the device's of_node while the structure
is used to compute the temperature.


>From this, we found two solutions:
- reattach the MFD driver's node to all its children, (what we did)
- "impersonate" the MFD driver in the devm_thermal_zone_of_sensor_register:

instead of
tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
                                           &sun4i_ts_tz_ops);

we could have:
tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, info,

                                           &sun4i_ts_tz_ops);

I'm starting to think the second solution is more appropriate.

Let me know your thoughts on this!

Quentin

>> 1: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun7i-a20.dtsi#n1520
>> 2: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun7i-a20.dtsi#n130
>>
> 
> 
> 
