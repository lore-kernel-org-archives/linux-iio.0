Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38460 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964782AbbENRKo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2015 13:10:44 -0400
Date: Thu, 14 May 2015 19:10:38 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xander Huff <xander.huff@ni.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, ben.shelton@ni.com,
	joe.hershberger@ni.com, joshc@ni.com
Subject: Re: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
Message-ID: <20150514171038.GG13442@linutronix.de>
References: <1431013090-18996-1-git-send-email-xander.huff@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1431013090-18996-1-git-send-email-xander.huff@ni.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Xander Huff | 2015-05-07 10:38:10 [-0500]:

>The driver currently registers a pair of irq handlers using
>request_threaded_irq(), however the synchronization mechanism
>between the hardirq and the threadedirq handler is a regular spinlock.
>
>Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can
>sleep, and is thus not able to be acquired from a hardirq handler.
>Because the set of operations performed under the spinlock is already
>minimal and bounded, it is a suitable candidate for being a raw_spinlock.
>
>This patch should not impact behavior on !PREEMPT_RT builds.
>
>Signed-off-by: Xander Huff <xander.huff@ni.com>
>Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
>Reviewed-by: Ben Shelton <ben.shelton@ni.com>
>Reviewed-by: Josh Cartwright <joshc@ni.com>

Do you have any cyclictest numbers how much the latency increases on
heavy iio usage? Traditionally the primary handler should be very quick
/ short.

Sebastian
