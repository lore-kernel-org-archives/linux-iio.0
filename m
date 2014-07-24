Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1157 "EHLO
	smtp-out-013.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759467AbaGXPLG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jul 2014 11:11:06 -0400
Message-ID: <53D12208.9030500@metafoo.de>
Date: Thu, 24 Jul 2014 17:11:04 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Krzysztof Sywula <krzysztof.m.sywula@linux.intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: IIO for PCIe-DMA ADC
References: <61739.163.33.230.161.1406207197.squirrel@linux.intel.com>
In-Reply-To: <61739.163.33.230.161.1406207197.squirrel@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/24/2014 03:06 PM, Krzysztof Sywula wrote:
> Hi there, I’m designing a PCIe driver for DMA enabled ADC. Is IIO handling
> such a combo? I'm based on kernel 3.8.7.
>
> Website:
> http://wiki.analog.com/software/linux/docs/iio/iio
> says "However typical DMA operated devices such as ones connected to a
> high speed synchronous serial (McBSP, SPORT) or high speed synchronous
> parallel (EPI, PPI) or FPGA peripherals are also subject to this
> subsystem."
>
> which is not clear enough for me to answer that question.


Hi,

The current upstream version of IIO does not have built-in support for DMA, 
but you can always create your custom buffer implementation that handles the 
DMA.

There is a out of tree generic DMA[0] and DMAengine[1] support for IIO. This 
is both scheduled for mainline submission, but obviously will not be 
available in a 3.8.7 kernel.

- Lars

[0] 
https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/industrialio-dmabuf.c
[1] 
https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/industrialio-dmaengine.c

