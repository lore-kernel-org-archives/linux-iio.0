Return-Path: <SRS0=rO/X=C2=amlogic.com=Yixun.Lan@kernel.org>
Subject: Re: [PATCH v4 0/4] fix the clock setting for SAR ADC
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
References: <20171107140942.29243-1-yixun.lan@amlogic.com>
 <CAFBinCB=2pb9dZkpSqdVAiumkSCzgaW0oejftjZNP7aYbiQJuw@mail.gmail.com>
 <20171111003737.000038f0@huawei.com>
CC: <yixun.lan@amlogic.com>, Mark Rutland <mark.rutland@arm.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Neil
 Armstrong <narmstrong@baylibre.com>, <linux-iio@vger.kernel.org>, Stephen
 Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>,
	<linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Xingyu Chen
	<xingyu.chen@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione
	<carlo@caione.org>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Jerome
 Brunet <jbrunet@baylibre.com>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <15745fd0-1af9-c7c0-8769-063f218a3d28@amlogic.com>
Date: Tue, 28 Nov 2017 21:11:29 +0800
MIME-Version: 1.0
In-Reply-To: <20171111003737.000038f0@huawei.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>


On 11/11/17 08:37, Jonathan Cameron wrote:
> On Tue, 7 Nov 2017 22:36:00 +0100
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
> 
>> Hi Yixun,
>>
>> On Tue, Nov 7, 2017 at 3:09 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
>>> patch [1/4]:
>>>   Fix wrong SARADC/SANA clock gate bit in Meson-GXBB/GXL,
>>> the published datasheets[4] also has wrong description about this.
>>>   This patch should be explicitly merged *before* other patches.
>>>
>>> patch [2-4/4]:
>>>   Drop the "sana" clock from SAR ADC module,  
>> I agree with Jerome that patch 2/4 should be applied last.
> 
> Let me know when I should take this.
> 
> Thanks,
> 
> Jonathan
> 
>> when I wrote the driver I couldn't get it to work on my GXBB board
>> (which unfortunately has died since then) because the clocks were
>> disabled (they weren't enabled by the bootloader). people who are
>> using an old .dtb would get the same problem again until the clock
>> driver is merged
>>
>>>   From the hardware perspective, the SAR ADC module doesn't
>>> require "sana" clock to wrok. This should apply to all SoC,
>>> including meson6,8, GXBB, GXL..  
>> thank you for clarifying this!
>>
>>> Note: the whole patchset series has been tested at GXL-P212 board,
>>> we haven't got any meson6,8 board to test, so I would appreciate
>>> if someone (Martin?) could help to confirm it works there.  
>> I can test this on a Meson8b and a Meson8m2 board on the weekend -
>> I'll let you know about the results
>>
>>
>> Regards
>> Martin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> .
> 

Hi Jonathan Cameron & Kevin Hilman:

 since the clk part patch has been applied[1], can we proceed with others?

to Jonathan:
I think the iio part(patch [2/4]) should be merged via your iio tree?
see [2]

to Kevin:
could you take the DTS part? see [3], and the patch [4/4] has a rework
version, see [4], to separate dt64 vs dt32 device tree.


[1]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005472.html

[2]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005264.html

[3]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005265.html

[4]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005304.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005305.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005306.html

Yixun
