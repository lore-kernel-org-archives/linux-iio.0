Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:54414 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcDRQlr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 12:41:47 -0400
Subject: Re: Driver directory selection for Power Supply Status chip
To: tthayer@opensource.altera.com, linux-iio@vger.kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	Guenter Roeck <linux@roeck-us.net>
References: <571507DE.3080408@opensource.altera.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <57150E47.4020503@metafoo.de>
Date: Mon, 18 Apr 2016 18:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <571507DE.3080408@opensource.altera.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/18/2016 06:14 PM, Thor Thayer wrote:
> Hi,
> 
> The Arria10 System Resource chip (A10SR) is a SPI based MFD implementing a
> GPIO expander, reset controller, and power supply monitoring. I'm not sure
> where the driver for the A10SR power monitoring driver should reside and I'm
> hoping someone can offer some advice.
> 
> I'd originally submitted the RFC to the HWMON list but the maintainer
> pointed out that it wasn't a good fit because the A10SR only indicates
> boolean power supply status - not the voltage level as required by HWMON.
> 
> I read that IIO acts as a bridge between IO and HWMON but I'm also not sure
> this fits those drivers (although I did find some power supply supervistors
> there). It isn't quite a power supply supervisor - the A10SR is a comparator
> instead of an Analog-to-Digital Converter.
> 
> One additional thing, the A10SR also had a number of enable bits for
> enabling devices external to Altera's SoC (but still on the development
> board). These don't quite fit into the reset controller framework but would
> seem to fit a MISC directory driver better.
> 
> If neither IIO or MISC is a good fit, can someone suggest a more appropriate
> place?

How does the device work, does it generate an interrupt when the voltage
level goes below the threshold? I'd like to pass the ball back and say that
this sounds like something that should go into hwmon.
