Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-002.synserver.de ([212.40.185.2]:1084 "EHLO
	smtp-out-002.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbbCMKpQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Mar 2015 06:45:16 -0400
Message-ID: <5502BFC0.6050706@metafoo.de>
Date: Fri, 13 Mar 2015 11:45:20 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org, quad@symbo1ics.com
Subject: Re: [PATCH] iio: si7020: Fix endianness for I2C reads
References: <1426215198-28630-1-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1426215198-28630-1-git-send-email-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/13/2015 03:53 AM, Andrey Smirnov wrote:
> Si7020 outputs most significant byte of the measurement result first
> and least significant byte last. As a result the data returned by
> i2c_smbus_read_word_data appears as big endian. Fix this by making a
> call to an approbriate byte conversion routine.

i2c_smbus_read_word_data() returns data in native endianess. But it 
interprets the word on the bus as little-endian (As specified by the SMBus 
spec). If your chip returns data in big-endian use 
i2c_smbus_read_word_data_swapped().

- Lars
