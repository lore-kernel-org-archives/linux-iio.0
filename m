Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1052 "EHLO
	smtp-out-023.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750858AbbERLe4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 07:34:56 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 0/3] iio: Refactor __iio_update_buffers()
Date: Mon, 18 May 2015 13:34:46 +0200
Message-Id: <1431948889-24069-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v1:
	* Dropped 'iio: __iio_update_buffers: Update mode before
	  preenable/after postdisable' for now

- Lars

Original cover letter below:

__iio_update_buffers() is quite the beast, it does quite a few different
things and has a couple of separate error paths due to this. This series
refactors the function starting with moving the configuration verification
out of the configuration path itself. This means we can verify that the
configuration will be accepted before we make any changes to the device and
don't have to implement rollback functionality. The function is also broken
down into a couple of smaller helper function each which only a single
error path. This should hopefully make it easier to comprehend what is
going on. The last step of the refactoring process is to make sure that we
always leave the device in a sane and consistent state even if we encounter
a fatal error. This allows to potentially recover from the fatal error and
will also make sure that we don't trigger unexpected behavior in drivers.

The main motivation for this series to get __iio_update_buffers() ready for
future extension like the ones that are needed to support DMA buffer
support as well as better support for hardware buffer support.

The last patch in this series is not meant to be applied, but it implements
some simple random error injecting into the various error paths of
__iio_update_buffers(). This was used to test the patch series for
regressions and to make sure that we can indeed recover from fatal errors
now.

Lars-Peter Clausen (3):
  iio: __iio_update_buffers: Verify configuration before starting to
    apply it
  iio: __iio_update_buffers: Split enable and disable path into helper
    functions
  iio: __iio_update_buffers: Leave device in sane state on error

 drivers/iio/industrialio-buffer.c | 287 +++++++++++++++++++++++---------------
 1 file changed, 175 insertions(+), 112 deletions(-)

-- 
1.8.0

