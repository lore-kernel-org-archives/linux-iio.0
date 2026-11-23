Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440336;
	b=I7pHXRUCUya+rroFTYtDYSSOeRvzPqpY1RZqaqA2CkExAxqtzGl2HmEwoFOfq7W4gh8s
	 xuCX+WL7gMfYoqpDJE19kDEH+yU+FMo2T/2XNELVG7ss3XjQ89VmEweWkYQNF2fKgd34V
	 YVJX56U8IeH8vy9IaMbmJEQGbdC+PJnzl0r9zZPixvaXlrQaHVxWr2jOmfrkvNESnEr8J
	 VVgAhR7rl3/GZNn2BersVfaU1TD+kfXnMPo5BpadFvp3WEvrwDdwajkmXe+O0s9qSdMCW
	 t6fxF4STh5b1p/JWdu4WOq1up8frAOS4uC0EpkhZfkJ91LINnHXbCY+bKgEVw6QDsCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440336;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FkBf6qqsrZyHDyBRt9YGRQiXsCrrDXtPwyJ0rWqsqxE=;
	b=Zbks0BfbMlqJaovY1vHdjEjB9kUsy/nVjlqwMVNSH4jBNl9sOV6bx6zNM2N9JmoRi/tV
	 CqlFnyMMjXpxG6MW/Vn/Zoxfi1Je7rrjr4B5spT39RPSW7n2QquPWwDmWY16Nwfse5A8T
	 CLd15DDPzJGQiA81p/y9Dmg70yDEJ9KIb8rZq8Sc4wjiCGrLg6w1CU9xREbJIJies4Kwj
	 f3UccnenCcjf8dT/YJPK1iyyQw8yddtP/QUsKShUR2EdjFQmFdzj7ir8TdbuzpGECdLar
	 EBCAwiIncLNJJ+eCPI1RxyC7xt7sGREriwFDLzWlfx5HBSBK5ZRqYybL/64MWRf3A0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GvmFhmA/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280A606A335;
	Mon, 23 Nov 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvmFhmA/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795440336;
	b=F34G3p+UkP/kJWVBCyDmD20EeTpzjGqYwr2M7JCzO2I5ZhhZa4OYycwfFKMA7b6in595
	 wzyJwx8x3isAhso1TuO3eKlmLIKHXzYpJLQVhHh8Jket2dZWX1yA9BAuybkAXFTZCJHBc
	 zItUVRsgalmFYEd6UQq+7G0qXkjxjPw5K935bE7dMYMLhdLBejv/edRo4ZNRrWbt43G90
	 naY4sedADSHdi0jfmRxENZRhaOxjgM6arpdn2cHayw77LM89ru0cRmNqWvTwPBflMBxga
	 +giYdefeIAvewK1KguI55leZ7rCvB9sDs8KGR98rzVWb+ho1ymhEdbrWX0Yg74qLVgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440336;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FkBf6qqsrZyHDyBRt9YGRQiXsCrrDXtPwyJ0rWqsqxE=;
	b=2A3Tc/+BbIFxW06bEcIb+OCJ+l+WzTsG9IFw2bHQwUjjMkc6VXeXcAuEtgP83KVgpgoA
	 2YutW0mNGC7wmsOKByNtbufKgEuPz73lAOgZBg3RRRpWlv++c2YBpFrqAjZ+dd+G2PrFU
	 H6SIM8DsdMQPD+buuI378QYyLtH8gbXAKzyS2SgvzGaiCxWWvpKMgUxEQLMgoARbLIfex
	 BddCsjrpcLZ1ieYbJ1IgLcM/N6pRhMAlgpHBwGbFWciTLAs2atCSrxvHuatc8rz94TVK9
	 57OAQCioI+bHUFo8HTAHshEbIT7swsI+K5bwrIhFh5t8hPb54M075d6OrF85WDn2eHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E907D1F000D3;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440336;
	bh=FkBf6qqsrZyHDyBRt9YGRQiXsCrrDXtPwyJ0rWqsqxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GvmFhmA/Erv9bVnFI97pnnub4/Hh0Af9QiAYhlafA0RYeu1WFBQDT2YL/N2HGLRsR
	 5d4NHGLOlhIb6AUrEb+IZZYD3BIfwGQ5T4Q2c0oJbg1uV0g3G7itkUa0DIO6bmtG0z
	 KT/EmLWfPjZ5uYSJyYIAVFP1AcDU/8w6KRufvWySi/o+AM3lxMMZvuoB1uo0u2dTSi
	 xAMXYRoIA/KG4MPcYj1EYteIGL3r+Fp6EsIbR5kHAW2PE/cEwTZygk/oN8gEW2rrpX
	 psrmKDvfrDO9ju536QgzCOB1BMHSaJuHxH/pLdVYtMt3WznV2bFZqlMurcamvPCm8i
	 Kbt5AwwcvrBUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 69B2F4C478;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 23 Nov 2026 15:25:25 +0200
