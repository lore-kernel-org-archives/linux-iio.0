Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48081 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbbDACzj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 31 Mar 2015 22:55:39 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 0/3] Added LTR501 Interrupt support
Date: Tue, 31 Mar 2015 19:55:18 -0700
Message-Id: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds interrupt support for LTR501 chip. Also
added acpi enumaration support.

Please let me know your review comments.

v1:
1. Added support to enable ALS & PS intterupts based 
   on threshold settings.
2. Added support to control intrrupt rate.
3. Added acpi enumeration support.

Kuppuswamy Sathyanarayanan (3):
  iio: ltr501: Add interrupt support
  iio: ltr501: Add interrupt rate control support
  iio: ltr501: Add ACPI enumeration support

 drivers/iio/light/ltr501.c | 395 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 392 insertions(+), 3 deletions(-)

-- 
1.9.1

