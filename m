Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-030.synserver.de ([212.40.185.30]:1099 "EHLO
	smtp-out-030.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbbE2QOe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2015 12:14:34 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/3] iio: Hardware buffer improvements
Date: Fri, 29 May 2015 18:14:19 +0200
Message-Id: <1432916062-15195-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This series has a few small improvements for hardware buffer support.

The first patch makes sure that we always compute the masklength for the
scanmask, even if the driver does not register a userspace accessable
buffer. This makes it possible to support cases where the data of the
device can not be accessed by software but is directly passed to a
different device which can then register a in kernel consumer to control
the buffer of the device.

The second patch adds support for specifying the supported buffer modes for
each buffer type. This makes sure that the correct mode is chosen when a
device driver support multiple types, e.g. both software and hardware
buffers and also makes sure that we can attach buffers which are not
supported by the device (e.g. callback buffer to sca3000).

The last patch makes sure that when running in hardware mode the scan mask
matching is strict since there is no software demuxer in that case.

- Lars

Lars-Peter Clausen (3):
  iio: Always compute masklength
  iio: Specify supported modes for buffers
  iio: Require strict scan mask matching in hardware mode

 drivers/iio/buffer_cb.c                  |  2 ++
 drivers/iio/industrialio-buffer.c        | 58 ++++++++++++++++++++++++--------
 drivers/iio/kfifo_buf.c                  |  2 ++
 drivers/staging/iio/accel/sca3000_ring.c |  2 ++
 include/linux/iio/buffer.h               |  3 ++
 5 files changed, 53 insertions(+), 14 deletions(-)

-- 
2.1.4

