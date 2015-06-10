Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:63953 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbbFJTvs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 10 Jun 2015 15:51:48 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 0/3] iio-tools out-of-staging cleanup
Date: Wed, 10 Jun 2015 21:51:18 +0200
Message-Id: <cover.1433721755.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now that the iio-tools got moved out of staging, it is about time to
improve code quality to common kernel level.

Changes in V2:
	iio_event_monitor: change error handling in case of read-problems
			   to abort the read loop, rather than just trying
			   again.

Hartmut Knaack (3):
  tools:iio:iio_event_monitor: check if event is fully read
  tools:iio: adjust coding style
  tools:iio: rename variables

 tools/iio/generic_buffer.c    |  46 +++++++++-------
 tools/iio/iio_event_monitor.c |  19 +++++--
 tools/iio/iio_utils.c         | 121 +++++++++++++++++++++++++-----------------
 tools/iio/iio_utils.h         |  15 +++---
 tools/iio/lsiio.c             |  43 ++++++++-------
 5 files changed, 143 insertions(+), 101 deletions(-)

-- 
2.3.6

