Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33210 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBHlH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Oct 2018 03:41:07 -0400
Subject: Re: [PATCH] iio: adc: Fix Renesas GyroADC MAINTAINERS entry
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: linux-iio@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
References: <20181001105804.17802-1-marek.vasut+renesas@gmail.com>
 <20181001115559.GA4134@kunai>
 <bc65ecfa-5135-5224-bdeb-938b3025c30c@gmail.com>
 <20181001121739.GB4134@kunai> <20181001132001.00007423@huawei.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <f7a97c8d-0b80-5873-3fbb-b3c6152323d0@gmail.com>
Date: Tue, 2 Oct 2018 03:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <20181001132001.00007423@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/2018 02:20 PM, Jonathan Cameron wrote:
> On Mon, 1 Oct 2018 14:17:40 +0200
> Wolfram Sang <wsa@the-dreams.de> wrote:
> 
>> On Mon, Oct 01, 2018 at 01:58:26PM +0200, Marek Vasut wrote:
>>> On 10/01/2018 01:55 PM, Wolfram Sang wrote:  
>>>> On Mon, Oct 01, 2018 at 12:58:04PM +0200, Marek Vasut wrote:  
>>>>> Fix the F: entry in MAINTAINERS file, point it to the correct file.  
>>>>
>>>> Right...
>>>>   
>>>>> @@ -12471,7 +12471,7 @@ RENESAS R-CAR GYROADC DRIVER
>>>>>  M:	Marek Vasut <marek.vasut@gmail.com>
>>>>>  L:	linux-iio@vger.kernel.org
>>>>>  S:	Supported
>>>>> -F:	drivers/iio/adc/rcar_gyro_adc.c
>>>>> +F:	drivers/iio/adc/rcar-gyroadc.c  
>>>>
>>>> Add the bindings, too?
>>>>
>>>> Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>>>   
>>> Separate patch or V2 ?  
>>
>> I'd say V2, but I am not the IIO maintainer.
>>
>>
> 
> v2 please given I haven't done anything with v1 yet.

Done

-- 
Best regards,
Marek Vasut
