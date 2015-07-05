Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59336 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbbGEMMc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 08:12:32 -0400
Message-ID: <55991F2D.3030902@kernel.org>
Date: Sun, 05 Jul 2015 13:12:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com,
	christoph.muellner@theobroma-systems.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 5/9] iio: mma8452: add devicetree documentation
References: <1436018110-3903-1-git-send-email-martink@posteo.de> <1436018110-3903-6-git-send-email-martink@posteo.de> <5599199B.6030006@kernel.org> <55991A1E.30608@posteo.de>
In-Reply-To: <55991A1E.30608@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/15 12:50, Martin Kepplinger wrote:
> Am 2015-07-05 um 13:48 schrieb Jonathan Cameron:
>> On 04/07/15 14:55, Martin Kepplinger wrote:
>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> This is trivial enough I'll take it without a device tree ack (after a few days)
>> but convention is to CC all device tree patches to the maintainers of devicetree
>> bindings as well as the devicetree list.  
>>
>> Jonathan
> 
> Thanks a lot so far. I'll send a next version based on your review and
> will add devicetree people. Maybe you can take the series cleanly in one
> go after that. Someone that quickly runs it, other than me, would be
> awesome of course ;)
Wuss ;)  You'd be amazed how many invasive changes go in without anyone
every finding anyone to test them on particular obscure parts.
Still it is indeed always nice.
> 
>                      martin
>>> ---
>>>  .../devicetree/bindings/iio/accel/mma8452.txt       | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>> new file mode 100644
>>> index 0000000..8d98e05
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>> @@ -0,0 +1,21 @@
>>> +Freescale MMA8452Q, MMA8453Q, MMA8652FC or MMA8653FC triaxial accelerometer
>>> +
>>> +Required properties:
>>> +
>>> +  - compatible: should be "fsl,mma8653", "fsl,mma8652", "fsl,mma8453" or
>>> +    "fsl,mma8452" respectively.
>>> +  - reg: the I2C address of the chip
>>> +
>>> +Optional properties:
>>> +
>>> +  - interrupt-parent: should be the phandle for the interrupt controller
>>> +  - interrupts: interrupt mapping for GPIO IRQ
>>> +
>>> +Example:
>>> +
>>> +	mma8653fc@1d {
>>> +		compatible = "fsl,mma8653";
>>> +		reg = <0x1d>;
>>> +		interrupt-parent = <&gpio1>;
>>> +		interrupts = <5 0>;
>>> +	};
>>>
>>
> 

