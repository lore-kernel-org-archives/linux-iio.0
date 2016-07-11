Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33637 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030859AbcGKPYW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2016 11:24:22 -0400
Date: Mon, 11 Jul 2016 08:24:12 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: tiberiu.a.breana@intel.com, mranostay@gmail.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: complete the setup of buffer timestamps
Message-ID: <cover.1468203399.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These drivers are using iio_poll_func->timestamp in their triggered buffer
handler as the timestamp pushed to buffer.  Problem is that it was not set up
at probe time via iio_triggered_buffer_setup(), so timestamp is always 0.

Buffer space has been allocated for the timestamp, so it seems to be
wanted.  

These patches make the fix io_triggered_buffer_setup() during probe by
passing the iio_pollfunc_store_time parameter.

Alternative change would be to use iio_get_time_ns() directly in the
push_to_buffers call in the handler.  We can do this if you are not
one of those "devices (who) need a timestamp grabbed as soon as possible
after the trigger" (from iio_poll_func definition)

Either way you are using iio_get_tme_ns(), it's just a question of when.  
Let me know if you'd rather go the slower way.


Alison Schofield (3):
  iio: accel: bma220_spi: set up buffer timestamps for non-zero values
  iio: humidity: am2315: set up buffer timestamps for non-zero values
  iio: proximity: as3935: set up buffer timestamps for non-zero values

 drivers/iio/accel/bma220_spi.c | 2 +-
 drivers/iio/humidity/am2315.c  | 2 +-
 drivers/iio/proximity/as3935.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.1.4

