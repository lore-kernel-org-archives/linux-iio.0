Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-230.synserver.de ([212.40.185.230]:1099 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaKZKHi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Nov 2014 05:07:38 -0500
Message-ID: <5475A66C.2090204@metafoo.de>
Date: Wed, 26 Nov 2014 11:07:40 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Mike Looijmans <mike.looijmans@topic.nl>, pmeerw@pmeerw.net
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio:adc:ad799x driver broken after commit "Write default config
 on probe and reset alert status on probe"
References: <547439F9.7070903@topic.nl> <54748C48.1090608@metafoo.de> <5475A1A0.5060003@topic.nl>
In-Reply-To: <5475A1A0.5060003@topic.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/26/2014 10:47 AM, Mike Looijmans wrote:
> On 11/25/2014 03:03 PM, Lars-Peter Clausen wrote:
>> On 11/25/2014 09:12 AM, Mike Looijmans wrote:
>>> After this commit:
>>>
>>>      iio:adc:ad799x: Write default config on probe and reset alert status on
>>> probe
>>>
>>>      writing ALERT_EN and BUSY_ALERT to the chip config register clears
>>>      pending alerts, BUSY_ALERT is cleared when reading back the register
>>>
>>> The AD7999 on our board no longer functions, reading the in_voltage*_raw
>>> sysfiles always returns "255" after this.
>>>
>>> I reverted the commit, and that fixed the problem for me.
>>
>> I suspect that there is something going wrong when reading back the config
>> register, can you check the attached patch and see what the output is?
>>
>> Thanks,
>> - Lars
>>
>
> The attached patch delivered the following output (using the current head
> code):
>
> ad799x 1-0029: config: b 0
>

Yea, kind of what I expected based on your description. Looking at the 
datasheet it seems the ad7999 doesn't even support register read back which 
would explain the issue. I'll try to find a board and see if I can fix it.

- Lars

