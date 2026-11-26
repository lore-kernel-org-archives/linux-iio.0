Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654426;
	b=YERS4LBNdu8TiCpVRzyF8BWf5qzOeuME+06Cbj4GCwsxM4V9prVc5mmRl6P8T0irCvhg
	 riMWhNXC6A7VPS+QVCgyjxOORDRX2CvX0s1wt60bymmP0RINaPMPGtXM5IrubhYAIqh2M
	 s3UFiP99AgiWgpp+AkxlpOtmzj2bKeJ3dE6kyycf3EWc7GRRCHIzI9ujq0i6+MVJTj//1
	 4m2TjyuRa28kMY+RIGRwAQGk9GCvQWpdRcKHGsM9+/bvKW5xrBw+tCqvZ8SgQIbr5ZIBe
	 ORSQxV1qeekRCciRZ5s0/ODGP2XE1jBZO5fbXT4kCQtxvx4POlKZAkHPHJiYC2uvuoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654426;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=K5FFI394OFMdGPEkQA4YWLY4c1CiFl6MzB/Tecc86+Y=;
	b=VVV/Rw00ZCNXUw/kz1D+V4D7zwlZXd+6Mj1jHHAR/V4Tv2g/JPOyigmTmpb3T/sU4/TM
	 UxuhpeaCy26O9vOhMB4Acxo/8AsSRRQEuDMaW94Y8yT3TkkNsikEQCaINYmPOMK6W3Vw9
	 H7yQNpPBFVInWJVBTLqM+F2Mzxs86gy7kcBeAcFx3BATU6qvndB8kP65SLH520ESx2ls7
	 LYNLR1Yr8zkB7drAvmixfL9KYB+NdGDgQ4+LULLbgaQ1+eH4ceta6tPtY29fW5f/nano6
	 xUujj7rvoglt6EIHgDGSkAyEM9rskSY4vnJwFq3Ndyuhrzpwu3ee575YwRyfOrJb1lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbUHrtif;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071A606A335;
	Thu, 26 Nov 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbUHrtif
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795654425;
	b=P2GRev9w+pw6kufLVx6cMjQNB7FEHa+7e9E7EBa1zcpJutLO+CA5oEpy3JH/uECShcty
	 mzb/MMMGgoBPBFLpAyBO5gzjoENyzEro0xFLaAcHanWtjB9MZpJaJspZ1sCbv00lTVOKQ
	 jVQd9+u4MkBpaxfJW9Zll9276VmWC1ltmhoQXgp6giMoV2HtvsFvx2fAungqsWVUXFesg
	 a4k6AVfVaRRUDuLMfvtGLME2eeTNu21ouBcOm1cwIfgNSuKEAYwshsouflD8YYLbpd/hJ
	 GiMYK5yv07DEZsXuaNDd83tX9YnDl75tqDNuM5TDFILXJ+Uydoa50kSgiIWtXDXpTDg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795654425;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=K5FFI394OFMdGPEkQA4YWLY4c1CiFl6MzB/Tecc86+Y=;
	b=nkWFsG8fEQmmhulMCMn1VGoDVd93uy8FUDWn6B/k2q0MmqYuTFkzfbZmr0vJgW7is3M+
	 ZwdFJQOj3YJz9oHRjPrHep81zmMWI3nzVAp0r4VOHeyloTHRreZsohah1LOgBvHcd11KC
	 rTVp4f3Pa18eknrY970YHzlFwQ2s78QwZiCA2LblFelOrlzPROPPF+t6V423hI2T2Yr1v
	 Hnub2W6eUBbQ0vdb7K/InEchio8x6goDKUvKg2vw+pu8JzRSIddExSuV2KWwKEHZRkcQD
	 BWxlj4dpPjMDsFHdiiNEnvLnwScBfkfwgNNXg6PCsD5tZuBW0HmsYLAMCGvsZ4pwE6Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 62A681F0156C;
	Thu, 26 Nov 2026 00:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654425;
	bh=K5FFI394OFMdGPEkQA4YWLY4c1CiFl6MzB/Tecc86+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=BbUHrtifF5icG0LhBs+/2UsinfE4jMNI35oTTERicdeXLUbY0yzAoW/D3eQ1ROtEx
	 iwjoasmXUDbz7Z7lLlK3DNA57VBve0rKKWKALnbErojUsFHSGmOT5mjSzpSi8kUeTm
	 Ain1n7kHF5eY1TpLLeLrH/7B7JPQ54SEy6x7Tcbe63AuFH3c0idUFTMClx1x15fBli
	 A0prV77s3iLtL9DG+VmvPd5AHscYM8X656pE9zEx9GIwIo4WEHYpCj1wrX7tKyoIRA
	 qKs9eyT2gllRGTG0Y82lVafzYfpEWd3tu5GCMz7AqiqX/vLqeut6if/n5zqz86Vex8
	 Zj3k/A4sDCm+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 37DA24D148;
	Thu, 26 Nov 2026 00:53:27 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: mt6359: divide scale by ADC resolution
Date: Thu, 26 Nov 2026 00:53:27 +0000
Message-Id: <20261126005326.71926-2-iasnezhkov@gmail.com>
In-Reply-To: <20261126005326.71926-1-iasnezhkov@gmail.com>
References: <20261126005326.71926-1-iasnezhkov@gmail.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795654406; l=1939;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=7vl4u01SgEwCwc9gl97LuugAuG8wvcClmhuIXz5B3VY=;
 b=M8ELTrNymnSSBWnP8gL6gLxOjdl2/HKVLecz/v7T5ncHp45P7pIx1mRuN2Oe8O5ic9rZfd5TL
 0UqwEjBwP4nCH1dmLbKyCuBz49O1aoUzCyYUkdxvixwGZbEItLupanh
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

mt6359_auxadc_read_raw() returns raw ADC counts for IIO_CHAN_INFO_RAW
(12-bit or 15-bit depending on the channel), and returns only
(r_ratio.numerator * vref_mV) / r_ratio.denominator for
IIO_CHAN_INFO_SCALE without dividing by the ADC full-scale range
(1 << chan->scan_type.realbits).

As a result, iio_read_channel_processed() and userspace consumers
multiplying raw * scale obtain millivolt values that are 4096x (12-bit)
or 32768x (15-bit) too large.

Include the 1 << chan->scan_type.realbits divisor in
IIO_CHAN_INFO_SCALE: shift r_ratio.denominator left by realbits for
IIO_VAL_FRACTIONAL when denominator > 1 (r_ratio.denominator is u8 and
realbits is at most 15, so the result fits comfortably in int), and
return IIO_VAL_FRACTIONAL_LOG2 with realbits otherwise so channels with
denominator == 1 use an exact shift and unpopulated descriptors (such
as MT6357 VDCXO where denominator == 0) cannot trigger division by zero.

Found and drafted with an AI coding assistant.

Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 88b0e26..54c9048 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -772,11 +772,12 @@ static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
 		*val = desc->r_ratio.numerator * cinfo->vref_mV;
 
 		if (desc->r_ratio.denominator > 1) {
-			*val2 = desc->r_ratio.denominator;
+			*val2 = (int)desc->r_ratio.denominator << chan->scan_type.realbits;
 			return IIO_VAL_FRACTIONAL;
 		}
 
-		return IIO_VAL_INT;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 
 	scoped_guard(mutex, &adc_dev->lock) {
-- 
2.54.0 (Apple Git-157)



