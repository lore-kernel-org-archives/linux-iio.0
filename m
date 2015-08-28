Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:54677 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbbH1WAT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Aug 2015 18:00:19 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 0/6] fixes, cleanup and improvements for m62332
Date: Fri, 28 Aug 2015 23:59:52 +0200
Message-Id: <cover.1440459082.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A set of patches to address some issues I spotted during review.

Hartmut Knaack (6):
  iio:dac:m62332: share scale and offset
  iio:dac:m62332: shutdown on remove
  iio:dac:m62332: use ARRAY_SIZE
  iio:dac:m62332: drop unrequired variable
  iio:dac:m62332: address some style issues
  iio:dac:m62332: use dynamic scale

 drivers/iio/dac/m62332.c | 63 +++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

-- 
2.4.6

