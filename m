Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:49351 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbbA0OTl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jan 2015 09:19:41 -0500
Received: by mail-lb0-f175.google.com with SMTP id 10so13310668lbg.6
        for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2015 06:19:39 -0800 (PST)
Message-ID: <54C79E65.6030706@gmail.com>
Date: Tue, 27 Jan 2015 16:19:17 +0200
From: =?UTF-8?B?S3Jpc3RpbmEgTWFydMWhZW5rbw==?=
	<kristina.martsenko@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Marek Vasut <marex@denx.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Juergen Beisert <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 0/4] iio: mxs-lradc: fix interactions between the touchscreen
 and the ADC
References: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com> <201501251947.17832.marex@denx.de> <54C6AB2B.9040709@kernel.org>
In-Reply-To: <54C6AB2B.9040709@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/15 23:01, Jonathan Cameron wrote:
> On 25/01/15 18:47, Marek Vasut wrote:
>> On Sunday, January 25, 2015 at 05:28:18 PM, Kristina Martšenko wrote:
>>> These patches fix some issues with using the touchscreen and reading
>>> other ADC channels at the same time.
>>
>> Entire series
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks again!

> All 4 applied to the fixes-togreg branch of iio.git and cc'd to
> stable.

Thanks, Jonathan! I'm not entirely sure if these are critical enough to
go in stable, but alright.

Kristina
