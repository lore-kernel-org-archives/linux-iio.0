Return-Path: <SRS0=jBNH=6C=roeck-us.net=linux@kernel.org>
Subject: Re: [PATCH v2] hwmon: Add LTC2471/LTC2473 driver
To: Lars-Peter Clausen <lars@metafoo.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
References: <1498733135-4729-1-git-send-email-mike.looijmans@topic.nl>
 <1498738434-18252-1-git-send-email-mike.looijmans@topic.nl>
 <db17f447-3c2e-1dbe-147e-34114554205c@metafoo.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c2f1b4c1-91b2-f3af-e76f-66d7d0633239@roeck-us.net>
Date: Thu, 29 Jun 2017 06:40:14 -0700
MIME-Version: 1.0
In-Reply-To: <db17f447-3c2e-1dbe-147e-34114554205c@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/29/2017 05:30 AM, Lars-Peter Clausen wrote:
> On 06/29/2017 02:13 PM, Mike Looijmans wrote:
>> The LTC2741 and LTC2473 are single voltage monitoring chips. The LTC2473
>> is similar to the LTC2471 but outputs a signed differential value.
>>
>> Datasheet:
>>    http://cds.linear.com/docs/en/datasheet/24713fb.pdf
> 
> This looks more like a general purpose ADC rather than a specialized voltage
> monitoring chip. In my opinion this driver would be better suited for the
> IIO framework. But before you start working on that lets try to hear what
> others think about this.
> 

Agreed (I just replied to that on another thread).

Guenter
