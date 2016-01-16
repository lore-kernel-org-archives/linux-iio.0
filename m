Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from argos.tuxed.org ([176.9.87.227]:42189 "EHLO argos.tuxed.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbcAPQOx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 16 Jan 2016 11:14:53 -0500
From: Alexander Koch <mail@alexanderkoch.net>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mhornung.linux@gmail.com, dannenberg@ti.com, balbi@ti.com,
	fengguang.wu@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Koch <mail@alexanderkoch.net>
Subject: [PATCH v2 2/3] iio: light: opt3001: trivial type refactoring
Date: Sat, 16 Jan 2016 17:14:37 +0100
Message-Id: <1452960878-1727-3-git-send-email-mail@alexanderkoch.net>
In-Reply-To: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change variable type of struct opt3001 members 'ok_to_ignore_lock' and
'result_ready' uint16-bitfield of length one to bool.

They are used as bool, let the compiler do the optimization.

Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>
---
 drivers/iio/light/opt3001.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index aefbd79..b05c484 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -79,8 +79,8 @@ struct opt3001 {
 	struct device		*dev;
 
 	struct mutex		lock;
-	u16			ok_to_ignore_lock:1;
-	u16			result_ready:1;
+	bool			ok_to_ignore_lock;
+	bool			result_ready;
 	wait_queue_head_t	result_ready_queue;
 	u16			result;
 
-- 
2.7.0

