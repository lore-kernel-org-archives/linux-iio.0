Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx36-44.antispamcloud.com ([209.126.121.60]:60195 "EHLO
        mx36-44.antispamcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbdF2PBg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jun 2017 11:01:36 -0400
Subject: Re: [PATCH v2] hwmon: Add LTC2471/LTC2473 driver
To: Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-hwmon@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jdelvare@suse.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <1498733135-4729-1-git-send-email-mike.looijmans@topic.nl>
 <1498738434-18252-1-git-send-email-mike.looijmans@topic.nl>
 <db17f447-3c2e-1dbe-147e-34114554205c@metafoo.de>
 <c2f1b4c1-91b2-f3af-e76f-66d7d0633239@roeck-us.net>
From: Mike Looijmans <mike.looijmans@topic.nl>
Message-ID: <26126017-55d8-3d38-f5de-c764ca9ec699@topic.nl>
Date: Thu, 29 Jun 2017 16:11:42 +0200
MIME-Version: 1.0
In-Reply-To: <c2f1b4c1-91b2-f3af-e76f-66d7d0633239@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

﻿On 29-06-17 15:40, Guenter Roeck wrote:
> On 06/29/2017 05:30 AM, Lars-Peter Clausen wrote:
>> On 06/29/2017 02:13 PM, Mike Looijmans wrote:
>>> The LTC2741 and LTC2473 are single voltage monitoring chips. The LTC2473
>>> is similar to the LTC2471 but outputs a signed differential value.
>>>
>>> Datasheet:
>>>    http://cds.linear.com/docs/en/datasheet/24713fb.pdf
>>
>> This looks more like a general purpose ADC rather than a specialized voltage
>> monitoring chip. In my opinion this driver would be better suited for the
>> IIO framework. But before you start working on that lets try to hear what
>> others think about this.
>>
> 
> Agreed (I just replied to that on another thread).

Took a peek at the IIO drivers, looks simple enough, so I suggest to drop this 
patch and I'll create an IIO driver instead.

The ltc2485 (as suggested by Guenter on that other thread) is pretty similar 
indeed, it might be feasible to join the two and have one driver handle them 
both. That would be preferred over a separat driver, right?


Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail



