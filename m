Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55954 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbeJASf4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Oct 2018 14:35:56 -0400
Subject: Re: [PATCH] iio: adc: Fix Renesas GyroADC MAINTAINERS entry
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-iio@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
References: <20181001105804.17802-1-marek.vasut+renesas@gmail.com>
 <20181001115559.GA4134@kunai>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <bc65ecfa-5135-5224-bdeb-938b3025c30c@gmail.com>
Date: Mon, 1 Oct 2018 13:58:26 +0200
MIME-Version: 1.0
In-Reply-To: <20181001115559.GA4134@kunai>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/2018 01:55 PM, Wolfram Sang wrote:
> On Mon, Oct 01, 2018 at 12:58:04PM +0200, Marek Vasut wrote:
>> Fix the F: entry in MAINTAINERS file, point it to the correct file.
> 
> Right...
> 
>> @@ -12471,7 +12471,7 @@ RENESAS R-CAR GYROADC DRIVER
>>  M:	Marek Vasut <marek.vasut@gmail.com>
>>  L:	linux-iio@vger.kernel.org
>>  S:	Supported
>> -F:	drivers/iio/adc/rcar_gyro_adc.c
>> +F:	drivers/iio/adc/rcar-gyroadc.c
> 
> Add the bindings, too?
> 
> Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
> 
Separate patch or V2 ?

-- 
Best regards,
Marek Vasut
