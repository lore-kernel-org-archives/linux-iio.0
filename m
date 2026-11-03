Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717583;
	b=NLb4irE0GzYP++r7ao3ePuHde/lbAoR6t2FR4+5Pij/4s7G6R7r4DolWxsi+mUV0ciDH
	 XwW7auNQ/8MpuaERny4bQ4OG3xBiCxcCkQmeYAKW22h9iQmqYnCp/DV6D085d3PkarFBR
	 JUtSNLRyfGN+QglpofhQ7J/DyMPclylEfVasB6CkPvucy3749/cEkDo6r4vCi82sbckQ0
	 2tfwcEJOBuX0Q6FldJesSKQct+vAQLcZEWGE//HlSzLdlg+i2D0Cx8n743T8Zck7X31oD
	 xqbJ4kL/VgUplbOdWcFIEis3BeLJAoTU675WDme4lYL6AhqKi7a5lWs1MjLdm7CjXFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717583;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	b=q55xDmhyf4zwciJ96rdi5cDRFVJB9k05EhoL2jmrwQu+YE4CUFjAPVkuEb7UuZtAH73M
	 bHmAsFQN6az/iG1yNdRTvPuMNPqQo4xK33VxhKCWjR1tPxmYp2E3tnvWVZtoG9jRCxWcp
	 j51eUJWea7eeyTSErVW+zvvZ6xy2SYyFXGZ4YrxzLafjV3nKHsA9ieDkK5Y/zR84+781D
	 orFUS/LXTL9r+ipORjo/SnMC5jsKgsBhO6JMKnGe6cI0Kn7FynFRPDmMeYuxQjd/jlpGy
	 35w64pzrYG1GPyehpbyOD4oMEB3pviXbTs4b6EriofpCzDm/I86OhNEmTTdIFN7v7bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lxw+/qq7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF9606C849;
	Tue,  3 Nov 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxw+/qq7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717583;
	b=3B/EZifgl6KnmZJn1wh++GivMsyLK/lHCSmvW5n/gO58D7G3uTZFN1FBkr0E2saodpwN
	 +6b9H8ZT4uyWfJRkihnhXovn7UvBqzyGyOSnNXeqcgoKmJDm5bSRhSYH3mivKk9Z0N6RC
	 CuL+lY+ys7EvaF7HMvaU9VFKQdHkZ5sGwS7NlXWjMxVYidV4Koq+0dkrr4JL5q3UA9NFi
	 UxpypIRz5EzvQk0HxkSfZ/kRV5thA+DC2J8nQHU+cQZ9lHT0lgd7BXF3iUiF9cjE4RN7F
	 bqKC6NyCwq+u33IYvDIiHo/+C3LUjNpiHNR89vQ/uwxC/H9M9V32h8zmbdGU7jEnM6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717583;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	b=16lxGBm82rEGYFfiT1gQPmCUnN0R7ZQjNrj1pxKh8fm9O7g3nqDm8KX7qlLbLlPwYeue
	 wREeNLlEJcY9jOXPcLXLXiB9SI5MRyDQpKby2cvk66RjaP21GUaes0gW8cH9dSwirl+oZ
	 AENRii0q29fp4rPVDmidDowFmDe5+R/0/ulS/M2L9252cUBttoZthrBr+WRrPVOsh1/OC
	 6k5LUh8Q1C66iCGeTcIlWuPC2kF9TAEbTd9PurNK2KlhVymCina1TZ8U2wiInEgdjjYT7
	 qvJUpgFuo1hlmi2dL7QjS/BYSp1ZOMiZX/le6ReztUHj6J3WoTXf1U/mO5wW55uELRA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4C221F00919;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717583;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lxw+/qq7dfyjXDQy2kgybl3ScP/fBr0r39plSIo6cVXRMjMKpvDybTg30sRc+bqou
	 ihi6bJPbUPIDTlhQy9wWnEZmaRWUkTA8ElLGfgfIBem89Sa21U/ZdTGNhWHacYCPP/
	 pL5530b9ziL0mkFGYFC6SENEptHM2dwa4Kp+fEpZRsJMehuep6A94HrEs0s/o3cH4T
	 lizYaGXyppyjxNb1pViMv9mvMH+e8yw2ok9n+icIzpWhqVokjZscVGlXul4IOnhLTg
	 /XCjs5JSGM+tHnX38ySMTS1DI/+/EBio7tjtqzD9bSqvMQ44fz9F1Ody6arLvCal8v
	 jGQxfFSE7llGw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5D40C46991;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Nov 2026 11:52:57 -0300
Subject: [PATCH v3 01/10] iio: frequency: ad9910: powerdown fix
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
Message-Id: <20261103-ad9910-backend-support-v3-1-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
In-Reply-To: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=2077;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=aJtPIXmw5LGBhO6Ijl0bIJNuEuTO3aFnvbkzsDyxwGs=;
 b=9/5AkNRnOThvLHbwYyM9gDBHV02u2WuZvK9mpIklVUEsyQJg/TrQCKv2F1CcKhRuUsx+Oljvh
 fEnKcBLvZaHAT3ro2LTw+NQUefbshq9kjv1SMoPWb6Lj8YlIRRZiQxE
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


