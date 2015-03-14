Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34120 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbCNTso (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 15:48:44 -0400
MIME-Version: 1.0
In-Reply-To: <5502BFC0.6050706@metafoo.de>
References: <1426215198-28630-1-git-send-email-andrew.smirnov@gmail.com>
	<5502BFC0.6050706@metafoo.de>
Date: Sat, 14 Mar 2015 12:48:43 -0700
Message-ID: <CAHQ1cqH92D7y9n0xvsW5yLt9NaCMLE4H_f6JbNvXavyX_tYk3g@mail.gmail.com>
Subject: Re: [PATCH] iio: si7020: Fix endianness for I2C reads
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robert Smith <quad@symbo1ics.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>
> i2c_smbus_read_word_data() returns data in native endianess. But it
> interprets the word on the bus as little-endian (As specified by the SMBus
> spec). If your chip returns data in big-endian use
> i2c_smbus_read_word_data_swapped().
>
> - Lars

Ah, good to know. I'll update the patch accordingly.

Thanks
