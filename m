Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF83F8EC6;
	Tue,  9 Jun 2026 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999993; cv=none; b=OrzzpZIbtDRsi6fU0IHiFFdOPGvqHMbRgbbvH5APX8XR2SGsdELbruTNjcoGubRqxUnx0Hf/eTZ5psKmTu1jZ6Jiv4aNJFHKExui3kqUZTC1u+2EarITvAreNNeN/sdTk700HmJOnzXNB5a8ql+IgdjhQCPJ43f2v8knbJiU7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999993; c=relaxed/simple;
	bh=c8mQ2JV5V3q9TpAEVhF1/ZX4rnxh/STgLp6RiPkrBSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9GcFentb4CaL3WWB1fGsRD1UAzNWSUrVcTrMdSQ8tX2xscaKh1sDRwwKWjgESOtuQWhAs3cFYBUbY5i4YfWPD1A7TABCUCEaFP5Mltw6gifNlbb+JHyjuTvGGK+Dado3sWifiUUZdbfmlSxoFdnGRBDFEuYqdQOVr6/5z5VQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC25k4e/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC25k4e/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E1CBC4AF0E;
	Tue,  9 Jun 2026 10:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999993;
	bh=c8mQ2JV5V3q9TpAEVhF1/ZX4rnxh/STgLp6RiPkrBSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FC25k4e/v/NlU+Du+CbcPYFdrOCRUQg/yidO/7Y2/LVvET+EaycQLfwq5lwtwDEHB
	 49QeO9mc1DrjEmAjQImffK75cLC0E5iB37wW1bDlzokHGiE14yzmk3LXirQ2lafVOr
	 oPgnTvxqzinY6r30NU0ZkQfr4YBkPJQiW+29Wm9FrcvEsJKVEbtqZRbyd5drQXBFkY
	 IChA9O6cjG9Tj0vjyUgxobo8+l64y8s/Fq84uY1x4ZtSq2AevaXCGe/ylfApbU3u6L
	 e11/8RQbkT5VeklSDibsAMpJoP/7CPTD7vQoXL/W8CL/UMFw2/430xhpZPV/fpkNQy
	 AAhUFNCGYFDIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A54CD8CA4;
	Tue,  9 Jun 2026 10:13:13 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 11:13:06 +0100
Subject: [PATCH v2 11/12] iio: dac: ad5686: write_raw: use guard(mutex)()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
In-Reply-To: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=1337;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9XCsIqgrbLMYi28HDanttyJKIxSBgEgPTgCUPJGE8dA=;
 b=toNk9uQu9iuhjLlaip28fuXIre7prdXxNYxb5ez5YxRPoMDcnDaZdNY9rjLoTbXRTooWGl0XC
 LVMUfVL7GTrBF4VZZ30Yj4HOciq2CwCDa6bRjuZ/+D4ALy3Fqmu/YdX
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Use guarded mutex lock to facilitate code review when adding new
attributes. This will allow for early returns, avoiding error-prone
locking and unlocking in error paths. Gain-control support will add
the scale attribute.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 487c61fbe5ab..d9022c6a3201 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -206,23 +206,19 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
-	int ret;
+
+	guard(mutex)(&st->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
-		mutex_lock(&st->lock);
-		ret = ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
-				   chan->address, val << chan->scan_type.shift);
-		mutex_unlock(&st->lock);
-		break;
+		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
+				    chan->address, val << chan->scan_type.shift);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info ad5686_info = {

-- 
2.43.0


