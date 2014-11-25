Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8076 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbaKYMrO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Nov 2014 07:47:14 -0500
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 0/4] Add valid sample channel
Date: Tue, 25 Nov 2014 14:48:03 +0200
Message-Id: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an attempt to address the problem of buffering in devices which have
different scan frequencies for different channels.

The first patch is a minor cleanup of the dummy code, the second one a
safeguard against duplicate scan_index channels.

The final two patches add a new channel and are RFC.

Vlad Dogaru (4):
  iio: dummy: set scan_index for unbuffered channels
  iio: ensure scan index is unique at buffer register
  iio: add valid sample channel
  iio: illustrate the use of a valid sample channel

 drivers/iio/industrialio-buffer.c             | 28 ++++++++++++++++++++++++
 drivers/iio/industrialio-core.c               |  1 +
 drivers/staging/iio/iio_simple_dummy.c        | 21 +++++++++++++++---
 drivers/staging/iio/iio_simple_dummy_buffer.c | 31 +++++++++++++++++++++++++--
 include/linux/iio/types.h                     |  1 +
 5 files changed, 77 insertions(+), 5 deletions(-)

-- 
1.9.1

