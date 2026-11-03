Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723747;
	b=Ja/95jREdbZmtNqazWauxMKsVymSxAbUFh1rR9C8HyuSZxB5iLeaqZNkdCnKBhpLvn65
	 5Z730djS7tJ0uMCDMQ0mTLicz5IXLCKPmq7mbLFEf/QFyoMgnvA4unDYyHW97EzyWzpP9
	 5D5EmiKPAb6Iidb4JCYHN07bh78vbH0eH9SQxZBA9KII50tc8lNYMYLcCbvZqfxsD1r0o
	 3GFEL6lYbcmroJMdddPXYC3i6LLg39mIjHP6geTAec1B6IlKmVQdMmJJDZFZORqqP2tha
	 +mLcOFXHt3XB84GEcgP3dFPxxPTglN87ga5JZV3ScJed99mkdKvn63h1w9NvTmLKrEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723747;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1gdqOYKlykeDMjNrInWMx9d6T1s+WWML0Tnqk1SqxjY=;
	b=aWJv/klF+pajGwEBYZKAjM2ywaI94YNbmwpvbicfVJWdtjtQCQ233/Ltx0Wf0b0aZdCm
	 NZ3b7NmZFnwh8DzJabvmurfYqEDth3mu+4W4RuL3LE+8yMusAwAEE7Tr0hUqOyRl9url3
	 0I7BWDEaeCQTZkN7DFIaUPpURhkgDJ6lQnEo7aaB4HZ7hzl/wT1vvd+HTzm0cBfDVD5v8
	 oSRmWYhEM6X83ZlOeyF0HbD77VMyHb9h7fs4eR8lHX2d6DQYZiSin/vsb7T4bfH6LgQAc
	 MLtT3vjq94NVv7DNLiDoXrWXJO/AJHO2KuQgRQ/nxHmPocoWs/56MZ0DgxCnv8b4aMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3HxGv+W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A9606A329;
	Tue,  3 Nov 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3HxGv+W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793723746;
	b=DPZCazyoMffFxf+ZCKFuG21lh1Tx9p1M3qjK5iL+lsgrhIvoTKNqnN9/fP/uSL6feV30
	 kOy8fQ/KiWWnpvjFwGRd3DwpqG+01ZoeFkeEamcXUSL8hi+SBgoWwQ1SgjgBgszepsWVf
	 AGhWRrNXWvaWbIlfg+fH3daSE2J9eHI1ME/WjLlzocv8j0o3eoLjmBvSRjusTGf+BEHhH
	 5a/ZhAoGi4UTl/w68lamEbLcMcxAl00iDnnykQOZSINIO2kSf3K1ROjFx63gLkbeD/ksz
	 3NyUiyKZpgBNrnYIG446nNb2Wo/ILKxJkMtS4TOxpdPnDp8rq2u+x172ljDls8Hojrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723746;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1gdqOYKlykeDMjNrInWMx9d6T1s+WWML0Tnqk1SqxjY=;
	b=OjaZG+ixq/4s+LtSam5KimtLqc5Of+LQUPXHTTfuS9Au4BlGHofzz22qFP7jjj2+2QJ6
	 PAzTkOldOqofAhQKQWCL7KsSwfWC9QJfbRYhT0nUrRh8TRP3wWN/jcAwlgDPlwOhPVfXR
	 tQGoMC41yWhyZl+A7AUeiVaPYCg63nresumznvIWWo7PBFg9EWtMCTMJpW1qlegrf5DAu
	 Kp2NPsvMcM5cNSW99eq4OpUUEM6xPPCxcRknPI+4zsyKxKpu6+oCRSNkTAFK2jzVpBTPG
	 emMDiZNlbZTp28bHRooT9seonkRAX6d6xQ4Yr4IpLWLVf/ldQN/BRTj2l2Rr+ie72uA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5B3B41F00A02;
	Tue,  3 Nov 2026 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723746;
	bh=1gdqOYKlykeDMjNrInWMx9d6T1s+WWML0Tnqk1SqxjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U3HxGv+WKizr4CCZFyTgYDsvuIq4XBqs3UU7kj4wbtZTZVPo9zl0VepxssKOySCXl
	 hfaW5bTmcENyBSpQYIDBdPb4nBsNDFAJ3q5Z/XMR28901T2IgKKoVKpcaKZ4aBoII+
	 VXxh7hHkQJFOoEQtwSLZMR/kh/O3Ua7u8E92yvjRV7Z+DM+EcQqcJgxK15/zXXw5RB
	 zOd58YR88L1OQIM05LAAx9f2pkgoJJZP4qlPORxQUw/s5NXh701CPjXhyPVFIVHbmK
	 weo/2KGr3naFgqxdLf+gaFCQWdZQNAirWoO2ocNRxIWpYZtku6AMdxoLkaccsYDXli
	 yTZj7mQIr5Ygg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D719746A3E;
	Tue,  3 Nov 2026 16:35:44 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 03 Nov 2026 18:32:09 +0200
Subject: [PATCH 3/3] iio: adc: mt6359-auxadc: fix scale calculation
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
Message-Id: <20261103-6768-6358-fixes-v1-3-2a868a33152b@protonmail.com>
References: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com>
In-Reply-To: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793723743; l=1136;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=R/Vgi/Hmv+iUny8kYvdB+lQ+e0rpx+YnD5NeeGn0NQU=;
 b=Ezy6TSOcsGzfCu0rU7JGw9B0yFsyUBQrW5l7OFzfA2ilmV3BjvHHzojotw8pFI/KqAKTiz55m
 i9/lIENPNMJDO6inOzG1kNoU/VraL7W4N9bCNfNqMKxXsgfsqzYDIDU
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

IIO_CHAN_INFO_SCALE currently returns value without dividing by
2^realbits, overflowing the integer to an invalid value.

Fix this by using IIO_VAL_FRACTIONAL and setting val2 to the ADC
resolution.

Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 09432d0974cf..3a969c30f633 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -770,13 +770,9 @@ static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
 
 	if (mask == IIO_CHAN_INFO_SCALE) {
 		*val = desc->r_ratio.numerator * cinfo->vref_mV;
+		*val2 = desc->r_ratio.denominator << chan->scan_type.realbits;
 
-		if (desc->r_ratio.denominator > 1) {
-			*val2 = desc->r_ratio.denominator;
-			return IIO_VAL_FRACTIONAL;
-		}
-
-		return IIO_VAL_INT;
+		return IIO_VAL_FRACTIONAL;
 	}
 
 	scoped_guard(mutex, &adc_dev->lock) {

-- 
2.56.0


