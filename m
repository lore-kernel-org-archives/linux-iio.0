Received: from out-2z4y-a131.jellyfish.systems (out-2z4y-a131.jellyfish.systems [198.54.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2023470EA2
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766893; cv=none; b=gRoYWvRVgv53HyOKhSjMHsaGumDmi9VE7XO17xPNVUxvxTfFdRwPT1oxthfAPK9E7pKYlGDbvDMpzcYN6KCOAem6bTh+EOvc0EXjhj+XXFaHvlBXFuEgBxC9xT6wnbP/tpz1Usm3eOCSguAyjbTwZy61eud5+9i1BmTfHtMod1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766893; c=relaxed/simple;
	bh=VPUFYZdlVAElE2+W6elbLSSYV2hb0wdMXIzDEaxaPHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYSf2QaBnE3Kgp8gMyfDkFFo8JT4JPSDfQYOnHs+6V84mUC0t/dE1SjMiOLzqp5gmKXZV5A2UXhtevqK2OA85enASrDckA7qqwmMffQEWdYdknjCTgtvyxONnfI9wMtrMEqDQIg3guZAf3RYdH1w9aaRRtgt7v2nKVIneHv/tEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hVXMv4jwzz8sWS;
	Wed, 26 Aug 2026 17:54:19 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 1/5] iio: light: stk3310: lower-case the i2c device ID names
Date: Wed, 26 Aug 2026 19:54:05 +0200
Message-ID: <20260826175409.326131-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The i2c device IDs were introduced in capitals, mirroring the ACPI
_HID entries added by the same commit be9e6229d676 ("iio: light: Add
support for Sensortek STK3310"); at that point the driver enumerated
through ACPI only, with no OF table and no i2c module alias export.
ACPI _HIDs have their own naming rules; i2c device names
conventionally use the lower-case part name, matching the devicetree
compatible suffix.

The spelling is visible: a client instantiated through the i2c sysfs
interface under the lower-case name taken from a compatible string
binds through the OF table's name fallback, but has no firmware node,
so i2c_match_id() is the only way for it to reach driver match data,
and its string comparison is case-sensitive, so the capitals can never
match. Lower-case the names so such clients match the id table, and
receive the per-chip match data a subsequent change attaches to it.

The module aliases follow the rename (i2c:STK3310 becomes
i2c:stk3310), and a sysfs client instantiated under a capitals name no
longer binds.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/iio/light/stk3310.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 7c8a1d2b2ed0..5b5b6812edc7 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -766,10 +766,10 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
 				stk3310_resume);
 
 static const struct i2c_device_id stk3310_i2c_id[] = {
-	{ .name = "STK3013" },
-	{ .name = "STK3310" },
-	{ .name = "STK3311" },
-	{ .name = "STK3335" },
+	{ .name = "stk3013" },
+	{ .name = "stk3310" },
+	{ .name = "stk3311" },
+	{ .name = "stk3335" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
-- 
2.55.0

