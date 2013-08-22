Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.246]:61359 "EHLO
	DVREDG02.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752352Ab3HVJxH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 05:53:07 -0400
Message-ID: <5215DF7C.2020909@atmel.com>
Date: Thu, 22 Aug 2013 17:53:00 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: <jic23@cam.ac.uk>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <thomas.petazzoni@free-electrons.com>,
	<mark.rutland@arm.com>, <b.brezillon@overkiz.com>,
	"Desroches, Ludovic" <Ludovic.Desroches@atmel.com>
Subject: Re: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask
 in MR for different IP
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com> <1376219071-29946-3-git-send-email-josh.wu@atmel.com> <20130815192044.GD12162@lukather> <5215DF2C.3050502@atmel.com>
In-Reply-To: <5215DF2C.3050502@atmel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add Ludovic in the loop.

On 8/22/2013 5:51 PM, Josh Wu wrote:
> Hi, Maxime
>
> On 8/16/2013 3:20 AM, Maxime Ripard wrote:
>> Hi Josh,
>>
>> On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
>>> For at91 boards, there are different IPs for adc. Different IPs has
>>> different STARTUP & PRESCAL mask in ADC_MR.
>>>
>>> This patch introduce the multiple compatible string for those
>>> different IPs.
>>>
>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Overall it looks like the right ways, but I think we can take it a step
>> further.
>>
>> I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
>> atmel,adc-status-register, atmel,adc-trigger-register properties (and
>> probably the triggers as well description as well).
>
> yeah, right. Currently I want to drop following:
>
> atmel,adc-drdy-mask, atmel,adc-status-register, 
> atmel,adc-trigger-register, atmel,adc-channel-base
>
> For the adc-num-channels, I'd like to leave it in dt parameters. It is 
> a description for an adc capablity.
>
> For the triggers, I am not decided. An obvious benifit to remove 
> trigger in dt will save many lines of code.
>
>>
>> Maxime
>>
>
> Best Regards,
> Josh Wu

