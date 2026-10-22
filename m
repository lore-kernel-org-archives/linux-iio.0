Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682350;
	b=XrZuHQ1l8W6YGdEq/UP8YGU+VR9fGEelAm2ZEv1bwp4y9lmscSEQbRsSeJkMs2C46mHB
	 xWcEz+l0e+2BX7YFtqGv1gKX+P78twcSzPHZcH4vBnbQns6ar0B2zJX5pLZNgZr03n76X
	 1Bv24h0Nro6FyLDHziLAeIYIVpYeNn4JYLo9ycu07ea4JnmmwlRSIExgRu7+yUCyUNQLJ
	 SvrphK7HayrUufYimleiHtjrgbW1ePYveFb2NCtLzIIarByClTOYxFbt5QwLDasLQXsT2
	 n3f/cgUv7ZBjfwQCDjEhi7b6PD286zTL45xOX3NroK00H4N1oldFH5k72azifmnnRzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682350;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	b=2B/4hqSQGkGxVc7sr+iPQCxomLW0iz6jCh8ejSd5fCNP5wkGzm6008ZQXa2RW+aZ//mY
	 fCmEe7EPlolnkP5yc5QJzcOJ5RgKevKr+JN0itKXmcVi1mWeTi6HYzdDgd9t5q5tJ8yNI
	 kLpvhOPCGnh9cLC7fOtD+Pw2pXltiwceK0aqq06fhZEgSedJNDIWrqApRgJOWpgpvENAF
	 x0jMKVoKd+3Yf9jjjpsnLE5bmKT2uCv9Fm3BhHZBGQpIZmo0V+wXGKximiqnLrfrm50mC
	 pni2Y5Ow0UgWessLDkv+lVgesnFtFeXmfnqR0ltBDeKtDfuik5qd/y4BUrC8gbhEhMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpN75crW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE715606CC43;
	Thu, 22 Oct 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpN75crW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682349;
	b=ifgZGx5BiqBeTWrnFqt60Jghy8Nmkx6IVCE06RKhauZjg3sjTQY//JbK3PkEK+FLNKdI
	 aQldORaOpDWsbG0hCvdj+1bL8rU6kqB35Wu+MoGrQ6blELP0HUPlBr7zNts/TRp3xRWNp
	 O+WfD0xwtHl8Qj1LKkkADl3pQohi/IYBT4Vjk1cb0pu5nwGuGATvrajibWyotOxFWUGUX
	 M8bBG1ajlVepHSqQK6qw/vgk9vtUe2HbCdLbERsZFOcZHgy/41LC1BPZNJ9/BN/CbyfrL
	 8zKplgxz0zJNUm2H+TMXvmWMGiktMAk3TXDbKChHeZ3aIEWKbH/UI8nszzTEGM7y3XQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682349;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	b=ge8RgnS0yBXSczKI6iEjndzjeP3KjlIO1VfV8bL+scxcI7VGz/uVLH9oGEunsCBF35rl
	 KDo7D9qnZB/AEym2bo2pbSZVY0EoAN6vMDCMhoVx0UjQCTOI62+8cCYiApg6i9k37Eei8
	 siVrITt1UQm1aQdutsM/FskMY5RJj9LuwMCSlvl7oyhQ0fTt/JHmqodOkD3GjuTfE+6Ar
	 zDxV3uXZiSwbD9D7Tf/OT6s/7AYKJERCGewO10BHHOhOMqnRA7b3CuQd9UQNpmAt3KxLp
	 QxUVWtKQ4n9pXpzGbhYdD/aees7n8SJK1PM+MWiK/thJtRKmn0CgoOD5KQXZs10efqA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E5F141F01828;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682349;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bpN75crWXyrGU6vEOJo0LqBTP6TdhqcZnzgM391FOlb4yY8nfvmSJpWOUZmeCGbnG
	 +glc9v9xl9IEOc96rPOvAM1VkD3uwS7HvQBRFtgpnNWczuJ/CokH59mFv0Z7kb3HKC
	 mRdUFztPbPAu8dSaJo1+z7mRUL5EkHGYnCQaa0wP2tDEHQZAKItxYlTAIIASZkhxQi
	 ojvd5JXTGGVgGlmd08A8YJgqg2NAROodQ+lQ9tiJxnPL6QBqBxmeJ0mgWdTSZb6Sx/
	 cGuWA6G/k4JX0hxSCSDAOcc8xPZKxahWz6WjkqDn5jNnhUrMfYnm2FT7mBazAsDoy/
	 ocH3KxyjvaQ1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6F94241E4E;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:18:59 -0300
Subject: [PATCH v2 01/10] iio: frequency: ad9910: powerdown fix
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
Message-Id: <20261022-ad9910-backend-support-v2-1-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
In-Reply-To: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=2077;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=aJtPIXmw5LGBhO6Ijl0bIJNuEuTO3aFnvbkzsDyxwGs=;
 b=h3/LsJueV0GYhI7rqbtQOzAPYVcgKAo9BSKeRCo5KLWK8yJL0GnbnqX/uFiGyviY7amK/iPGg
 PYwPjp03N+PCCISoO1mXYvzrxcH4l1STar1V3ZEXXKWlpRZI8N8QOxb
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 8bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Enable the software powerdown on all the applicable CFR1 register bits at
once with an IO update.

It turns out that DIGITAL and REFCLK_INPUT powerdown do need an IO update
when enabling the powerdown, but that is not the case when powering it up
again. It is an asymmetric behavior, which was observed while profiling
power consumption in the lab.

Fixes: 22452fe6cd08 ("iio: frequency: ad9910: initial driver implementation")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index 04a4e184b873..8bc24d0b7442 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -621,26 +621,16 @@ static int ad9910_sw_powerdown_set(struct ad9910_state *st, bool enable)
 	if (ad9910_sw_powerdown_get(st) == enable)
 		return 0;
 
-	/*
-	 * When powering down, the DAC and AUX_DAC (SW1) must be powered down
-	 * first, as they require an I/O update to take effect. The opposite is
-	 * true when powering up, the DAC and AUX_DAC must be powered up last,
-	 * i.e., after the DIGITAL and REFCLK_INPUT (SW0) power up.
-	 */
-	if (enable) {
-		ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
-					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
-					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
-					  true);
-		if (ret)
-			return ret;
-
+	if (enable)
 		return ad9910_reg32_update(st, AD9910_REG_CFR1,
-					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
-					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
-					   false);
-	}
+					   AD9910_CFR1_SW_POWER_DOWN_MSK,
+					   AD9910_CFR1_SW_POWER_DOWN_MSK,
+					   true);
 
+	/*
+	 * When powering up, the DIGITAL and REFCLK_INPUT (SW0) must be powered
+	 * up first, as they do not require an I/O update to take effect.
+	 */
 	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
 				  AD9910_CFR1_SW0_POWER_DOWN_MSK, 0, false);
 	if (ret)

-- 
2.43.0


