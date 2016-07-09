Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32790 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbcGILwu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jul 2016 07:52:50 -0400
Received: by mail-qk0-f182.google.com with SMTP id p74so23426847qka.0
        for <linux-iio@vger.kernel.org>; Sat, 09 Jul 2016 04:52:50 -0700 (PDT)
MIME-Version: 1.0
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
Date: Sat, 9 Jul 2016 17:22:49 +0530
Message-ID: <CAHNg1SoX_VFcKLYTmir9=Mh-UtLjGqJ_Q3xbfyxKv+HAAQGFCg@mail.gmail.com>
Subject: How to set Current register in IIO driver from sysfs
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I am trying to add support of adjusting IR led current in vcnl4000
driver (has IR led current register for doing the same).

Below is what I have done till now:

1) Added Current channel in the vcnl4000_channels structure with
separate mask IIO_CHAN_INFO_RAW
2) Reading the LED current register inside IIO_CURRENT case in vcnl4010_read_raw
3) Writing to LED current register inside IIO_CURRENT case in vcnl4010_write_raw

Is this the correct way of setting Current register in IIO subsystem?

Best Regards,
Pratik Prajapati
