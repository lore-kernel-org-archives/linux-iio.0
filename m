Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from alln-iport-2.cisco.com ([173.37.142.89]:33028 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdF0Qzp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jun 2017 12:55:45 -0400
Date: Tue, 27 Jun 2017 09:46:01 -0700
From: Gaurav Gupta <gauragup@cisco.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH] iio: core: Fix mapping of iio channels to entry numbers
Message-ID: <20170627164601.GA30866@sjc-ads-988.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When adding maps to the list, they were added using list_add, which adds
them in LIFO order. When parsing using iio_channel_get_all(), these
elements are hence returned in reverse order. As a result, the iio_hwmon
mapping maps the first entry to the last channel and so on.

Signed-off-by: Gaurav Gupta <gauragup@cisco.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 7a13535..9b0715c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -44,7 +44,7 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
 		}
 		mapi->map = &maps[i];
 		mapi->indio_dev = indio_dev;
-		list_add(&mapi->l, &iio_map_list);
+		list_add_tail(&mapi->l, &iio_map_list);
 		i++;
 	}
 error_ret:
-- 
2.10.2.dirty
