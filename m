Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38784 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbHLQdc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 12:33:32 -0400
Message-ID: <55CB7558.3090608@linutronix.de>
Date: Wed, 12 Aug 2015 18:33:28 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Xander Huff <xander.huff@ni.com>, jic23@kernel.org
CC: knaack.h@gmx.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	joe.hershberger@ni.com, joshc@ni.com, nathan.sullivan@ni.com,
	jaeden.amero@ni.com
Subject: Re: [PATCH v4] iio: adc: xilinx-xadc: Push interrupts into hardirq
 context
References: <55C07160.5040907@metafoo.de> <1439334049-28671-1-git-send-email-xander.huff@ni.com> <55CB6391.7060502@metafoo.de>
In-Reply-To: <55CB6391.7060502@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/2015 05:17 PM, Lars-Peter Clausen wrote:
> On 08/12/2015 01:00 AM, Xander Huff wrote:
>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>> and is thus not able to be acquired from a hardirq handler. This patch gets
>> rid of the threaded handler and pushes all interrupt handling into the
>> hardirq context, and uses request_irq().
>>
>> To validate that this change has no impact on RT performance, here are
>> cyclictest values with no processes running:
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Yes, I'm fine with the rework, too.

Sebastian
