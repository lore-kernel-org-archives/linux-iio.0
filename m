Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57474 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbdEGV4G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 17:56:06 -0400
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
 <1493978058.30052.26.camel@linux.intel.com>
 <cab56143-9e49-2f5c-81d5-8d4aeda4a568@siemens.com>
 <ad99c0e0-565d-5876-cc98-2751dd4faaf5@kernel.org>
 <faa11f51-1853-4aee-58ae-95022d68873a@siemens.com>
 <1494016323.30052.44.camel@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8006a81e-6b5a-dce0-0780-67f3059a1d37@kernel.org>
Date: Sun, 7 May 2017 12:19:22 +0100
MIME-Version: 1.0
In-Reply-To: <1494016323.30052.44.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 21:32, Andy Shevchenko wrote:
> On Fri, 2017-05-05 at 22:09 +0200, Jan Kiszka wrote:
>> On 2017-05-05 20:52, Jonathan Cameron wrote:
>>> On 05/05/17 11:39, Jan Kiszka wrote:
>>>> On 2017-05-05 11:54, Andy Shevchenko wrote:
>>>>> On Fri, 2017-05-05 at 08:31 +0200, Jan Kiszka wrote:
> 
>>>>>> +			if (st->reg)
>>>>>> +				*val =
>>>>>> regulator_get_voltage(st->reg) 
>>>>>> / 1000;
>>>>>> +			else
>>>>>> +				*val = st->va_millivolt;
>>>>>> +
>>>>>
>>>>> Another way is to not just hard code the value, but create a
>>>>> fixed
>>>>> voltage regulator out of it. In this case you will have one way
>>>>> to get
>>>>> its value.
>>>>
>>>> That's a good idea.
>>>
>>> Agreed. Make sure to cc Mark Brown though as I'll need an ack from
>>> him
>>> to have a fixed reg hiding in here.
>>
>> After diving deeper, it not longer appears to be a good idea:
>>
>> - pulls in a non-obvious requirement for CONFIG_REGULATOR on platforms
>>   that otherwise do not need it
> 
> Why is it a problem?
It seems unlikely this is the first ever case of needing proper
regulator support on ACPI platforms.  Mark/Liam, an precedents that you
know of?
> 
>> - requires complex life-cycle management so that the fixed regulator
>> is
>>   instantiated on the first device creation and removed with the last
>>   one
> 
> Who cares if you register more than one?
> 
>> We better go with the static value assignment.
>>
>> I'll move that regulator_get_voltage into the probing function which
>> will simplify things further (va_millivolt will carry the value for
>> both
>> cases).
> 
> Yes, it would be the way, if system has it's fixed.
> 
> But in this case you need to threat regulator as optional if we are
> going to enable/disable them for PM.
> 

