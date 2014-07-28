Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5658 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbaG1LJq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Jul 2014 07:09:46 -0400
Message-ID: <57688.163.33.229.63.1406545747.squirrel@linux.intel.com>
In-Reply-To: <53D12208.9030500@metafoo.de>
References: <61739.163.33.230.161.1406207197.squirrel@linux.intel.com>
    <53D12208.9030500@metafoo.de>
Date: Mon, 28 Jul 2014 11:09:07 -0000 (GMT)
Subject: Re: IIO for PCIe-DMA ADC
From: "Krzysztof Sywula" <krzysztof.m.sywula@linux.intel.com>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Cc: "Krzysztof Sywula" <krzysztof.m.sywula@linux.intel.com>,
	linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars, I have few more questions, would love if you could answer.
- ADC I have uses max 4KHz sampling frequency, SoC CPU is 533MHz; will IIO
cope?
- are there any other ADCs in IIO framework that use your DMA-extension?
- I would like to use dw_dmac DMA driver, I hope both, IIO and your
DMA-extension will honour that
- what is the status of upstreaming DMA-extension? Are you commited to any
dates?
- is there any out of the box set of tests for IIO/DMA-extension?

Thanks,
Krzysztof Sywula

> On 07/24/2014 03:06 PM, Krzysztof Sywula wrote:
>> Hi there, I’m designing a PCIe driver for DMA enabled ADC. Is IIO
>> handling
>> such a combo? I'm based on kernel 3.8.7.
>>
>> Website:
>> http://wiki.analog.com/software/linux/docs/iio/iio
>> says "However typical DMA operated devices such as ones connected to a
>> high speed synchronous serial (McBSP, SPORT) or high speed synchronous
>> parallel (EPI, PPI) or FPGA peripherals are also subject to this
>> subsystem."
>>
>> which is not clear enough for me to answer that question.
>
>
> Hi,
>
> The current upstream version of IIO does not have built-in support for
> DMA,
> but you can always create your custom buffer implementation that handles
> the
> DMA.
>
> There is a out of tree generic DMA[0] and DMAengine[1] support for IIO.
> This
> is both scheduled for mainline submission, but obviously will not be
> available in a 3.8.7 kernel.
>
> - Lars
>
> [0]
> https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/industrialio-dmabuf.c
> [1]
> https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/industrialio-dmaengine.c
>
>

