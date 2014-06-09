Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1041 "EHLO
	smtp-out-136.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864AbaFIL5r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jun 2014 07:57:47 -0400
Message-ID: <5395A138.2030708@metafoo.de>
Date: Mon, 09 Jun 2014 13:57:44 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: linux-iio@vger.kernel.org
Subject: Re: iio: dht11 HW issues
References: <E1WtlyB-00012Z-I6@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1WtlyB-00012Z-I6@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/09/2014 12:53 AM, Harald Geyer wrote:
> Hi,
>
> a few month ago I submitted a driver vor DHT11 and DHT22 humidity
> sensors.
>
> Alas at least DHT22 seems to have hardware issues: After a few days
> of operation (reading the sensor once per minute) the sensor seems
> to stop responding entirely and the only way to fix this is to power
> cycle the sensor.
>
> I have tried 3.3 V and 5 V supply and have observed this on at least
> two pieces of hardware, so I'm pretty confident the issue is real.
> The obvious solution is to use an additional gpio line to control
> power for the sensor. Now I'm torn whether to handle this in kernel
> space or user space: Since software using the sysfs ABI doesn't even
> know (and shouldn't need to know) that the humidity values come from
> a DHT22, this clearly should be handled be the kernel driver.
>
> OTOH there probably is an infinite number of algorithms (and HW
> configurations) people might want to use to control power and coming
> up with an ABI that allows implementing any of them, will be a
> challange. Any guidance is appreciated.
>

Yes, this sounds like an issue that should be handled transparently in the 
kernel if possible. If you can detect that the sensor does not respond I'd 
say add code to the kernel driver to issue a reset if that happens.

- Lars
