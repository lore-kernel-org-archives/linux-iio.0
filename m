Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:50024 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbcBCLAx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Feb 2016 06:00:53 -0500
Message-ID: <56B1DCA4.9050903@parrot.com>
Date: Wed, 3 Feb 2016 11:55:32 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
Subject: using monotonic clok for timstamping
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear  all,

Our application relies on precise and monotonic timestamping of IMU 
samples (and other sensors).
I am wondering what reasons / use cases led to the choice of realtime 
clock to implement
iio_get_time_ns (not to mention time gaps that may be seen after wake up 
from sleep states).

As a dirty hack, I simply rewrote iio_get_time_ns on our platform. But I 
suspect it would be usefull as
a long term solution, to give userland the ability to choose a 
particular posix clock (realtime, monotonic,
etc...) on a per device and / or driver basis through a sysfs attribute 
for example.

I'd be glad to hear your suggestions. Best regards,
Grégor.
