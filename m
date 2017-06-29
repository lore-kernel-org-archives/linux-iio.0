Return-Path: <SRS0=jBNH=6C=roeck-us.net=linux@kernel.org>
Subject: Re: [PATCH v2] hwmon: Add LTC2471/LTC2473 driver
To: Mike Looijmans <mike.looijmans@topic.nl>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
References: <1498733135-4729-1-git-send-email-mike.looijmans@topic.nl>
 <1498738434-18252-1-git-send-email-mike.looijmans@topic.nl>
 <db17f447-3c2e-1dbe-147e-34114554205c@metafoo.de>
 <7c14b49d-5878-b665-fd4f-0582058cedd5@topic.nl>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1fdc6985-f6ca-2751-3503-a6de67b517e0@roeck-us.net>
Date: Thu, 29 Jun 2017 06:41:11 -0700
MIME-Version: 1.0
In-Reply-To: <7c14b49d-5878-b665-fd4f-0582058cedd5@topic.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/29/2017 06:22 AM, Mike Looijmans wrote:
> On 29-06-17 14:30, Lars-Peter Clausen wrote:
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
> 
> I'm neutral on it, it's being used as a hardware monitor on the board I have, but it's indeed a generic I2C ADC.
> 
> Do you have a suggestion for a similar device (simple I2C ADC) that I could base the IIO driver on? I've come across the AD799x which seems a good starting point.
> 

ltc2485, ltc2497 ? No idea how close they are.

Guenter
