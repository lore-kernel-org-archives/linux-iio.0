Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:1830 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbcAZGZ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jan 2016 01:25:58 -0500
Subject: Re: [RFC 2/2] iio: ad5755: added support for switching between
 voltage and current output
To: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>
References: <1453467296-26356-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1453467296-26356-2-git-send-email-sean.nyekjaer@prevas.dk>
 <56A64686.8030003@metafoo.de>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <56A70F10.3090507@prevas.dk>
Date: Tue, 26 Jan 2016 07:15:44 +0100
MIME-Version: 1.0
In-Reply-To: <56A64686.8030003@metafoo.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 2016-01-25 17:00, Lars-Peter Clausen wrote:
> On 01/22/2016 01:54 PM, Sean Nyekjaer wrote:
>> DAC ad5755 have both support for voltage and current output, before the driver
>> only had support for switching modes at compile time. Not very smart...
>>
>> This patch adds support for switching modes from userspace.
>>
>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>> ---
>>
>> This patch is not done yet :-) I would like to get some feedback of my work.
>> I have tested this patch with an ad5755 and it works.
>>
>> So if you have any ideas on how I should progress please give me some feedback.
> Hi,
>
> I'd like to better understand why this is necessary (or not). What is your
> usecase where you need to support switching at runtime?
>
> - Lars
>
Hi Lars

Our customer is building an IO board, where they are going to loop some 
-15-15V or 0-24mA signals thru their board and manipulate them. We are 
using an ti-ads8688 for input and an ad5755 for output :-)
In our case it's necessary because our costumer does not know about the 
input signals therefore we have to give them the posibility to switch 
between the modes.
Yes we could just provide them with 2 voltage modes and 2 current mode 
or two different boardfiles, but they have declined that proposal :-(

/Sean
