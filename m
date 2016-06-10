Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54973 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbcFJFgG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2016 01:36:06 -0400
Subject: Re: [PATCH] HC-SR04 ultrasonic ranger IIO driver
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <1465238418-26095-1-git-send-email-johannes@johannesthoma.com>
 <5756E614.5010508@metafoo.de>
From: Johannes Thoma <johannes@johannesthoma.com>
Message-ID: <3fd11d4e-54c4-1589-f0ce-14554bb041c4@johannesthoma.com>
Date: Fri, 10 Jun 2016 07:35:47 +0200
MIME-Version: 1.0
In-Reply-To: <5756E614.5010508@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Am 07.06.16 um 17:19 schrieb Lars-Peter Clausen:
>
> Any new ABI needs to be documented in Documentation/ABI/...
>
I will move it there thanks for pointing that out.

> But to take one thing ahead passing the GPIO number (or a label) from
> userspace is not really a good ABI in my opinion. The GPIO numbers should
> come from the hardware description (DTS, ACPI, board file, ...)
>
I wanted to offer the possibility to configure the device at run time. 
Since it is not part of the board but a periphial device it could also 
be attached while the system is running. I would like to keep this 
interface but will add support for also configue it via device tree, as 
you suggested.
>> +	do_gettimeofday(&now);
>
> gettimeofday is not a good function if you want to measure elapsed time
> since the returned value jumps around when the system time is changed. Try
> to use one of the monotonic time sources, those are guaranteed not to jump
> around.
Thanks I didn't think about that.

Kind regards,

- Johannes
