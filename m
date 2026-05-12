Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7238398B;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=ohAAl0Zy/LmslWxrm9s1K4xXJ90zCAEzC4lP/24Oy5vusD3IIIKiglghNgDYJAXvOeWs6JJ7pb6Agb1/6ZtwnjYLoByjXs1Ng397VRxfvyzJjvssWpdCsFUlOrQ+iS4sv5w1njC4+zxRBB6XSE+bcpL3QAdaG6ZaKWGOLUmcFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=QHbSxCdazSBxzl8Hq6xYTxEwaoXrcPTFT4d0vykRE/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSlKBe9YJ4JhEe6MjStFaXZAxWWDXkZYrial2TWNNlbc2aKlBDRU8Vv5P6eQJSnjo3ZfEWBXCxrDxpMTCg9fjz6IVAei6CU3CwQFayi5JJJ1C1HHelOHJiyshFb5oDrODqLj1905ofQuI6HZnwghtQUf7bEe3A1CB6qFYA0idpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrUJ/b6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrUJ/b6y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0285FC2BCFB;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583473;
	bh=QHbSxCdazSBxzl8Hq6xYTxEwaoXrcPTFT4d0vykRE/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SrUJ/b6yRw/4gx6HsRKwgAIuA74/EgSZO4YN39BkfjO6/7L3I5GkyzmD7YodpZGwU
	 aVhR3URF0yYu1wA7oZ9mhDabkhkzDBN0hZ58dLVPeApW4CL9Hpvtza5pckqBjibMcw
	 wIBxIdWDioUmZKh5T5udzA3nla8j3bnIJD30QYFILA/uP/s+vnTkwHH8fmlER7RFiS
	 CxaEBCVZruyeahpapqjzAsEXZoonPq+Ua7AqCK1yE5mz4eRnCmr8bI2rDW38hzw0h3
	 nNW7+DnS+1B0OqypR1Vucql2vZOo8e0lwTIEt99BNqBP1KeQIsxoaqcI0aMh5q+VcR
	 GeQ6jzOypFlVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC279CD4F37;
	Tue, 12 May 2026 10:57:52 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 12 May 2026 12:57:23 +0200
Subject: [PATCH v2 03/10] iio: light: opt3001: use macros from bits.h
 header
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-opt3001-cleanup-v2-3-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=1632;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=iX892qeHeNekGLCGmiyvjOL4SHT70l99mvgbcZasL0o=;
 b=zYDfszESnQe9kQW6ceqWv41z72XjEdoSp5wSCO69CxigjrDT3mPULSYtTHElmMPKsMxgC0A+f
 0caXr8acBPNBVqleBIgTwrz4ci4bR3Xi7p+d/subqUdeyy4Yp/P2ljV
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Use GENMASK() and BIT() macros from bits.h header where it makes
sense. While at it, remove unused macro.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 7efd92875c3f8c86b00a8aff8fab664457399983..6ce1a2d7647a3b9cd8964a276878630d31f61794 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -33,17 +33,16 @@
 #define OPT3001_MANUFACTURER_ID	0x7e
 #define OPT3001_DEVICE_ID	0x7f
 
-#define OPT3001_CONFIGURATION_RN_MASK	(0xf << 12)
+#define OPT3001_CONFIGURATION_RN_MASK	GENMASK(15, 12)
 #define OPT3001_CONFIGURATION_RN_AUTO	(0xc << 12)
 
 #define OPT3001_CONFIGURATION_CT	BIT(11)
 
-#define OPT3001_CONFIGURATION_M_MASK	(3 << 9)
+#define OPT3001_CONFIGURATION_M_MASK	GENMASK(10, 9)
 #define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
 #define OPT3001_CONFIGURATION_M_SINGLE	(1 << 9)
 #define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* also 3 << 9 */
 
-#define OPT3001_CONFIGURATION_OVF	BIT(8)
 #define OPT3001_CONFIGURATION_CRF	BIT(7)
 #define OPT3001_CONFIGURATION_FH	BIT(6)
 #define OPT3001_CONFIGURATION_FL	BIT(5)
@@ -51,7 +50,7 @@
 #define OPT3001_CONFIGURATION_POL	BIT(3)
 #define OPT3001_CONFIGURATION_ME	BIT(2)
 
-#define OPT3001_CONFIGURATION_FC_MASK	(3 << 0)
+#define OPT3001_CONFIGURATION_FC_MASK	GENMASK(1, 0)
 
 /* The end-of-conversion enable is located in the low-limit register */
 #define OPT3001_LOW_LIMIT_EOC_ENABLE	0xc000

-- 
2.47.3


