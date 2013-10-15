Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42135 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759775Ab3JOVE0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 17:04:26 -0400
Message-ID: <525DBC0B.9050903@kernel.org>
Date: Tue, 15 Oct 2013 23:04:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.12 set 3
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.12c

for you to fetch changes up to e086ed76671252d5b539854a83f8506be7bea05c:

  iio:buffer: Free active scan mask in iio_disable_all_buffers() (2013-10-15 19:26:43 +0100)

----------------------------------------------------------------
Third set of IIO fixes for the 3.12 cycle.

Two little ones this time:

1) A missing clk_unprepare in adf4350.
2) A missing free of the active_scan_mask when iio_disable_all_buffers is
called during an unexpected device removal.  This leak was introduced by
the fix
a87c82e454f184a9473f8cdfd4d304205f585f65 iio: Stop sampling when the device is removed
and hence is a regression fix.

----------------------------------------------------------------
Lars-Peter Clausen (1):
      iio:buffer: Free active scan mask in iio_disable_all_buffers()

Wei Yongjun (1):
      iio: frequency: adf4350: add missing clk_disable_unprepare() on error in adf4350_probe()

 drivers/iio/frequency/adf4350.c   | 6 ++++--
 drivers/iio/industrialio-buffer.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)
