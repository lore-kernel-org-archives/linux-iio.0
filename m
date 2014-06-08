Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.cosmopool.net ([178.63.74.76]:34538 "EHLO
	mail.cosmopool.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbaFHXCQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jun 2014 19:02:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.cosmopool.net (Postfix) with ESMTP id 30FCF6D8252
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2014 00:53:59 +0200 (CEST)
Received: from mail.cosmopool.net ([127.0.0.1])
	by localhost (mail.cosmopool.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8d7mHKFEqpeK for <linux-iio@vger.kernel.org>;
	Mon,  9 Jun 2014 00:53:58 +0200 (CEST)
Received: from stardust.g4.wien.funkfeuer.at (46.57.15.238.wireless.dyn.drei.com [46.57.15.238])
	by mail.cosmopool.net (Postfix) with ESMTPSA id 4F65E6D8005
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2014 00:53:58 +0200 (CEST)
Received: from lambda (helo=stardust.g4.wien.funkfeuer.at)
	by stardust.g4.wien.funkfeuer.at with local-esmtp (Exim 4.80)
	(envelope-from <harald@ccbib.org>)
	id 1WtlyB-00012Z-I6
	for linux-iio@vger.kernel.org; Mon, 09 Jun 2014 00:53:43 +0200
From: Harald Geyer <harald@ccbib.org>
To: linux-iio@vger.kernel.org
Subject: iio: dht11 HW issues
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 09 Jun 2014 00:53:43 +0200
Message-Id: <E1WtlyB-00012Z-I6@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

a few month ago I submitted a driver vor DHT11 and DHT22 humidity
sensors.

Alas at least DHT22 seems to have hardware issues: After a few days
of operation (reading the sensor once per minute) the sensor seems
to stop responding entirely and the only way to fix this is to power
cycle the sensor. 

I have tried 3.3 V and 5 V supply and have observed this on at least
two pieces of hardware, so I'm pretty confident the issue is real.
The obvious solution is to use an additional gpio line to control
power for the sensor. Now I'm torn whether to handle this in kernel
space or user space: Since software using the sysfs ABI doesn't even
know (and shouldn't need to know) that the humidity values come from
a DHT22, this clearly should be handled be the kernel driver.

OTOH there probably is an infinite number of algorithms (and HW
configurations) people might want to use to control power and coming
up with an ABI that allows implementing any of them, will be a
challange. Any guidance is appreciated.

TIA,
Harald
