Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D13C9ED5
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884549; cv=none; b=MqXA+pgFsjqmkCmnBNOP1R4J4UFgXtXoUJC+SNH6Q5x+NynxMExFRp7ehgN01XtplKOa5NMqZeqqgNPMNYR/E2DOvmrGyiWkLAOPcwra5RJSRMrkUo2ZnDJBpw3svhmLaa+rayFrZTZV74Imu8qgowP6+4/TDokviI7by9B9+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884549; c=relaxed/simple;
	bh=wPM5GGcsQFVTIBDPZ70NRcd8C2Qs0IrujwLvCiOl59g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2Jl412be5mRZK/nY6iA6+lXY5mbewTbVKN8d2MS+gM2OJIiRG3GQdPkQwWUiIMnE5NAX/zMbpgXpvFmSrcyay6G75JKDCf6qXIFh+tTHqgggoUc8rqc6426dNj0ij+/k+Z49EPJcP9bdXbq527mZ/kreJeX0TORpWKl15qy1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Y0s+VyJj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Y0s+VyJj"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4631679f204so1617795f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884538; x=1782489338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bffnwId5AI6KcDIEhgyLtJOygYgr4I3ga9axIgTnSVc=;
        b=Y0s+VyJjUzuTrARFjyf5KAIRfvnBLQkBvnLW22IYhIYHV4TUsCleYdogK0TBIGUDov
         OIyFzsFpGFvZh4lcSEXYdJjBJ7yKIbliUkMHYBLNuMf4UyDPvFnVN8xGLKt+LuUXg/Po
         CyisWvKRdAOwvVCyzhS496U1Gvz4mNtmDnYK2DuiddTPdp7z7aTKr9PM3qDaIGdMHpVQ
         gubuIl2gsUPG2rvjNlKGvERSv/lv2lNUzVOxPcGdvCt3sk0zmk+DyVYKgfufuUpbPSlR
         NmhS6B0/kkYHCaXlj5KBOBd7UsfLedr1eVXtyPaK92RTvVDWxOtbNFnmJvRGOmxdjdoW
         8OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884538; x=1782489338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bffnwId5AI6KcDIEhgyLtJOygYgr4I3ga9axIgTnSVc=;
        b=XWmibSyy6wP4DTKRQASAEHS2N3b0MqwB3BxfN7XdXqLxrGZ8L1O44fJwIh+HwReKrC
         4sht1rrrT4jkBeup7MrhTmxCBX847QuWhPxFjDbe6dom9jCCHP5MarIlaaalfks84w9u
         AFhXRlTU/woDMuKwBSV68iaXkN3wikh6JHZ7041og8sK3eKu41qn3lWBuMUG8eMEBuHO
         aOKTWSUNHEIJX/BSJozD2sRCE3K8g7ULR04AFrOi/CrBle8K45ZD+7ZqcGe6KDk+SRi2
         bfozmqFSl4MOYnyL/DEleew+WbyfWAz630QrOh1uwbAfympQO3q2H2LBdxwzjOY3sDM4
         Vajg==
X-Forwarded-Encrypted: i=1; AFNElJ/lNS1rSHpTZ9XsErIUzWCYv7EEJZikSOZgxZ6Ajx6oSTGX7AthyCtm92Pk338eAKvku3GWOR6JwWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BHzRSXORwouf/zOfVOlUXy3s+BkoQAm87Jy6+pwllsy0yjVB
	TgEytzuJEI4mtc/c522IQqEYNSIXwK9XMgwZAm7pqglA5t6l1ytS/B6IA0RkIHIq3tY=
