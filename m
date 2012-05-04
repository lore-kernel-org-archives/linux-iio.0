Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:36199
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758162Ab2EDNbO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 May 2012 09:31:14 -0400
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/3] iio: documentation: create frequency sub-folder and move dds docs
Date: Fri, 4 May 2012 15:31:05 +0200
Message-ID: <1336138266-25480-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1336138266-25480-1-git-send-email-michael.hennerich@analog.com>
References: <1336138266-25480-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 .../{ => frequency}/sysfs-bus-iio-dds              |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename drivers/staging/iio/Documentation/{ => frequency}/sysfs-bus-iio-dds (100%)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds b/drivers/staging/iio/Documentation/frequency/sysfs-bus-iio-dds
similarity index 100%
rename from drivers/staging/iio/Documentation/sysfs-bus-iio-dds
rename to drivers/staging/iio/Documentation/frequency/sysfs-bus-iio-dds
-- 
1.7.0.4


