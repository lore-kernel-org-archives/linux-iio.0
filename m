Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20151229183447.GE12450@rob-hp-laptop>
References: <1451191104-1281-1-git-send-email-mranostay@gmail.com> <20151229183447.GE12450@rob-hp-laptop>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 29 Dec 2015 18:13:58 -0800
Message-ID: <CAKzfze---+VUotfM91YC1TcEU-aK0UeNhBy8LL39772uvmVhDA@mail.gmail.com>
Subject: Re: [PATCH] iio: health: max30100: add config for LED current
To: Rob Herring <robh@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 29, 2015 at 10:34 AM, Rob Herring <robh@kernel.org> wrote:
> On Sat, Dec 26, 2015 at 08:38:24PM -0800, Matt Ranostay wrote:
>> Allow the current for both RED and IR LEDs to be set via an device tree
>> property setting.
>>
>> This is an optional setting that is useful for applications that have a
>> known glass attenuation factor.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/health/max30100.txt     |  7 +++++++
>>  drivers/iio/health/max30100.c                       | 21 +++++++++++++++------
>>  2 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/health/max30100.txt b/Documentation/devicetree/bindings/iio/health/max30100.txt
>> index f6fbac6..009314c 100644
>> --- a/Documentation/devicetree/bindings/iio/health/max30100.txt
>> +++ b/Documentation/devicetree/bindings/iio/health/max30100.txt
>> @@ -11,11 +11,18 @@ Required properties:
>>    Refer to interrupt-controller/interrupts.txt for generic
>>    interrupt client node bindings.
>>
>> +Optional properties:
>> +  - max30100,led-current: configuration for LED current (in mA) while the engine
>> +    is running. Upper nibble is for the RED LED, and lower nibble the IR LED.
>
> Can you use the common LED binding and led-max-microamp instead?
>
> Otherwise, please add "-microamp" suffix and just split to 2 cells for
> RED and IR LEDs. Also, "max30100" is not a vendor prefix. Use maxim.

Ok.

>
>
>> +     ret = of_property_read_u32(np, "max30100,led-current", &val);
>> +     if (ret) {
>> +             /* Default to 24 mA RED LED, 50 mA IR LED */
>> +             val = (MAX30100_REG_LED_CONFIG_24MA <<
>> +                     MAX30100_REG_LED_CONFIG_RED_LED_SHIFT) |
>> +                     MAX30100_REG_LED_CONFIG_50MA;
>> +             dev_warn(dev, "no led-current set, defaulting to %d", val);
>> +     }
>> +
>> +     ret = regmap_write(data->regmap, MAX30100_REG_LED_CONFIG, val & 0xFF);
>
> Huh? You say the units are milliamps, but then you use the DT value
> directly?

Yeah they are direct index values in the register. Probably should
make the documentation more clear.

>
> Rob
