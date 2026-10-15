Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86E384CCD;
	Thu, 15 Oct 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082995; cv=none; b=ahRMoRdC7GTjM/uxnPCYey1ImEsb6Y3YqGfMDj0gX6l2WS7ppgWljHV4gvotfHgTP71gUmZUuuzB9WY5aIls3ZbR4xOOjUEOSen8sx542xWgiOhn7Libb77KFUlC/lntoOa3PBNqf29cuUsRHCCtAvKqzdpkLODHacjCKa5zbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082995; c=relaxed/simple;
	bh=eAb5oFB+rdh2Zz6njY91rxePgaWUNucu8QwqMo+DuCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAFIO4O1XxBjZGcCS0uqdbEptIzmsI38OsihWCxG8YyszzzHNzIepFchB/NFpVq+dYcOL7+Vr8jc26PXrI87rv4rGW3wT11xYVK1J6faZTDnm+Ix0BYt32GNmc+UgnoBHmMbyRHY3x53ixoEyvwxYlHlDLGKP+6LBxwSbTe/FtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf+AjsLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf+AjsLh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF26BC2BCF5;
	Thu, 15 Oct 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792082994;
	bh=eAb5oFB+rdh2Zz6njY91rxePgaWUNucu8QwqMo+DuCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qf+AjsLhz4AfkZ2mvB/FOclY9mC0ye0yqp9WCofv4H6mh2NCmqOKZxU7DPfzjGw7O
	 eVzt4CABi/TlRVW10qeMvT7cPcawn/UVA6drd6mKYmKb43r1dMa22FNLLfQTnyVtiY
	 yAmu4sCJ9CLVlalNWeRNn17Z7BU1mpxy6x8N82IZtbZSLjF4Hdzfil3SlYL/BFCEks
	 TWwJERX2sZ9+/lfxhHufL9a56xdXHoEAMlBtwmUTxu5mTmAlbKwxxbnMKwIlBC3B2A
	 lduqCTpsib8q8EKbfQatzAC4LBiaAcgZSBjH3TfxJZD8R1LxD4pIyX06c7MHid8kLy
	 U372z/RiEeRKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF192CC6B39;
	Thu, 15 Oct 2026 16:49:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 15 Oct 2026 13:49:41 -0300
Subject: [PATCH 01/10] iio: frequency: ad9910: powerdown fix
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ad9910-backend-support-v1-1-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
In-Reply-To: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792082993; l=2033;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=z7PqLUz1GS3N66gFTTPD/4sazamj3Ede7ek83iY24FI=;
 b=v3kIziO3EaoK9N1dW+gWYnAJBcqYdT/6j2lGpDIPLJMxA/OeAZrnJe7PdyQBwxGHRyMoYM4AK
 mfY6ZmIzvwcBkwwwtsSlJZns0QgAvD2PPvv0cXt0fZCeh3DR1zIiywX
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Enable the software powerdown on all the applicable CFR1 register bits at
once with an IO update.

It turns out that DIGITAL and REFCLK_INPUT powerdown do need an IO update
when enabling the powerdown, but that is not the case when powering it up
again. It is an asymmetric behavior, which was observed while profiling
power consumption in the lab.

Fixes: 22452fe6cd08 ("iio: frequency: ad9910: initial driver implementation")
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


