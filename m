Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43984 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbcJALWB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 07:22:01 -0400
Subject: Re: [PATCH 2/3] Documentation: dt: iio: add mcp4725/6 dac device
 binding
To: Tomas Novotny <tomas@novotny.cz>, devicetree@vger.kernel.org
References: <1475241588-18429-1-git-send-email-tomas@novotny.cz>
 <1475241588-18429-3-git-send-email-tomas@novotny.cz>
 <ac9b5f52-5ac1-52a9-aa9a-eb812639e033@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8815a607-c9e3-e7e7-0884-2d5d49c353b4@kernel.org>
Date: Sat, 1 Oct 2016 12:21:57 +0100
MIME-Version: 1.0
In-Reply-To: <ac9b5f52-5ac1-52a9-aa9a-eb812639e033@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/16 12:15, Jonathan Cameron wrote:
> On 30/09/16 14:19, Tomas Novotny wrote:
>> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
>> ---
>>  .../devicetree/bindings/iio/dac/mcp4725.txt        | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/mcp4725.txt b/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
>> new file mode 100644
>> index 0000000..69c9462
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
>> @@ -0,0 +1,28 @@
>> +Microchpip mcp4725 and mcp4726 DAC device driver
>> +
>> +Required properties:
>> +	- compatible: Must be "microchip,mcp4725" or "microchip,mcp4726"
>> +	- reg: Should contain the DAC I2C address
>> +	- vref-millivolt: Value of the reference voltage
Sorry dozing this morning so missed this until looking at the code.

Use the regulator framework to supply two regulators:

vref-suppy and vdd-supply
first one optional.

Then query them in the driver.  Much more flexible than just hard coding
a value here.  Entirely possible to have a variable regulator used for
the reference.
>> +
>> +Optional properties:
>> +	- vref-mode: Reference voltage selection. It is available only on
> Not a generic attribute, so wants to have a vendor prefix on it.
>> +	  mcp4726. Valid values are:
>> +		- 0, 1: Vdd pin voltage (unbuffered)
> This should not be a direct mapping of the register values but rather
> a means to control the setting.  Having two values mapping to the
> same thing makes no sense.
> 
> Would also be odd to specify a vref and then not use it.  So you could
> infer this first option.
>> +		- 2: Vref pin voltage unbuffered
>> +		- 3: Vref pin voltage internally buffered
> Having inferred the first option then this becomes control of whether it
> is buffered  or not. So could be named appropriately to cover that.
> Might be nice to have a little note here on why you might want the
> buffer or not..
>> +
>> +Examples:
>> +
>> +        mcp4725@60 {
>> +                compatible = "microchip,mcp4725";
>> +                reg = <0x60>;
>> +                vref-millivolt = <3300>;
>> +        };
>> +
>> +        mcp4726@60 {
>> +                compatible = "microchip,mcp4726";
>> +                reg = <0x60>;
>> +                vref-mode = <2>;
>> +                vref-millivolt = <2500>;

>> +        };
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

