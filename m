Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:55146 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbcDRLMr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 07:12:47 -0400
Message-ID: <5714BA79.40803@denx.de>
Date: Mon, 18 Apr 2016 12:44:09 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	linux-iio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH RFT 0/5] iio: mxs-lradc: fix leak and implement PM ops
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com> <570FF5AF.7010801@denx.de> <57147BEF.4070606@i2se.com>
In-Reply-To: <57147BEF.4070606@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/18/2016 08:17 AM, Stefan Wahren wrote:
> Am 14.04.2016 um 21:55 schrieb Marek Vasut:
>> On 04/14/2016 05:48 PM, Stefan Wahren wrote:
>>> This patch series fix a memory leak and implements suspend/resume
>>> support for mxs-lradc.
>>>
>>> Patch 1: fix the memory leak
>>> Patch 2-4: refactor mxs-lradc in order to prepare PM implementation
>>> Patch 5: implement suspend/resume support
>>>
>>> These patches has been tested with i.MX23 and i.MX28 but without
>>> a touchscreen. I added only a bogus touchscreen in devicetree.
>>>
>>> It would be nice if someone with a real touchscreen could test it.
>>>
>>> Stefan Wahren (5):
>>>   iio: mxs-lradc: fix memory leak
>>>   iio: mxs-lradc: move TS config into suitable function
>>>   iio: mxs-lradc: move STMP reset out of ADC init
>>>   iio: mxs-lradc: disable only mapped channels in mxs_lradc_hw_stop
>>>   iio: mxs-lradc: implement suspend/resume support
>>>
>>>  drivers/iio/adc/mxs-lradc.c |  116 ++++++++++++++++++++++++++++++-------------
>>>  1 file changed, 82 insertions(+), 34 deletions(-)
>>>
>> On M28EVK:
>>
>> Tested-by: Marek Vasut <marex@denx.de>
>>
> 
> 
> Thanks. Only one question, does it imply a test with a touchscreen?
> 

Yes, this one [1]. It's an Ampire 800480 display and resistive touch
on top of it.

[1] http://www.denx-cs.de/?q=MxxDK

-- 
Best regards,
Marek Vasut
