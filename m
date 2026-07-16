Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E041DEFE;
	Thu, 16 Jul 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205150; cv=none; b=aNd5kHE4pLJh3izb5qaOLRcui2rVr6RHX0Jr3YR6uu/iuE13dw1EvalTEtkiA0RpuYK/z3ZsGCjWszdGKENTyEJXvJYkK0Jv2AEQ4gAQ18fORUg/ASOqDR/eHdd2kD0jKh6i8ZkLcaTWJ5Jtk8xGB32u+q0yuNGDsgChN2F0gl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205150; c=relaxed/simple;
	bh=KrthvANV5cWN3Y+NtoooBph2B4UQX8kYkhATs4O4In8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g8/F27fZvWsGSM2JQLOYvEc8b0FjDMEjuLp3/8eZdc+dVubbCfuYAGZKZ5WZlGZAW7rUI6gxlkeqK8hED/jmEPkThzb3y3zf/k7kUULT0P4GiRtAwyD25c/rATlAre//fWyioim/jAyyqhcPv6fyy4HdKLXO+e7Hc/TuLi/WNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=XM/Yb8OD; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="XM/Yb8OD"
Received: from email.seznam.cz
	by smtpc-mxd-7457b5647d-hg8d7
	(smtpc-mxd-7457b5647d-hg8d7 [2a02:598:96:8a00::1200:712])
	id 7aed6d8ec28240017813f712;
	Thu, 16 Jul 2026 14:32:05 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1784205125; bh=z4dFavrImgzsHwnCKjeETYjhWeSpqpr9tUynKV4DRy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=XM/Yb8ODRQUQLrpRBNZ7S+EnErcr5v0tnrkWf7zyfy4tMImAlb6XcmT0U/dmDQjrh
	 bVeg4lHXH6Xv/5KQEjiiDPXuDNGajWDRH+y5Mla+8aCtMB+37R2ZSneHBS7Z/NwBhC
	 hk8tkddavTSIhkjd8UyTAlNpgcQbODnlhHGo/CiXjr5Loj0HUhdpAiaYxS+UGubUow
	 bmVQHwLnW07Xvpwyq1HSkfqcTiHSqTP5a84epNCx/wyB5swuSP0mKlIA6+rhMMaKR+
	 EeAGJBFDYM6BCgg3THKNbcvI8yGTlXHzCVpg5zBL8EaxnPDQVjUp7hdarFjh9tRqp+
	 fRctzMC47Ew6w==
Received: from archlinux.localdomain ([88.146.244.229])
	by smtpd-relay-697464fc87-jgntd (szn-email-smtpd/2.0.77) with ESMTPA
	id 3462db11-0300-49aa-ac7b-debe37b69add;
	Thu, 16 Jul 2026 14:31:06 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vo.kratky@seznam.cz
Subject: [PATCH] iio: resolver: ad2s1200: use dev_err_probe()
Date: Thu, 16 Jul 2026 14:31:00 +0200
Message-ID: <20260716123100.100394-1-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use dev_err_probe() instead of dev_err() to simplify the error path
and cleanly handle deferred probing.

Signed-off-by: Vojtěch Krátký <vo.kratky@seznam.cz>
---
 drivers/iio/resolver/ad2s1200.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index 55bcbbd4021a..7c7ce0e2f9cc 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -144,16 +144,14 @@ static int ad2s1200_probe(struct spi_device *spi)
 
 	st->sample = devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
 	if (IS_ERR(st->sample)) {
-		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
-			PTR_ERR(st->sample));
-		return PTR_ERR(st->sample);
+		return dev_err_probe(&spi->dev, PTR_ERR(st->sample),
+				"Failed to claim SAMPLE gpio\n");
 	}
 
 	st->rdvel = devm_gpiod_get(&spi->dev, "adi,rdvel", GPIOD_OUT_LOW);
 	if (IS_ERR(st->rdvel)) {
-		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
-			PTR_ERR(st->rdvel));
-		return PTR_ERR(st->rdvel);
+		return dev_err_probe(&spi->dev, PTR_ERR(st->rdvel),
+				"Failed to claim RDVEL gpio\n");
 	}
 
 	indio_dev->info = &ad2s1200_info;
-- 
2.55.0

