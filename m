Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35339 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdFIJaB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jun 2017 05:30:01 -0400
Received: by mail-pg0-f52.google.com with SMTP id k71so24909630pgd.2
        for <linux-iio@vger.kernel.org>; Fri, 09 Jun 2017 02:30:01 -0700 (PDT)
MIME-Version: 1.0
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Fri, 9 Jun 2017 11:30:00 +0200
Message-ID: <CAA2SeNJKoERD=ejx8ip=4fhdjB7AY8-9KZyndnnFyvcfU0TohQ@mail.gmail.com>
Subject: spi 3wire support for ST MEMs sensors
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

I started working on supporting spi-3wire mode in some STM MEMs
drivers and I am facing a tricky issue. Let's consider the driver for
LSM303AGR accel device
(http://www.st.com/resource/en/datasheet/lsm303agr.pdf). The sensor is
configured by default in spi 4 wire mode (BIT 0 in register 0x23) but
the package does not export the MISO line for accelerometer. The only
way to support spi is to enable 3-wire at bootstrap. I am wondering
how to figure out the correct register address since it is not
possible to read the device whoami. The only way that come up to my
mind is to add a lookup table in st_accel_spi.c based on
spi_device_id. Is there something better? Or should I just remove the
spi support for LSM303AGR? Thanks

Regards,
Lorenzo

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
