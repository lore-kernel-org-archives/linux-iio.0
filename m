Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34870 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964936AbcKLNPn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 08:15:43 -0500
Subject: Re: [PATCH 2/2] Documentation: DT: Add bmi160 imu binding
To: Marcin Niestroj <m.niestroj@grinn-global.com>
References: <20161103112527.29623-1-m.niestroj@grinn-global.com>
 <20161103112527.29623-2-m.niestroj@grinn-global.com>
 <e46a4b5e-a347-f268-80f4-0ee1edc77aac@kernel.org>
 <d07474fc-e6c9-d529-6a06-0549f3dfad52@grinn-global.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <884563d1-67a0-d47d-09aa-59af38fdbfe4@kernel.org>
Date: Sat, 12 Nov 2016 13:15:40 +0000
MIME-Version: 1.0
In-Reply-To: <d07474fc-e6c9-d529-6a06-0549f3dfad52@grinn-global.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/16 15:18, Marcin Niestroj wrote:
> On 06.11.2016 13:41, Jonathan Cameron wrote:
>> On 03/11/16 11:25, Marcin Niestroj wrote:
>>> This adds documentation for Bosch BMI160 Inertial Measurement Unit
>>> device-tree bindings.
>>>
>>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>> Unless I missed it in the previous patch we should also have of tables
>> added to the i2c and spi files (which is why the various tests haven't
>> been screaming at me that this device doesn't have documented bindings).
> 
> Ok, I will add them.
> 
>>
>> Otherwise, the use of interrupt names to indicate which pin on the chip
>> is a little unusual (if you cribbed this from somewhere I've forgotten
>> about then do say so!), so will want a devicetree bindings maintainer
>> input on this.
> 

> I have used interrupt names similar as in other driver. Please see
> [1] for it's DT documentation and [2] for implementation.
> [1] Documentation/devicetree/bindings/iio/accel/mma8452.txt
> [2] drivers/iio/accel/mma8452.c

Fair enough.  Just put the INT1 option in the docs as requested and this
should be fine.

Jonathan
> 
>>
>> Thanks,
>>
>> Jonathan
>>> ---
>>>  .../devicetree/bindings/iio/imu/bmi160.txt         | 34 ++++++++++++++++++++++
>>>  1 file changed, 34 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
>>> new file mode 100644
>>> index 0000000..b02ef3e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
>>> @@ -0,0 +1,34 @@
>>> +Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
>>> +and externally connectable Magnetometer
>>> +
>>> +https://www.bosch-sensortec.com/bst/products/all_products/bmi160
>>> +
>>> +Required properties:
>>> + - compatible : should be "bosch,bmi160"
>>> + - reg : the I2C address or SPI chip select number of the sensor
>>> + - spi-max-frequency : set maximum clock frequency (only for SPI)
>>> +
>>> +Optional properties:
>>> + - interrupt-parent : should be the phandle of the interrupt controller
>>> + - interrupts : interrupt mapping for GPIO IRQ, must be IRQ_TYPE_LEVEL_LOW
>>> + - interrupt-names : set to "INT2" if using INT2 pin
>>> +
>>> +Examples:
>>> +
>>> +bmi160@68 {
>>> +    compatible = "bosch,bmi160";
>>> +    reg = <0x68>;
>>> +
>>> +    interrupt-parent = <&gpio4>;
>>> +    interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
>>> +};
>>> +
>>> +bmi160@0 {
>>> +    compatible = "bosch,bmi160";
>>> +    reg = <0>;
>>> +    spi-max-frequency = <10000000>;
>>> +
>>> +    interrupt-parent = <&gpio2>;
>>> +    interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
>>> +    interrupt-names = "INT2";
>>> +};
>>>
>>
> 

