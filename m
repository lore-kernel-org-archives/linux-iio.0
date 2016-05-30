Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26008 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161259AbcE3PTt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 May 2016 11:19:49 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v4 0/3] iio: generic_buffer: Select device/trigger by number
Date: Mon, 30 May 2016 18:19:25 +0300
Message-Id: <cover.1464610998.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds support for selecting iio devices/triggers by numeric id
rather than just name. This is useful because the names are not actually
guaranteed to be unique.

Changes since v3:
* Rebase on top of latest jic23/testing
* Fix handling of --trigger-num 0. Initialize trig_num to -1 and check if >= 0
for valid id.

Jonathan: you replied to v3 saying that they were applied but I don't see those
patches on any branch from your repo:
    https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Crestez Dan Leonard (3):
  iio: generic_buffer: Cleanup when receiving signals
  iio: generic_buffer: Add --device-num option
  iio: generic_buffer: Add --trigger-num option

 tools/iio/iio_generic_buffer.c | 261 ++++++++++++++++++++++++++++-------------
 1 file changed, 181 insertions(+), 80 deletions(-)

-- 
2.5.5

