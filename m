Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx12-04.smtp.antispamcloud.com ([46.165.232.174]:33533 "EHLO
        mx12-04.smtp.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752830AbdF2OIv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jun 2017 10:08:51 -0400
Subject: Re: [PATCH v2] hwmon: Add LTC2471/LTC2473 driver
To: Lars-Peter Clausen <lars@metafoo.de>, <linux-hwmon@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux@roeck-us.net>,
        <jdelvare@suse.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <1498733135-4729-1-git-send-email-mike.looijmans@topic.nl>
 <1498738434-18252-1-git-send-email-mike.looijmans@topic.nl>
 <db17f447-3c2e-1dbe-147e-34114554205c@metafoo.de>
From: Mike Looijmans <mike.looijmans@topic.nl>
Message-ID: <7c14b49d-5878-b665-fd4f-0582058cedd5@topic.nl>
Date: Thu, 29 Jun 2017 15:22:56 +0200
MIME-Version: 1.0
In-Reply-To: <db17f447-3c2e-1dbe-147e-34114554205c@metafoo.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

﻿On 29-06-17 14:30, Lars-Peter Clausen wrote:
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

I'm neutral on it, it's being used as a hardware monitor on the board I have, 
but it's indeed a generic I2C ADC.

Do you have a suggestion for a similar device (simple I2C ADC) that I could 
base the IIO driver on? I've come across the AD799x which seems a good 
starting point.



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



