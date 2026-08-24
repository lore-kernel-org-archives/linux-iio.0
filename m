Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3B3161A1;
	Mon, 24 Aug 2026 03:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787543747; cv=none; b=eK42r3HJHlEsZistB7wWn49BJA+50C+AbA8ckHviwntPLmaDAMapkCtfifM/UBuJwISqJa0K51Y13smwdaH8W/01WQx8PtLuyFiU46LqaUyIQYFcUKAhkDPuxWV4LIgyYw+grJgu9o52rsiVZ8i5xrvyZEaw/T+hR8YdvvBjxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787543747; c=relaxed/simple;
	bh=bX1KCzAoyE1JUG3NiFQ0Z96txw2W5NWWSJyM0if0ItQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IFiH59uUzOijop/0X3JQU/n13hbb6IT69qPA8/uonfTLpHE+wpQ3fnbrYhstWO5L2TMha/J2e98oAkqc5PVw4qDdXh935VcYXlIAz9At6AXwviiG841N5h0sheX3vxC1m7WN4+Uxa9byXWthncQxXVgSib7QhysN4GlV0HNHfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a9601d229f6f11f19a56ed5b684f684d-20260824
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8bd83afb-288e-4c55-9ed2-3888799fb6ae,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:2c31c025ac352c2d11dcb4689d3c03cd,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:5|-
	100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a9601d229f6f11f19a56ed5b684f684d-20260824
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 539606431; Mon, 24 Aug 2026 11:55:35 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH togreg v4 0/2] iio: imu: inv_icm42607: fix PM error handling
Date: Mon, 24 Aug 2026 11:55:29 +0800
Message-Id: <20260824035531.141429-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently queued ICM-42607 PM support has two error paths that can leave
the PM core's state inconsistent with the device.

Patch 1 propagates sensor shutdown failures from runtime suspend.  Patch 2
ensures that system resume restores runtime PM management on both of its
error paths, so that a failed resume does not leave runtime PM disabled for
good.

Changes since v3:
- Patch 1: commit message expanded with the practical effect of the current
  behaviour, the cost of propagating the error, and a description of the
  recovery path that does not assume a particular regmap bus
  implementation.  No code change.
- Patch 2: unchanged.

Neither patch was reproduced on hardware; both were found by code
inspection.  They were compile-tested with W=1 and checked with smatch.

Whether patch 1 is worth making is still a fair question - it trades a
possible idle power leak that may be cleared by a later successful access
for a runtime PM error state that needs an explicit reset.  The commit
message spells that out; happy to drop it if you would rather not take
that trade.

Linmao Li (2):
  iio: imu: inv_icm42607: propagate runtime suspend errors
  iio: imu: inv_icm42607: restore runtime PM on system resume errors

 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.25.1

