Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33323 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbcDOSmx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Apr 2016 14:42:53 -0400
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Subject: Question about differential muxing
Message-ID: <5711362A.1020700@ti.com>
Date: Fri, 15 Apr 2016 13:42:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello all,

I am currently working on a driver for a part similar to the AFE4300. I
was hoping to get some information on the recommended way to handle a
mux such as the one in the AFE4300 BCM front-end (page 13 of
http://www.ti.com/lit/ds/symlink/afe4300.pdf has a good image).

The top several pins are outputs that can be routed to the OP-AMP, but
only one at a time, because of this I'm not sure if they should be
exposed as output channels, or sysfs switches.

The other issue is with the input pins, I believe the standard way to
handle this is by exposing every mux setting as a separate channel, then
only allowing one bit set in the scan mask, but for this part, when all
differential combinations are exposed we have more than 100 channels,
and the other part I'm working on makes this several times worse.

Could someone point to any information, or an existing driver, that
explains the preferred way to handle this?

Thanks,
Andrew
