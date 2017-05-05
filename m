Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43044 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753357AbdEESue (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 May 2017 14:50:34 -0400
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
 <20170505094009.GP2697@lahna.fi.intel.com>
 <5d96337b-df40-b3eb-8d03-cdb2b55af9b3@siemens.com>
 <20170505104026.GS2697@lahna.fi.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <92acddc4-47d7-2739-9a9b-6831c226369a@kernel.org>
Date: Fri, 5 May 2017 19:50:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170505104026.GS2697@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 11:40, Mika Westerberg wrote:
> On Fri, May 05, 2017 at 12:23:26PM +0200, Jan Kiszka wrote:
>>>> +	} else {
>>>> +		st->reg = devm_regulator_get(&spi->dev, "vref");
>>>> +		if (IS_ERR(st->reg))
>>>> +			return PTR_ERR(st->reg);
>>>
>>> This should be an optional regulator and in case of ACPI you just don't
>>> have it.
>>
>> It's mandatory for this DT case, so I will not change that.
> 
> Well, it would be better if you don't need to deviate in the driver like
> this. And it clearly is optional because in case of ACPI you don't need
> it.
> 
> Not my call, though.
> 
I'd keep it as mandatory. The ACPI case is more of a workaround of
a lack of information than anything.  The only way you could make it optional
would be to simply not provide the scale if it wasn't there.
(to do that have two channel sets and switch between them depending on its
presence).

We'd do it as optional if there was an existing binding defined where it wasn't
specified (not much use having the fake regulator show up but be unable to
answer the what voltage question ;)

Jonathan
