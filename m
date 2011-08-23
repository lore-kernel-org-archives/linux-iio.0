Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [203.199.255.40] ([203.199.255.40]:40295 "EHLO
	etraining-ejeevika.tenet.res.in" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752587Ab1HWIbt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2011 04:31:49 -0400
Received: from respark.iitm.ac.in ([10.65.0.51])
	by etraining-ejeevika.tenet.res.in (8.13.8/8.13.8) with ESMTP id p7N8WV1w005987
	for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2011 14:02:31 +0530
Received: from tcoe.iitm.ac.in (localhost.localdomain [127.0.0.1])
	by respark.iitm.ac.in (8.13.1/8.13.1) with ESMTP id p7N8IOnu028875
	for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2011 13:48:29 +0530
From: "malas" <malas@tcoe.iitm.ac.in>
To: linux-iio@vger.kernel.org
Subject: ad7793 iio-ring test read issue - Reg
Date: Tue, 23 Aug 2011 13:48:24 +0530
Message-Id: <20110823080829.M36921@tcoe.iitm.ac.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Dear Michael Hennerich,


I shall post iio quesris in this mail list as per your suggestions.

AD7793 driver is built into kernel. The chip gets configured and am able to read data on
continuous mode via spi interface using ad7793 driver at kernel level.

While testing userspace test iio-ring to read data from ring buffer, generic_buffer code
was executed, it  proceeds till opening /sys/bus/iio/devices/device0:buffer0 and
Read call fails.

In fs I can list the iio device ad7793 with following properties get/set.

root:/> ls /sys/bus/iio/devices/device0\:buffer0/
bytes_per_datum  enable           power            subsystem
dev              length           scan_elements    uevent
root:/>

I find access0 and event0 missing in this list. Is that the reason for read() fails.

Please help.

Thanks
Mala
--
Open WebMail Project (http://openwebmail.org)



