Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:41528 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741Ab3GUPYi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jul 2013 11:24:38 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so3260983eek.23
        for <linux-iio@vger.kernel.org>; Sun, 21 Jul 2013 08:24:37 -0700 (PDT)
Received: from gmail.com (cpc3-seac14-0-0-cust157.7-2.cable.virginmedia.com. [81.97.204.158])
        by mx.google.com with ESMTPSA id b7sm43568265eef.16.2013.07.21.08.24.35
        for <linux-iio@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 08:24:36 -0700 (PDT)
Date: Sun, 21 Jul 2013 16:24:32 +0100
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: linux-iio@vger.kernel.org
Subject: Cant read more than 2 bytes from triggered buffer 3.10
Message-ID: <20130721152431.GA22495@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I am running kernel version with the tag 3.10.

I am trying to read data from a triggered buffer I created for the ti-adc
driver. Just wanted to read a counter back using generic_buffer.c
and sysfs triggers.

But for some reason, I can only read 2 samples using generic_buffer.c

I tried a dozen printfs and lots of hours.
indio_dev->scan_bytes seems fixed at 8 or 4.
indio_dev->masklength is similar 8 or 4.

I use generic_buffer -n TI-am335x-adc -t sysfstrig1 -l 1024.

but only one sample output or two.

I enabled the simple dummy buffer and tried triggering it too.
Only 1 sample..
no matter the buffer length.

Have spent a couple of hours messing over this. But I can't get my counter output from the driver.

If anyone wants to see the modified am335x adc driver

pastebin(.)com/1Zrw3KTt

Hope somebody can point out whats wrong..

Thanks
Zubair Lutfullah
