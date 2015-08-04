Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1110 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbbHDIFJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 04:05:09 -0400
Message-ID: <55C0722C.7080904@metafoo.de>
Date: Tue, 04 Aug 2015 10:05:00 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
CC: Xander Huff <xander.huff@ni.com>, jic23@kernel.org,
	bigeasy@linutronix.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michal Simek <michal.simek@xilinx.com>,
	=?windows-1252?Q?S=F6ren_Brink?= =?windows-1252?Q?mann?=
	<soren.brinkmann@xilinx.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	joe.hershberger@ni.com, joshc@ni.com, nathan.sullivan@ni.com,
	jaeden.amero@ni.com
Subject: Re: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>	<1437434050-32907-1-git-send-email-xander.huff@ni.com>	<55B231DE.4080308@metafoo.de> <CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ@mail.gmail.com>
In-Reply-To: <CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/2015 07:34 AM, Shubhrajyoti Datta wrote:
> On Fri, Jul 24, 2015 at 6:08 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> Hi,
>>
>> Sorry, but I don't think this patch has been sufficiently tested against a
>> mainline kernel. The driver wont even probe the way it is right now.
>>
>> On 07/21/2015 01:14 AM, Xander Huff wrote:
>>>
>>> The driver currently registers a pair of irq handlers using
>>> request_threaded_irq(), however the synchronization mechanism between the
>>> hardirq and the threadedirq handler is a regular spinlock.
>>
>>
>> If everything runs in threaded context we don't really need the spinlock
>> anymore and can use the mutex throughout.
> 
> that should be better from the performance point of view.
> 
>>
>>>
>>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>>> and is thus not able to be acquired from a hardirq handler. This patch
>>> gets
>>> rid of the hardirq handler and pushes all interrupt handling into the
>>> threaded context.
>>
>>
>> We actually might as well run everything in the hardirq handler (which will
>> be threaded in PREEMPT_RT). The reason why we have the threaded handler is
>> because xadc_handle_event() used to sleep, but it doesn't do this anymore.
> 
> The point is why have the hard irq. If we use hardirq then not mutex
> can be used and spinlock will
> be busy.

Well there is no need to use a threaded IRQ. The interrupt handler is quite
small and doesn't take too much time and doesn't have any delays or sleeps
in it either.


