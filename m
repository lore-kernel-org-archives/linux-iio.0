Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-229.synserver.de ([212.40.185.229]:1032 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751584AbbJDRa2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 13:30:28 -0400
Message-ID: <5611622D.7060504@metafoo.de>
Date: Sun, 04 Oct 2015 19:30:21 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: Octavian Purdila <octavian.purdila@intel.com>,
	Andrey Yurovsky <andrey@snupi.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/7] iio: Add generic DMA buffer infrastructure
References: <1443797107-13391-1-git-send-email-lars@metafoo.de> <1443797107-13391-6-git-send-email-lars@metafoo.de> <56114716.4040504@kernel.org>
In-Reply-To: <56114716.4040504@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/2015 05:34 PM, Jonathan Cameron wrote:
> On 02/10/15 15:45, Lars-Peter Clausen wrote:
>> The traditional approach used in IIO to implement buffered capture requires
>> the generation of at least one interrupt per sample. In the interrupt
>> handler the driver reads the sample from the device and copies it to a
>> software buffer. This approach has a rather large per sample overhead
>> associated with it. And while it works fine for samplerates in the range of
>> up to 1000 samples per second it starts to consume a rather large share of
>> the available CPU processing time once we go beyond that, this is
>> especially true on an embedded system with limited processing power. The
>> regular interrupt also causes increased power consumption by not allowing
>> the hardware into deeper sleep states, which is something that becomes more
>> and more important on mobile battery powered devices.
>>
>> And while the recently added watermark support mitigates some of the issues
>> by allowing the device to generate interrupts at a rate lower than the data
>> output rate, this still requires a storage buffer inside the device and
>> even if it exists it is only a few 100 samples deep at most.
>>
>> DMA support on the other hand allows to capture multiple millions or even
>> more samples without any CPU interaction. This allows the CPU to either go
>> to sleep for longer periods or focus on other tasks which increases overall
>> system performance and power consumption. In addition to that some devices
>> might not even offer a way to read the data other than using DMA, which
>> makes DMA mandatory to use for them.
>>
>> The tasks involved in implementing a DMA buffer can be divided into two
>> categories. The first category is memory buffer management (allocation,
>> mapping, etc.) and hooking this up the IIO buffer callbacks like read(),
>> enable(), disable(), etc. The second category of tasks is to setup the
>> DMA hardware and manage the DMA transfers. Tasks from the first category
>> will be very similar for all IIO drivers supporting DMA buffers, while the
>> tasks from the second category will be hardware specific.
>>
>> This patch implements a generic infrastructure that takes care of the
>> former tasks. It provides a set of functions that implement the standard
>> IIO buffer iio_buffer_access_funcs callbacks. These can either be used as
>> is or be overloaded and augmented with driver specific code where
>> necessary.
>>
>> For the DMA buffer support infrastructure that is introduced in this patch
>> sample data is grouped by so called blocks. A block is the basic unit at
>> which data is exchanged between the application and the hardware. The
>> application is responsible for allocating the memory associated with the
>> block and then passes the block to the hardware. When the hardware has
>> captured the amount of samples equal to size of a block it will notify the
>> application, which can then read the data from the block and process it.
>> The block size can be freely chosen (within the constraints of the
>> hardware). This allows to make a trade-off between latency and management
>> overhead. The larger the block size the lower the per sample overhead but
>> the latency between when the data was captured and when the application
>> will be able to access it increases, in a similar way smaller block sizes
>> have a larger per sample management overhead but a lower latency. The ideal
>> block size thus depends on system and application requirements.
>>
>> For the time being the infrastructure only implements a simple double
>> buffered scheme which allocates two blocks each with half the size of the
>> configured buffer size. This provides basic support for capturing
>> continuous uninterrupted data over the existing file-IO ABI. Future
>> extensions to the DMA buffer infrastructure will give applications a more
>> fine grained control over how many blocks are allocated and the size of
>> each block. But this requires userspace ABI additions which are
>> intentionally not part of this patch and will be added separately.
>>
>> Tasks of the second category need to be implemented by a device specific
>> driver. They can be hooked up into the generic infrastructure using two
>> simple callbacks, submit() and abort().
>>
>> The submit() callback is used to schedule DMA transfers for blocks. Once a
>> DMA transfer has been completed it is expected that the buffer driver calls
>> iio_dma_buffer_block_done() to notify. The abort() callback is used for
>> stopping all pending and active DMA transfers when the buffer is disabled.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> This is nice and clean.  It might take me a little time to mull
> it over in detail for now, I've just pointed out a few typos in comments :)
> The fun question is who is going to dive in and review it?
> 
> Beautifully presented series!
> 
> Thanks,
> 
> Jonathan
> 
> p.s. Almost years since we sat down and talked this through ;)
> Hmm. That was the same day Greg asked me when we were finally going
> to get the remaining drivers out of staging on the basis they'd been
> there a while by then. Ooops.

Yeah, two years next week, it was during ELCE2013, I'm at the airport on my
way to ELCE2015 right now. Writing the documentation for all of this took a
while ;)

Thanks for having a look.

- Lars
