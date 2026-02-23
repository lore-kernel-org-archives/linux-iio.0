Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C534A3C9
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835092; cv=none; b=UfNWStM0n5hx7bFaAT8XzuQ3/XRQvS5l2trRftxDCRhkcUnabrgS7i/fM0o8VTD5oiQmpLh43lG6qCs54mSO4oiN4QJrzig2xkhPtIH/zy0kGvL2b4A8bMlQsiJaNUwjrOsk//3gsVBvPn1DJsQnzBL1HdBtfgA9DCZdUX8ZAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835092; c=relaxed/simple;
	bh=tAL/R5fKAhwfdtD3GkwTixn6bUiwxxlxA9kAZ7ZsXpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IS6Za4NPU8uGq08qAS3TgyXf0Ab+XQms/sR0mvoLlttq5/1H9HbiJ1pCcGkS7jUvP7VmbZqdLCufo5KTBkVccbCV8BGcpuTrbMz13mFmPoNmud/i11sHIgR9y0w2/0TYn+AA45rTq3XN/r4aMYn/ZVuRDXRb47Zj5YsUB5mD1fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AivWj+sn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AivWj+sn"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4376bd50b01so238617f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771835088; x=1772439888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RLo+RfmuSBtwLWYV0Cdsy2K3dP0LnVfNc+KReCQxxno=;
        b=AivWj+sn2izB2VhwcsAv4/lOsMEQGEM068D2MrFVQY60oVKogLBBzEz/6DP6tTMcz1
         1Sv7pQXSEQ9fa67IVwMrnSQaknIz5rl8WNYA+kUoWeUqP3M3ROcjhTHDV6llIwxDvTd6
         DyYWO1REGtoBteAc5ImK/xugcwXieGS4L3XNS1sgp52mccTbxfCNe1l9S+EGBpiRN9cU
         i1ET8wz0PzGNSLCyaX2z1+hYGhHltipj2NzOUk8LptKUXSkL5uNLCE1jARsb+yFXv4rR
         HMWxvFFJgeX1+yx5h3f81JhfKMLnv2a3K65ayOypf2vlHeD2wZ1/D+PBMitaEe/e557q
         1q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771835088; x=1772439888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLo+RfmuSBtwLWYV0Cdsy2K3dP0LnVfNc+KReCQxxno=;
        b=lVHOmOcdagoy77hdmEFLuZEinA0QtSrcz7YTPlOkZ5ZqE92NbyERbAY42Z+JO0YbwH
         7wOO8bBWT6bIIA8DsfA8RYNfHEL5h3kHeLYQR/BPwF1bgsSg4ZZzR9UvpwBfayaNNJQD
         3eCeeNpkws8ws227NqiSmZwBjR/i7gODo0WnqsDcw44nnMk1oLtq20EsFuEQGm9HkzUs
         zaj/tR2RBV1776PEhB5b2X4YUGZ0oPsGDEVDim9dqx/U46/5Nwn8IJFlzHlfNmL2V7jx
         OuFXQ2ovFZNk6QOdmznLdapN0yrpK/z7oZ92VRBo05rZsub/t8FXCDdQPgPLETlKvDbD
         KPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtXDNdOfiikl7RWwyqQfQv2lgKEF+MztTRqXAUXeCttEkRfemF9+EevJK1TRbeNX7ivu5PlLuo9fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mYuzwxTnppwAD6yNEpU35EKRBFf8YwRQ2UQcfN7YI4l9ZhXu
	n2pr4QBE28dWt7vf8kGk1F/M+hPDVDhNwI/7rzwAkTtv7W1wBvlVVTxZ
X-Gm-Gg: AZuq6aLGgaHapEXv3zWMyNGXKO5CyMGg4wZZ8fb540cKOAXxASJrqIqzQLuuvDdMH9G
	lyosS7GEnp9FubU8h4pSygpXgGLoYnJ0Rjkahnn/I0Mikm4UJwZXWnDLRtW0tGcrel3HJimLDSe
	3axNyOTJwMaW8TkdP0S/JcLPnSx8FoolRzHLj4tbtXFnTFBX5/VB9uQbDPzbgfO55wR9zTZqX6/
	ZeQ61MidHdD/+LPSWVbEGEUL+TcKD5pnnxiLuQTeCp2OWV1SIUp1SmoAEsGPdTCGGiypgfm+iX0
	hZ5fAgabABFwPLBbc770P0a4agZg+ocpQw//+mbq8cUdYuTL71+zmMq1uef3m5ZWhQ4Fj9tGuzj
	wp009rmFW4lieJevR7uX9C6nrAYgR4jvaDrJbt1ncOB8H5P/qpvpzdMDpT2y1hb4a8/S+7nqFFw
	i34y0dh6acZ5wGjxlP2NkXRJjgXemci7zENVW2h9Ge+QH8YvL8YA8atRCZ5NenyWei2zVBA4j1c
	d+l+Fsork1koWVBq4JV6hyqcrKiu0YzYlCAG9HA/3ZnEzyWqIfr
X-Received: by 2002:a05:600c:3111:b0:46e:43f0:6181 with SMTP id 5b1f17b1804b1-483a9644074mr69494175e9.7.1771835088289;
        Mon, 23 Feb 2026 00:24:48 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a4293bdfsm132701905e9.3.2026.02.23.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:24:47 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ad7173: move opening brace to a separate line
Date: Mon, 23 Feb 2026 12:24:00 +0400
Message-ID: <20260223082359.46403-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Place the opening brace of ad7173_calc_openwire_thrsh_raw() on its own
line to comply with the kernel coding style for function definitions.
Issue found by checkpatch.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ad7173.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index d36612352b44..f76a9e08f39e 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1763,7 +1763,8 @@ static int ad7173_validate_openwire_ain_inputs(struct ad7173_state *st,
 static unsigned int ad7173_calc_openwire_thrsh_raw(struct ad7173_state *st,
 						   struct iio_chan_spec *chan,
 						   struct ad7173_channel *chan_st_priv,
-						   unsigned int thrsh_mv) {
+						   unsigned int thrsh_mv)
+{
 	unsigned int thrsh_raw;
 
 	thrsh_raw =
-- 
2.52.0

