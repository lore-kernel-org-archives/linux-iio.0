Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53967 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbcGWKzz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jul 2016 06:55:55 -0400
Subject: Re: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
To: Lee Jones <lee.jones@linaro.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
 <20160719073109.GD17074@dell>
 <d64cf632-41a4-3e23-6239-7f854cbb0293@kernel.org>
 <20160721121253.GE14925@dell> <20160721200802.GL5993@lukather>
 <20160722135556.GG14925@dell>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d14ee65b-a508-b30e-83d8-f3b87e0a340f@kernel.org>
Date: Sat, 23 Jul 2016 08:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <20160722135556.GG14925@dell>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/07/16 15:55, Lee Jones wrote:
> On Thu, 21 Jul 2016, Maxime Ripard wrote:
> 
>> 1;4205;0c
>> On Thu, Jul 21, 2016 at 01:12:53PM +0100, Lee Jones wrote:
>>> On Wed, 20 Jul 2016, Jonathan Cameron wrote:
>>>
>>>> On 19/07/16 08:31, Lee Jones wrote:
>>>>> On Mon, 18 Jul 2016, Jonathan Cameron wrote:
>>>>>
>>>>>> On 15/07/16 10:59, Quentin Schulz wrote:
>>>>>>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>>>>>>> controller and a thermal sensor. For now, only the ADC and the thermal
>>>>>>> sensor drivers are probed by the MFD, the touchscreen controller support
>>>>>>> will be added later.
>>>>>>>
>>>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>>>> Hmm. Previous patch includes the header this one creates.  Ordering issue?
>>>>>> The depends kind of prevents build failures by ensuring that can't be built
>>>>>> until this one is in place, but it is certainly an ugly way to do it.
>>>>>>
>>>>>> Few little bits innline.
>>>>>>> ---
>>>>>>>
>>>>>>> v2:
>>>>>>>  - add license headers,
>>>>>>>  - reorder alphabetically includes,
>>>>>>>  - add SUNXI_GPADC_ prefixes for defines,
>>>>>>>
>>>>>>>  drivers/mfd/Kconfig                 |  14 +++
>>>>>>>  drivers/mfd/Makefile                |   2 +
>>>>>>>  drivers/mfd/sunxi-gpadc-mfd.c       | 197 ++++++++++++++++++++++++++++++++++++
>>>>>>>  include/linux/mfd/sunxi-gpadc-mfd.h |  23 +++++
>>>>>>>  4 files changed, 236 insertions(+)
>>>>>>>  create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
>>>>>>>  create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h
>>>>>
>>>>> [...]
>>>>>
>>>>>>> +static struct mfd_cell sun6i_gpadc_mfd_cells[] = {
>>>>>>> +	{
>>>>>>> +		.name	= "sun6i-a31-gpadc-iio",
>>>>>>> +		.resources = adc_resources,
>>>>>>> +		.num_resources = ARRAY_SIZE(adc_resources),
>>>>>>> +	}, {
>>>>>>> +		.name = "iio_hwmon",
>>>>>> I still really dislike using this to force the probe of that driver but
>>>>>> kind of up to the hwmon / mfd guys on this.
>>>>>
>>>>> Can you at least say *why* you don't like it?
>>>> It just feels odd to have an mfd child that isn't really dependent
>>>> on the mfd hardware itself.
>>>>
>>>> Still if you are happy, mfd is your domain and my objections were
>>>> as you probably noticed not that strong - or well described!)
>>>>
>>>> So I'm fine with this.
>>>
>>> I see.  So it's not actually part of the same IP/chip?
>>
>> The chip has a temperature sensor, and we want to expose that
>> temperature through IIO.
>>
>> But we don't really have the choice on how we probe iio-hwmon
>> here. The binding was already there, and we have to keep it.
> 
> What binding?
> 
The somewhat 'interesting' one for iio-hwmon I would guess is what
Maxime is referring to.  Here they are using what was effectively
the old 'board file' methods inside the driver itself.  Which is
fine and done in quite a few places - though we have some issues
with deferred probing that we can improve upon.

Anyhow, it's real hardware and as this doesn't have anything to
do with device tree there is no need to get around the objections
of lack of generality that bothers the dt maintainers :)

Lets go with it as it is. Sorry for confusing everyone!

p.s. I'm pitching a tech session for the KS at the moment
on ksummit-discuss to hit the fiddlier question of bindings
/ cross subsystem interactions if anyone is interested.
