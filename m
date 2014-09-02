Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1289 "EHLO
	smtp-out-164.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbaIBP5j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Sep 2014 11:57:39 -0400
Message-ID: <5405E8EE.4020309@metafoo.de>
Date: Tue, 02 Sep 2014 17:57:34 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: pushing SOC specific Trigger provider driver to upstream kernel
References: <27E62D98F903554192E3C13AFCC91C3C2B778F57@hbmail01.hb.imgtec.org> <54034456.5050004@kernel.org>
In-Reply-To: <54034456.5050004@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/2014 05:50 PM, Jonathan Cameron wrote:
> On 31/08/14 15:50, Naidu Tellapati wrote:
>> Hi Mr. Jonathan and all,
>>
> For now just cc'd Lars-Peter on the basis Analog have a very similar timer based trigger (still in staging)
> and I suspect he has some thoughts on this.
>
> Lars, want to comment?

The plan for that driver is to replace it with a generic driver that uses 
the PWM framework. What we really want from this driver is that it generates 
a waveform on a pin which can be used as a conversion start signal.

If you just want to use a timer chip without a PWM waveform write a 
clockchip/clocksource driver for your timer IP and then use hrtimer as a 
generic IIO trigger. Which brings us back to the old problem that we still 
need to create the infrastructure to instantiate hrtimer triggers.

- Lars

>> My name is Naidu Tellapati from India. I work for Imagination Technologies, India. Thanks in advance for your help in this regard.
>>
>> After going through some of the emails in the Linux-IIO email archive, we have taken the following approach to implement our Linux IIO based ADC driver.
>>
>> We are planning to have two drivers as part of our implementation.
>>
>> 1. Timer's Periodic Interrupt Trigger Provider IIO driver (This driver uses our SOC specific Timer's periodic interrupt)
>>
>> 2. The generic IIO ADC driver (This ADC driver uses the periodic Timer Interrupt Trigger provided by the above driver)
>>
>> The plan is to push both the drivers upstream to kernel.org. Now please suggest us, do you consider SOC specific Trigger Provider driver as well for pushing upstream to kernel.org ?
>>
>>
>> Thanks in advance,
>>
>> Regards,
>> Naidu.
>>
>>
>>

