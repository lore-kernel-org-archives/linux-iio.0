Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41611 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933AbcGELzq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:46 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de
Subject: [PATCH 0/9] staging: iio: isl29018 and isl29028 cleanup
Date: Tue,  5 Jul 2016 13:55:35 +0200
Message-Id: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

cleanup for two staging drivers, prefixing stuff mostly

Peter Meerwald-Stadler (9):
  isl29018: Prefix #defines
  isl29018: Remove excessive output messages
  isl29018: Drop newlines
  isl29018: Cleanup of comments
  isl29018: Prefix remaining functions
  isl29028: Prefix #defines
  isl29028: Prefix stuff
  isl29028: Expose scale and sample frequency available without comma
  isl29028: Prefix functions

 drivers/staging/iio/light/isl29018.c |  133 +++++++++++++++-------------------
 drivers/staging/iio/light/isl29028.c |  102 +++++++++++++-------------
 2 files changed, 109 insertions(+), 126 deletions(-)

-- 
1.7.10.4

