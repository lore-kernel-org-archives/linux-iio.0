Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34580 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbbHFJka (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 05:40:30 -0400
Received: by ykax123 with SMTP id x123so57988860yka.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2015 02:40:30 -0700 (PDT)
MIME-Version: 1.0
From: Crt Mori <cmo@melexis.com>
Date: Thu, 6 Aug 2015 11:39:50 +0200
Message-ID: <CAKv63uuEs4qVzKyAfRRX6ruxYD65L_UaYTTHnZpfc_rRvaX=tg@mail.gmail.com>
Subject: Spliting u16, u32 to u8 array
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,
I am sure at least some of you were faced to split a u16 or u32 value
in u8 array without being affected by host endianness. My search
turned empty for a standardized function for this task, but this seems
quite improbable. My task is to send 16 bit LE data through i2c.

I am looking for something like:
static void u16_to_u8_array(u16 value, u8 *array)
{
        *array = cpu_to_le16(value) >> 8;
        *(++array) = (u8) cpu_to_le16(value);
}

Best regards,
Crt
