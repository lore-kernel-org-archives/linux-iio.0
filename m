Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34445 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbbLMO3X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2015 09:29:23 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] 3rd 'set' of IIO fixes for the 4.4 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566D80C2.5070105@kernel.org>
Date: Sun, 13 Dec 2015 14:29:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 9225c0b7b976dd9ceac2b80727a60d8fcb906a62:

  staging: lustre: echo_copy.._lsm() dereferences userland pointers directly (2015-12-01 12:13:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.4c

for you to fetch changes up to d590faf9e8f8509a0a0aa79c38e87fcc6b913248:

  iio: adis_buffer: Fix out-of-bounds memory access (2015-12-05 17:32:04 +0000)

----------------------------------------------------------------
3rd set of IIO fixes for the 4.4 cycle.

Only a single fix this time and for a bug that's been in the kernel
since around about the start of 2013 (so no rush!)

* Out-of-bounds memory access in adis core (Analog Devices IMUs)

----------------------------------------------------------------
Lars-Peter Clausen (1):
      iio: adis_buffer: Fix out-of-bounds memory access

 drivers/iio/imu/adis_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
