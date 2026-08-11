Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207E3644B3;
	Tue, 11 Aug 2026 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413840; cv=none; b=Mx0hPtZeXPyVry+VHXL3zAwoUqumKaqexfvHpaHUPlN/pT4sfiUHHTqt2lFCifdaJcM+yYDWXHO2elZeif+YJuTof6nxwCmWK4VeHXMNgk9l1SUT75+7vk447eXR8tHerSsfFSkv2raBmr21RpPE3JJz+VkT71BjryBlH1P3TyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413840; c=relaxed/simple;
	bh=EN1CLy4hArCiAOz0HZcsp1+rRb46aqvMjBQjH25f2TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AifooZaw3Ozh1bh2cxASQKa9eHQ8azfM9vfSY+8kKvVGvJ4Ml+NJ1/OHlSRvceqL+5vfAJ71iCDKtNZRBhqLGE8Eg8wb4wlbBYkGRUIv5RFpSjVcrAzEUdSsYMYXs3vIxiDDsI0M/n5aSuSwX/isQdI+na77VvdyZMofeOZ60GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e52ad10e952811f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d275808c-d933-44be-9a78-4209cc1e2351,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:314a9ad1e48e6da90ed3047e1a1f5e75,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e52ad10e952811f1aa26b74ffac11d73-20260811
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 969026006; Tue, 11 Aug 2026 10:03:50 +0800
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
Subject: [PATCH togreg v2 0/2] iio: imu: inv_icm42607: fix PM error handling
Date: Tue, 11 Aug 2026 10:03:43 +0800
Message-Id: <20260811020345.950137-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260805035451.487465-1-lilinmao@kylinos.cn>
References: <20260805035451.487465-1-lilinmao@kylinos.cn>
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

Changes since v1:
- Patch 2: split the device side of inv_icm42607_resume() into a helper so
  the PM bookkeeping stays in the wrapper, per Andy's review.  No
  functional change.
- Rebased onto the current togreg head.
- Patch 1 is unchanged.

The Fixes commit is in iio.git togreg and has been included in
linux-next. It has not reached mainline.

Based on iio.git togreg at 350d1fb9204b.

Both patches were compile-tested with W=1 and checked with smatch. No
ICM-42607 hardware or fault-injection setup was available.

Linmao Li (2):
  iio: imu: inv_icm42607: propagate runtime suspend errors
  iio: imu: inv_icm42607: restore runtime PM on system resume errors

 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.25.1

