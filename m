Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:56193 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752052AbbFHOpj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 8 Jun 2015 10:45:39 -0400
Message-ID: <5575AA65.20907@ni.com>
Date: Mon, 08 Jun 2015 09:44:53 -0500
From: Xander Huff <xander.huff@ni.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, ben.shelton@ni.com,
	joe.hershberger@ni.com, joshc@ni.com
Subject: Re: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
References: <1431013090-18996-1-git-send-email-xander.huff@ni.com> <20150514171038.GG13442@linutronix.de> <55552570.5050407@ni.com> <20150518211728.GC4275@linutronix.de> <5574633F.7090004@kernel.org>
In-Reply-To: <5574633F.7090004@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/7/2015 10:29 AM, Jonathan Cameron wrote:
> On 18/05/15 22:17, Sebastian Andrzej Siewior wrote:
>> * Xander Huff | 2015-05-14 17:45:04 [-0500]:
>>
>>> With no other processes running, I got the following results after a
>>> couple of hours on one of our devices:
>>>
>>> admin@Xander-roboRIO:~# cyclictest -S -m -p 98
>>> # /dev/cpu_dma_latency set to 0us
>>> policy: fifo: loadavg: 0.01 0.07 0.12 1/176 1473
>>>
>>> T: 0 ( 1373) P:98 I:1000 C:6503872 Min:      9 Act:   13 Avg:   13 Max:      51
>>> T: 1 ( 1374) P:98 I:1500 C:4335914 Min:      9 Act:   12 Avg:   13 Max:      49
>>>
>>> With a VI reading all default handles (raw, offset, scale,
>>> sampling_frequency) in /sys/bus/iio/devices/iio:device0 constantly in
>>> a while loop, I got the following results after a couple hours on the
>>> same device:
>>>
>>> admin@Xander-roboRIO:~# cyclictest -S -m -p 98
>>> # /dev/cpu_dma_latency set to 0us
>>> policy: fifo: loadavg: 6.93 7.30 7.47 3/182 1530
>>>
>>> T: 0 ( 1487) P:98 I:1000 C:4497008 Min:     11 Act:   20 Avg:   21 Max:      69
>>> T: 1 ( 1488) P:98 I:1500 C:2998005 Min:     11 Act:   20 Avg:   22 Max:      59
>>
>> So there is an increase. And there is even a for-loop and I don't know
>> how deep it is nested. Anyway, do you think it is worth it or would it
>> be better to get rid of the raw-locks and simply push everything into
>> threaded context?
>>
> Certainly seems likely to be a better way forward to me but I don't
> really mind either way.
>
> J
>
We'll be giving Sebastian's suggestion a try, as time allows.

-- 
Xander Huff
Staff Software Engineer
National Instruments
