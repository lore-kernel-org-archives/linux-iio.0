Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FA3E0228
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178422; cv=none; b=jZdboHjreRMQEy03o/m4ku+3Qmj+dCzm2x6wSyvpBdGGkze2GJrk+11SmmcdebGJgcL0stgW8AZJYnLzqvpSyU9YwhIOh1Ch/NwW92mcb1Ncwtk5fjUxTCl8zV65i3Bedni8u9jjxd281mI4PDAwMAsYcpezk6la9vE6J7geMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178422; c=relaxed/simple;
	bh=M7xMzDDwZ/A1sgg24zdNQRb81VZaFn4ErBaEK5dALkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLtMAl2V5H/QqK04j0hKQYnVIO2q/mu/wNmxekVufXMf3VEG/0qJ5FVtGCqQgQbaXjRoIuvapEquxEghb5uAitlYg2LZ73WQrsQvahLjdVfJn1fs60F9l9Q8sAgkXc5WHTIlFFWGTdy4oOfAWz6CcjXvTGBrMmUdDxvfS3dFwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Dw/uwLFX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Dw/uwLFX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so31870255e9.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779178420; x=1779783220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFCO6IJf3Mp2M4P0MEbky1yuVhpsld0HPMHntoVtX14=;
        b=Dw/uwLFXGi+mYD1HqAGORhmE3fG3iqCVzKfIVLM67hi43IQdnigpXUVunyxkGKx+Ra
         tzxv2umYHVg9Pe9T0E0KZSy5q1M2HJvF94AKQJI9bFt4hX3GYcRj6cw0Vm5uRntw6Pi/
         co6U5+wcDWFSEOEypPvUwE5SukWQol/+FXUjyQvNTB2umQchxApxUKs8xLDtGByPIA+V
         WUjBEJOXbs9WukGZmT9Fm7KQfWeFHEQm6+XYJ1XYlbjLuqu39Nc/sagDGm9tENs20Jrr
         OSM1FGvD/thu4crcVhQca34ErOVETAlWEoUkdp4H/K60sCwMoh/Uj2iWRxDJGO/BDSLJ
         ixkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178420; x=1779783220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DFCO6IJf3Mp2M4P0MEbky1yuVhpsld0HPMHntoVtX14=;
        b=S4W8gdl3mY52NyBDKwtqp20K6eruSpIb/7BTkdMq8TD3vvGZeeMDbY11I1DQJbQAxW
         Wo8f/5wye0xNLF2j+xGFw3uaA28DnZGXwCjwHcY+d1ZZh7RU1FxILY9wr9oBITpLjElT
         7ghmYJ7jec1rXAPEd43W4vTmdPGhDoasrnoCRj83QfRX0xWA2lH8vJb0ZWTZDi8WHutn
         m0Q11zAw+VDOTeJbQgKffrnp4/kcR/kwlprABk6SBVs4PU0gMWnrsyk2Z+5krrppNY0N
         jXo33db4+5+UVkqB/qUJodA+arkVPRKXO/9iSDFqfcaMdZrlYrv7ZzkdCY1jsq44Ouf6
         leiA==
X-Forwarded-Encrypted: i=1; AFNElJ/XdLFdkR0YoIBsaB5KTR8ku0CQEFhUWtQQnZmFQvu80221bvQ6V3ePIrJUTVYfy14xffy47rFfKi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2jo0ELZ5i+3uiciBj/1gbWrLwJF32LW4T2AorU3XI89tb8ZA
	uG1tkR8+NLWlZbIvzj6BevkyzIOmsDNdmHLu1J4Tx+Cc717eWpQMVEdu8uwNZtODzYY=
