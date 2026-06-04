Received: from outbound10.mail.transip.nl (outbound10.mail.transip.nl [136.144.136.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9F3C3451;
	Thu,  4 Jun 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555783; cv=none; b=Xz4Nup9PIfibpTawNxLve+GPE3Zv6R9fQefMnTnAFzMJNAPat6cDPH/eFz/rUs5lao5NJ3Ya/RYBffF3KgXxbAI5UYDubABNgwwaToTMGCsmk4D1/AwRVwZhejj84WyzC3oW9jJ0vqJf45UnI8+xgtcTxakqCNqqVvdt5qitazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555783; c=relaxed/simple;
	bh=oywdSivV/NpQN1wXKSdQq5Wu/6uQhRyMY9gM5iiPf/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYjUzqlKBQd8X8krCYUEMW3yc6RSYiYy0PJbjVDvVqeFltRK8gAq7zBjUR3DyMf8vgp0jFZnE7BqAvwFbvI/UIq/p7l7DxTXvFQ6FFQs0QiR1lAGmpFDme66rxm1Sje5eDY3xYJOmokmrDFMbi0KCajlEtMgtB1ix5CZ5Wkc42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=hDUivU0t; arc=none smtp.client-ip=136.144.136.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="hDUivU0t"
Received: from submission3.mail.transip.nl (unknown [10.100.4.72])
	by outbound10.mail.transip.nl (Postfix) with ESMTP id 4gWFY33DrrzTPNX4;
	Thu,  4 Jun 2026 08:49:27 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission3.mail.transip.nl (Postfix) with ESMTPA id 4gWFY26TGhzf52bR;
	Thu,  4 Jun 2026 08:49:26 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH v2 1/2] iio: light: isl29018: fix 32-bit overflow in isl29018_read_lux()
Date: Thu,  4 Jun 2026 08:49:24 +0200
Message-ID: <20260604064925.3097108-2-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604064925.3097108-1-github.com@herrie.org>
References: <20260604054723.2983181-1-github.com@herrie.org>
 <20260604064925.3097108-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission3.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780555767; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=4cYIfd0/w5cJoCAlF9Q80FADB/3Lqf1vY5KVb3NzNwk=;
 b=hDUivU0thqMMyOL2nmhKeCorFEqJvBw2gpm8qI5GrYvmbpnB6do9GtyBjXifwaMFJtH4Lf
 sfCpSt6SINgV4t6ls3bOzHXey+9EZAbcC+M0E5C1vu/5TDehcN+8j8H5cLh7wc9RDG0NZB
 o14mk3zL/2ETAd1X4oNzkuV6KNLxW6jIBBUV+E5smuFiynILWD9jnpdFasKtEk6QsMu4dE
 Ap/RgBZPDOYoy72X6q54IvKpoFUs46amxa7MG6NF00I05ynuW/PCx5TSh+dIj5JOtMrbjV
 zDWWCjet6IIJbfzXrlpgnMdiz3MGc1mCVbndBg+HaBRpyh7wZNO0O/lRzjUkVQ==
X-Report-Abuse-To: abuse@transip.nl

The intermediate calculations in isl29018_read_lux() use 32-bit
arithmetic throughout, which overflows in two distinct ways:

1. lux_data * chip->scale.uscale — at 16-bit integration time and the
   1000 fc range, scale.uscale is 976562.  A full-scale 16-bit reading
   (65535) gives 65535 * 976562 ≈ 64 billion, far beyond UINT_MAX.
   The value wraps before the / 1000000 division can save it, producing
   a wildly wrong data_x_range.

2. data_x_range * chip->calibscale — even after a correct data_x_range,
   multiplying by a calibscale of a few hundred (reasonable for a deeply
   tinted cover glass) pushes the product past INT_MAX, causing *lux to
   wrap negative.

Fix both by widening the intermediate variables to u64 and clamping the
final result to INT_MAX before storing it in the signed int *lux out
parameter.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/iio/light/isl29018.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b6ab726d1dae..eafdfd9c4635 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -193,17 +193,18 @@ static int isl29018_read_sensor_input(struct isl29018_chip *chip, int mode)
 static int isl29018_read_lux(struct isl29018_chip *chip, int *lux)
 {
 	int lux_data;
-	unsigned int data_x_range;
+	u64 data_x_range, result;
 
 	lux_data = isl29018_read_sensor_input(chip,
 					      ISL29018_CMD1_OPMODE_ALS_ONCE);
 	if (lux_data < 0)
 		return lux_data;
 
-	data_x_range = lux_data * chip->scale.scale +
-		       lux_data * chip->scale.uscale / 1000000;
-	*lux = data_x_range * chip->calibscale +
-	       data_x_range * chip->ucalibscale / 1000000;
+	data_x_range = (u64)lux_data * chip->scale.scale +
+		       (u64)lux_data * chip->scale.uscale / 1000000;
+	result = data_x_range * chip->calibscale +
+		 data_x_range * chip->ucalibscale / 1000000;
+	*lux = (int)min_t(u64, result, INT_MAX);
 
 	return 0;
 }
-- 
2.43.0

