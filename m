Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662637;
	b=UDRirS9cYkQjQMh4mMxftHyqhLD3L+DW3y2xH9TSTzXq86S58RdQ5UYQdoc7opQACkcK
	 w4QX7BDaXlfc+veBfXvBeUmXBAIq7VnKBQIDPyYKo5qzWB+0jZr0/RhWp0AgXh3v7LMRf
	 W2/oRTDx3uPCXadwpr1MQoZOWmExZKieBr00b0urVLNFSKE/+4KnSFG65tc9uMeni4obe
	 sFOfIzrC5oPCBO5jWEcb+wDDGtN/NdwPR0UVWGQ3/8XzDaYEereXQIylCyhHkIwNPxVGQ
	 /NKuyi4J+m+UOO1gYsUXhVwjkrxLEHUC2hl7CzE9Juq4goncR9fYxK11MdZbqbJDF2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662637;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z5+WW7qUd9uSQGp6BA5//nwMY+Ej/kIvfg3ReMKVqIY=;
	b=iKu2ZIou40ZQroyS/n37Apmjx25AvUVbMfbieyJuDvc9q+cj2I5lgy7hL2ZKRvXa5IVv
	 r2/pOZwg4dtzi4cP82+guZW/YihbvetuBuSPGZGmtqaxPeT22ckJXwozTTHCOMICLZx32
	 mpa+HSIn5aiXq1B+FwMDyYjBxlm/HoZ6v5ww4S3Ypas6/AjnCuK4Chvtcnu7k6L1u9wGm
	 pBy02wzGmX+PqZEiLCUIGezIIFnfybsZRJP1pN2TOtwkixViklOGznnwv+B169ZSvPOLa
	 +PXBxt5Hq3GMRU1SAQd73s++hW08vK6cni6S781U+ajQ+0VLbEQ0uXVWRjETP+QcBPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INkCk2oG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E1606A323;
	Thu, 26 Nov 2026 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INkCk2oG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795662636;
	b=CkVyi2u8RW/GSX5EnypGIhPrvQVL0d9uIopFdEQ+RTcx14A7hQomIMIWfktxOU2Zyvbr
	 Pq+V7N+bgSeg9I30pNb7q5TKQC6rpmXYKb9MyGNUx3CqzYLjKDVn+qg4FHdli7YuR+RQq
	 IfqSRrCc8jLGGwrATwJUgg1sJoqE3MUmEXgdap3gw44NfRlKACfDZ0Uo/z9RXgmX5WjBJ
	 Ke+SM7X110BSY3k4FcuEoE34N+oa7Eg2kWJFulqiSs7lqzY6D4rcm4vJnpB4AtJEl1v49
	 jD9vp/fMudvBPVzh2h8Iy3mAIURN5rhYFI3EAWKh68QvZrbwSfbDoHeyeqnqSSSG1Og==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795662636;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z5+WW7qUd9uSQGp6BA5//nwMY+Ej/kIvfg3ReMKVqIY=;
	b=czJFvgfs+UPXZe5BwJxorcG44R4xINUN7mgDDfTY6uZp0ZYrZvnQYhvL7kG6sA0vVeUt
	 3/NtfG8eblqrRTu/7d4FpMfEqzOGd6fEY9vVmFwMAqakFrl7KwWghHDDNkP05KwHPqVf+
	 eozAJwaUz/fkyzK8QFqq+VfmEFd9A3ic9A1ZZbHhfgZZwQPr8sobdOgWUY8gcs2ffY3ni
	 2du6vqIxUa+j0avfH6C4O09grtdSyfKxh4aEAJU3s2m02qnzqolPPLPipSoCa52X3kJe8
	 0k+InhB6BR063gRoiQ4dTNDetUayRurYrTaEIKgZAplHdm0b7GZjCsfmh8N3c/VSb4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AB2751F00AD4;
	Thu, 26 Nov 2026 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662636;
	bh=Z5+WW7qUd9uSQGp6BA5//nwMY+Ej/kIvfg3ReMKVqIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=INkCk2oGEim83xGiHoYYjYSpAwK653Mt8tLRNB0+yolCakcfPcXCn4GHyKfMuU4mH
	 AxMa+z5V9WjLOOZkcd7H3zWSg6WmSQ4QYe3M3ujUh9JNQ2TQTxhbnUXzxSiBNYKJRN
	 Pgz9WWwTTAwKyY4Hrv0O4nvOG3qmkXqO91pYZ9IjdiciI1gkb/jZssBnayXB8BpiiT
	 JsSARsT7eookjia44d2S3rovaqz23uekCVK7XPGlFtP3fyFE7xscjezMA1P7U97ZBx
	 5tRdXHF36Q5GTP1Udxu7wB9QTgMhkmCurUGJGKDO/YG9yRB/pgc0SQAIuMdrAXZgje
	 hbapcoH+92a8w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 379094D1FB;
	Thu, 26 Nov 2026 03:10:15 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: adc: mt6359: divide scale by ADC resolution
Date: Thu, 26 Nov 2026 03:10:14 +0000
Message-Id: <20261126031013.27701-2-iasnezhkov@gmail.com>
In-Reply-To: <20261126031013.27701-1-iasnezhkov@gmail.com>
References: <20261126031013.27701-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795662614; l=2018;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=RTq1aVD1zHl4LRRZyx7FmcWLrY9bYuovI3sBY101iG8=;
 b=eNji+Xp7bTqcjraAhKZxOoZg3iNx91cOnLGanRiAoa4odxvP9t6+4JNZzsH1FRofnEamRt6Qw
 7ZC9iX79/DeDJdlW8bw+ZUoEk1GUNFqWu0PessygF6LU2u0G+DOv3QH
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

Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
Changes in v2:
- Move AI coding assistant note below ---. No code changes.

Found and drafted with an AI coding assistant.

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


