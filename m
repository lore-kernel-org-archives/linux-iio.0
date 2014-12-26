Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44103 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbaLZJiU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 04:38:20 -0500
Message-ID: <549D2C89.2050007@kernel.org>
Date: Fri, 26 Dec 2014 09:38:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Michael.Hennerich@analog.com, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/3] iio: frequency: Remove 'out of memory' message
References: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com> <1418721107-5429-2-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZDYT4wUb5uOkqPvkmZ5+Rs8O1TP2Z7mEhF9OeQTHY97gw@mail.gmail.com> <549930D1.9050600@metafoo.de> <5499CEB0.5020508@gmx.de> <5499E299.2080305@metafoo.de>
In-Reply-To: <5499E299.2080305@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/12/14 21:46, Lars-Peter Clausen wrote:
> On 12/23/2014 09:21 PM, Hartmut Knaack wrote:
>> Lars-Peter Clausen schrieb am 23.12.2014 um 10:07:
>>> On 12/23/2014 09:51 AM, Daniel Baluta wrote:
>>>> On Tue, Dec 16, 2014 at 11:11 AM, Roberta Dobrescu
>>>> <roberta.dobrescu@gmail.com> wrote:
>>>>> This patch fixes the following checkpatch.pl warning:
>>>>> WARNING: Possible unnecessary 'out of memory' message
>>>>>
>>>>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>>>>> ---
>>>>>    drivers/iio/frequency/adf4350.c | 4 +---
>>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
>>>>> index 63a25d9..2b301eb 100644
>>>>> --- a/drivers/iio/frequency/adf4350.c
>>>>> +++ b/drivers/iio/frequency/adf4350.c
>>>>> @@ -387,10 +387,8 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
>>>>>           int ret;
>>>>>
>>>>>           pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>>>> -       if (!pdata) {
>>>>> -               dev_err(dev, "could not allocate memory for platform data\n");
>>>>> +       if (!pdata)
>>>>>                   return NULL;
>>>>> -       }
>>>>>
>>>> Based on Harmut's review we can return ERR_PTR(-ENOMEM) here
>>>> and then use IS_ERR and PTR_ERR inside adf4350_probe()
>>>
>>> This patch is fine as it is. It removes the redundant error message. Every
>>> thing else should be done in a second patch.
>>
>> I can't follow on this one. From what I see, if memory allocation fails here,
>> we will get an appropriate error message here, and _probe will pass up -EINVAL,
>> causing a misleading error message. Where do you see redundancy?
> 
> Unless you pass __GFP_NOWARN to k*alloc it will print a error message on its own if the allocation fails.
> 
Yes, separate issues - be it the case that they both want fixing.  Anyhow, have applied
this patch to the togreg branch of iio.git

Thanks

