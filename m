Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw1-f49.google.com ([209.85.161.49]:35554 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeJJRQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Oct 2018 13:16:40 -0400
Received: by mail-yw1-f49.google.com with SMTP id y76-v6so1922484ywd.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Oct 2018 02:55:17 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?7LWc6rSR7Zi4?= <cgh9046@gmail.com>
Date: Wed, 10 Oct 2018 02:55:05 -0700
Message-ID: <CABqjdMW+PNniq1PxZ+qW8YJDeVK43BnNcC2gCuU1s=Df1Xuzfg@mail.gmail.com>
Subject: Declaring a SPI slave device
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi I am Gwangho Choi,

I am trying to connect my EVAL-AD5791 board with a raspberry pi 3 b+
using iio. I enabled SPI from raspi-config. And I made an ad5791
module from a kernel and loaded. Now, I can see ad5791 and industialio
module running from "lsmod" command. And I can also see the
/sys/bus/iio/ directory.So, I connected my board with my raspberry pi,
but in the /sys/bus/iio/devices there is nothing. I suspect that I did
not declare a slave device, but I do not know how I can do it. I do
not know where I should put the spi_board_info code. I cannot find
arch/.../mach-*/board-*.c files.

Thanks
