Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from email.invensense.com ([12.199.206.106]:40106 "EHLO
	email.invensense.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbaCYWBR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Mar 2014 18:01:17 -0400
From: Ge Gao <GGao@invensense.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: unreliable time function inside IRQ?
Date: Tue, 25 Mar 2014 21:56:08 +0000
Message-ID: <E7747D604FBC9F43A71AA431AFF447622577643E@IUSEXCH01.invcorp.invensense.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear all,
	Had to bring this question again to see whether anyone see the same problem. IIO fetches the timestamp inside IRQ using iio_get_time_ns(), which in turn call ktime_get_real_ts(&ts). However, I notice that the clock taken during interrupt is not always reliable. Sometimes the clock does not update. It is updated after one or more interrupts. It is very easy to reproduce. First find a hardware generating fixed interval of interrupts and using IIO driver to run it. Print out the timestamp. You could find that the timestamp distance is not always correct. For example, if you run a 5 Hz interrupt, most of time you will interrupt timestamp interval is around 200ms. However, sometimes, you could see interval sequence like ...200, 192, 208, 200, 200, 182, 218, 200.......
I searched online and only found one result, which is exactly the same as I observed. Below is the link:
http://stackoverflow.com/questions/17080516/unable-unreliable-to-use-clock-gettime-in-hard-irq-context
But no one answer the question.
	Is there anyone see the same problem? Thanks.

Best Regards,

Ge GAO

