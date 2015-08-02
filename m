Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:51797 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbbHBUoG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 16:44:06 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
Subject: [PATCH 0/7] mma8452 fixes and cleanup
Date: Sun,  2 Aug 2015 22:43:45 +0200
Message-Id: <cover.1438483410.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series addresses some issues found during review.

Hartmut Knaack (7):
  iio:accel:mma8452: fix _get_hp_filter_index
  iio:accel:mma8452: drop double include
  iio:accel:mma8452: pass up real error code
  iio:accel:mma8452: check values to be written
  iio:accel:mma8452: rework register definitions
  iio:accel:mma8452: coding style cleanup
  iio:accel:mma8452: reorder Kconfig entry

 drivers/iio/accel/Kconfig   |  24 ++---
 drivers/iio/accel/mma8452.c | 216 +++++++++++++++++++++++++-------------------
 2 files changed, 134 insertions(+), 106 deletions(-)

-- 
2.4.6

