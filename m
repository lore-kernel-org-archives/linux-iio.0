Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:45256 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbdEDQeZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 12:34:25 -0400
Subject: Re: DMA support for at91-sama5d2 ADC driver
To: Jonathan Cameron <jic23@kernel.org>, Eugen.Hristev@microchip.com,
        linux-iio@vger.kernel.org
References: <EA573BDD7CF69549972F7393812B404A558EA7@CHN-SV-EXMX03.mchp-main.com>
 <E01FD574-0ED8-4207-B589-065806ADC592@kernel.org>
Cc: Nicolas.Ferre@microchip.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a6e7d8be-2640-48b7-fe0c-bdadef84d068@metafoo.de>
Date: Thu, 4 May 2017 18:34:19 +0200
MIME-Version: 1.0
In-Reply-To: <E01FD574-0ED8-4207-B589-065806ADC592@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/04/2017 06:21 PM, Jonathan Cameron wrote:
> 
> 
> On 4 May 2017 14:07:19 BST, Eugen.Hristev@microchip.com wrote:
>> Hello,
>>
>> I am making a proof of concept for DMA functionality for the
>> at91-sama5d2 ADC driver.
>> I would like to ask if it's better to implement in an old fashion way
>> (request dma channel, allocate memory, start transfer), or try to
>> integrate with the DMA-buffer in the iio subsystem ?
>> Is there any driver using that system in the current kernel ?
> Lars?

I know that somebody at some point made a working implementation for the
AT91 using the generic DMAengine buffer. So that certainly is an option and
I'd recommend it.

Unfortunately their e-mail address started bouncing (probably moved jobs)
and I'm not sure if the code ever got published.

