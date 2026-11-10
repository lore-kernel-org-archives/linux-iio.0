Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794326250;
	b=h2b8gatAwHvrlkflV2lo66TWBQV6MXiBTyEgiMc5j64TGGVCHYPaK0MGqY478WeDJSSL
	 xUS0fHEF0/iU5NfRImGJ87XYZkEY2BkLiTdIy9fXzWvCLM/Uei+LlNRJHoFj5We/SyApy
	 60zq5JZAu4EL8mQYKCXjrfFkdJ+e1x7S2y3bGcyZ7G7jDMx8bMwbFb9SoFaZ/vpl4ca5Z
	 piGfZpcNDJ1lHlxrVG47T90qipwpz6dOKDZKJUjXnrc/5WEq/45ZSNq1qdE8zNDSUHyHW
	 bYMJvo6KDeL4yfSgulTDr4ad5PDfMq5MV9x/1VqIsNrxbFg4ygmo+mM2OgbLX7mvjNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326250;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=39uN6QVnkekX33X3HSTIkP3ZnGG9y+02IyW7mJHRFNc=;
	b=3xvXh6VmrY0qJ6afXjziytPx2vby9OB0YYeAVd93V6MTx7ziSLNVAg2qzW8YWUYCLMPv
	 AzYZdhCrL6QALtItlMAQLi2ec6He9uzoJo6qq7rllEiEE24sW6az2STpjUcB5mEfpuvRW
	 BcV1/Bcz81RhbZxfpWmLgzItNz8zhcoJ2Yp6wqHrghiHvmcN27rHIsNlXNoxQUKS0DSQU
	 RdlMJ2J9PYRoK8bYJcTGJL2o2B9bcm3w3lTBp25wvDPoj6WTI6XF6m9XkudFUL7bE/A7O
	 1PjU4Ke3RK84aGugcAe8bAvLe+Ffl7RbcZCikOi4ENUahBIJL2dWHrjeB+VytHN3rPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juvJTzo9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0494606A31C;
	Tue, 10 Nov 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juvJTzo9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794326249;
	b=wXC+NY7GBXS49Z7I9it7wrEuNfPgWB6XNMZLSpIT/sOPprphOgTMzENqRJYwddGTbnLb
	 y5gWf2oXiaOdBrwOeq/VYnQsRNqEN5lYJDC4ZXL8Ypge8mSEQtLUs8K8Uic6TnEg2Dc8t
	 hnTDfkPIAIf10grfjG2RFxwpWL9P2sl/WckJKqeS6RTWNMXTuOIqjhUK4+ru79vAkc9B9
	 pmnIjINKHpE6EG6nZdRLCzhrvH9zDFnBBkuOGJ0ryZcFzTXCIcYNH//3hgI7O4Lggo3Fi
	 qKSpklI69Fes8J+fvXb++dZ3VM//ecHEXgUOdxvOLftdyYCF0rDls4IFmYN9AbxJfZg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794326249;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=39uN6QVnkekX33X3HSTIkP3ZnGG9y+02IyW7mJHRFNc=;
	b=A5PaY8FGVVd+RXEkUlxlMo8CSpJnOqxKI2NN7fZ8pwrl2Ls3EqZHS+1QaopH9tvDBqLb
	 8YBXCFQZmkJG5GynVhBRQhgrytCnU/m8tiDczKlHfM9ah9VkbtmKZ/F3UyC29knW4gI+0
	 tYdHQTbomr8x7svQEEoHroTIELSgwgZn6PK9yqjYIa/rX5k+3LAoHLPJWFRlde/ZV8oL1
	 OVQBBVBypj+1OLMsZk1Qbnf9zAHDFdd2QE853Q/jUOa4TqKtwPkwfBgAac0RdW1AveADz
	 cy1u2N3cIOg0zlns+HTOeqxbttxpn+S2pmci7ygeeDl3uGUAnUSfQ0Uv6+p58ToNfAA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ACEDD1F0089F;
	Tue, 10 Nov 2026 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326249;
	bh=39uN6QVnkekX33X3HSTIkP3ZnGG9y+02IyW7mJHRFNc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=juvJTzo9eNzna8ByYEiU1P6Jh9l2FWGz0IhbEtmf+VJYrv1DWCDV3LE8xMHYZJ/PB
	 hXkIe1xGh4d9jAZ5N0etiFaUaAdrWRLZRctDpHS0orqKjWDjJlO5k+v7jzhm3Viyva
	 O0rIsSVw3YJ7nsjmyak519+tyTjA7W/zXS79X00lVrv/hQ6XcuAL1CpgeVVgnbwbPR
	 dLZrVW6sHZUh31cXnlje5nOfYcxjfcd5TF4ONp89+gNPcgLlGeAlFAvVUUuCzPMm9W
	 onQZgKAm3AUpyWxy2gZWU1aP0y82eyMnqIuT+jtXQIH8d8D5LIrVgAMf6iEngSlBle
	 E58HddBCp0HYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 12BC948BC5;
	Tue, 10 Nov 2026 15:57:28 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Tue, 10 Nov 2026 16:57:17 +0100