Subject: [PATCH 1/7] iio: imu: adis16475: Use the reset timeouts of the
 ADIS1657x
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
Message-Id: <20261123-adis-fifo-v1-1-f6ad9e493e19@analog.com>
References: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
In-Reply-To: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
 Radu Sabau <radu.sabau@analog.com>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795440327; l=4005;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=ppM60eYFlYxENuKFnzc7MAMyPxIgDQNsNzoZAOE4acw=;
 b=QvlHsQgtTPrbaQx22b2H5WGaagKWp7yp1Z7ot1lF6yrYtI+kBe9oDVUtARcUp6CxccVkJ4rq6
 1piMeIaBIdEDHnxnFDt08VvhXnIikCf/AtJM6DMIOl31aEgb6/mdu7q
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

The ADIS1657x variants share the timeouts of the ADIS1647x parts, which
wait 200 ms after a reset. The ADIS1657x datasheets give a longer
recovery: about 275 ms after a hardware reset, 241 ms after a software
reset and 282 ms from power on.

Reading the product ID right after the shorter wait returns 0 on an
ADIS16577-2, so the warning about a product ID mismatch is printed, and
the registers written while the part is still starting up are lost. This
includes the FIFO control bits written at probe (watermark pin polarity
and enable, and the overflow behaviour), so the watermark pin is never
driven and the FIFO does not behave as configured.

Give the ADIS1657x variants their own timeouts, a bit above the typical
values from the datasheet.

Fixes: f95920baa066 ("drivers: iio: imu: Add support for adis1657x family")
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16475.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 5f21dceda8f7..44520d9216a2 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -887,6 +887,12 @@ static const struct adis_timeout adis16475_timeouts = {
 	.self_test_ms = 20,
 };
 
+static const struct adis_timeout adis1657x_timeouts = {
+	.reset_ms = 300,
+	.sw_reset_ms = 260,
+	.self_test_ms = 20,
+};
+
 static const struct adis_timeout adis1650x_timeouts = {
 	.reset_ms = 260,
 	.sw_reset_ms = 260,
@@ -1331,7 +1337,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 			 ADIS16475_HAS_BURST_DELTA_DATA |
 			 ADIS16475_NEEDS_BURST_REQUEST |
 			 ADIS16475_HAS_TIMESTAMP32,
-		.adis_data = ADIS16475_DATA(16575, &adis16475_timeouts,
+		.adis_data = ADIS16475_DATA(16575, &adis1657x_timeouts,
 					    ADIS16575_BURST32_DATA_TS32,
 					    ADIS16575_BURST_MAX_SPEED, true),
 	},
@@ -1354,7 +1360,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 			 ADIS16475_HAS_BURST_DELTA_DATA |
 			 ADIS16475_NEEDS_BURST_REQUEST |
 			 ADIS16475_HAS_TIMESTAMP32,
-		.adis_data = ADIS16475_DATA(16575, &adis16475_timeouts,
+		.adis_data = ADIS16475_DATA(16575, &adis1657x_timeouts,
 					    ADIS16575_BURST32_DATA_TS32,
 					    ADIS16575_BURST_MAX_SPEED, true),
 	},
@@ -1377,7 +1383,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 			 ADIS16475_HAS_BURST_DELTA_DATA |
 			 ADIS16475_NEEDS_BURST_REQUEST |
 			 ADIS16475_HAS_TIMESTAMP32,
-		.adis_data = ADIS16475_DATA(16576, &adis16475_timeouts,
+		.adis_data = ADIS16475_DATA(16576, &adis1657x_timeouts,
 					    ADIS16575_BURST32_DATA_TS32,
 					    ADIS16575_BURST_MAX_SPEED, true),
 	},
@@ -1400,7 +1406,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 			 ADIS16475_HAS_BURST_DELTA_DATA |
 			 ADIS16475_NEEDS_BURST_REQUEST |
 			 ADIS16475_HAS_TIMESTAMP32,
-		.adis_data = ADIS16475_DATA(16576, &adis16475_timeouts,
+		.adis_data = ADIS16475_DATA(16576, &adis1657x_timeouts,
 					    ADIS16575_BURST32_DATA_TS32,
 					    ADIS16575_BURST_MAX_SPEED, true),
 	},
@@ -1423,7 +1429,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 			 ADIS16475_HAS_BURST_DELTA_DATA |
 			 ADIS16475_NEEDS_BURST_REQUEST |
 			 ADIS16475_HAS_TIMESTAMP32,
-		.adis_data = ADIS16475_DATA(16577, &adis16475_timeouts,
+		.adis_data = ADIS16475_DATA(16577, &adis1657x_timeouts,
 					    ADIS16575_BURST32_DATA_TS32,
 					    ADIS16575_BURST_MAX_SPEED, true),
 	},
@@ -1446,7 +1452,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 			 ADIS16475_HAS_BURST_DELTA_DATA |
 			 ADIS16475_NEEDS_BURST_REQUEST |
 			 ADIS16475_HAS_TIMESTAMP32,
-		.adis_data = ADIS16475_DATA(16577, &adis16475_timeouts,
+		.adis_data = ADIS16475_DATA(16577, &adis1657x_timeouts,
 					    ADIS16575_BURST32_DATA_TS32,
 					    ADIS16575_BURST_MAX_SPEED, true),
 	},

-- 
2.43.0


