Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bon0080.outbound.protection.outlook.com ([157.56.111.80]:30913
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752168AbcDRQYu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Apr 2016 12:24:50 -0400
Reply-To: <tthayer@opensource.altera.com>
To: <linux-iio@vger.kernel.org>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>
From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Driver directory selection for Power Supply Status chip
Message-ID: <571507DE.3080408@opensource.altera.com>
Date: Mon, 18 Apr 2016 11:14:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

The Arria10 System Resource chip (A10SR) is a SPI based MFD implementing 
a GPIO expander, reset controller, and power supply monitoring. I'm not 
sure where the driver for the A10SR power monitoring driver should 
reside and I'm hoping someone can offer some advice.

I'd originally submitted the RFC to the HWMON list but the maintainer 
pointed out that it wasn't a good fit because the A10SR only indicates 
boolean power supply status - not the voltage level as required by HWMON.

I read that IIO acts as a bridge between IO and HWMON but I'm also not 
sure this fits those drivers (although I did find some power supply 
supervistors there). It isn't quite a power supply supervisor - the 
A10SR is a comparator instead of an Analog-to-Digital Converter.

One additional thing, the A10SR also had a number of enable bits for 
enabling devices external to Altera's SoC (but still on the development 
board). These don't quite fit into the reset controller framework but 
would seem to fit a MISC directory driver better.

If neither IIO or MISC is a good fit, can someone suggest a more 
appropriate place?

Thank you for your help,

Thor
