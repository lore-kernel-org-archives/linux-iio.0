Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:38052 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaLRQnS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Dec 2014 11:43:18 -0500
Received: by mail-qg0-f49.google.com with SMTP id a108so1097849qge.22
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2014 08:43:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5492FE42.70009@metafoo.de>
References: <1418839183-27819-1-git-send-email-angelo.compagnucci@gmail.com> <5492FE42.70009@metafoo.de>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Thu, 18 Dec 2014 17:42:36 +0100
Message-ID: <CA+TH9VkQ_yprkV_2PCc57jMoW-=vFr6nXfBAUyy1jLtQetKibw@mail.gmail.com>
Subject: Re: [PATCH] iio: ti-adc128s052: Add DT binding documentation
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars-Peter,

2014-12-18 17:18 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 12/17/2014 06:59 PM, Angelo Compagnucci wrote:
>>
>> Adding binding documentation for Texas Instruments' ADC128S052 ADC chip.
>>
>> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>
>
> Looks good to me, but you might want to send this to the devicetree list and
> the devicetree bindings maintainers.

Ouch! Resending to the right ml, thank you for your support!

>
> [...]
>>
>> +Example:
>> +adc@0 {
>> +       compatible = "ti,adc128s052";
>> +       reg = <0>;
>> +        vref-supply = <&vdd_supply>;
>
>
> strange indention here
>
>
>> +       spi-max-frequency = <1000000>;
>> +};
>>
>



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
