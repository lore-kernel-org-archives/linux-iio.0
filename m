Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:12884 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932196AbcDNP0r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 14 Apr 2016 11:26:47 -0400
Message-ID: <570FB712.5070903@parrot.com>
Date: Thu, 14 Apr 2016 17:28:18 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: generic_buffer and 24 bits samples
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Greetings,

I'm trying to use an st_pressure based sensor to sample pressure
data using generic_buffer tool. However it seems that it does not
support data packed onto 24 bits samples.
st_pressure driver defines scan_type for my device as:
<code>
/* ... */
     .scan_type = {
         .sign = 'u',
         .realbits = 24,
         .storagebits = 24,
         .endianness = IIO_LE,
     },
</code>

What is the proper way to make this work ? Using 32 bits storagebits
field ? Enhance generic_buffer to support 24 bits samples ? Anything
else ??

It seems iio_compute_scan_bytes consider sample data as a simple byte
stream. So I'm wondering what are the alignment constraints for sample
start address ? Should they be aligned onto their natural "word"
boundaries, i.e. 16 bits for u16, 32 bits for u32, etc... ? And for
24 bits samples ?

Regards.
Grégor
