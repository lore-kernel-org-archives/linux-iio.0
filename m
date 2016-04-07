Return-Path: <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/9] iio: adc: exynos_adc: use regmap to retrieve struct
 device
To: Alison Schofield <amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
 <2329d20396db00b60f4e7d2e783ea46b48eea9c1.1459918214.git.amsfield22@gmail.com>
 <5704B4A4.1070704@samsung.com> <20160406203308.GA3462@d830.WORKGROUP>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 kgene@kernel.org, k.kozlowski@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <5705F131.4090201@samsung.com>
Date: Thu, 07 Apr 2016 07:33:37 +0200
MIME-version: 1.0
In-reply-to: <20160406203308.GA3462@d830.WORKGROUP>
Content-type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hello,

On 2016-04-06 22:33, Alison Schofield wrote:
> On Wed, Apr 06, 2016 at 09:03:00AM +0200, Marek Szyprowski wrote:
>> Hello,
>>
>> On 2016-04-06 07:15, Alison Schofield wrote:
>>> Driver includes struct regmap and struct device in its global data.
>>> Remove the struct device and use regmap API to retrieve device info.
>>>
>>> Patch created using Coccinelle plus manual edits.
>>>
>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> This patch changes the struct device which is used by the driver to report
>> errors. The driver used correctly the struct device associated with its
>> device tree node, while after the patch it will use device which is
>> associated with PMU regmap, which is a different device. PMU regmap is there
>> only to enable/disable the ADC block and it is not the regmap used to access
>> registers of the ADC device.
>>
>> I would prefer to drop this patch.
> Thanks Marek!  Please check my understanding.  Driver is not carrying
> a duplicate struct device. The regmap in exynos_adc is *not* this
> devices regmap. It belongs to the PMU, (power mgmt unit?)

Exactly.

> It seemed excessive to carry around a struct device just for the
> dev_err messages, but, we need that struct to extract the correct
> iio_dev struct. Without a regmap belonging to this actual device,
> no efficiencies can be gained in exynos, and the patch will be
> dropped from set v2.

Thanks.

> Now I need to be able to recognize such cases elsewhere. I'm going
> back though other patches in this set looking for that, but I'm not
> so sure I would recognize it.
>
> Jonathan & all, Any hints on the rule of regmap?

You may check how the regmap is initialized. When it is retrieved by
phandle from device tree, then you might be almost sure that it refers
to the different device.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
