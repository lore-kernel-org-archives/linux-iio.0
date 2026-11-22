Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795367814;
	b=i1EixDX1HZyh0xEaXbMZIai/f3mKH5gCTZ7TjkFlJOszEXFoCTk7FCK2sqx/0upBiCTk
	 iCB/iPiCAU3C0o5QHoyS6FgTiXwFuWSaPTT4aPvBo4xScXkq0WqMjgsjcU5lgC59mVN1l
	 ICpu4zonMQDhOdx+jNK0/08UkrLe0b3ulwsuwYLRaQ9CSIXYJ3Py7k2UvLHdx4iOp6NAS
	 v4NOgzcbkUJdM/YeNfJOLcuCS+r6Mgcx/rx25VXRdZh7okmRw8x27+S5LCgzdhEOiu/jf
	 mArwFvAUhw8uO+dCQbUfBZnxb6Pzh3PUIW5EPcWQYuuzO2/8+yylcelqNBH+yMKe79g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367814;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1gsEPMLSLNXUzFDsM0fvne+TM/WcKzxNkLAC4U/axbA=;
	b=eVlLMaX4yttjIoWjalMAycrwvFU2CcNLEc9C57QFV0GQA98gxThT4E2miPO/xVmRfgXV
	 0IlZmy83PUcS2YmYFmCAALgQ4vIarj/cDaBH2LXQwIX2v7KW58id4yqz4xyZE5m5mYz8g
	 VpadgPY+mLJ6bkZqsPmWg3WwFkQMRSTT0pVY/QYF8xcBfAcIPTGrS4YzHKd2W7Tig1CG5
	 xVEo4SAnPcF0iRKY1SSLt6oRrf7vUA3sarOmokKmTae8WtXRVtbKQ8PDp4zwYv08CNchJ
	 YJ/abjAtd8Z5NR68gX31GjV2ALGrKyow41WXnp9symUtjfKuSdHLnznNPJgXllGMzsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQgSMbrW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182DD606A68C;
	Sun, 22 Nov 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQgSMbrW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795367813;
	b=aRr0t2tCTRG210OrODA5bfEjr+1H8cvb6zMpjypmynPFRkFlcNMJKhtuX754IwUuwgQi
	 i0Ncy2KAYn+T5mBHq6kjQqiOS66lHloJjiPW0p8tIbtC4Izd5dzbWRw7YH4nX71GS4TAq
	 yURBX2heWRevtHo5y6yNJ1Eu6vzgaPMD5FuZZHbt+8PxUfuT8JxtexhutaOImlbM4RFTb
	 zK4ZcJxLSLXkx+Lhbj2uehloKJxUjWQK8oJm14xXEUstmkVxqt6W4AKq19Z17mMxmorSH
	 YsUnuJ2HoL1a/x6n732NxjkYLVX5BQLcB/SXd4mVOh5xnpPI2ctBsgo7jTURU9UzaeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367813;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1gsEPMLSLNXUzFDsM0fvne+TM/WcKzxNkLAC4U/axbA=;
	b=tH07grRE7/VYnkIb22lXakLVEkLomEydXGYp76ce5EbatqeEauqx7D+hYX1nxPZvvCVe
	 0zgYU7rjONByOqSugVQNYUBADR+QiihfdF4KJ+SRSX43IubQbX62HgoNYayOBjF5EMxdk
	 KgJoVLZ3JemgPPokv3pGiML0FBjATwhkMfUveCaRHct4uOMCwouYEtHq5baZqo4E19cqn
	 rDP0Ej4yE+PJvtQ2Px6jNgXIuouVMk7W1Y02hwvvnsq2vnrrJYDHqM1Xg1ZE1urwkStZx
	 dXyLNcEWmth2+n3XM3bcVfrgmTs2+i/LOHGnd9PNkKUhv0ddWXjPW7+x7hpZqEUR8Rw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CA8851F000D3;
	Sun, 22 Nov 2026 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367813;
	bh=1gsEPMLSLNXUzFDsM0fvne+TM/WcKzxNkLAC4U/axbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QQgSMbrWa7qptMtJZ9rUvWGrbNQzdNqv3PVVbKOXAlcdTXKDzsdPYgRZ3Y00f4yWT
	 cRH1eAGaqPuoFTr/EV7ILAXCr9ILThRDbskhheuPpmBvV0g3+iGxBVI8BpexruoWNQ
	 v4mIskraF5QBJ7aqwaUSXjTuaJS7JrPwFzLT7yBPQosOSN0TSW6e1bdaEF+q2Q2xGZ
	 MV2lv5lawqwAGFffGLRHK05bCcakLszcNqCcIsGsm1hP8jFN4t7b4+JqZysO1WzpZG
	 SMBrIu9t8xg/OF1mqpdHhrdzV602XVXJwEp5RGg/kfHej+Xx/Bd60BQZUMZwUv2Ftz
	 HqWS4DeOVIjzQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 00E204C159;
	Sun, 22 Nov 2026 17:16:37 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 22 Nov 2026 19:15:48 +0200
Subject: [PATCH v3 7/7] iio: light: stk3310: add STK3331-A support
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
Message-Id: <20261122-6768-stk3337-v3-7-b0d0a924e843@protonmail.com>
References: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
In-Reply-To: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795367795; l=1115;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=5Lb0wBjkKirl6paCvZStiiK+HOmi2iCm2HR1MhrJJ0c=;
 b=bT6AmY/HNuP+2j4nkBV8i/5kVozT97Iq41N3J9UlmTdlbzYaAguB3sr/Y+zXwQfWxcXNvS8Cc
 WH1zcJSuFMMBM4gKOtqAd5jm5d53EBJRk/zapvnWpgyU6mXpqoKwL7B
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

STK3331 is a STK3337 with slightly bigger package. Add support for the A
revision.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
A revision has different chip ID compared to the base STK3331, but
otherwise chips are identical. Only this revision is added since I have
no other hardware with stk3331.
---
 drivers/iio/light/stk3310.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 83f40714b972..8f640ab10677 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -60,6 +60,7 @@
 #define STK3311A_CHIP_ID_VAL			0x15
 #define STK3311S34_CHIP_ID_VAL			0x1E
 #define STK3311X_CHIP_ID_VAL			0x12
+#define STK3331A_CHIP_ID_VAL			0x5E
 #define STK3335_CHIP_ID_VAL			0x51
 #define STK3337_CHIP_ID_VAL			0x5F
 #define STK36C61_CHIP_ID_VAL			0x95
@@ -112,6 +113,7 @@ static const u8 stk3310_chip_ids[] = {
 	STK3311S34_CHIP_ID_VAL,
 	STK3311X_CHIP_ID_VAL,
 	STK3311_CHIP_ID_VAL,
+	STK3331A_CHIP_ID_VAL,
 	STK3335_CHIP_ID_VAL,
 	STK3337_CHIP_ID_VAL,
 	STK36C61_CHIP_ID_VAL,

-- 
2.56.1


