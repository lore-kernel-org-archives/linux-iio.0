Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:47363 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbdF2Pah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jun 2017 11:30:37 -0400
Subject: Re: [PATCH v2] hwmon: Add LTC2471/LTC2473 driver
To: Mike Looijmans <mike.looijmans@topic.nl>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <1498733135-4729-1-git-send-email-mike.looijmans@topic.nl>
 <1498738434-18252-1-git-send-email-mike.looijmans@topic.nl>
 <db17f447-3c2e-1dbe-147e-34114554205c@metafoo.de>
 <c2f1b4c1-91b2-f3af-e76f-66d7d0633239@roeck-us.net>
 <26126017-55d8-3d38-f5de-c764ca9ec699@topic.nl>
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <63b1e076-38e8-c276-8518-d8c9d7abb1b7@metafoo.de>
Date: Thu, 29 Jun 2017 17:30:22 +0200
MIME-Version: 1.0
In-Reply-To: <26126017-55d8-3d38-f5de-c764ca9ec699@topic.nl>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/29/2017 04:11 PM, Mike Looijmans wrote:
> On 29-06-17 15:40, Guenter Roeck wrote:
>> On 06/29/2017 05:30 AM, Lars-Peter Clausen wrote:
>>> On 06/29/2017 02:13 PM, Mike Looijmans wrote:
>>>> The LTC2741 and LTC2473 are single voltage monitoring chips. The LTC2473
>>>> is similar to the LTC2471 but outputs a signed differential value.
>>>>
>>>> Datasheet:
>>>>    http://cds.linear.com/docs/en/datasheet/24713fb.pdf
>>>
>>> This looks more like a general purpose ADC rather than a specialized voltage
>>> monitoring chip. In my opinion this driver would be better suited for the
>>> IIO framework. But before you start working on that lets try to hear what
>>> others think about this.
>>>
>>
>> Agreed (I just replied to that on another thread).
> 
> Took a peek at the IIO drivers, looks simple enough, so I suggest to drop
> this patch and I'll create an IIO driver instead.
> 
> The ltc2485 (as suggested by Guenter on that other thread) is pretty similar
> indeed, it might be feasible to join the two and have one driver handle them
> both. That would be preferred over a separat driver, right?
> 

I think the ltc2485 is close enough. It's even listed in the datasheet as a
related part. The main difference seems to be the resolution of the ADC and
the extra temperature sensor channel.

Although one thing to consider is that their control/mode register is quite
different. But the current driver doesn't write it.

