Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E550C294
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540713; cv=none; b=hZZA1Yf9yeMQ4ZRzaHVDrBA1wYVWZ0Ji5GrdROWko84Ymkg6a4A+vtz2VkJ5Z8iu4V4yOI4cPHWNcBt0lKMrL3Gi0pAz1BJLoeGSw4t98ONw6BzgMZ5b33jywPDiVpiNLC1cTMGAHC5lNP380Vrsby9HdSttVKoP2QKLyI5FbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540713; c=relaxed/simple;
	bh=wr06q1j6egQgLlwJ2GcTDS7dH7wTNEsRtN9Wo3hJNDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbJJt6hk8xw/AlCHYwc+nyGFVYr1P9qF1ntQeFm2H+L55kWB0vHZiGK1g7jHdOOcU8Rz7zhgy00mtf1eDp2osgjHEoLL1rIMLNyTEeK2uMnoORjXKTOde3k1GAjSCPieELiUvEqwhZ5uMweYcKd1rZySIu3W/4q32joXVc8Okmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBMtbdre; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBMtbdre"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d8fd3b729dso11061365ad.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540711; x=1789145511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGHMxZ3rFuySAWzmDjUwEnKK4209RW925xasnyoZmGw=;
        b=NBMtbdrena5Kic+XrW1tI6FUkeEHVfc8f8pVOg5Yn+eLBw+wf2+eoRrMf8mH7MJtmF
         dYi2sSbiXbtay1fbPqQUnFcEhX1PPCHLKAbO0LcN3j/Y1qMMXe68Enp+T0SO8s06yCJb
         JAcZUv7LEQdTnalxdm5lUNBZr/NuDb4niwv3g1DY5LGoS8YJhpfpwnzZ3OFsOGP1c0BL
         TBVxugIg+5pulhayoMfC1Sc+ohNGER6o9FG9gbzPjVEMd8/EoMfGA7FcGGMTVMOmxbyt
         FSnghaZXBwDT8UsEYU2luDHjbh1gcs+u2gjDpRupQspHdHBZVDKlGQTCVT1EQ6wKLeBa
         XHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540711; x=1789145511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGHMxZ3rFuySAWzmDjUwEnKK4209RW925xasnyoZmGw=;
        b=iZN9OItHnGkl+gU6zam1O+SpeK99Jr8yOjf9i5viuwutQ4cAbMhOgY3Im276XWta/1
         1l94vZZoiyUDqnYt91+aNxtF404dZwAWZBQs/Uv8oPWUyZ0Inf1D933hd8h+CbS4vuzv
         o+IX0ukIetK97I+UceojRaB3jF6BSkeeek7F8ER8iLeHqLKFmS8FeWKVkhqqmpsX/OTJ
         k1eP/DeRZ33njHRKZz5a5R23h34cn60+o8rv3Ab28UObvQq/hdKv4hu/VC8Zdt5S3ow4
         +vjfbuwO+Oo5hBNuXQKTxMCAnkdNOTX7OtGgepelp+H+/7ScZEGmmvEHS7JUrDSm1vPQ
         ml6w==
X-Forwarded-Encrypted: i=1; AKwUvBxt7QfHIX0Ae92Mv2oWRZiu8NYVQjZeC1750Pg5ZMSv+e/D0UutLSpP3D8CISqOEuFXCo+L9NuWRHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mzMtVZBSvfasKT1bjZ7640nsW2QjmOSmRurWdwwCRrDlrkQciP
	ZRgjt7mc9waHkAlmHY28YXCOTfSbvC7DyFijuu7Rm0IP+Iq4f4/vlbmU
X-Gm-Gg: AYBFou3mS9AUJsX3XLDLR7kCBUNTb5iTE0GJuPy+47cdEIJY4mR0Eyhphx2ITqiEUQN
	UW0r24mplcQZ1kBvaHQKwiew5cjnnDFgp8zoYEsgT08UDc0X9RE25fuwFmIm/TsR3BdV3jMg5UZ
	0YBwNIjppCoE+UGqOVd+CjwDmibnidu9gnMp+TNAHV/s9x7Gq54PVbGgvJ9/wBaW1t3lTbnSuoZ
	qxv2Au96gHbO2b6KgdCpIiw3K9l4aJ3NAtUDY0H7JsWcx5KvoKx33IziUCK7diKNm26fvw2DzMX
	OEgcABzYP4GjUDGmQICL4GFfxTNJXDzSn7zSmndC7jHIu0JIKFkwZeSNfMdMT/g9KvK2iOxOxHx
	3wgn1yA7s39a1mZGi3aUqK7Pmcv8mVe/kMnRXKzJxjHKOzx5YjYgJv1G1s2JpaM19B3jAqfqcJF
	5859MUiAZcSqHWhH5xCWfOy9+a7+seB2XQziL4yuc1crjGlW5+hnoyOjUBr2nsdC9scqE1Okf6J
	G8mLrBNypk0XWop0BATkyrQbToGt4n8q9xbDpF1fS7kmyOk9BEdG5+wyNn/LrlqK0Z3heDIcdNC
	RMMtGl9J8L8=
X-Received: by 2002:a17:90b:4b0c:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39b26121f6cmr11436269a91.2.1788540710785;
        Fri, 04 Sep 2026 09:51:50 -0700 (PDT)
Received: from workstation ([2401:4900:8902:9774:f2e9:38cc:6b1d:1764])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b6036fcsm8463943eec.20.2026.09.04.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:51:50 -0700 (PDT)
From: Amiitesh TSP <tspamiitesh@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	tspamiitesh@gmail.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: fix typos in drivers/staging/iio
Date: Fri,  4 Sep 2026 22:21:15 +0530
Message-ID: <20260904165115.228990-1-tspamiitesh@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo error in iio staging documentation from none zero to non-zero

Signed-off-by: Amiitesh TSP <tspamiitesh@gmail.com>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a b/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a
index 863d3856718a..d19db00acd1d 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a
@@ -4,7 +4,7 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Writing 1 enables the cell balance output switch corresponding
 		to input Y. Writing 0 disables it. If the inY-inZ_balance_timer
-		is set to a none zero value, the corresponding switch will
+		is set to a non-zero value, the corresponding switch will
 		enable for the programmed amount of time, before it
 		automatically disables.
 
-- 
2.55.0

