Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:43045 "HELO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756638Ab2D3UMI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2012 16:12:08 -0400
Received: by wgbdr13 with SMTP id dr13so867824wgb.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Apr 2012 13:12:06 -0700 (PDT)
From: Ge Gao <ggao@invensense.com>
MIME-Version: 1.0
Date: Mon, 30 Apr 2012 13:03:46 -0700
Message-ID: <abd67b68b54fc6c88b83c91a200ace5e@mail.gmail.com>
Subject: different data rate in IIO ?
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear all,
I am currently developing a driver for a chip that has gyro,
accelerometer and compass sensor together and these sensor data could come
at different rate. There could be more data coming from this chip because
this chip has on-chip CPU to do some data processing. The IIO subsystem is
in some sense "fixed" once "enable" is 1. "Fixed" means the element and
sequence inside ring buffer is fixed. For example, if MPU9150,
which is a 9-axis chip, containing gyro, accelerometer and compass, is
developed, the
ring buffer would have byte_per_datum of 32 bytes(6 + 6 + 6  = 18; 18
rounding up to 24; and 24 plus timestamp) if all sensors and all axis are
enabled . So every data packet should contain this amount of data no
matter what. If I have gyro running at 200 HZ, accelerometer running at
100Hz and compass running at 50 Hz, this will have problems. Because I
can't provide accelerometer data and compass data for each packet. Some
packets could miss data. I have to fake data for these packets, either by
repeating or other non-standard ways.  Is this supposed to be? Because we
could have other data item which is even slower(10HZ quaternion data, for
example). This way, it will be more trouble. Because each data element has
different rate, while IIO needs them at the same rate.
                The best way is to have a header for each packet to
indicate what packet it is. But this way seems to violate the design goal
of IIO.  That would be more like input subsystem because input subsystem
uses different code type to distinguish different type of data thus
allowing different data type mixed together. If such driver is written,
all files under "scan_element" would be meaningless and useless.
	I got some suggestions about using multiple IIO devices in one
driver because one IIO device can only has one ring buffer. It could be OK
to handle this. However, since IIO device allocation is to allocate the
private data directly along with IIO device, it seems one IIO driver can
only have one IIO device. Could IIO kernel accept such practice that one
IIO
driver has more than one IIO device? Or could there be some changes in
the IIO code such that such scenario is taken care of in the future?
Thanks.

Ge
