Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-247.synserver.de ([212.40.185.247]:1051 "EHLO
	smtp-out-243.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751295AbaG1LsO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jul 2014 07:48:14 -0400
Message-ID: <53D63879.5050709@metafoo.de>
Date: Mon, 28 Jul 2014 13:48:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Krzysztof Sywula <krzysztof.m.sywula@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: IIO for PCIe-DMA ADC
References: <61739.163.33.230.161.1406207197.squirrel@linux.intel.com>    <53D12208.9030500@metafoo.de> <57688.163.33.229.63.1406545747.squirrel@linux.intel.com>
In-Reply-To: <57688.163.33.229.63.1406545747.squirrel@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/28/2014 01:09 PM, Krzysztof Sywula wrote:
> Lars, I have few more questions, would love if you could answer.
> - ADC I have uses max 4KHz sampling frequency, SoC CPU is 533MHz; will IIO
> cope?

That's more of a hardware issue and less of a IIO framework issue. But I 
think 4kHz is something that's even without DMA possible to archive without 
problems.

> - are there any other ADCs in IIO framework that use your DMA-extension?

Not at this point.

> - I would like to use dw_dmac DMA driver, I hope both, IIO and your
> DMA-extension will honour that

If the dw_dmac driver is compliant with the DMAengine API it will work out 
of the box.

> - what is the status of upstreaming DMA-extension? Are you commited to any
> dates?

soon ;) The plan is to at least send the kernel parts after the next merge 
window has closed.

> - is there any out of the box set of tests for IIO/DMA-extension?

The userspace API is backwards compatible so you can use the same tools that 
can be used to test other IIO applications.

- Lars

>
> Thanks,
> Krzysztof Sywula
>
>> On 07/24/2014 03:06 PM, Krzysztof Sywula wrote:
>>> Hi there, I’m designing a PCIe driver for DMA enabled ADC. Is IIO
>>> handling
>>> such a combo? I'm based on kernel 3.8.7.
>>>
>>> Website:
>>> http://wiki.analog.com/software/linux/docs/iio/iio
>>> says "However typical DMA operated devices such as ones connected to a
>>> high speed synchronous serial (McBSP, SPORT) or high speed synchronous
>>> parallel (EPI, PPI) or FPGA peripherals are also subject to this
>>> subsystem."
>>>
>>> which is not clear enough for me to answer that question.
>>
>>
>> Hi,
>>
>> The current upstream version of IIO does not have built-in support for
>> DMA,
>> but you can always create your custom buffer implementation that handles
>> the
>> DMA.
>>
>> There is a out of tree generic DMA[0] and DMAengine[1] support for IIO.
>> This
>> is both scheduled for mainline submission, but obviously will not be
>> available in a 3.8.7 kernel.
>>
>> - Lars
>>
>> [0]
>> https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/industrialio-dmabuf.c
>> [1]
>> https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/industrialio-dmaengine.c
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

