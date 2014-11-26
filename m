Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-243.synserver.de ([212.40.185.243]:1069 "EHLO
	smtp-out-243.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbaKZRzR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Nov 2014 12:55:17 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/11] iio: Buffer cleanups and consolidations
Date: Wed, 26 Nov 2014 18:55:06 +0100
Message-Id: <1417024517-7564-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This series contains a couple of cleanups and code consolidations for the
IIO buffer handling. The biggest change is probably the moving of the buffer
registration itself to the core rather than having to do this manually in
each driver. Having to do this manually had its place in earlier days, but
today it is just boilerplate code.

The other changes are mostly concerned with moving boilerplate code from
individual buffer implementations to the core. Given that there is only one
serious buffer implementation at the moment this doesn't do to much. But
this series is done in preparation for adding the DMA buffer support, so we
do not have to add the same duplicated code for the DMA buffer.

- Lars

Lars-Peter Clausen (11):
  staging:iio:ad5933: Don't enable channels by default
  staging:iio:sca3000: Don't enable channels by default
  iio: Unexport iio_scan_mask_set()
  staging:iio:sca3000: Register same channels for device and buffer
  staging:iio:dummy: Register same channels for device and buffer
  iio: Move buffer registration to the core
  iio: Remove get_bytes_per_datum() from iio_buffer_access_funcs
  iio: buffer: Move iio_buffer_alloc_sysfs and iio_buffer_free_sysfs
  iio: buffer: Allocate standard attributes in the core
  iio: buffer: Make length attribute read only for buffers without
    set_length
  iio: buffer: Drop get_length callback

 drivers/iio/adc/ti_am335x_adc.c                 |   9 -
 drivers/iio/iio_core.h                          |   9 +
 drivers/iio/industrialio-buffer.c               | 403 ++++++++++++------------
 drivers/iio/industrialio-core.c                 |  14 +-
 drivers/iio/industrialio-triggered-buffer.c     |   9 -
 drivers/iio/kfifo_buf.c                         |  27 --
 drivers/staging/iio/Documentation/ring.txt      |   8 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |  13 +-
 drivers/staging/iio/accel/sca3000_core.c        |  17 +-
 drivers/staging/iio/accel/sca3000_ring.c        |  29 +-
 drivers/staging/iio/iio_simple_dummy.c          |  13 +-
 drivers/staging/iio/iio_simple_dummy.h          |   3 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c   |  10 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |  16 +-
 drivers/staging/iio/meter/ade7758.h             |   1 -
 drivers/staging/iio/meter/ade7758_core.c        |  15 +-
 drivers/staging/iio/meter/ade7758_ring.c        |   5 -
 include/linux/iio/buffer.h                      |  76 +----
 18 files changed, 255 insertions(+), 422 deletions(-)

-- 
1.8.0

