Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD843711B;
	Tue, 11 Aug 2026 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444399; cv=none; b=MCmw6hfczDm/+8xxc8HXWp+Lzu/+vMi1rtkg4HZv9LcR3O9TCCjNtW8G6rksXXh/zJi+6JXirqwKF8LI/vRSbyNfnrDSzL/lnwq8EoSq1JNxSzSUGTbglEPp3p+CBQl7h/3JHc4v6X7ecvR4gai2mrajreAkg1ZmlyS282PhRJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444399; c=relaxed/simple;
	bh=VxugrjIF4trUGLbFCITjSlHM3uhThBlcHP0VoKQL2s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdqIySCqFDdK/KlarSXMDLvaqIlXzgUtxh7ANRT0tu/XRUOKZeVHO8LD1iYXwkaocsOBf6NZihWKPZrkfOPj1OD1cL9WgwkXT30onDV7teDC6ZDFy7BTfE4Y+TOdIGA24zBhr3EnDewfO6970h7iZYx3S/UI35tjKlW3MYWIhp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0a01a31c957011f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2174f42d-0c1a-4991-a4e0-4b4c3faaefb9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:214218ff6df55f205c8517a94b145e3b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a01a31c957011f1aa26b74ffac11d73-20260811
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1223409682; Tue, 11 Aug 2026 18:33:06 +0800
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
Subject: [PATCH togreg v3 0/2] iio: imu: inv_icm42607: fix PM error handling
Date: Tue, 11 Aug 2026 18:32:59 +0800
Message-Id: <20260811103301.1157404-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811020345.950137-1-lilinmao@kylinos.cn>
References: <20260811020345.950137-1-lilinmao@kylinos.cn>
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

Changes since v2:
- Patch 2: restructure inv_icm42607_resume() along the lines Andy
  suggested.  No functional change.
- Dropped the redundant hand-written base note; --base already emits
  base-commit:.
- Patch 1 is unchanged.

Changes since v1:
- Patch 2: split the device side of inv_icm42607_resume() into a helper
  so the PM bookkeeping stays in the wrapper.  No functional change.
- Rebased onto the current togreg head.

On the ordering question from the v2 review: pm_runtime_force_suspend()
runs the .runtime_suspend callback, which writes PWR_MGMT0 over the bus,
so it has to happen while vddio is still enabled - that is, before
inv_icm42607_disable_vddio_reg() in .suspend().  .resume() then unwinds
in the opposite order, which is why pm_runtime_force_resume() comes last
there.  That ordering is what the driver already does; this series does
not change it.

The Fixes commit is in iio.git togreg and has been included in
linux-next. It has not reached mainline.

Both patches were compile-tested with W=1 and checked with smatch. No
ICM-42607 hardware or fault-injection setup was available.

Linmao Li (2):
  iio: imu: inv_icm42607: propagate runtime suspend errors
  iio: imu: inv_icm42607: restore runtime PM on system resume errors

 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.25.1

