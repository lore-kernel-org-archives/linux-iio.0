Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47686 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757964AbcIMRRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Sep 2016 13:17:15 -0400
Subject: Re: [PATCH] iio: dt-bindings: add documentation for Light&Proximity
 sensor STK331x
To: Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>
References: <1473758822-17955-1-git-send-email-andy.yan@rock-chips.com>
 <2244323.LAARBqky8d@phil>
Cc: knaack.h@gmx.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, mark.rutland@arm.com, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1f5a585d-c04c-a2fb-c69d-4783d674f58b@kernel.org>
Date: Tue, 13 Sep 2016 18:17:09 +0100
MIME-Version: 1.0
In-Reply-To: <2244323.LAARBqky8d@phil>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/09/16 10:53, Heiko Stuebner wrote:
> Hi,
> 
> Am Dienstag, 13. September 2016, 17:27:02 CEST schrieb Andy Yan:
>> Add the device tree binding documentation for Light & Proximity sensor
>> STK331X from Sensortek
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>>
>>  .../devicetree/bindings/iio/light/stk3310.txt       | 21
>> +++++++++++++++++++++ 1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/light/stk3310.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/stk3310.txt
>> b/Documentation/devicetree/bindings/iio/light/stk3310.txt new file mode
>> 100644
>> index 0000000..d697118
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/stk3310.txt
>> @@ -0,0 +1,21 @@
>> +* Sensortek STK331X I2C Light&Proximity sensor
>> +
>> +Required properties:
>> +- compatible: should be "sensortek,STK3310" or "sensortek,STK3311"
> 
> I guess that is more a question for Rob / Jonathan regarding the casing.
> 
> The stk3310 drivers currently provides both an acpi as well as an i2c module 
> table and in both the naming is in upper-case ... probably the i2c table being 
> simply a copy of the acpi table.
Yup. Not the best. It should have dropped to lower case for the i2c table.
I missed it.  Now it's in there we'll have to maintain both going forward
to avoid breaking anyone.
> 
> By using the i2c-quirk of extracting the i2c-id from the compatible, the 
> binding here would codify this upper case, while normally i2c tables as well 
> as dt-bindings are all lower case. 
> 
> Looking at kernel c-code and current mainline devicetree files, it doesn't look 
> like the i2c-ids gets used anywhere yet, so I guess we could do:
> 
> - keep acpi-ids as they are
> - make i2c-ids lower-case
Add another entry that is lowercase...
> - make dt-binding lower-case (and it can still use the i2c quirk to not need a 
> separate of id-table)
> 
> alternatively we could also just add a separate of-id table with the lower-
> case compatible elements.
Should have one of those as well to allow full matching.  Sooner or later
we'll run into a collision with just the part name...

Jonathan

> 
> 
> Heiko
> 
>> +- reg: the I2C address of the device
>> +- interrupt-parent: phandle to the parent interrupt controller
>> +- interrupts: interrupt mapping for GPIO IRQ
>> +
>> +Example:
>> +	&i2c1 {
>> +		/* ... */
>> +
>> +		stk3310@48 {
>> +			compatible = "sensortek,STK3310";
>> +			reg = <0x48>;
>> +			interrupt-parent = <&gpio1>;
>> +			interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>> +		};
>> +
>> +		/* ... */
>> +	};
> 
> 