X-Gm-Gg: AfdE7ckgn8Beec+GGpSuKdOkcQrx3jSDYGIFrsKHtk7deIXtyQceRNu6vpN534wzqer
	TxH4TwbTFHf7FBYfW/93BAS6UzLoX6jSNBU4TnSCa5oc97Esm8vwVu8V5rrxRPHg6g3oTojM8EE
	I4lHzAzCblZUDkZAA6ZH6sGyY1PmALe4xXXq7qxsCJdYwrr7ZaKbLxvGtQQTuYgWsnPSHCTHtQO
	Gc7capJVy8Q4w1/8eB7HrBcW39zfyE2sMm126WNJQt0d7JKrvYzInx6J4kg55tIVOIGBOwoy8kr
	4mbx53pZ/Zd49b/RFtOeWMXqOJ+2LzHoYY+a3+3HSdVjRxrXhKHu+Y1y+Xf/CKZ1M59/Qs730Ri
	cWlPcXsDqNNbKz4MW0AD6HHaI8FirEW/3B0rOcmkIuFERIPA37QbXn2teau+dfNxV9ekAaVcnMc
	u3tmVTvTxBI/rVMfO4PDzgq2BOyJooodP75NayfsChWmRbKsn1BXgyNWkJfg3bKZH8dUom9TL8E
	io=
X-Received: by 2002:a05:6000:1787:b0:460:1c31:7cc8 with SMTP id ffacd0b85a97d-4651df0992fmr6429059f8f.14.1781884538281;
        Fri, 19 Jun 2026 08:55:38 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466648c698dsm48872f8f.16.2026.06.19.08.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/13] staging: iio: Drop unused assignment of spi_device_id driver data
Date: Fri, 19 Jun 2026 17:54:40 +0200
Message-ID:  <0322f4b8c30f04c0e2243f3a9da7382c68e588e5.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=wPM5GGcsQFVTIBDPZ70NRcd8C2Qs0IrujwLvCiOl59g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWZT6X9RNULTT8/UvEBxnTQtPbDJuko2y1EkI FjLVjN3GsuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmUwAKCRCPgPtYfRL+ Tq46B/93oycLDS4pk5NUVWw0JPXR2r3r/RLX8y3hmgjc6h0ooPOoBd19v7/bQM2pkLspXRH+ZfK FtvJjOu9gXyc8fIXDvR9jeFRGOVuCWCtn11hG1FDMkrvybEULEzglr7qjGNeFbPNWV+qiMJD7Ic qDErge6VUqiX0m2YXHeqqkg1W5TueGzLPYRSBJgGZCbTNCCbJ0/fDZ6WuQGXyvfvQQp3V6nYAx0 hQAuHHzW9O8/ba84UcBHVJ4e4EyPO+tq2LGeLYHTWOjsI4capIZTf45x3mcow0ZCYOlLPI0exyv lcNq+dKKIB4etam/0p6Bq6y0AHI4JiaWdLEHr7ZbCHSSgAaf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The drivers explicitly set the .driver_data member of struct
spi_device_id to zero without relying on that value. Drop these unused
assignments.

While touching these arrays use named initializers for .name.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/staging/iio/addac/adt7316-spi.c | 13 ++++++-------
 drivers/staging/iio/frequency/ad9832.c  |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 1debcc36c1af..459dd7416b1d 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -126,15 +126,14 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 }
 
 static const struct spi_device_id adt7316_spi_id[] = {
-	{ "adt7316", 0 },
-	{ "adt7317", 0 },
-	{ "adt7318", 0 },
-	{ "adt7516", 0 },
-	{ "adt7517", 0 },
-	{ "adt7519", 0 },
+	{ .name = "adt7316" },
+	{ .name = "adt7317" },
+	{ .name = "adt7318" },
+	{ .name = "adt7516" },
+	{ .name = "adt7517" },
+	{ .name = "adt7519" },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
 
 static const struct of_device_id adt7316_of_spi_match[] = {
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 659821a1e2cb..1a6666c1948e 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -381,8 +381,8 @@ static const struct of_device_id ad9832_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad9832_of_match);
 
 static const struct spi_device_id ad9832_id[] = {
-	{"ad9832", 0},
-	{"ad9835", 0},
+	{ .name = "ad9832" },
+	{ .name = "ad9835" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad9832_id);
-- 
2.47.3

