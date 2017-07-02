Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx42-out3.antispamcloud.com ([138.201.61.179]:37614 "EHLO
        mx42-out3.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751608AbdGBLoa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jul 2017 07:44:30 -0400
Subject: Re: [PATCH] iio: Add LTC2471/LTC2473 driver
To: Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <linux@roeck-us.net>
References: <1498807267-946-1-git-send-email-mike.looijmans@topic.nl>
 <alpine.DEB.2.20.1706301614130.29944@vps.pmeerw.net>
 <20170702102539.51b430c1@kernel.org>
From: Mike Looijmans <mike.looijmans@topic.nl>
Message-ID: <6117ac7a-b216-2886-de7b-95d7c3a2e8ea@topic.nl>
Date: Sun, 2 Jul 2017 13:24:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170702102539.51b430c1@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

﻿On 02-07-17 11:25, Jonathan Cameron wrote:
> On Sun, 2 Jul 2017 10:29:35 +0200 (CEST)
> Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> 
>>> The LTC2741 and LTC2473 are single voltage ADC chips. The LTC2473
>>> is similar to the LTC2471 but outputs a signed differential value.
>>
>> comments below
>>   
>>> Datasheet:
>>>    http://cds.linear.com/docs/en/datasheet/24713fb.pdf
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Enough here that I've dropped the patch for now and look forward
> to a v2 incorporating both Peter and Lars' comments.
> 

I'll create and send a v2 probably tomorrow.


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



