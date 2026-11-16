Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847201;
	b=C+mB9m1sE9clBo6g0q8ezIPq/hh9+uNNfWDRKxPBNd0bfqRzG44H+LV0U5PasjKFndr3
	 Psik95BPN+BllMGw6zKg+FCYFtV0CQLxOwHQyyKEI0dg5+9gDIjPyYHmp5J8UyjZ17nAh
	 eQ77hRDg1yPda1JPSV0c5LuM/Th0cRI1BMGGAGlxnzQqCZhpLuUFcsl2u+i+VQkH/IdGm
	 tnzwImN6WzU/RsQtHqPToTO6dy4j6T4X9fdovqQvkR4Mowvdacm6WF9akrM1Di2saxWup
	 L5IhtxVR3ZroYcn1DcF+VLsntDE8f4/TXX1/Av5yVQSaE7dMWDdZxD74ngrXn6pcWfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847201;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	b=LJKHVp6FK5ccPN0xuNVyf5sGpv5Hjtj34bRz3WqlXN8R2BPkWFClInb59XQrRbtUxnLn
	 RkT3i2GFJvtiB6MRBgAxzXeDAh6evy6QgulByKoFVi/DAHaCiS//OB4FQTSFinZY19COC
	 PB5E4b94ERJq1Os0xhzDpIdWSObUGNNIUSna/yB/q4U19CnWXfPKrpfWUPm54qpyUDDFB
	 hmVytDrrz59hMUyogeIbTsGayodEE84ToFnRYnRcLnO6fgiSnUTe+lB96G4A0tzrsVQXA
	 ByvjUoKtzSDEMgF/p3rJ1pnlVtwM4xf/xsaRcvlB75400dUb3MTsc0fubt6Ik1QNTMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CTLG/u35";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F1606A88C;
	Mon, 16 Nov 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTLG/u35
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847201;
	b=UfUN8T5yxJOn6WCTD17P903MnUTOjRm0BtF57lahoba7AKBveqUCLMCbxXF41hu0ubHS
	 d6Rr5qXwZZQpWA5iuzc44l4u0H5S5HEc6+FKY7U7XvjCaj5gPCI4Knz74X2RbsuuldLLT
	 jhH6JCPNcZB1Gq8s28quPCQFHcpkekSBsdLEGyiu9IRfM51Fkul43yagkfbTP7CPXxC4X
	 35TeliRKA/UPBF+zgTz+TCkFv2xOEqOjxgdrmSjh6lCvkn/WqsAUHO6c5c6HT/kH7cVQG
	 yKS4yQDzJchqT/NXO+OhhHtEpSZFSxrCQT31rJYNiSWVK+9Qc2Okj75nnAQUH1xml/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847201;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	b=bWBxT5MJhv8NfKWUvs9mV3GrNITgsv/UlnDiH+QA2LT9FzPklIoTd/yhZVpIUff1jqda
	 IxuNrVIx0oLw0kLWYs+PNW3344O+TwGCQFTmPLk0cyTbVhsb0uSujtDZdRVmhNlexJFof
	 vVHw9cc9Rwa4dW9Gc/Ct1UJfowNpeKTWsS6OdPJscCYtKakNNs4JiBI2JfIciGTleb45v
	 hWxP9aqBAL3LJo1ZcaGbnEBXgRgxmH6C8PKJlM8uLgfhHOxDyk1U+rokJ5koYnRXSz9W5
	 ZI/wIau2Sxw68zsa619BPUveXe8uJdFUUXjA4lbpTtgoudXlpGqGIQSHdn9zuC81/EQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 57BBB1F000C9;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847201;
	bh=fvStjk2P5Y/1Jdt3vgXWKnB8BBjsKIf7mXeprvth/xQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CTLG/u35f7GbQcxV85LyFc4nqbudA05FnjKHr0CQT77LHTIkQ48E+ugntb+neA9iz
	 Ok2hvkWS38mN5k85DZ0F6klOFKt7OYaXa8K+pvaZbZwzCQtlYApqmR64vgL7jAeE1A
	 FT4/RDcuvoIA8TXGvWfVrIAUpsiJpg9rL/6bgir0Cbeah1pvNjtzQ/a/AR2K8OYQrc
	 sjWjMx2oChpi1PHyi3prp67aE+pU9UW5a6MHGeannb+VWG0qwCV1ANiGE+8HgjDd0X
	 /val58WOihYEjXJsPxRpHb1HlyxrPplX7jvb9H1Ay/TheD6yWX9Ae8TNiXxZJvVf4e
	 xr0oG3VfNkrOQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C66634A514;
	Mon, 16 Nov 2026 16:39:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:39:53 +0000
Subject: [PATCH v4 01/12] iio: frequency: ad9910: powerdown fix
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
Message-Id: <20261116-ad9910-backend-support-v4-1-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=2077;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=aJtPIXmw5LGBhO6Ijl0bIJNuEuTO3aFnvbkzsDyxwGs=;
 b=PDWdSJZWoWSgoSwHFEEXlGEpAYdyxW4OMSAOoqXHqnkwEuP7NLpqOYvCfx8NWEkf2uHW4tFk6
 e2GXp1wbv2ZDiQPyzVNt78xjgGk3AzCcL02xA+kSvXeLZVI7OK6B/mk
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


