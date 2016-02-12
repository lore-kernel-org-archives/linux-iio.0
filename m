Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30856 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbcBLKFN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 12 Feb 2016 05:05:13 -0500
Message-ID: <56BDAE57.4010900@parrot.com>
Date: Fri, 12 Feb 2016 11:05:11 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
Subject: read_raw when buffered sampling enabled
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Greetings,

I see in several iio drivers supporting triggered buffer mode that read_raw
returns -EBUSY when buffered sampling is enabled. This additional logic
is implemented in read_raw using iio_buffer_enabled().
Since some drivers don't implement this I'm wondering wether this logic is
an IIO design requirement or if this is device / driver specific.

Regards,
Grégor.
