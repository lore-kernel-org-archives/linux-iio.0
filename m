Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-233.synserver.de ([212.40.185.233]:1041 "EHLO
	smtp-out-024.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753747AbaCaTGU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Mar 2014 15:06:20 -0400
Message-ID: <5339BCDC.80609@metafoo.de>
Date: Mon, 31 Mar 2014 21:07:08 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Ge Gao <GGao@invensense.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: unreliable time function inside IRQ?
References: <E7747D604FBC9F43A71AA431AFF447622577643E@IUSEXCH01.invcorp.invensense.com> <5336A913.1040908@kernel.org> <E7747D604FBC9F43A71AA431AFF4476225780BE2@IUSEXCH01.invcorp.invensense.com>
In-Reply-To: <E7747D604FBC9F43A71AA431AFF4476225780BE2@IUSEXCH01.invcorp.invensense.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/31/2014 07:44 PM, Ge Gao wrote:
> Dear Jonathan,
> 	Thanks for answering my question. I am using Panda board(OMAP4430). It is using a 32K counter clock as the high resolution clock(arch/arm/plat-omap/couter_32k.c). But I also observe the same thing in Nexus 7 first generation(announced in 2012), which uses Nvidia Tegra 3 platform. I suspect the data that represents the time is cached, or it is using some older value in the interrupt case.
> It could be the Linux's time function problem. Is that possible? I actually tried using Jiffy, which is the built-in software clock. The time between each interrupt also varies big. My HZ setting is 1000. I also tried a later version of Linux, which is 3.7 or later. The result is the same.
> 	The implementation of the time function is very simple. Below is the function from 32K clock counter. It is reading the hardware clock, compute the difference between a static variable and update the time. For a different clock, only the "clocksource_32k.mult", "clocksource_32k.shift", would be different.
> 	Thanks.

You have to consider that there will be other things running with IRQs off, 
which will cause some jitter for your IRQ handler. This is nothing IIO specific.

- Lars
