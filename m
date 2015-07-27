Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:52239 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754401AbbG0Wth (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:49:37 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 0/7] stk8312 fixes and cleanup
Date: Tue, 28 Jul 2015 00:49:20 +0200
Message-Id: <cover.1437955135.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixing some issues I spotted during review.

Hartmut Knaack (7):
  iio:accel:stk8312: add triggered buffer dependency
  iio:accel:stk8312: check for invalid value
  iio:accel:stk8312: improve error handling
  iio:accel:stk8312: rework macro definitions
  iio:accel:stk8312: use appropriate variable types
  iio:accel:stk8312: code style cleanup
  iio:accel:stk8312: drop local buffer

 drivers/iio/accel/Kconfig   |  2 ++
 drivers/iio/accel/stk8312.c | 85 +++++++++++++++++++++++++--------------------
 2 files changed, 49 insertions(+), 38 deletions(-)

-- 
2.4.6

