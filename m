Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53927 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab1D3Hdu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2011 03:33:50 -0400
Received: by yia27 with SMTP id 27so1521097yia.19
        for <linux-iio@vger.kernel.org>; Sat, 30 Apr 2011 00:33:50 -0700 (PDT)
MIME-Version: 1.0
From: Prashant Shah <pshah.mumbai@gmail.com>
Date: Sat, 30 Apr 2011 13:03:30 +0530
Message-ID: <BANLkTikjnjSRtDRBHjXeMfHAOEsVzkkwag@mail.gmail.com>
Subject: drivers for usb daq card
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I am total newbie and this is my first device drivers. I am trying to
write drivers for National Instruments USB 6008 USB based data
acquisition card.

I was initially trying to do that with the comedi based system but I
was suggest to try working with the IIO sub system. I was reading
through the IIO docs and IIO seems to be more targeted to SPI and I2C
systems. I am not sure about how good is the support for USB based
systems. I am newbie so I dont want to do something that will be hard
for me to work with :)

Also, we already have user space applications that interface with
comedi like scilab and xoscope, etc. Will these applications that use
the comedi based interface work with IIO ?

Regards.
