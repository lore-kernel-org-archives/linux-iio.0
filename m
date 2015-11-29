Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33317 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbK2S1K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 13:27:10 -0500
Received: by wmec201 with SMTP id c201so126821157wme.0
        for <linux-iio@vger.kernel.org>; Sun, 29 Nov 2015 10:27:08 -0800 (PST)
Subject: Re: [PATCH 5/5] iio: adc: New driver for Cirrus Logic EP93xx ADC
To: Jonathan Cameron <jic23@kernel.org>,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <56558B23.4080506@gmail.com> <5655A0A5.20908@gmail.com>
 <565B23FB.9040405@kernel.org> <565B2A91.6050409@gmail.com>
 <565B33AC.40908@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <565B437A.4030501@gmail.com>
Date: Sun, 29 Nov 2015 19:27:06 +0100
MIME-Version: 1.0
In-Reply-To: <565B33AC.40908@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

On 29/11/15 18:19, Jonathan Cameron wrote:
>> High end models (EP9307, EP9312, EP9315) have TS controller, which can operate
>> > in general purpose ADC mode. In this mode these names are just ball names on the
>> > pinout. They are all the same. There is only one issue -- I have not found any
>> > official numbering for these devices, therefore wanted to expose this naming to
>> > user space. Low end devices (EP9301, EP9302) have same hw block where TS mode is
>> > not advertised, and even though the balls/pins are still named as in TS controller,
>> > they are also referred as ADC0-ADC4 in datasheet. But there are only 5 of them,
>> > so we do not know the numbers for other 3 in the bigger devices.
>> > 
>> > If this is not the purpose of extend_name, I'll drop them.
> It's not.  We've had discussions about either exposing the datasheet names via
> sysfs or perhaps allowing arbitrary labelling but nothing has come of it yet.
> 
> Perhaps in this case clear documentation of the mapping is the way to go in 
> documentation for the driver.

Do you think something like Documentation/ABI/testing/sysfs-bus-iio-adc-ep93xx is a right
place?

Regards,
Alexander.
