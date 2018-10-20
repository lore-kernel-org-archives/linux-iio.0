Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vs1-f51.google.com ([209.85.217.51]:39030 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeJTK6H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Oct 2018 06:58:07 -0400
Received: by mail-vs1-f51.google.com with SMTP id m5so26454442vsk.6
        for <linux-iio@vger.kernel.org>; Fri, 19 Oct 2018 19:49:18 -0700 (PDT)
MIME-Version: 1.0
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Fri, 19 Oct 2018 23:49:06 -0300
Message-ID: <CAHd-oW7fA_1H3jnUTOhs7VXJ3Zciq6j2WthAytE39NedYpTibg@mail.gmail.com>
Subject: Work plan on ad2s90
To: linux-iio@vger.kernel.org
Cc: kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello everyone.

I'm looking at the code and datasheet of ad2s90, trying to understand
what is needed to move it to the main tree. I and my study group
intend to work on it.

I do not understand all the necessary steps yet, but I will present
here some brief items for discussion. I'd like to ask if I'm on the
right track. All feedback will be much appreciated.

Some of the things that I think need to be done:
- The IIO_CHAN_INFO_SCALE information mask is not set yet
- The read_raw function does not return the error code returned by
spi_read on failure
- There is no channel for velocity yet
- There are two minor codestyle corrections to be made
- Maybe it's possible to change the bit operations at the read_raw for
a bitops.h function call

Best regards,
Matheus
