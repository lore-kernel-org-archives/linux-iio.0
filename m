Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.108]:12196 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752522Ab3GBO4Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 10:56:16 -0400
Message-ID: <51D2E9EF.50303@digi.com>
Date: Tue, 2 Jul 2013 16:55:43 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Marek Vasut <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: Accessing specific hardware features of mxs-lradc
References: <51D2B057.9090005@digi.com> <51D2CE6A.7040103@metafoo.de> <51D2D591.4040101@free-electrons.com>
In-Reply-To: <51D2D591.4040101@free-electrons.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

On 07/02/2013 03:28 PM, Alexandre Belloni wrote:
> On 02/07/2013 14:58, Lars-Peter Clausen wrote:
>> On 07/02/2013 12:49 PM, Hector Palacios wrote:
>>> Greetings,
>>>
>>> The mxs-lradc has some hardware specific features like the DIVIDE_BY_TWO (an
>>> analog divide by two circuit that can be activated per channel).
>>> This is not currently implemented in the driver and I was wondering what would
>>> be the way to expose and control such setting. A specific sysfs entry? Somehow
>>> through the device tree?
>>>
>>> Is there any example of how to control a hw-specific feature in other similar
>>> iio drivers?
>>>
>>
>> This sounds as if the channel scale is programmable. There are quite a few
>> drivers for devices which have similar features, just make the scale property
>> writable and provide a scale_available.
>>
>
> I was looking at that yesterday as I had to had a scale for the
> temperature sensors. You'll have to be careful because the maximum
> measured voltage when DIVIDE_BY_TWO is not set is 1.85V and when it is
> set, it becomes VDDIO - 50mv.
>
> Also, scaling for quite a lot of channels is fixed. You'll also get
> channels with a fixed divider that can take DIVIDE_BY_TWO. That is quite
> a mess ;)

Thank you, I checked and it's easy to add custom sysfs attributes using 
IIO_DEVICE_ATTR(). I was thinking whether adding a divide_by_two attribute per channel:

	divide_by_two0
	divide_by_two1
	...
	divide_by_two7

or a unique divide_by_two descriptor that admits a mask value for all channels.
I think the first approach (one per channel) is cleaner. Opinions?

Best regards,
--
Hector Palacios
