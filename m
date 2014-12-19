Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailsender.cdac.in ([196.1.113.117]:46686 "EHLO
	mailsender.cdac.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaLSGIz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Dec 2014 01:08:55 -0500
Received: from mailhub2.pune.cdac.in (mailhub2.pune.cdac.in [10.208.1.6])
	by mailsender.cdac.in (8.14.2/8.14.2) with ESMTP id sBJ5rkSk028051
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2014 11:23:51 +0530
Received: from mailhub.pune.cdac.in (mailhub.pune.cdac.in [10.208.1.7])
	by mailhub2.pune.cdac.in (8.14.4/8.14.4) with ESMTP id sBJ5rkLe006093
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2014 11:23:46 +0530
Message-ID: <5493BC70.1020006@cdac.in>
Date: Fri, 19 Dec 2014 11:19:36 +0530
From: Varka Bhadram <varkab@cdac.in>
MIME-Version: 1.0
To: harald@ccbib.org
CC: linux-iio - ML <linux-iio@vger.kernel.org>
Subject: Dht11 driver problem
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,


I loaded the DHT11 driver with current linus tree on my BeagleBone black, Interfaced DHT11.

While reading the DHT11 data from sys file system, its failing.

dmesg:  gpio-30 (humidity_sensor): _gpiod_direction_output_raw: tried to set a GPIO tied to an IRQ as output

Its failing because in probe function we register gpio as irq and after that while read raw making same pin as output.

Is there any updated patches to avoid this problem..?

One more thing is that this driver is not available in IIO git tree.

Any help..?

-- 
Regards,
Varka Bhadram.


-------------------------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
-------------------------------------------------------------------------------------------------------------------------------

