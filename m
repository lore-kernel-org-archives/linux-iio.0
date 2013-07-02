Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47498 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab3GBRTb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 13:19:31 -0400
Message-ID: <51D30BA2.7020008@free-electrons.com>
Date: Tue, 02 Jul 2013 19:19:30 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, otavio@ossystems.com.br,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
References: <1372723722-13902-1-git-send-email-marex@denx.de> <201307021403.57543.marex@denx.de> <51D2CC68.1080808@free-electrons.com> <201307021813.18019.marex@denx.de>
In-Reply-To: <201307021813.18019.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 02/07/2013 18:13, Marek Vasut wrote:
> Dear Alexandre Belloni,
> 
>> On 02/07/2013 14:03, Marek Vasut wrote:
>>> Dear Alexandre Belloni,
>>>
>>>> Dear Marek,
>>>>
>>>> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you know
>>>> how to reproduce it ?
>>>
>>> The check is just redundant, it's not a bug.
>>
>> Ok, that's what I understood first but then got confused by reports of
>> it solving a bug.
> 
> It cannot solve a thing. If it does, then we have a problem.
> 
> What kind of bug do you see ? How can I replicate it ? Can you send me a 
> testcase?
> 

It doesn't solve anything on my side, I never saw any issue with that
code. I was surprised by those reports though:

http://marc.info/?l=linux-iio&m=137275710622191&w=2
http://marc.info/?l=linux-iio&m=137273629716559&w=2

Hector and Otavio seem to be the ones with an issue ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
