Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0F1D9A5F;
	Wed,  5 Aug 2026 03:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902105; cv=none; b=jrbXRm2hRvd7hVkOHgSvXNglQdTg33NMVDbYRHh2Jl+AKBJbuvdGrfHG5QdJdVpUR4+HY8MfGgW9WDA2tNfQtoyID8jvGQjQU5k0Hm2m7Jn5Ao2jwtjLXXbplrXt0iCtUK8XLKQFhliCsBUmPBlakPIIvI7jxq5ZPqMeSrVk540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902105; c=relaxed/simple;
	bh=oBZk+sXuJ8SM44hLPHsRoXp2llIklhbdQbeSodJCtDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTQ66FdqfiiDwiQ5jpqj2Qf14sePJ1a1Svm6irL7+87qwRaI5DIo6yEAJLwKI943BKb5DAD+efFKSJhpUJIlUMQf2LiDBiaCd3eFx//pV8RiVUTXZvcPqelsr4vUzictP98N9+HUpAgAPyaONWseJuChlfXlr9/ixHNALwLb1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6d5b3976908111f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0f7af518-ba87-48e5-88a1-a48b0aefb76c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:95c0440cf884ee1151d48f6b283735d1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6d5b3976908111f1aa26b74ffac11d73-20260805
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 845792877; Wed, 05 Aug 2026 11:54:58 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH togreg 0/2] iio: imu: inv_icm42607: fix PM error handling
Date: Wed,  5 Aug 2026 11:54:49 +0800
Message-Id: <20260805035451.487465-1-lilinmao@kylinos.cn>
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

Patch 1 propagates sensor shutdown failures from runtime suspend, matching
the behavior of the sibling ICM-42600 driver. Patch 2 ensures that system
resume restores runtime PM management on both of its error paths, so that
a failed resume does not leave runtime PM disabled for good.

The Fixes commit is in iio.git togreg and has been included in
next-20260804. It has not reached mainline.

Based on iio.git togreg at 0efaefce4e95.

Both patches were compile-tested with W=1 and checked with smatch. No
ICM-42607 hardware or fault-injection setup was available.

Linmao Li (2):
  iio: imu: inv_icm42607: propagate runtime suspend errors
  iio: imu: inv_icm42607: restore runtime PM on system resume errors

 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)


base-commit: 0efaefce4e95a3331550329c0078b2fb38b3ff1f
-- 
2.25.1

