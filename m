Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:17927 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbK0PIY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2015 10:08:24 -0500
Date: Fri, 27 Nov 2015 16:08:23 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <linux-iio@vger.kernel.org>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: directions to write a new adc driver
Message-ID: <20151127150823.GB11016@odux.rfo.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I want to add support for the ADC device of the SAMA5D2 SoC. I may
write a new driver because they are some changes about the register
contents. Moreover, the new device doesn't fit the dt bindings (which are
not very good since there is configuration stuff which is not
relating to the SoC or to the board).

My main concern is how to adress the configuration of my ADC, some
examples:
- choosing the resolution (some resolutions will impact the sampling
  time)
- enabling the sleep mode or not
- using offset correction
- signed or unsigned conversions
- etc.

Having a look to other adc drivers, it seems resolution only depends on the
SoC.
Is there a generic solution? If not, can I create the files I need for my
device in sysfs?

Which adc driver would be the best to take as a reference?

If you have some interesting discussions, I am interested too. I have
browsed the iio mainling list up to september but I have not found
answers.

Thanks for you help

Regards

Ludovic
