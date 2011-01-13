Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:39116 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab1AMMq6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 07:46:58 -0500
Message-ID: <4D2EF5FA.40607@cam.ac.uk>
Date: Thu, 13 Jan 2011 12:54:18 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: different ring buffer usage scenario
References: <544AC56F16B56944AEC3BD4E3D591771324BEA42CB@LIMKCMBX1.ad.analog.com> <4D0B7888.6050007@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771324BFF3F3A@LIMKCMBX1.ad.analog.com> <4D2EE0BA.2090603@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771324BFF4041@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324BFF4041@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/13/11 12:17, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-01-13:
>> On 01/13/11 09:20, Hennerich, Michael wrote:
>>> Jonathan Cameron wrote on 2010-12-17:
>>>> On 12/17/10 13:47, Hennerich, Michael wrote:
>>>>> Hi Jonathan,
>>>>>
>>>>> I'm currently working on a high speed ADC driver, that requires a
>>>>> different ring buffer use case scenario. Let me explain a little bit
>>>>> the setup. I'm running Linux on a Microblaze softcore inside an
>>>>> Virtex6 FPGA. Part of the system is a peripheral interface block, we
>>>>> call it the ADC Interface Module (AIM). External to the FPGA we
>>>>> connect a single channel high speed ADC AD9649, to the AIM signals.
>>>>>
>>>>> The AIM features a FIFO, with watermark interrupt capabilities.
>>>>> There are two modes that need to be supported. Continues Sampling
>>>>> Mode and Single Shot Sample Mode. In Single Shot Sample Mode, the
>>>>> user reads an arbitrary Number of samples from the
>>>> ADC, and then the sampling stops. This mode does not need to have a
>>>> ringbuffer at all.
>>>>> A simple chardev might be sufficient.
>>>>>
>>>>> Any objections creating a driver private chardev?
>>>> None at all.
>>>> Is it appropriate to maintain the interfaces and buffer description
>>>> we have for those where there is a buffer involved?  I think those
>>>> interfaces are flexible enough... If not we probably want to make
>>>> it so they are.
>>>>
>>>> I did think of creating a pass through buffer that would effectively
>>>> allow other devices to simulate this behaviour. Basically to the core
>>>> it would look like a buffer, but it would only store one scan and then
>>>> only if someone has the chrdev open. It would support select type
>>>> calls. This would be needed for the input bridge to no apply any delay
>>>> to the data stream.
>>>>
>>>> Not actually done any work on it though.
>>>
>>> Hi Jonathan,
>>>
>>> For a project I'm currently working on I need such a pass through
>>> buffer.
>>>
>>> The requirements I have are pretty basic. When user space reads x
>>> number of elements
>>>> From the buffer, the generic pass through buffer implementation
>>>> calls a registered
>>> function in the ADC driver, that may sleep until the requested
>>> amount of elements are available.
>>>
>>> I wonder if you have something in the make already?
>> Interesting, that's not a case I'd thought of previously.
>>
>> You could get fairly close by using the ring buffer with 2x the number
>> of elements then do a blocking read on the event (for a 50% full
>> event). It would be a bit ugly if the number x changes regularly
>> though so far from ideal.
> 
> That's not what I need.
> User space triggers the sampling process by reading from the buffer chardev.
> The device samples @ 20MHz, so the time the read() may sleep is in the
> range of micro seconds. My idea is basically to use the infrastructure in
> industrialio-ring.c to allocate the buffer_access_chrdev.
> Theoretically I don't need the buffer_event_chrdev at all, but in order to keep consistency
> I should send a 100_FULL event.
I wouldn't bother. Not all buffer types send events anyway. We certainly don't guarantee them.
> 
>> So all in all it will probably need a custom buffer.  Quickest option
>> is probably to use the kfifo implementation and play games in the rip
>> lots function. Depending on how big x typically is, you could either
>> add a waitqueue that makes iio_rip_kfifo wake up every time any new
>> data is added to the kfifo,
> 
> Data is added to the buffer in one shot - I receive sampling done interrupt,
> and then may use Core or DMA to transfer the data from the device internal fifo
> to some local buffer which is then copied to the user.
> For now the maximum number of samples that can be read in one shot must be less or equal
> the hardware fifo size.
Sounds sensible.

> 
>> or you could set a value in the buffer and
>> check how many elements are in the buffer in iio_store_to_kfifo and
>> only signal iio_rip_kfifo when it is bigger than your threshold. I
>> guess you may want to flush the kfifo as well though that will IIRC
>> require some careful locking. Might actually be quicker to just eat
>> the existing contents at the beginning of iio_rip_kfifo (if ugly).
>>
>> I think this would need to be a separate implementation from kfifo,
>> but I guess you could do it as a couple of 'variant functions' and
>> supply a separate iio_kfifo_register_funcs in the header.
>>
>> Should be relatively straight forward to get something that works. I'm
>> sure there are more efficient ways of doing it, but this is probably
>> the easiest to implement.
> 
> Well - I think I don't need an additional software fifo at all.
> The device I'm interfacing has a built-in
> FIFO, and some controls that allow me the set the number of samples that are captured.
> I'll probably do something similar to the sca3000_ring.c driver, and add my own buffer
> implementation.
That is probably the best bet.

