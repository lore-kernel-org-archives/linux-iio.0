Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25253C4143
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884541; cv=none; b=WsBRP+QYIx2Ugfg6PuZpKpYJHtxwoIeGkEBv5/o4SKq1So2I2BIYCuf7uB4/wqt0SCHrlkhW+O7m/9JKauySt4d5N9nUHG+0tJKAvkrTs+33LSVBDnyb87RhFEg4fMYz3T2+0i5u5LavuDoyvQliSuotjf2aKLTSoYHetSefR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884541; c=relaxed/simple;
	bh=UUe03ZkNGosoQ3KORV05/9VmenjZHA2NytVpBOOT0Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yl5NPiaVBwevTox4IWqSklanXcIwYLQZH2sTesNmCcFHBU8z1EWGMrEpUToD12snM3iVi/pLVtEW4JomX71AeLpOowbJWPJ5Cn/lFL40WxnarS3/OwMfR6U92K2S+h3rQFlzUCZ/I+rx6ww+S1x6ELs47UeqzKzg0ZxxhRdaFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QO2p9FWr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QO2p9FWr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4922244f7c7so19079515e9.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884532; x=1782489332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deDE19nz04ib/fm9WmlwsSg1wMN2s3aZ/eqI7oBJT5E=;
        b=QO2p9FWrgzWxVFbWs14MbaCBHPktaK0IrfAe7lHACadYx/MZY/AOf8B0ogqyWimHqX
         312asxzufphIgQ71h3DE45AxjGF4c/MSJEu8S7YzyiwiIRU4j708uaTx0ZWJdc4PNtT7
         2Q2jNtH9QjCICO0XxXchzy48trA8soKQ75XSIoPjHtEW08Hr405BTCzn3C64kkwynkvc
         frlKNoy2PPkyIYfVsfWtrsgJb2gXDpzd5iR8QJLKGahrltIasdD/H46rSHUnBXmMEj73
         idmiKFhBHrvUgOD472U/Z3ZuojyrZthc5zv6GvLarc4gVqM+rZbZLLOe/hUuoc6waCeg
         uaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884532; x=1782489332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=deDE19nz04ib/fm9WmlwsSg1wMN2s3aZ/eqI7oBJT5E=;
        b=Zc32lzMr+h/lOTMdPgTPSw7SLbKTZws4PcEgLKHuFPL0tF7LRZ50a0Mp5wy+Fvpi+C
         55zVScUrmJDvsT22OUTjKd/x+/zKKLqfZEYokePvkgGUXqJ2i1IpH9p3EW/hn2s7ivyI
         XYFCZ5SzpXNfLE+lIyW/z+4kNeRHOCfcyr0Ak8bpvTnJPVT5YN6UywC9KzteMhQ6aKKx
         ErN2kRRZgqs9bzCSDxSChf7R80HGMFQhVSHomasmmKZROTiroVXzoxtzQjCTZT7QF6SK
         yKksg0ZVGwt+fOaym80xdFKrf64aeEBD/x5+RTUbOBbJ9jRmKC1uP43VbjxiUC9V4omC
         7CeA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZxTt5yNqq9E0H6E84f6FgZEpA4rcg1WM6S8uNgaArJ01me3vTYPeZPNccvZHaV8i8YhmsLuikakM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+FYRVtNnK21kS8aPGlE+caBTDiiLHd1ECQLU6qeebSmftcXM
	/5bkvtt6029Y3DUivk2qgzCcyK2kVO/njPgBucAvSsGklvSWQd/fHMXYE5OOjSKbHFo=
X-Gm-Gg: AfdE7cmU3tOkSKhJsW6YZ7W0yUmfBZtnpFl1OwDGT5AqrOkW9sPT1ddfZ52kAX9zqXN
	/J2MYln/uFxRF0/8gcK0sabaLEDjSfn8wtXquFEnqNDUeEtxJSSXEJRA8XfrZDMMrhDZcUGXoxK
	8roicrV3fYETfiW2NW59rDuV0lQJLOeeIlBH9AITjvStdmInCR4FbMjW3h29gRyBmd6Tc5nfYEi
	ybgU0jdKuUFmVXf9E1HZJz6yZtpWO1sBtYHWiH4ZarZE/cfHNs/8Y+XWAu+TxTRe7CQOLWtrRkb
	PNgFeyw3R6VZX2s3Busa4AfTT4aHddkyfbSZUEuIzbYV7oe0eREkxZZmiVJX3qOez7RRErizLzD
	DZXjydulztZ8tXOgCShv8Rl0LTF6gN5jQVJLvXU6QkucVZRQv3evJlKu5QLZSmooqmnuaWU4CLF
	ggTM09/9Zs1vt2pMP9FKd+U5AoE4ozcWWFw44k9tzPpOzV0zCuAiPBg7YN9xdrPPVMBt58DzKlv
	8A=
X-Received: by 2002:a05:600c:4690:b0:490:bbc1:d508 with SMTP id 5b1f17b1804b1-4923ef47ddamr80947715e9.1.1781884531755;
        Fri, 19 Jun 2026 08:55:31 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466667881bfsm2847f8f.22.2026.06.19.08.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/13] iio: accel: bmc150: Explicitly set spi .driver_data
Date: Fri, 19 Jun 2026 17:54:37 +0200
Message-ID:  <2f0bfff94332c5d42f29b33556bb6ba95935408d.1781883685.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=UUe03ZkNGosoQ3KORV05/9VmenjZHA2NytVpBOOT0Kw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWZM8GzdxIjKbFd9mgexAVGW7WcLxKGey4saS 5df08ZlTESJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmTAAKCRCPgPtYfRL+ TojZCACtDZiUYQ9D2b4JKNn6uWgOjMZgiqvDsnu/CawumIDjOiJplWqIPA3Y0w0JfNuFSX/lilw IWQAUz/Ln6VzIANhJ2p07S9FiqgAFrLDGxlIMuQ7wrue9tzaAnZFHotESIOnZodKBG+ADV87AIv Sg2KkUCt5x9r9LCAnhNfXHSx4gELvibwuX7Xl3suCLnn5g0owYo/yDR6Inhftnjiv4bYFvsEFDx JLo7Kjs90/4Ax2pN14rPOcBNpZt3OMuWv0nSFdJR7Qdpr+WoQe+UnS7iEZL9HMTb2UtBljQNbGg wVEniaN+vEbH2VxYhBrEHF4bRTx97sJg9waXiDXCzM5VeYOc
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There is one id entry that has an explicit assignment to .driver_data.
To make the intention clearer, assign BOSCH_UNKNOWN (which is also 0)
for all previously ids that had .driver_data = 0 implicitly before.

While touching all entries in this array, convert to named initializers.

This change is similar to commit e50856dc41e8 ("iio: accel: bmc150:
Explicitly set .driver_data") but cares for the driver's spi part
instead of i2c.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/accel/bmc150-accel-spi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 26ce50b37716..6488d4a91c08 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -53,15 +53,15 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
 static const struct spi_device_id bmc150_accel_id[] = {
-	{"bma222"},
-	{"bma222e"},
-	{"bma250e"},
-	{"bma253"},
-	{"bma255"},
-	{"bma280"},
-	{"bmc150_accel"},
-	{"bmc156_accel", BOSCH_BMC156},
-	{"bmi055_accel"},
+	{ .name = "bma222",       .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma222e",      .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma250e",      .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma253",       .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma255",       .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma280",       .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bmc150_accel", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bmc156_accel", .driver_data = BOSCH_BMC156 },
+	{ .name = "bmi055_accel", .driver_data = BOSCH_UNKNOWN },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
-- 
2.47.3

