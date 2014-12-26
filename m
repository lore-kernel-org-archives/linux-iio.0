Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44943 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaLZLz6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 06:55:58 -0500
Message-ID: <549D4CCC.5080503@kernel.org>
Date: Fri, 26 Dec 2014 11:55:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ti-adc128s052: Add DT binding documentation
References: <1418839183-27819-1-git-send-email-angelo.compagnucci@gmail.com> <5492FE42.70009@metafoo.de> <CA+TH9VkQ_yprkV_2PCc57jMoW-=vFr6nXfBAUyy1jLtQetKibw@mail.gmail.com>
In-Reply-To: <CA+TH9VkQ_yprkV_2PCc57jMoW-=vFr6nXfBAUyy1jLtQetKibw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/12/14 16:42, Angelo Compagnucci wrote:
> Hi Lars-Peter,
> 
> 2014-12-18 17:18 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 12/17/2014 06:59 PM, Angelo Compagnucci wrote:
>>>
>>> Adding binding documentation for Texas Instruments' ADC128S052 ADC chip.
>>>
>>> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>>
>>
>> Looks good to me, but you might want to send this to the devicetree list and
>> the devicetree bindings maintainers.
> 
> Ouch! Resending to the right ml, thank you for your support!
Do keep linux-iio in the loop as well as it'll probably go
through my tree ultimately and I don't read the device-tree list
directly :)  Nature of these patches is that they want to go
to the maintainers, reviewers and lists for both iio and devicetree.

Jonathan
> 
>>
>> [...]
>>>
>>> +Example:
>>> +adc@0 {
>>> +       compatible = "ti,adc128s052";
>>> +       reg = <0>;
>>> +        vref-supply = <&vdd_supply>;
>>
>>
>> strange indention here
>>
>>
>>> +       spi-max-frequency = <1000000>;
>>> +};
>>>
>>
> 
> 
> 

