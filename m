Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37091 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbLLIgm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 03:36:42 -0500
Received: by wmnn186 with SMTP id n186so60662296wmn.0
        for <linux-iio@vger.kernel.org>; Sat, 12 Dec 2015 00:36:41 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 12 Dec 2015 16:36:41 +0800
Message-ID: <CAAn_ec90t=N1e1m8aUcBZRb5wsRwiz56WUzFCWqTrVHHhcAuBA@mail.gmail.com>
Subject: read /dev/iio:device0 return -1 (Invalid argument)
From: Julio Cruz <jcsistemas2001@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I get an error trying to read /dev/iio:device0 in a custom application
(C/C++), however in a terminal the command "cat /dev/iio_device0"
return data.

Below the procedure:

- enable channels
- setup trigger
- setup buffer lenght
- enable buffer (the SPI interrupt is setup properly and all the
trigger handler are done)
- read /dev/iio_device0

It's a SPI device acquiring 27 bytes @ 1KHz.

Results:

1. Custom application (based on generic_buffer.c): function 'read'
return -1 and strerror(errno) return "Invalid argument"
2. iio_readdev (libiio): show the message "Unable to refill buffer:
Input/output error"
3. In terminal, the command "cat /dev/iio_device0" show values (no
readable) while the buffer is enable.

Any suggestion?

Thanks for your help!
