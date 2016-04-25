Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42597 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933040AbcDYSeI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2016 14:34:08 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: [PULL] Third set of IIO fixes in the 4.6 cycle.
Message-ID: <8ad08229-52e8-05f1-e7dc-e711d4901da7@kernel.org>
Date: Mon, 25 Apr 2016 19:34:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.6c

for you to fetch changes up to 8e6cb470bac6b1e7afa4642a40a71f9bcd066242:

  iio:adc:at91-sama5d2: Repair crash on module removal (2016-04-18 19:53:34 +0100)

----------------------------------------------------------------
3rd set of IIO fixes for the 4.6 cycle.

* ak8975
  - fix a null pointer exception if an interrupt occurs during probe.
  - fix a maybe-unitialized warning.
* at91-sama5d2
  - fix a crash on removal of the module.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      iio: ak8975: Fix NULL pointer exception on early interrupt

Marek Vasut (1):
      iio:adc:at91-sama5d2: Repair crash on module removal

Richard Leitner (1):
      iio: ak8975: fix maybe-uninitialized warning

 drivers/iio/adc/at91-sama5d2_adc.c | 2 ++
 drivers/iio/magnetometer/ak8975.c  | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)
