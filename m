Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058F33E360
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038093; cv=none; b=lgqLnWOC/CRyPFvv61iy4rDyeqLJqx0daJYfiMIrYTaIzdPHc3AUMLB+1HoxbdzG1Mu7MziMXsTAM4XHGamU4LJqEf7KQfuepTGDrDfQht3EBmKnfD3iBvyIgmXebkJyufcjlw6vREjRb8LoLlFwVPE86rpqDuU9lgSrj7VTuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038093; c=relaxed/simple;
	bh=llI1eYDiE1+44pcJabFhew7U9QxDwmAqAUb32p9WxAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWJwQH0jGzuWFoVjGY247XyH0329jZuG/KiTNyi6V6lqL0AToMos9zrQTlhDqNDTfa9Yj4qlPNDJNJNl0NU5Q00Mcdvlcd6DdNkRbeIu9gf5IoOlaZSxOyCA6V9Ms58AxFR9UgIazrzUxObyjly6J4wpY6btLe4epqh+geEiQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b=NTbCVQSD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20251104.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20251104.gappssmtp.com header.b="NTbCVQSD"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso3336191a91.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1787038091; x=1787642891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/J6livk/VLSut+74toCa5+NkTdeXoYOz8nw8KIzNek=;
        b=NTbCVQSD7q3EZJhYjmEdN7PkWwHf/yLZ2dkzGxM+Wk/8ar6nAYvfdi1z4Qe0Z5GNdL
         8a7V4H4WQ0q153QA9uCTI9le3witxiNSfmDoyXAE4ebcw4H50nYxk74IaJQaej8KqBIj
         SvAAUqvGDOCrKH3xoPvMkX4oNnEJxb8Isg/kI7CQ4gEXwO/dBHkLatdyJo58xgedTFDY
         qEeP7CeUYns7o5InGDwKdUkqSlJTjG7aEPL9PgPqZAOip4Lv9uefj6HWJpzUAgEdwYEO
         7pnlfIm5rNe8/kh9x5MYyp5QOAJtyqGxozx+cCX0OWQdS+LB+qCYuCeXQtutbY6hCCGZ
         ePuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787038091; x=1787642891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/J6livk/VLSut+74toCa5+NkTdeXoYOz8nw8KIzNek=;
        b=ILpszqwquPYqV0Ls8VGxRR2mDkg2ZWWWQ9Q57uaHKrkovbaFTWKEH9Dv1UB7oS6+BV
         JI3puEn7xFUGXhAuZdWbOJ0Ij9rGBlsqU3GgAkljk5x579FEKq2iAOUNBF3zuTy8UCzI
         /WLpAyJ56KCrbrtxEpdUA1PvoDjm6Tdc/zgb0UHr3Ag08P1Fv5SGroNOm5MmDDHbKgwX
         +c//Sh+DanerebPaDMirW+ScCchYIGTyDdqulAjcrX+DcpyrHYm168ZKTapaTxKfEbM1
         XQrDAac9Wl0jrlI0kb04tjISARWCCemt5jzwNcmhmbJwifMBC9hRDrjrrvStjAG1F7RS
         l6EQ==
X-Forwarded-Encrypted: i=1; AHgh+RroyVem0MoZ4Jp/lPMioKxX0uOmvbI0s1NAgQNYXvlh1lqFTdNFxXhg+gwpe26DfkXfJC6jlq+kmBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Y4/H8sLLdeQYr0jcReLk4lCiNA291DWbJE6tzskd8p3j6pFc
	h0xErDoo3ZVFKWOONtw5AIkyhMvgHku4Cy6mxy50ELx7PINA4jcQIzYPBYd0w9IYhg8=
X-Gm-Gg: AR+sD139YWp/t4Shv0Zz5TLxKJ0/gkOmumJKomYi48aKpLohkP+BZcSWHn6dSuMN27Y
	oYp87BdCbzTD9V8FHJgxXTZ/mWKcI5+j/36jBNa7+7nXtW5AxeBmClMyp1gZ953th/JgBGykZm3
	9VwH49+/qdPCplALXrHRhNfokTQJJ3j1c1WvLKtRnQyWlxri191dC9fZGhgKlJoVvUZ+0GCMmin
	loJYtrgrbS3TzjUU0yp6QxSYmpMaJpDavSDma8S9TJv0LQDjWQRTfK+Sv92bWmv5+ew7ksfcNtp
	ZmJbs7LZXib6XRyqvCeFZeNZLbC4UtZgLb1CvEqBhhQCBAOJbewkknowRxlY6vSaQq4gbNOX5ZK
	7skjWEnLbJsoZ6lIFiMT/fYxqpsDuJri+4iLxNKajGBIU+5cUwKSg2+0eykwD1ua4qmkTWjLvfy
	gh8w8OTUm5HVAdhanEwHDYTvdmhgixK7Mpvdd4uUfyYoPd6wiEopcUaFIcqhB25nJshYdv7ofRc
	SaZBGbFSoKZKrA6VhkwIydeX9ntB2AGD09N4Fc9LHlMbThNAdVWaw0=
X-Received: by 2002:a17:90b:4b01:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-3933b714d4dmr29278418a91.2.1787038091235;
        Tue, 18 Aug 2026 00:28:11 -0700 (PDT)
Received: from lucianna-LOQ-15AHP11.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bd51sm5146630a91.12.2026.08.18.00.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:28:10 -0700 (PDT)
From: Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: gwendal@chromium.org,
	swboyd@chromium.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: proximity: sx9324: Correct proximity channel resolution
Date: Tue, 18 Aug 2026 15:28:03 +0800
Message-ID: <20260818072803.463864-1-zhangjie14@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The proximity channels were previously defined with 12 realbits.
However, PROXDIFF is read from RegDiffMsb (0x65) and RegDiffLsb
(0x66). The SX9324 datasheet assigns bits 7:0 of each register to
PROXDIFF and documents it as a signed two's-complement value
(Revision 3, Section 8, Table 8, page 43). In contrast, RegOffsetMsb
explicitly marks bits 7:6 as reserved. Thus, PROXDIFF is a 16-bit
signed value.

With realbits = 12, sx_common_read_proximity() uses bit 11 as the
sign bit in sign_extend32(), causing samples outside the 12-bit
signed range to wrap into the [-2048, 2047] range.

Correct the realbits value to 16 to accurately reflect the hardware.

Tested on an SX9324-based device: a phase 0 DIFF readback of 0x7fff
was reported as -1 before this change and as 32767 afterward.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>
---
 drivers/iio/proximity/sx9324.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 36c45d101336..de6176fd8d47 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -223,7 +223,7 @@ static const struct iio_chan_spec_ext_info sx9324_channel_ext_info[] = {
 	.scan_index = idx,					 \
 	.scan_type = {						 \
 		.sign = 's',					 \
-		.realbits = 12,					 \
+		.realbits = 16,					 \
 		.storagebits = 16,				 \
 		.endianness = IIO_BE,				 \
 	},							 \
-- 
2.53.0

