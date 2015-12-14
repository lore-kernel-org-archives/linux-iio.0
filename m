Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56191 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbbLNMZW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Dec 2015 07:25:22 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v2 0/3] iio: light: us5218d: Add interrupt support and some tidying up
Date: Mon, 14 Dec 2015 14:24:44 +0200
Message-Id: <1450095887-13122-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first patch fixes an inconsistency that I've missed in the px_enable and
als enable status variables.
The second patch adds interrupt support for proximity.
And lastly, some refactoring to improve readability regarding the read raw function. 

Adriana Reus (3):
  iio: light: us5182d: Fix enable status inconcistency
  iio: light: us5182d: Add interrupt support and events
  iio: light: us5182d: Refactor read_raw function

 drivers/iio/light/us5182d.c | 442 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 360 insertions(+), 82 deletions(-)

-- 
1.9.1

