Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39531 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbcGCRjK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 13:39:10 -0400
Subject: Re: [PATCH 1/3] mfd: add support for Allwinner SoCs ADC
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
 <87ab8638-926b-89ce-26a5-705a321d3066@kernel.org>
 <5779422D.9060207@metafoo.de>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57794DB3.2050506@roeck-us.net>
Date: Sun, 3 Jul 2016 10:38:59 -0700
MIME-Version: 1.0
In-Reply-To: <5779422D.9060207@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2016 09:49 AM, Lars-Peter Clausen wrote:
> On 07/03/2016 01:17 PM, Jonathan Cameron wrote:
>> On 28/06/16 09:18, Quentin Schulz wrote:
>>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>>> controller and a thermal sensor. For now, only the ADC and the thermal
>>> sensor drivers are probed by the MFD, the touchscreen controller support
>>> will be added later.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> The code looks fine to me. The 'controversial' bit of this is listing
>> iio-hwmon as an mfd child to get it to probe as a result of this being
>> present.  My immediately thought is that it should be separately
>> described in the devicetree and hence instantiated outside of this driver.
>
> The devicetree is a generic description of the hardware. The iio-hwmon
> bridge is a software component that translates between two Linux specific
> ABIs. In my opinion putting the later in the former is makes no sense, it is
> simply not part of the hardware description.
>
Actually, this is where people get it wrong.

> Its quite terrible that we have the bindings in the first place, but I guess
> we have to keep them considering they are ABI and there are existing users.
> But we should definitely strongly discourage the introduction of new users.
>

I do agree that the _bindings_ are bad.

The ultimate problem is to find bindings which do describe the hardware
in a way that would be acceptable to the devicetree community and is at the
same time useful for software when trying to determine what to do with that
hardware. _This_ is the exceptionally hard problem.

One example would be an adc channel connected to a board voltage. I would assume
that it should be permissible to describe this relationship in a way that can
be _used_ by software to expose that adc channel as voltage, by whatever
means necessary (it be through hwmon or as a regulator or whatever).

Similar, some pin on a chip may be connected to a thermal sensor. I would
assume that it should be permissible to describe that thermal sensor (and its
location) in a way that can be _used_ by software in a meaningful way, either
for it to be reported as hardware monitoring attribute or to be used by the
thermal subsystem as a thermal input channel.

In addition to that, there are various other properties which _do_ describe
the hardware, but are commonly seen as "software". Examples for that would
be voltage or temperature limits (or any other limits, for that matter).
Such limits _are_ part of the hardware description, but are not commonly
accepted as such.

> It is policy whether an application wants to access a device using the IIO
> or hwmon API. As such it must be managed by userspace, this is not something
> that can be done using devicetree nor should it be something that is done on
> a driver by driver basis.
>

Agreed. However, the connections from one chip to another, and the use of a chip
on a board, _is_ part of the hardware description. It is determined by the
schematics as well as the board layout. A well defined hardware description
needs to provide more than "this is an ADC channel" or "this is a thermal sensor".

Guenter

