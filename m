Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35535 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759263AbdAIOQ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 09:16:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so22543052wml.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Jan 2017 06:16:25 -0800 (PST)
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20170109000309.22511-1-marek.vasut@gmail.com>
 <94f3e023-03a5-99f0-1810-15b35f3417b9@metafoo.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <1bf1278c-cfbd-bda6-9417-96ea49dd0098@gmail.com>
Date: Mon, 9 Jan 2017 14:47:24 +0100
MIME-Version: 1.0
In-Reply-To: <94f3e023-03a5-99f0-1810-15b35f3417b9@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2017 02:45 PM, Lars-Peter Clausen wrote:
> On 01/09/2017 01:03 AM, Marek Vasut wrote:
> [...]
>> +- renesas,gyroadc-mode:	GyroADC mode of operation, must be either of:
>> +			1 - MB88101A mode, 12bit sampling, 4 channels
>> +			2 - ADCS7476 mode, 15bit sampling, 8 channels
>> +			3 - MAX1162 mode,  16bit sampling, 8 channels
> 
> So is this a ADC, or is this just a specialized SPI controller that
> interfaces to an external ADC?

It's a special SPI controller, except one cannot access the SPI bus
directly. It sends out clock and reads in the data from the ADC .

-- 
Best regards,
Marek Vasut
