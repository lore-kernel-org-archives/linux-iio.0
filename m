Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36558 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753631AbcL3Vtm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 16:49:42 -0500
Subject: Re: [PATCH] iio: adc: Add Renesas GyroADC driver
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161230191800.2532-1-marek.vasut@gmail.com>
 <alpine.DEB.2.02.1612302027480.3977@pmeerw.net>
 <442f8085-110c-659d-d097-add788b8f291@gmail.com>
 <alpine.DEB.2.02.1612302205210.3977@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <84a65f76-b82a-030b-a527-ee23d9ad25a8@gmail.com>
Date: Fri, 30 Dec 2016 22:49:37 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1612302205210.3977@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/30/2016 10:09 PM, Peter Meerwald-Stadler wrote:
> 
>>>> Add IIO driver for the Renesas RCar GyroADC block. This block is a
>>>> simple 4/8-channel ADC which samples 12/15/24 bits of data every
> 
>>>> +		if (iio_buffer_enabled(indio_dev))
>>>> +			return -EBUSY;
>>>
>>> use iio_device_claim_direct_mode()
>>
>> Why ? Do I really need the mutex locking here ?
> 
> no, not needed, since you do not support buffered mode yet; but neither do 
> you need iio_buffer_enabled() 
> 
> p.
> 

So drop the whole thing then ?

-- 
Best regards,
Marek Vasut
