Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-176.synserver.de ([212.40.185.176]:1091 "EHLO
	smtp-out-175.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752867AbaG3OA0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jul 2014 10:00:26 -0400
Message-ID: <53D8FA72.3050204@metafoo.de>
Date: Wed, 30 Jul 2014 16:00:18 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Why drivers don't depend on CONFIG_REGULATOR?
References: <CA+TH9VkYTQOEaV4OX2HAZcpvXhgcP8e+Mp1m1otnX5v=OPbBCw@mail.gmail.com> <53D8ECB9.1010503@metafoo.de> <CA+TH9VkMzi1U1C1GagBTEcQ_3E4vGiKoa+2mz-MNiA8x4O5udQ@mail.gmail.com>
In-Reply-To: <CA+TH9VkMzi1U1C1GagBTEcQ_3E4vGiKoa+2mz-MNiA8x4O5udQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/2014 03:23 PM, Angelo Compagnucci wrote:
> Hi Lars,
>
> I have this fixed regulator in my device tree:
>
> adc_supply: fixedregulator {
>    compatible = "regulator-fixed";
>    regulator-name = "fixed-supply";
>    regulator-min-microvolt = <3300000>;
>    regulator-max-microvolt = <3300000>;
>    regulator-boot-on;
> };
>
> With CONFIG_REGULATOR=y CONFIG_REGULATOR_FIXED_VOLTAGE=y:
>
> # cat in_voltage0_raw in_voltage_scale
> 4095
> 0.805664062
>
> 4095 * 0.805664062 = 3299.19433389, OK wonderful!
>
> With CONFIG_REGULATOR not set:
>
> # cat in_voltage0_raw in_voltage_scale
> 4095
> cat: read error: Invalid argument
>
> How do you cope with something like this? Is this expected?

We don't really handle this a t the moment. I guess ideally we wouldn't show 
the scale attribute in this case.

>
> Thank you for your time!
>
> 2014-07-30 15:01 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 07/30/2014 11:51 AM, Angelo Compagnucci wrote:
>>>
>>> Hello List,
>>>
>>> I wasted a little bit of my time this morning understanding why the
>>> regulator I used in my device tree wasn't working, only to discover
>>> later that the regulator support was not enabled in my config.
>>>
>>> I think that all the drivers that use a regulator should depend on the
>>> CONFIG_REGULATOR.
>>>
>>> Is there a reason why any driver has "depends on REGULATOR" in their
>>> Kconfig entry?
>>>
>>> Thank you for your time!
>>
>>
>> Hi,
>>
>> A lot of drivers work just fine without regulator support enabled. When
>> disabled the regulator API stubs itself out with dummy function that always
>> succeed.
>>
>> - Lars
>>
>
>
>

