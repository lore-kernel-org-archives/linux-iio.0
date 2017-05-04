Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43044 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbdEDNHa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 09:07:30 -0400
From: <Eugen.Hristev@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>
CC: <Nicolas.Ferre@microchip.com>
Subject: DMA support for at91-sama5d2 ADC driver
Date: Thu, 4 May 2017 13:07:19 +0000
Message-ID: <EA573BDD7CF69549972F7393812B404A558EA7@CHN-SV-EXMX03.mchp-main.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I am making a proof of concept for DMA functionality for the
at91-sama5d2 ADC driver.
I would like to ask if it's better to implement in an old fashion way
(request dma channel, allocate memory, start transfer), or try to
integrate with the DMA-buffer in the iio subsystem ?
Is there any driver using that system in the current kernel ?

Also, is there a way to enable/disable DMA coming from the subsystem to
the driver ? (I mean from sysfs, to have or create an option for the
buffer to use DMA or not).
Using DMA has the advantage of less interrupts coming, but much less
granularity on the incoming triggered conversions. So I thought a way
for the user to enable or disable it might be convenient.


Thanks for all the inputs,

Eugen Hristev

