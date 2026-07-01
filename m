Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAE48AE20
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920627; cv=none; b=jET4VD+iRZInCR0iQqc29MmSg17uoGPx0JLOuKo8SwIAx80BOBRKYybO/Cre/yKgSH3GXkDZFLlMzyH8kchKCyy/5+4QREdpGFu9QLUBpEjZzxSL9RUp/M333Y0oyM3oowll85ylXqfIbY2S3tWoNSbzsph4r+LlpKpKVyOlY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920627; c=relaxed/simple;
	bh=d4NOc9YNbJ/JhYhjRZWX86swlQUFSu6XSeifKNwUOK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYZZVcB6BDqX6VtmFeR850UszEGaA6b7BaAhkuB9y93vaCx7kVEJrzVaeiKaIPnakuTryjttKQisOHKn/HBxC5HfovlDutW8ef6bQB3WQIEj+ihBMnCkNoKyUcz1LGGdHWRLuGuc044bqvmz8Am35XaALrTnME7y+NlGD7GyoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phpCp3Rv; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phpCp3Rv"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13b2d7dc8d1so973239c88.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782920626; x=1783525426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piPE4JfsG2ylSd4ODtECXlwBBWCmK9/TFrXLEBNRABU=;
        b=phpCp3Rvwzb5vS5qT9c61QE4+kJcD48otmYdSUhbKM81bBEysDIFsG9nJP1fOSpIib
         T82SJOP0g51cBcEA2G73+tGny20oDX+y4Udol/a+/5712Dxxi3TM9AnUfiFkAenZfD52
         wOcVEHMkIXVRkkeAHi2VN11eqqxPR9ZoaICznJX0k+BkyJPavIX5Td2A1r6TwUso8rte
         J5waKYt+QTbmYtfRPzvqo2ckmUhL5q34tOSbRMv1yMOWjXZg/e5H1J+ZI/b1lwbPn3Nb
         mqL1jevbIgeJxyFWNezpWE8iQ1mdf5hG9SNtMXSKI2BQSVEcma1POuPAeDp95Q4dICO4
         9HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782920626; x=1783525426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piPE4JfsG2ylSd4ODtECXlwBBWCmK9/TFrXLEBNRABU=;
        b=bOC9Bs9pBix1FhOj8Pg9KbefILtQ82qdI5Z3xDeUyIGz+1yEbMky/LkzH7kwkZLjh7
         CDsTmWpqEn53z4EkdIpDXnjw2AOnsf4Qej3S2ozY8q2jS5o2wzyKBjz9CXNbqOkRavP+
         CH94Dlyv9hoj2driIDPPfYs4lEM+r5+HOblkaSmwE/llW5qTXvgrPNXYLR4K1tdUKGse
         jo72bpcvZfaio01+bkvDcnyi759rA4m7cU4L4K+datzRTmeHFsc1O03E208R+fay9zXK
         H3WHdGD7EoXH+tGMGD5MwQmxce+UMXjXD6gd4GWeDLzGWIW4hi7VXciwOBHNF2n6/6gT
         RB7w==
X-Gm-Message-State: AOJu0Yxxqx6LH4S4LeU8yrR25yXLiW/xb4eSsUP1v70wyCg0tYILEpv5
	9tWRfgaMu+7jck6Ffv4TFwjIOA5tyTQJI1FDETddqgdpoDFdCqkr03jy
X-Gm-Gg: AfdE7cloYhfqj+N3vjndrOkdzBi2V7NBc1w3+QlT4a8s8xpvWCYHM52+xxpqM2f23gh
	KCfJcCDe7znQolHeBXUJAU75CUwUKueHneB7VHN17KDjbJsimy4j0PyQebjCEn1nnolWWlbVZnp
	ipqgwkvimFTFgR9y4n5P/ASGrGePFYRtR2uhRVsAAp5NJc3gcq9OZ+xLELKQxmAiUCwQ/2TeDRl
	ku3btPDjzROmSXQxXxu2uvehsRSodYhsgGCn4D0F1kdSFXdVLD1XCHUSDWMZXaCpJTMZo9F35XT
	4xUz/eZW37xkpqZEUBFMqvqCfdQ0iZ7dulw8/egIub7OudrTFwEJT9uLf455B9s5Z2CmqWGEgTT
	4lN58ltQzZhG8627V4bVnHyg5eRwcRYPYbcg9OeL4synzz+/07aDJJIMBVlxFEt6sFqbgktdCKh
	pG/31JJf9eqYc=
X-Received: by 2002:a05:7300:6408:b0:30c:ab97:d7b1 with SMTP id 5a478bee46e88-30eff3868e4mr2683605eec.43.1782920625918;
        Wed, 01 Jul 2026 08:43:45 -0700 (PDT)
Received: from ZepGo ([49.230.160.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2fc12e7sm21299054eec.8.2026.07.01.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:43:45 -0700 (PDT)
From: Kittisak Boonmapa <goorock.goopop@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sakari.ailus@linux.intel.com,
	joshua.crofts1@gmail.com,
	Kittisak Boonmapa <goorock.goopop@gmail.com>
Subject: [PATCH] iio: hid-sensors: Fix poll_value sign check before msleep_interruptible
Date: Wed,  1 Jul 2026 22:43:19 +0700
Message-ID: <20260701154319.23497-1-goorock.goopop@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_sensor_read_poll_value() returns -EINVAL when the HID descriptor
does not contain a Report Interval feature field.

_hid_sensor_power_state() currently treats any non-zero value as a
valid delay and passes it to msleep_interruptible(). Since
msleep_interruptible() takes an unsigned int, negative values are
converted into very large delays.

Only sleep when poll_value is positive.

Fixes: 5d9854eaea77 ("iio: hid-sensor: Store restore poll and hysteresis on S3")
Closes: https://lore.kernel.org/linux-iio/CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3Lfyoj3RaZ2v4dg@mail.gmail.com/
Reported-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
Assisted-by: Anthropic:Claude Sonnet 4.6
Signed-off-by: Kittisak Boonmapa <goorock.goopop@gmail.com>

---
The bug was discovered while implementing a custom USB HID Sensor
(Accelerometer 3D, HID Usage 0x200073) on a Seeed XIAO nRF52840 Sense
for use with the Linux IIO subsystem and iio-sensor-proxy.

The device intentionally omitted the Report Interval feature from its
HID descriptor. This causes hid_sensor_read_poll_value() to return
-EINVAL, which is then treated as a non-zero delay by
_hid_sensor_power_state() and passed directly to
msleep_interruptible(). Since msleep_interruptible() takes an
unsigned int, the negative value is converted into an unintended
sleep of approximately 49.7 days.

The issue was reproduced consistently on a Steam Deck LCD running
Bazzite (Linux 6.17.x), and disappeared completely after adding the
Report Interval feature to the HID descriptor, confirming the root
cause.

This patch changes the condition to sleep only when poll_value is
strictly positive, avoiding unintended delays while preserving the
existing behavior for valid poll intervals.

 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..20099614bb27 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -143,7 +143,7 @@ static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
 			       st->power_state.index,
 			       sizeof(state_val), &state_val);
-	if (state && poll_value)
+	if (state && poll_value > 0)
 		msleep_interruptible(poll_value * 2);
 
 	return 0;
-- 
2.53.0

