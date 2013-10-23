Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-048.synserver.de ([212.40.185.48]:1144 "EHLO
	smtp-out-024.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750936Ab3JWPN2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2013 11:13:28 -0400
Message-ID: <5267E795.7030804@metafoo.de>
Date: Wed, 23 Oct 2013 17:13:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: Add new driver dht11-gpio
References: <E1VYf74-0000gd-5Z@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222030570.23009@pmeerw.net> <E1VYiDp-0000pb-1i@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222210230.23009@pmeerw.net> <E1VYjUo-0000uN-OY@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1VYjUo-0000uN-OY@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/22/2013 11:28 PM, Harald Geyer wrote:
> Replying to both of your mails in one message here:
> 
>>>> +config DHT11_GPIO
>>>> +   tristate "DHT11 (and compatible sensors) driver"
>>>> +   help
>>>> +     This driver supports reading data via a single interrupts
>>
>> should probably depend on GENERIC_GPIO?
> 
> After thinking about this a bit, I believe a dependency on
> OF_GPIO is necessary. Maybe also add an explicit dependency
> on GPIOLIB?

The of_gpio calls are stubbed out if OF_GPIO is not selected. So there is no
need to add the dependency and not having the dependency makes compile
testing easier on platforms which e.g. do not support OF. But the
GENERIC_GPIO symbol got removed recently, since everybody is using GPIOLIB
these days. So that's the right symbol to depend on.

- Lars
