Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from grace.univie.ac.at ([131.130.3.115]:44275 "EHLO
	grace.univie.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcDRO0F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 10:26:05 -0400
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.87)
	(envelope-from <axel.kittenberger@univie.ac.at>)
	id 1asA7l-0003f7-9j
	for linux-iio@vger.kernel.org; Mon, 18 Apr 2016 16:26:01 +0200
Received: from webmail2016.univie.ac.at ([2001:62a:4:1::80:48] helo=webmail2016.univie.ac.at)
	by joan.univie.ac.at with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.87)
	(envelope-from <axel.kittenberger@univie.ac.at>)
	id 1asA7l-0003Ow-3l
	for linux-iio@vger.kernel.org; Mon, 18 Apr 2016 16:26:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 18 Apr 2016 16:26:00 +0200
From: Axel Kittenberger <axel.kittenberger@univie.ac.at>
To: linux-iio@vger.kernel.org
Subject: hid-sensor-hub as pci device 9d35?
Message-ID: <8b8d1025678dbe2d9e3919a31d2319f0@webmail2016.univie.ac.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

hello,

I got a new Lenovo Yoga 460 convertible here and I'd like to get the 
accelerometer going under Linux.

In lspci I see
"""00:13.0 Non-VGA unclassified device: Intel Corporation Device 9d35 
(rev 21)"""
Which I'm pretty sure is the sensor hub hanging directly on the pci bus 
and lsusb shows nothing that would qualify.

'hid-sensor-hub.c' only contains code for usb. Would it even work for 
the pci thing?

Any idea how I can proceed from here?

kind regards,
axel
