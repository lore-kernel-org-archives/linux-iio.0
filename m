Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50499 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbaJNRr3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Oct 2014 13:47:29 -0400
Message-ID: <543D61AF.30405@kernel.org>
Date: Tue, 14 Oct 2014 18:47:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Fedorenko <gregfed243@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.18 set 1
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0f33be009b89d2268e94194dc4fd01a7851b6d51:

  Linux 3.17-rc6 (2014-09-21 15:43:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
tags/iio-fixes-for-3.18a

for you to fetch changes up to 75d7ed3b9e7cb79a3b0e1f417fb674d54b4fc668:

  iio: adc: mxs-lradc: Disable the clock on probe failure (2014-10-09 21:02:51
+0100)

----------------------------------------------------------------
First round of IIO fixes for the 3.18 cycle.

* ad5933 - fix a null pointer dereference due to an old change that prevents
  different channels being registered for the buffer and used for sysfs
  interfaces.
* ad5933 - Drop a bonus _raw from attribute names.
* st-sensors - Makes sure the correct number of elements are copied when
  filling a local buffer copy.
* mxs-lradc - Disable clocks in a failure path during probe so they aren't
  left running.

----------------------------------------------------------------
Fabio Estevam (1):
      iio: adc: mxs-lradc: Disable the clock on probe failure

Lars-Peter Clausen (2):
      staging:iio:ad5933: Fix NULL pointer deref when enabling buffer
      staging:iio:ad5933: Drop "raw" from channel names

Robin van der Gracht (1):
      iio: st_sensors: Fix buffer copy

 drivers/iio/common/st_sensors/st_sensors_buffer.c |  2 +-
 drivers/staging/iio/adc/mxs-lradc.c               | 12 ++++++++----
 drivers/staging/iio/impedance-analyzer/ad5933.c   | 15 ++++++---------
 3 files changed, 15 insertions(+), 14 deletions(-)
