Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:53768 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbaFZIpg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jun 2014 04:45:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAHfPSqBL9hH+r8Fy4GbbY1E_sJVCP-gpDHATDJgRHP4wKrFaiA@mail.gmail.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
 <1403677773-21141-5-git-send-email-ch.naveen@samsung.com> <CAD=FV=WeuFhGK=JNEm20CT73J=c1Zc_dZGQT6bKeob895M+kQA@mail.gmail.com>
 <CAHfPSqBL9hH+r8Fy4GbbY1E_sJVCP-gpDHATDJgRHP4wKrFaiA@mail.gmail.com>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Thu, 26 Jun 2014 14:15:15 +0530
Message-ID: <CAHfPSqBAurQtiVg8KjxJkgvdB7XUHdQkEfjRtgUCKncE2feCdA@mail.gmail.com>
Subject: Re: [PATCH 4/4 v2] ARM: DTS: Add NTC thermistor nodes to Exynos5420
 based Peach_PIT
To: Doug Anderson <dianders@chromium.org>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"cpgs ." <cpgs@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Doug, Kukjin,

On 26 June 2014 11:46, Naveen Krishna Ch <naveenkrishna.ch@gmail.com> wrote:
> Doug,
>
> On 26 June 2014 02:10, Doug Anderson <dianders@chromium.org> wrote:
>> Naveen,
>>
>> On Tue, Jun 24, 2014 at 11:29 PM, Naveen Krishna Chatradhi
>> <ch.naveen@samsung.com> wrote:
>>> Exynos5420 based Peach PIT board has 4 NTC thermistors to measure
>>> temperatures at various points on the board.
>>>
>>> IIO based ADC becomes the parent and NTC thermistors are the childs,
>>> via the HWMON interface.
>>>
>>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>>> Cc: Doug Anderson <dianders@chromium.org>
>>> ---
>>> Changes since v1:
>>> 1. Arranged the ADC node alphabetical
>>> 2. Added "status = "okay"" to the ADC node
>>>
>>> This patch needs
>>> 1. MAX77802 PMIC device tree nodes (for ldo9)
>>>    https://www.mail-archive.com/devicetree@vger.kernel.org/msg31430.html
>>> 2. Uses the DT documentation for NTC thermistors updated with vendor-prefix
>>>
>>> This patch set is tested
>>> 1. On Peach PIT board via sysfs entry exposed by hwmon
>>> localhost ~ # cat /sys/class/hwmon/hwmon*/device/temp1_input
>>> 37436
>>> 36449
>>> 38560
>>> 38059
>>>
>>> 2. Backward compatibility is tested by replacing "murata" with "ntc"
>>>    in the dts nodes and running the above test.
>>>
>>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   34 ++++++++++++++++++++++++++++
>>>  1 file changed, 34 insertions(+)
>>
>> Now that Javier has spun his patch, perhaps you can fold the "pi"
>> version in here too?
>
> Sure, thanks for the information.
>
> Snow also needs the adc nodes.
> Will try to implement an adc fragment for PIT, PI and Snow.

I just found out  https://lkml.org/lkml/2013/3/27/453

Adding ADC based Thermistor nodes to Exynos5250-snow.dts din't make it in.


>
>>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Tested-by: Doug Anderson <dianders@chromium.org>
>
>
>
> --
> Shine bright,
> (: Nav :)



-- 
Shine bright,
(: Nav :)
