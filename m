Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:40825 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422680AbbENWps (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 14 May 2015 18:45:48 -0400
Message-ID: <55552570.5050407@ni.com>
Date: Thu, 14 May 2015 17:45:04 -0500
From: Xander Huff <xander.huff@ni.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, ben.shelton@ni.com,
	joe.hershberger@ni.com, joshc@ni.com
Subject: Re: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
References: <1431013090-18996-1-git-send-email-xander.huff@ni.com> <20150514171038.GG13442@linutronix.de>
In-Reply-To: <20150514171038.GG13442@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/14/2015 12:10 PM, Sebastian Andrzej Siewior wrote:
>
> Do you have any cyclictest numbers how much the latency increases on
> heavy iio usage? Traditionally the primary handler should be very quick
> / short.
>
> Sebastian
>
With no other processes running, I got the following results after a couple of 
hours on one of our devices:

admin@Xander-roboRIO:~# cyclictest -S -m -p 98
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.01 0.07 0.12 1/176 1473

T: 0 ( 1373) P:98 I:1000 C:6503872 Min:      9 Act:   13 Avg:   13 Max:      51
T: 1 ( 1374) P:98 I:1500 C:4335914 Min:      9 Act:   12 Avg:   13 Max:      49

With a VI reading all default handles (raw, offset, scale, sampling_frequency) 
in /sys/bus/iio/devices/iio:device0 constantly in a while loop, I got the 
following results after a couple hours on the same device:

admin@Xander-roboRIO:~# cyclictest -S -m -p 98
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 6.93 7.30 7.47 3/182 1530

T: 0 ( 1487) P:98 I:1000 C:4497008 Min:     11 Act:   20 Avg:   21 Max:      69
T: 1 ( 1488) P:98 I:1500 C:2998005 Min:     11 Act:   20 Avg:   22 Max:      59

-- 
Xander Huff
Staff Software Engineer
National Instruments
