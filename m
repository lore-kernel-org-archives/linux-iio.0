Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:64689 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbaFXNkg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jun 2014 09:40:36 -0400
MIME-Version: 1.0
In-Reply-To: <20140624133231.GI5856@leverpostej>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
 <1403612356-23685-3-git-send-email-ch.naveen@samsung.com> <20140624133231.GI5856@leverpostej>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Tue, 24 Jun 2014 19:10:15 +0530
Message-ID: <CAHfPSqBTKa8hRC6EH5qe4pTG9CF6dNAF4yn52SGu9zXNoY16QQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: ntc_thermistor: Use the manufacturer name properly
To: Mark Rutland <mark.rutland@arm.com>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"kgene.kim@samsung.com" <kgene.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"cpgs@samsung.com" <cpgs@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Mark,

On 24 June 2014 19:02, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jun 24, 2014 at 01:19:14PM +0100, Naveen Krishna Chatradhi wrote:
>> Murata Manufacturing Co., Ltd is the vendor for
>> NTC (Negative Temperature coefficient) based Thermistors.
>> But, the driver extensively uses "NTC" as the vendor name.
>>
>> This patch corrects the vendor name also updates the
>> compatibility strings according to the vendor-prefix.txt
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> ---
>> This changes is needed for the following reasons
>>
>> 1. The vendor prefix "ntc" is not defined in vendor-prefixes.txt
>>    Thus, giving an error when checked with scripts/checkpatch.pl
>> 2. Murata Manufacturing Co., Ltd. Is the vendor for the
>>    NTC (Negative Temperature Coefficient) based thermistors.
>>    Hence, "murata" is the right vendor-prefix, Not "ntc".
>> 3. NTC is a technology used, But the prefix "ntc" is wrongly
>>    and heavily used in the driver and the documentation.
>>
>>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |    2 +-
>>  .../devicetree/bindings/hwmon/ntc_thermistor.txt   |   12 ++++++------
>>  Documentation/hwmon/ntc_thermistor                 |    8 ++++----
>>  drivers/hwmon/Kconfig                              |    5 +++--
>>  drivers/hwmon/ntc_thermistor.c                     |   12 ++++++------
>>  5 files changed, 20 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> index 5d49f2b..832fe8c 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> @@ -48,7 +48,7 @@ adc@12D10000 {
>>
>>       /* NTC thermistor is a hwmon device */
>>       ncp15wb473@0 {
>> -             compatible = "ntc,ncp15wb473";
>> +             compatible = "murata,ncp15wb473";
>>               pullup-uv = <1800000>;
>>               pullup-ohm = <47000>;
>>               pulldown-ohm = <0>;
>> diff --git a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
>> index c6f6667..4e9f344 100644
>> --- a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
>> +++ b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
>> @@ -3,11 +3,11 @@ NTC Thermistor hwmon sensors
>>
>>  Requires node properties:
>>  - "compatible" value : one of
>> -     "ntc,ncp15wb473"
>> -     "ntc,ncp18wb473"
>> -     "ntc,ncp21wb473"
>> -     "ntc,ncp03wb473"
>> -     "ntc,ncp15wl333"
>> +     "murata,ncp15wb473"
>> +     "murata,ncp18wb473"
>> +     "murata,ncp21wb473"
>> +     "murata,ncp03wb473"
>> +     "murata,ncp15wl333"
>
> So we're outright changing these rather than deprecating the existing
> forms?
>
> In general we've pushed back on changes like this, and requested that
> the old strings are kept in both documentation and code as deprecated
> forms.

Should have kept the old bindings as deprecated.

>
> Can you guarantee that changing this is not going to stop someone's
> board worknig properly? I suspect not.

As a result of this change, Exynos4412-Trats2 board is broken.
Will re-spin with the deprecated binding.

>
> Mark.
>
>>  - "pullup-uv"        Pull up voltage in micro volts
>>  - "pullup-ohm"       Pull up resistor value in ohms
>>  - "pulldown-ohm" Pull down resistor value in ohms
>> @@ -21,7 +21,7 @@ Read more about iio bindings at
>>
>>  Example:
>>       ncp15wb473@0 {
>> -             compatible = "ntc,ncp15wb473";
>> +             compatible = "murata,ncp15wb473";
>>               pullup-uv = <1800000>;
>>               pullup-ohm = <47000>;
>>               pulldown-ohm = <0>;
>> diff --git a/Documentation/hwmon/ntc_thermistor b/Documentation/hwmon/ntc_thermistor
>> index 3bfda94..057b770 100644
>> --- a/Documentation/hwmon/ntc_thermistor
>> +++ b/Documentation/hwmon/ntc_thermistor
>> @@ -1,7 +1,7 @@
>>  Kernel driver ntc_thermistor
>>  =================
>>
>> -Supported thermistors:
>> +Supported thermistors from Murata:
>>  * Murata NTC Thermistors NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, NCP15WL333
>>    Prefixes: 'ncp15wb473', 'ncp18wb473', 'ncp21wb473', 'ncp03wb473', 'ncp15wl333'
>>    Datasheet: Publicly available at Murata
>> @@ -15,9 +15,9 @@ Authors:
>>  Description
>>  -----------
>>
>> -The NTC thermistor is a simple thermistor that requires users to provide the
>> -resistance and lookup the corresponding compensation table to get the
>> -temperature input.
>> +The NTC (Negative Temperature Coefficient) thermistor is a simple thermistor
>> +that requires users to provide the resistance and lookup the corresponding
>> +compensation table to get the temperature input.
>>
>>  The NTC driver provides lookup tables with a linear approximation function
>>  and four circuit models with an option not to use any of the four models.
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 08531a1..154851b 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1052,7 +1052,7 @@ config SENSORS_PC87427
>>         will be called pc87427.
>>
>>  config SENSORS_NTC_THERMISTOR
>> -     tristate "NTC thermistor support"
>> +     tristate "NTC based thermistor support from Murata"
>>       depends on !OF || IIO=n || IIO
>>       help
>>         This driver supports NTC thermistors sensor reading and its
>> @@ -1060,7 +1060,8 @@ config SENSORS_NTC_THERMISTOR
>>         send notifications about the temperature.
>>
>>         Currently, this driver supports
>> -       NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333.
>> +       NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333
>> +       from Murata.
>>
>>         This driver can also be built as a module.  If so, the module
>>         will be called ntc-thermistor.
>> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
>> index e76feb86..6c38fc8 100644
>> --- a/drivers/hwmon/ntc_thermistor.c
>> +++ b/drivers/hwmon/ntc_thermistor.c
>> @@ -163,15 +163,15 @@ static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
>>  }
>>
>>  static const struct of_device_id ntc_match[] = {
>> -     { .compatible = "ntc,ncp15wb473",
>> +     { .compatible = "murata,ncp15wb473",
>>               .data = &ntc_thermistor_id[0] },
>> -     { .compatible = "ntc,ncp18wb473",
>> +     { .compatible = "murata,ncp18wb473",
>>               .data = &ntc_thermistor_id[1] },
>> -     { .compatible = "ntc,ncp21wb473",
>> +     { .compatible = "murata,ncp21wb473",
>>               .data = &ntc_thermistor_id[2] },
>> -     { .compatible = "ntc,ncp03wb473",
>> +     { .compatible = "murata,ncp03wb473",
>>               .data = &ntc_thermistor_id[3] },
>> -     { .compatible = "ntc,ncp15wl333",
>> +     { .compatible = "murata,ncp15wl333",
>>               .data = &ntc_thermistor_id[4] },
>>       { },
>>  };
>> @@ -534,7 +534,7 @@ static struct platform_driver ntc_thermistor_driver = {
>>
>>  module_platform_driver(ntc_thermistor_driver);
>>
>> -MODULE_DESCRIPTION("NTC Thermistor Driver");
>> +MODULE_DESCRIPTION("NTC based Thermistor Driver from Murata");
>>  MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
>>  MODULE_LICENSE("GPL");
>>  MODULE_ALIAS("platform:ntc-thermistor");
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>



-- 
Shine bright,
(: Nav :)
