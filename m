Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:54522 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbbASUbJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jan 2015 15:31:09 -0500
Received: by mail-lb0-f171.google.com with SMTP id w7so30136053lbi.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2015 12:31:07 -0800 (PST)
Message-ID: <54BD6977.4050906@gmail.com>
Date: Mon, 19 Jan 2015 22:30:47 +0200
From: =?windows-1252?Q?Kristina_Mart=9Aenko?=
	<kristina.martsenko@gmail.com>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	devel@driverdev.osuosl.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Juergen Beisert <jbe@pengutronix.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/4] iio: mxs-lradc: fix interactions between the touchscreen
 and the ADC
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <496109820.289562.1421580077115.JavaMail.open-xchange@oxbaltgw03.schlund.de>
In-Reply-To: <496109820.289562.1421580077115.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/01/15 13:21, Stefan Wahren wrote:
> Hi Kristina,

Hi Stefan!

>> Kristina Martšenko <kristina.martsenko@gmail.com> hat am 17. Januar 2015 um
>> 01:22 geschrieben:
>> These patches fix some issues with using the touchscreen and reading
>> other ADC channels at the same time.
>>
>> The main issue is that the "virtual" channels the touchscreen uses can
>> overlap with the channels that the iio buffer is configured to read,
>> causing the touchscreen to read those channels instead, and report wrong
>> values. Patch #1 fixes that by separating the channels they use.
>>
>> Patches #2 and #3 stop buffered mode and sysfs reads from disabling the
>> touchscreen. Patch #4 keeps the buffer from reporting wrong values when
>> the touchscreen is in use.
>>
>> Note that I've only tested these patches on i.MX28. I checked the i.MX23
>> reference manual [1], and there don't seem to be any differences in the
>> parts I changed, but it would still be nice if someone could test on
>> i.MX23 as well.
> 
> i have a iMX233-Olinuxino-MAXI, but no touchscreen. If it does make sense
> to you, could you please send me testing instructions and i'll give it a try?

Thanks a lot for offering! Unfortunately in this case all testing
involves using the touchscreen while reading other ADC channels, so
without a touchscreen there isn't much to test, sorry :(

Kristina
