Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vif1-retry101.mer-nm.internl.net ([217.149.192.107]:56329 "EHLO
	retry101.mer-nm.internl.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750957AbaKZJxA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 26 Nov 2014 04:53:00 -0500
Received: from smtp102.mer-nm.internl.net (smtp102.mer-nm.internl.net [217.149.192.138])
	by retry101.mer-nm.internl.net (Postfix) with ESMTP id 52357415B1
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2014 10:47:21 +0100 (CET)
Message-ID: <5475A1A0.5060003@topic.nl>
Date: Wed, 26 Nov 2014 10:47:12 +0100
From: Mike Looijmans <mike.looijmans@topic.nl>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio:adc:ad799x driver broken after commit "Write default config
 on probe and reset alert status on probe"
References: <547439F9.7070903@topic.nl> <54748C48.1090608@metafoo.de>
In-Reply-To: <54748C48.1090608@metafoo.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

﻿On 11/25/2014 03:03 PM, Lars-Peter Clausen wrote:
> On 11/25/2014 09:12 AM, Mike Looijmans wrote:
>> After this commit:
>>
>>      iio:adc:ad799x: Write default config on probe and reset alert status on
>> probe
>>
>>      writing ALERT_EN and BUSY_ALERT to the chip config register clears
>>      pending alerts, BUSY_ALERT is cleared when reading back the register
>>
>> The AD7999 on our board no longer functions, reading the in_voltage*_raw
>> sysfiles always returns "255" after this.
>>
>> I reverted the commit, and that fixed the problem for me.
>
> I suspect that there is something going wrong when reading back the config
> register, can you check the attached patch and see what the output is?
>
> Thanks,
> - Lars
>

The attached patch delivered the following output (using the current head code):

ad799x 1-0029: config: b 0



Met vriendelijke groet / kind regards,

Mike Looijmans
System Expert


TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail

Topic zoekt gedreven (embedded) software specialisten!
http://topic.nl/vacatures/topic-zoekt-software-engineers/