Subject: [PATCH v2] iio: imu: inv_icm42600: update gyro start and stop
 delay
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v2-1-c6f5d35290d4@tdk.com>
X-B4-Tracking: v=1; b=H4sIANw+82oC/52OQQ6CMBBFr0K6dkzbYCOuvIdhUdsBRoWStjQSw
 t0t6Anc/OQlf+b9hQX0hIFdioV5TBTIDRnkoWCm00OLQDYzk1wqwUUFRA6on4CGBGT6UirOYRq
 tjgjt7B2EqH3M6Uaw+NIzqLPVDQrFpeAs/x09NvTenbf6y2G6P9DETbQ1Osrnft5HJbH1fn7J/
 /AnAQLQnqSsuC6NLq/RPo/G9axe1/UDm5J4ogIBAAA=
X-Change-ID: 20261019-iio-imu-inv-icm42600-update-gyro-start-stop-delay-68dafe160210
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794326247; l=1876;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=wbjCfT8lL7PclacDYR3DRKYlOUIY87724PnXNhJLve8=;
 b=6wUpx8Kg5KkPuhX+hmbhxqIfwB80/mW6VjatkPKupXnqAS8x+G1WNdRGgYGtZGokSNi1LlGeL
 ndBOIuVJGPTAS0HS9n7AEKQuqulhEyV6/C+LgEbILYyqdHWOb5Lwn3+
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
Content-Transfer-Encoding: 8bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

From internal specifications maximum start time for gyroscope is 45ms.
Stop time is required for letting gyroscope mechanical structure settle
down before enabling it back. 50ms is a sufficient value for that.

Update values to these numbers.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v2:
- Do not refer to datasheet since these values are not available.
- Link to v1: https://patch.msgid.link/20261020-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v1-1-ed52290a4ca4@tdk.com

To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3737e79dbcc1..c4a928fd3b8a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -439,8 +439,8 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_POWER_UP_TIME_MS		100
 #define INV_ICM42600_RESET_TIME_MS		1
 #define INV_ICM42600_ACCEL_STARTUP_TIME_MS	20
-#define INV_ICM42600_GYRO_STARTUP_TIME_MS	60
-#define INV_ICM42600_GYRO_STOP_TIME_MS		150
+#define INV_ICM42600_GYRO_STARTUP_TIME_MS	45
+#define INV_ICM42600_GYRO_STOP_TIME_MS		50
 #define INV_ICM42600_TEMP_STARTUP_TIME_MS	14
 #define INV_ICM42600_SUSPEND_DELAY_MS		2000
 

---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261019-iio-imu-inv-icm42600-update-gyro-start-stop-delay-68dafe160210

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


