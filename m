Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:42551 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbeCURq5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Mar 2018 13:46:57 -0400
Received: by mail-qk0-f176.google.com with SMTP id b198so6336340qkg.9
        for <linux-iio@vger.kernel.org>; Wed, 21 Mar 2018 10:46:56 -0700 (PDT)
Received: from [192.168.128.126] (modemcable134.147-37-24.static.videotron.ca. [24.37.147.134])
        by smtp.gmail.com with ESMTPSA id e3sm3622862qkm.51.2018.03.21.10.46.53
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 10:46:54 -0700 (PDT)
To: linux-iio@vger.kernel.org
From: Anthony Legault Cesta <anthony@alcmedia.com>
Subject: Controlling ADC SPI devices
Message-ID: <58bf1805-774a-5b88-75cd-024199308491@alcmedia.com>
Date: Wed, 21 Mar 2018 13:46:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

my name's Anthony & I need some help with the following:

Reading ADC values from mcp3208 on the spi bus within my custom made 
kernel module.

I'm able to read spi values thru /sys/bus/iio/devices/iio:device0 no 
problems but I need access it from within my drivers.

I've tried using dev_to_iio_dev(dev) but can't seem to claim the *dev 
allocated for the spi device.

How can I get a ref * to the device?

How can I tackle this using iio method?

Thanks i advanced!


Anthony



