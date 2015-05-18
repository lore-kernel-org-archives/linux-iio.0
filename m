Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26832 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155AbbERQYR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 May 2015 12:24:17 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Introduce PM runtime helper functions
Date: Mon, 18 May 2015 19:25:26 +0300
Message-Id: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Working on a new driver I noticed that there is a fair amount of duplicate
code for adding PM runtime support.

First patch refactors the PM runtime support in a new header
 <linux/iio/pm_runtime> introducing functions for setup/cleanup and
set power state.

Second patch modifies the KXCJK-1013 driver to use the newly created API. If
this is ok follow up patches will modify the rest of the drivers.

There is a small difference for hid-sensors where the setup sequence additionally
calls pm_suspend_ignore_children. This is taken care of by introducing a 3rd
parameter to iio_pm_runtime_setup.

Daniel Baluta (2):
  iio: pm_runtime: Introduce PM runtime helper functions
  iio: accel: kxcjk1013: Use the new IIO pm runtime helpers

 drivers/iio/accel/kxcjk-1013.c | 56 ++++++++++---------------------------
 include/linux/iio/pm_runtime.h | 63 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/iio/pm_runtime.h

-- 
1.9.1