X-Gm-Gg: Acq92OFrWapX4NYhwnNW8HWAWSJCQ7wRhlWe4rURxTpf4nNAPDYNUsQ4Sv3QKcAV2jQ
	J26Ok9qlUa0le2SgJ4R/Eeq30GKpqMSiur3PoPg7g/Ok3k7mno21CBwSpv2lADdNConCRc7eygK
	UFBHnxF7odUrmI3gCnwMe0Q2dGU/Ersp2IRXjY5N5277Fk57UC1Q2qIMdmCwrZTPkgjgRmzdiiN
	F5IASgZB3F8rJo0Y26Z0OOUxwUyCTZ+Z9NkmXVPS8AoPin0cOFu3/UdIYrA/x8aDcY8vWvePAM4
	GoCMVXSNHWyOxYFKIqW9mZaBy4GvId4rIt1Y0s+Me8prWVzN9c3piW5Gi9qxDkA8NpGMeOmnI+Z
	0/ER+mvcv38xzvBjcxvZnSYGJ/UV/BUjBURK6615GCg2HTtmstsf0FMrif8OZgcg/lzK93GsLmL
	0PSPX/LLr6I2YJyjzJyb4Nk+YAfxgkwgqKZL/QIh83UUdFjko+rYkGOE+CjJZZyjGgyko+U5RgO
	5VzpQqHn+K70/4=
X-Received: by 2002:a05:600c:42ca:b0:48f:ef34:7ec1 with SMTP id 5b1f17b1804b1-48fef347fabmr151252405e9.25.1779178419821;
        Tue, 19 May 2026 01:13:39 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45d9ec3acf7sm43677040f8f.12.2026.05.19.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] iio: accel: bmc150: Explicitly set .driver_data
Date: Tue, 19 May 2026 10:13:04 +0200
Message-ID:  <7ff04e7dd864ed05df875174a29ade662135b683.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=M7xMzDDwZ/A1sgg24zdNQRb81VZaFn4ErBaEK5dALkk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDBudV8zSZVUAtTufVxfKRzNVq+Koiayb08YkV rhH1p1Bh3qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagwbnQAKCRCPgPtYfRL+ TnbpCACsJqVs2rniMz7FIJ7GZgXznpMlf5kG4UQmKI7Je6AcjOi07MQIAg2Q6Dl4wee51WM71Ah jU8pcdDz6Xl+R6o2WZvpHcKvoXt7W4kyv7B89HVJcx2XNeHAswdzI27/J7ZjbuxRvksPSCD5S0X 5UbR2uYkW77Y66ktSItIrrcoQE/Rz0M81UmzlmCGoUGK7I0M9UNQ/SlWJmG+zuTf1OfspkV9dl+ /STncONtsmxcI+MC0ntrVTlfRR5MX23Ynm1BHTES9Xzu2mnV4d9yv96rLVlxpIXDa0i8t8ZQC4I aXLXi2BA4qqU1giWjNE5Nh98ZFsCOwCLbPeBHUldgxh1Lnt5
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There is one id entry that has an explicit assignment to .driver_data.
To make the intention clearer, assign BOSCH_UNKNOWN (which is also 0)
for all previously ids that had .driver_data = 0 implicitly before.

While touching all entries in this array, convert to named initializers.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/accel/bmc150-accel-i2c.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index b4604f441553..3315172742d0 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -245,16 +245,16 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
 static const struct i2c_device_id bmc150_accel_id[] = {
-	{"bma222"},
-	{"bma222e"},
-	{"bma250e"},
-	{"bma253"},
-	{"bma254"},
-	{"bma255"},
-	{"bma280"},
-	{"bmc150_accel"},
-	{"bmc156_accel", BOSCH_BMC156},
-	{"bmi055_accel"},
+	{ .name = "bma222", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma222e", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma250e", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma253", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma254", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma255", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bma280", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bmc150_accel", .driver_data = BOSCH_UNKNOWN },
+	{ .name = "bmc156_accel", .driver_data = BOSCH_BMC156 },
+	{ .name = "bmi055_accel", .driver_data = BOSCH_UNKNOWN },
 	{ }
 };
 
-- 
2.47.3

