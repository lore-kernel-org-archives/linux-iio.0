Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:62141 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbbFJTvv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 10 Jun 2015 15:51:51 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 1/3] tools:iio:iio_event_monitor: check if event is fully read
Date: Wed, 10 Jun 2015 21:51:19 +0200
Message-Id: <52e7c9b1da4e0918722cc993bd3b25287f342e55.1433721755.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433721755.git.knaack.h@gmx.de>
References: <cover.1433721755.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433721755.git.knaack.h@gmx.de>
References: <cover.1433721755.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check that the read event is of the expected size.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_event_monitor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 016760e..2559fba 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -299,6 +299,12 @@ int main(int argc, char **argv)
 			}
 		}
 
+		if (ret != sizeof(event)) {
+			printf("Reading event failed!\n");
+			ret = -EIO;
+			break;
+		}
+
 		print_event(&event);
 	}
 
-- 
2.3.6

