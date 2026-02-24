Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE037B40E
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931893; cv=none; b=XOOFh6kec59ckaQT7qBHi2mBM8+bSfg5h8bMqr/PHSM9QJle/vq/rRix7TljshW2hFuYCycHlkDXPCAoSP6HTWYadFb7RJV3Kczhr0Znpe9DdAriyJwmAGsNeodwaxwvVUKTu+HV/UfK8zjQXmQx3Ru2fsu9y04MilltetESASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931893; c=relaxed/simple;
	bh=0S7kfxKgV0CNFYtt/C16GTdFTBDN0GKO0twm0SiDPwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XA6AGpJrIJQcKT1DVtMj5apWpRFzD7aURSNDd21rtfYoAMf4jl7pQ98nYuLcoFOyEL7XIM6E93zPJxRd2+KywfilgY7wjHEClvcLDro2IqF0UhT3V5msjfTMbgXKFkuvBPiVZ7nX8F/4Y6aW6rwjMb555jaVxJ/CCixDTGZ1akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEJ16laz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEJ16laz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43595901036so385903f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 03:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771931890; x=1772536690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OC3RKN0Zc0MlgqDq1FsZc1BQM2szyCGZ/h5gBqb35VI=;
        b=WEJ16lazQ0pUS2Ny1f80mquGRhgExMfcpGLi7KpZIBxDdwS+B8qVn8QBiVyLW/Dltw
         gjXqnfCELJ+Z0OVD6767OE6nspZrARrtzh5Ex9GaXrcbhvdaM/lLk4xqHZGDQ+PnwgPi
         AO961QRZELqeaacFIhhnqjeUeXyUoFt7f7VQvhssA2gdc6XexbbdawSmNxUWZPUd7MEl
         4nvupzg0/kVa1mBBSF4uD4+N3aBYIBb1aaDbj7jkvn32Esfw4sB6ckdPZBJJS3GXiEjR
         rXUdkebR38hJEapYzwAQKJYY/HChKw9/vCdzdIn6+3G5O+b9ABzUSdatdr+uWbRVUF7v
         jmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771931890; x=1772536690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC3RKN0Zc0MlgqDq1FsZc1BQM2szyCGZ/h5gBqb35VI=;
        b=dnTs0Yrb0ZOoU6+EXGpvm6ZHBe9p1EdJ0iLgceaqGxHkqg+DO30+eq7QPw4S1kiBIY
         lNfSdy9iNeIjRz9GhF+RK8YwVLmAHDja7YVN/Dz74jJvD/fNtZ/IQkx/0M6pnthTYQs2
         9BgyihHHD+LH9NDyIBaa5nTfA+eKmtl4C8uyPEE+t/73cGqdUE2aA+jgZ9D99dctQ1/7
         sXazoe9u0CLSgnnQbp+VW9VKo3W0DYCOFd43kkm1GwOuyTcYjD8nwdokime1lo2DhT/+
         Kxrzq35HqQuN8jGGih3tGKFTelqHQqnB8cIqYcroW7MvSFeS6Pc/zjvZU9c9Bli8d+MU
         /8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXo4Ch3V0gfJ/7FJEXF9+DZqIdxuIhJKWX/3KfokngnGuXjF5q117bRSTWee/uOg7V4VL77aCe9a5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jEFb/vfzsQysPRkk5YA1TLkdIhKVNFnvqmbp/VtaKvCw/+g3
	O5H9+hkhKRVyzFh/k7bNV51ewoq4YZeN2U3JPKBCkFsafNl9Eoa1ec92NSoNImen
X-Gm-Gg: AZuq6aIxwGYWejK7DLMiRY44bBn1F32b2rlOrvwUyu3l02G6Frkww6H3H+EsiDFOxjA
	WLTtjuewnmb4+7AknMgcBYbWinxFJDGt93/5288j+QAlhIm1s0Lu9Ix5WvwLrW5+1q9Qs7UPrx0
	j1BSs//MV5u7C/ql6kYt9yh71dGCxpiFkqx7I1I7MZCeHilngbthxJlU9ahz4dHsgGWjNdq22Sk
	6cJ8GX6310P8B7KRgyL1FSZQpGkqQsI0KRr6Ca8b/E0PSWQ1w4Q49TB1620EsFk1Qng9VyQhtd8
	l3MkatpDWvDgIB3UlSONByE0s0By1yOR2FpicAUjkBFANGk8J9gN0+2bvqNr1BaSIdkwUFCUwiX
	saRzlZYTvtjW1e+lOtlgFQZxK4o814cH5iZh6irhNf4zoXyOXpYiIAwa4O3XRBSw6HS/ay/sKt8
	s/P7Ga5agDQ9tvn2nU53n3SRq2MxXyAp5K5Y8QgNVkHy9eYXI8AzAkJ3/VUPZAuHQBSG3uwaXA3
	kv4EX1ml10MHzV1DZe34XCtY859Gzo/K2RgahZiQdJA9gGQnruC
X-Received: by 2002:a05:600c:1e8f:b0:483:79af:ca1e with SMTP id 5b1f17b1804b1-483a96382e8mr115944925e9.5.1771931889828;
        Tue, 24 Feb 2026 03:18:09 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm3652769f8f.7.2026.02.24.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:18:09 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ade9000: fix typo in error message
Date: Tue, 24 Feb 2026 15:17:45 +0400
Message-ID: <20260224111744.55378-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in a dev_err() message: "maks0" -> "mask0".

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..4b96651e6cd9 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1549,7 +1549,7 @@ static int ade9000_buffer_postdisable(struct iio_dev *indio_dev)
 
 	ret = regmap_clear_bits(st->regmap, ADE9000_REG_MASK0, interrupts);
 	if (ret) {
-		dev_err(dev, "Post-disable update maks0 fail\n");
+		dev_err(dev, "Post-disable update mask0 fail\n");
 		return ret;
 	}
 
-- 
2.52.0

