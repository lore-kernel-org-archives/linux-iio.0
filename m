Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35503 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754045AbdEDQVY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 12:21:24 -0400
Date: Thu, 04 May 2017 17:21:17 +0100
In-Reply-To: <EA573BDD7CF69549972F7393812B404A558EA7@CHN-SV-EXMX03.mchp-main.com>
References: <EA573BDD7CF69549972F7393812B404A558EA7@CHN-SV-EXMX03.mchp-main.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: DMA support for at91-sama5d2 ADC driver
To: Eugen.Hristev@microchip.com, lars@metafoo.de,
        linux-iio@vger.kernel.org
CC: Nicolas.Ferre@microchip.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <E01FD574-0ED8-4207-B589-065806ADC592@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 4 May 2017 14:07:19 BST, Eugen.Hristev@microchip.com wrote:
>Hello,
>
>I am making a proof of concept for DMA functionality for the
>at91-sama5d2 ADC driver.
>I would like to ask if it's better to implement in an old fashion way
>(request dma channel, allocate memory, start transfer), or try to
>integrate with the DMA-buffer in the iio subsystem ?
>Is there any driver using that system in the current kernel ?
Lars?

>
>Also, is there a way to enable/disable DMA coming from the subsystem to
>the driver ? (I mean from sysfs, to have or create an option for the
>buffer to use DMA or not).
>Using DMA has the advantage of less interrupts coming, but much less
>granularity on the incoming triggered conversions. So I thought a way
>for the user to enable or disable it might be convenient.
Use the fifo watermark stuff perhaps?  
If set high enough use DMA, if lower then don't.

Complexity around triggering however. Generally DMA pushed to kfifo is done without triggers as
there is no per scan interrupt to hang other devices off.  Also no timestamps...
>
>
>Thanks for all the inputs,
>
>Eugen Hristev
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
