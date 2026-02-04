Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947742317F;
	Wed,  4 Feb 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228394; cv=none; b=ZqFh9BVtYJF2vJLO2T45xAlD8yV1ZiL9nLWz8/dhEo7mjEabDld3cJeZeSQSANtPjekXlSxH17KgeobW9T9oBqfIF/0PQX0QK69SYHBaMBzGZSSYusUrBohkzkFXkoX96kPZE5O7L1Hi85rUJFRsu0M/6llR8y1OmKS5gU+SHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228394; c=relaxed/simple;
	bh=23gI3CfLHbVYup6LCK2uSMk5qPT33yWeLiPz0/EECpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzdzhrDq+9TOrsjKKj8QJQo7MuC3Sy2IAaM3VxxBbNUsdAyV3JGBKWl+OnLxJFC8dxwiLagVcC1vRYimmYYE6WCqb39V4xl/6J0YBjnFHxEGTABEYqvevII37h+RXQ5OBLhkwdcJMFowimt8pr0pc3oAvDNfP32SSBFrYx1XNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 34ILyVG5Rzej1Vs/yWD6uA==
X-CSE-MsgGUID: tv5O8Kr3TSyiD/r2y4Zv+A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2026 03:01:24 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.27])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0DD4E4072C22;
	Thu,  5 Feb 2026 03:01:22 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: William Breathitt Gray <wbg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH] counter: sysfs: remove double return in counter_sysfs_attr_add()
Date: Wed,  4 Feb 2026 20:00:32 +0200
Message-ID: <20260204180032.514328-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs attribute creation for counter extensions has been consolidated
into a single function, counter_sysfs_exts_add().

Inside counter_sysfs_attr_add(), although the code was changed to return
the result of counter_sysfs_exts_add(), an unreachable return 0;
statement was left at the end of the function.

Remove it.

Fixes: bb4bbbec664f ("counter: Consolidate Counter extension sysfs attribute creation")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/counter-sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 42c523343d32..ed85da907982 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -1101,8 +1101,6 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	/* Add device extensions */
 	return counter_sysfs_exts_add(dev, cattr_group, counter->ext,
 				      counter->num_ext, scope, NULL);
-
-	return 0;
 }
 
 /**
-- 
2.52.0

