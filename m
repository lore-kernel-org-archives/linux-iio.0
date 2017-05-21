Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:46431 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbdEUMoS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 May 2017 08:44:18 -0400
Subject: Re: [PATCH v6] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
References: <e96cd67d-ac54-435e-b376-0d029fdb75c3@siemens.com>
 <9eae4928-c278-62e5-05d1-728326aad45b@kernel.org>
 <9f60dc23-6ba1-335a-d95b-870cdd250539@siemens.com>
 <ef515402-40fd-a4be-1402-6e893f69b08f@kernel.org>
 <a2978699-8791-90d6-ba3a-9748545d2689@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <eb74c0c5-beaa-e6f4-68b5-52ee28682fd3@siemens.com>
Date: Sun, 21 May 2017 14:44:09 +0200
MIME-Version: 1.0
In-Reply-To: <a2978699-8791-90d6-ba3a-9748545d2689@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-05-21 14:18, Jonathan Cameron wrote:
> On 21/05/17 13:17, Jonathan Cameron wrote:
>> On 21/05/17 12:59, Jan Kiszka wrote:
>>> On 2017-05-21 12:47, Jonathan Cameron wrote:
>>>> On 17/05/17 16:28, Jan Kiszka wrote:
>>>>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>>>>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>>>>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>>>>> included.
>>>>>
>>>>> Due to the lack of regulators under ACPI, we hard-code the voltage
>>>>> provided to the VA pin of the ADC to 5 V, the value used on Galileo
>>>>> and
>>>>> IOT2000. For DT usage, the regulator "vref-supply" provides this
>>>>> information. Note that DT usage has not been tested.
>>>>>
>>>>> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
>>>>> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
>>>>> Todor Minchev <todor@minchev.co.uk>.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Still an issue wrt to it being obviously correct in the ordering in
>>>> probe
>>>> and remove.
>>>>
>>>> As a reviewer I want to be able to run through each step in probe and
>>>> compare with remove to ensure they occur in the opposite order and
>>>> reverse all the steps in probe.  Where ever it deviates from that I
>>>> have
>>>> to think about it and we all know the last thing a reviewer with a big
>>>> backlog of patches wants to do is to think hard ;)
>>>>
>>>> Anyhow, I've fixed up and applied to the togreg branch of iio.git and
>>>> pushed out as testing for the autobuilders to play with it.
>>>>
>>>> Please check I haven't made a mess of it.
>>>
>>> Forgot to push? Not finding it in togreg, which is 5 days old.
>>>
>> As it says, pushed out as testing...  Togreg is non rebasing so only
>> gets pushed out publicly once all the trivial stuff the autobuilders
>> find has been sorted.
>>
>> Depending on how busy I am it can be a few days before I get a chance
>> to push out togreg, whereas testing goes every few patches when I'm
>> merging stuff.
> Mind you I hadn't pushed that for half an hour or so hence that might
> have been out of date too ;)

OK, now I see what went wrong: Please have a second look at commit
52d4de2441af... ;)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
