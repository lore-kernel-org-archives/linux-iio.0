Return-Path: <mfuzzey@parkeon.com>
Message-ID: <559A3715.3040206@parkeon.com>
Date: Mon, 06 Jul 2015 10:06:45 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Martin Kepplinger <martink@posteo.de>,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 roberta.dobrescu@gmail.com, christoph.muellner@theobroma-systems.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 5/9] iio: mma8452: add devicetree documentation
References: <1436018110-3903-1-git-send-email-martink@posteo.de> <1436018110-3903-6-git-send-email-martink@posteo.de> <5599199B.6030006@kernel.org>
In-Reply-To: <5599199B.6030006@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/07/15 13:48, Jonathan Cameron wrote:
> On 04/07/15 14:55, Martin Kepplinger wrote:
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> This is trivial enough I'll take it without a device tree ack (after a few days)
> but convention is to CC all device tree patches to the maintainers of devicetree
> bindings as well as the devicetree list.

Currently the binding is covered by 
Documentation/devicetree/bindings/i2c/trivial-devices.txt
Shouldn't that one be removed now that a full binding document is being 
created?

Regards,

Martin

> Jonathan
>> ---
>>   .../devicetree/bindings/iio/accel/mma8452.txt       | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> new file mode 100644
>> index 0000000..8d98e05
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> @@ -0,0 +1,21 @@
>> +Freescale MMA8452Q, MMA8453Q, MMA8652FC or MMA8653FC triaxial accelerometer
>> +
>> +Required properties:
>> +
>> +  - compatible: should be "fsl,mma8653", "fsl,mma8652", "fsl,mma8453" or
>> +    "fsl,mma8452" respectively.
>> +  - reg: the I2C address of the chip
>> +
>> +Optional properties:
>> +
>> +  - interrupt-parent: should be the phandle for the interrupt controller
>> +  - interrupts: interrupt mapping for GPIO IRQ
>> +
>> +Example:
>> +
>> +	mma8653fc@1d {
>> +		compatible = "fsl,mma8653";
>> +		reg = <0x1d>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <5 0>;
>> +	};
>>
