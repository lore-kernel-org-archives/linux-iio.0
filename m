Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:33316 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750774Ab3GBPwD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 11:52:03 -0400
Message-ID: <51D2F7F1.7000305@metafoo.de>
Date: Tue, 02 Jul 2013 17:55:29 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Hector Palacios <hector.palacios@digi.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Marek Vasut <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: Accessing specific hardware features of mxs-lradc
References: <51D2B057.9090005@digi.com> <51D2CE6A.7040103@metafoo.de> <51D2D591.4040101@free-electrons.com> <51D2E9EF.50303@digi.com> <51D2EFDD.9000403@metafoo.de> <51D2F580.5070205@free-electrons.com>
In-Reply-To: <51D2F580.5070205@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2013 05:45 PM, Alexandre Belloni wrote:
> On 02/07/2013 17:21, Lars-Peter Clausen wrote:
>>>>
>>>> I was looking at that yesterday as I had to had a scale for the
>>>> temperature sensors. You'll have to be careful because the maximum
>>>> measured voltage when DIVIDE_BY_TWO is not set is 1.85V and when it is
>>>> set, it becomes VDDIO - 50mv.
>>
>> I had a quick peak at the datasheet and I think that's a typo. VDDIO is 3.3V.
>> This sentence also doesn't make much sense if divide by two would actually
>> lower the range. "For input channels (other than BATT, 5V, or VDDIO) with
>> signals larger than 1.85 V, the divide-by-two option should be set."
>>
> 
> Yeah, what I think they meant is if !DIVIDE_BY_TWO : Vmax = 1.85V else
> Vmax = 3.25V. So it may not be as easy as multiplying hte scale by two.
> I couldn't test it, so I didn't implement it.

Parse error on my side, in the datasheet it is a hyphen not a minus, so I
though the sentence meant that the maximum is 50mV.

I guess it is still a divide by two, but since the max input voltage is 3.3V
you simply can't max out the ADC anymore since the maximum value corresponds to
3.7V

-Lars
