Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35071 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933274AbcKWIPs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 03:15:48 -0500
Received: by mail-qt0-f172.google.com with SMTP id c47so4686499qtc.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2016 00:15:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161122165228.GK10134@dell.home>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-2-git-send-email-benjamin.gaignard@st.com> <20161122165228.GK10134@dell.home>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Wed, 23 Nov 2016 09:15:46 +0100
Message-ID: <CA+M3ks4cVLtVe4zSvSiDUz6jKy0Wbw8j24VuStf_31D5ntwfvw@mail.gmail.com>
Subject: Re: [PATCH 1/7] add binding for stm32 multifunctions timer driver
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-11-22 17:52 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Tue, 22 Nov 2016, Benjamin Gaignard wrote:
>
>> Add bindings information for stm32 timer MFD
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../devicetree/bindings/mfd/stm32-timer.txt        | 53 ++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
>> new file mode 100644
>> index 0000000..3cefce1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
>> @@ -0,0 +1,53 @@
>> +STM32 multifunctions timer driver
>
> "STM32 Multi-Function Timer/PWM device bindings"
>
> Doesn't this shared device have a better name?

In SoC documentation those hardware blocks are named "advanced-control
timers", "general purpose timers" or "basic timers"
"stm32-timer" name is already used for clock source driver, that why I
have prefix it with mfd

>
>> +stm32 timer MFD allow to handle at the same time pwm and IIO timer devices
>
> No need for this sentence.
>
OK

>> +Required parameters:
>> +- compatible: must be one of the follow value:
>> +     "st,stm32-mfd-timer1"
>> +     "st,stm32-mfd-timer2"
>> +     "st,stm32-mfd-timer3"
>> +     "st,stm32-mfd-timer4"
>> +     "st,stm32-mfd-timer5"
>> +     "st,stm32-mfd-timer6"
>> +     "st,stm32-mfd-timer7"
>> +     "st,stm32-mfd-timer8"
>> +     "st,stm32-mfd-timer9"
>> +     "st,stm32-mfd-timer10"
>> +     "st,stm32-mfd-timer11"
>> +     "st,stm32-mfd-timer12"
>> +     "st,stm32-mfd-timer13"
>> +     "st,stm32-mfd-timer14"
>
> We don't normally number devices.
>
> What's stopping you from simply doing:
>
>         pwm1: pwm1@40010000 {
>                 compatible = "st,stm32-pwm";
>         };
>         pwm2: pwm1@40020000 {
>                 compatible = "st,stm32-pwm";
>         };
>         pwm3: pwm1@40030000 {
>                 compatible = "st,stm32-pwm";
>         };
>

Because each instance of the hardware is slightly different: number of
pwm channels, triggers capabilities, etc ..
so I need to distinguish them.
Since it look to be a problem I will follow your suggestion and add a
property this driver to be able to identify each instance.
Do you think that "id" parameter (integer for 1 to 14) is acceptable ?

>> +- reg :                      Physical base address and length of the controller's
>> +                     registers.
>> +- clock-names:               Set to "mfd_timer_clk".
>
Only one but I use devm_regmap_init_mmio_clk() to avoid calling
clk_{enable/disable}
everywhere in the drivers when reading/writing regsister.
devm_regmap_init_mmio_clk() find the clock by it name that why I have
put it here
In the doc this clock in named "clk_int" I will use this name.


> How many clocks are there?
>
> If only 1, you don't need this property.
>
> "mfd_timer_clk" is not the correct name.
>
> What is it called in the datasheet?
>
>> +- clocks:            Phandle of the clock used by the timer module.
>
> "Phandle to the clock ..."
>
>> +                     For Clk properties, please refer to [1].
>> +- interrupts :               Reference to the timer interrupt
>
> Reference to?
>
> See how other binding documents describe this property.
>
>> +Optional parameters:
>> +- resets :           Reference to a reset controller asserting the timer
>
> As above.
>
>> +Optional subnodes:
>
> Either use ":" or " :" or "<tab>:", but keep it consistent.
>
>> +- pwm:                       See Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>> +- iiotimer:          See Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>
> Use the relative paths "../clock/", "../pwm/", "../iio/".
>
OK

>> +Example:
>> +     mfd_timer1: mfdtimer1@40010000 {
>
> This is not an "MFD timer".  MFD is a Linuxisum.
>
>> +             compatible = "st,stm32-mfd-timer1";
>
> Better description required.
>
>> +             reg = <0x40010000 0x400>;
>> +             clocks = <&rcc 0 160>;
>> +             clock-names = "mfd_timer_clk";
>> +             interrupts = <27>;
>> +
>> +             pwm1: pwm1@40010000 {
>> +                     compatible = "st,stm32-pwm1";
>> +             };
>> +
>> +             iiotimer1: iiotimer1@40010000 {
>> +                     compatible = "st,stm32-iio-timer1";
>> +             };
>> +     };
