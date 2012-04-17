Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63740 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab2DQUvz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 Apr 2012 16:51:55 -0400
Received: by vbbff1 with SMTP id ff1so4502632vbb.19
        for <linux-iio@vger.kernel.org>; Tue, 17 Apr 2012 13:51:54 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Apr 2012 22:51:53 +0200
Message-ID: <CAAfyv35jTq6eSM4gEarUiZQRQy0pOBKev-LzohvQe40k2TuXMQ@mail.gmail.com>
Subject: adding hmc5883 driver
From: Marek Belisko <marek.belisko@open-nandra.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm owner gta04 board which have hmc5883 compass.
I'm currently using hmc5843 iio staging driver with some hacks
(difference is only
for range and rate values) which is working fine. I would like ask for
opinion how to properly
add new device.

IMO options are:
1. add hmc5883 to DEVICE_TABLE with some flags and then use proper values for
one or another device (possibly rename driver to hmc58x3)

2. separate common functions from existing driver and use custom setup
for hmc5843
and hmc5883.

Is there another way which I overlooked?

Thanks,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
