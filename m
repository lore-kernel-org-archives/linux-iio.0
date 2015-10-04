Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-229.synserver.de ([212.40.185.229]:1047 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751566AbbJDRXb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 13:23:31 -0400
Message-ID: <5611608B.2040105@metafoo.de>
Date: Sun, 04 Oct 2015 19:23:23 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: Octavian Purdila <octavian.purdila@intel.com>,
	Andrey Yurovsky <andrey@snupi.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/7] staging:iio:dummy: Add DMA buffer support
References: <1443797107-13391-1-git-send-email-lars@metafoo.de> <1443797107-13391-7-git-send-email-lars@metafoo.de> <56114C77.3070909@kernel.org>
In-Reply-To: <56114C77.3070909@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/2015 05:57 PM, Jonathan Cameron wrote:
> On 02/10/15 15:45, Lars-Peter Clausen wrote:
>> Add a DMA buffer implementation to the IIO dummy driver. Similar to the
>> existing kfifo based dummy buffer implementation the buffer is not
>> connected to any real hardware, but rather emulates its behavior.
>>
>> The dummy DMA buffer is meant to be used as a template for implementing DMA
>> buffer support and can also be used to test the generic IIO DMA buffer
>> infrastructure without having access to hardware that has DMA capabilities.
>>
>> The dummy driver is split into two parts. The first part emulates the
>> behavior of a typical DMA controller and converter while the second part
>> implement a typical device driver for such a system. The separation of the
>> two parts is intentionally kept very strict to be to make it clear which
>> parts will be found in a driver for real hardware and which parts will be
>> performed by the hardware and will not be part of the driver.
>>
>> The type of the buffer used by the IIO dummy device has to be chosen at
>> compile time and can either be the old FIFO based software triggered buffer
>> or the DMA buffer. Given that the dummy device driver is mainly intended
>> for testing the framework and providing a simple example to be used as a
>> template for new drivers it is not critical that the buffer type can be
>> chosen or changed at runtime.
> I almost wonder if it's worth building two modules. One with the kfifo and
> one with the dma buffer.
> 
> This is mainly to avoid confusing the distros who will wonder which
> 'fake' option to chose.

Ideally distros shouldn't ship this at all. But we could allow to built both
and then use a module parameter to choose which one to use when both are
built into the module.
