Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36437 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbGXNN6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 09:13:58 -0400
Date: Fri, 24 Jul 2015 16:13:07 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 0/6] iio: Fix kernel docs warnings
Message-ID: <cover.1437737942.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset walks through drivers/iio/*, include/linux/iio/*
to fix kernel docs warnings.

Cristina Opriceana (6):
  iio: core: Add function params for kernel docs
  iio: buffer: Fix kernel docs warnings
  iio: trigger: Add missing fields in kernel docs
  iio: event: Add missing fields in kernel docs
  include: linux: iio: Fix function parameter name in kernel doc
  include: linux: iio: Add missing kernel doc field

 drivers/iio/industrialio-buffer.c  | 15 ++++++++++++++-
 drivers/iio/industrialio-core.c    | 25 ++++++++++++++++++++-----
 drivers/iio/industrialio-event.c   |  6 ++++++
 drivers/iio/industrialio-trigger.c | 27 ++++++++++++++++++++++++---
 include/linux/iio/consumer.h       |  2 +-
 include/linux/iio/sysfs.h          |  3 ++-
 6 files changed, 67 insertions(+), 11 deletions(-)

-- 
1.9.1

