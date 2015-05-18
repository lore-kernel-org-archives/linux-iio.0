Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51272 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbERVRe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 17:17:34 -0400
Date: Mon, 18 May 2015 23:17:28 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xander Huff <xander.huff@ni.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, ben.shelton@ni.com,
	joe.hershberger@ni.com, joshc@ni.com
Subject: Re: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
Message-ID: <20150518211728.GC4275@linutronix.de>
References: <1431013090-18996-1-git-send-email-xander.huff@ni.com>
 <20150514171038.GG13442@linutronix.de>
 <55552570.5050407@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <55552570.5050407@ni.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Xander Huff | 2015-05-14 17:45:04 [-0500]:

>With no other processes running, I got the following results after a
>couple of hours on one of our devices:
>
>admin@Xander-roboRIO:~# cyclictest -S -m -p 98
># /dev/cpu_dma_latency set to 0us
>policy: fifo: loadavg: 0.01 0.07 0.12 1/176 1473
>
>T: 0 ( 1373) P:98 I:1000 C:6503872 Min:      9 Act:   13 Avg:   13 Max:      51
>T: 1 ( 1374) P:98 I:1500 C:4335914 Min:      9 Act:   12 Avg:   13 Max:      49
>
>With a VI reading all default handles (raw, offset, scale,
>sampling_frequency) in /sys/bus/iio/devices/iio:device0 constantly in
>a while loop, I got the following results after a couple hours on the
>same device:
>
>admin@Xander-roboRIO:~# cyclictest -S -m -p 98
># /dev/cpu_dma_latency set to 0us
>policy: fifo: loadavg: 6.93 7.30 7.47 3/182 1530
>
>T: 0 ( 1487) P:98 I:1000 C:4497008 Min:     11 Act:   20 Avg:   21 Max:      69
>T: 1 ( 1488) P:98 I:1500 C:2998005 Min:     11 Act:   20 Avg:   22 Max:      59

So there is an increase. And there is even a for-loop and I don't know
how deep it is nested. Anyway, do you think it is worth it or would it
be better to get rid of the raw-locks and simply push everything into
threaded context?

Sebastian
