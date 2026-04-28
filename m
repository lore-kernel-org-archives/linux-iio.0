Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CE3ACEF1
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389769; cv=none; b=mWvqaMwlNkp0vpbWJBvK/iz9VpJjx7FcnfWgqhFe3FfDZnWDckF/LnYLntp2PMb8Yqpnb5Mq7mjHoXPHHbEQjf/7/lEzdl8HMDP0TN+yGEVT6mnxPVFRjj+h2/sIMxa3V8vP6y68K5zJM6skkqW13BlJ34Sdq2YcFvvvRMU492I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389769; c=relaxed/simple;
	bh=f/4yOoCV5vlymixcr/qKdh9g8tiEjeMhHU80anAg0xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1axoRHLS6ogbFeEEYrIPKUQL75nif1yF/ZxM12ua+WW/VQaUe9feSx69EHEXi9Rs0rjilJaVIiqFVKzcPJ6e6nu4m6h6DmuwNMwtqGBZPYTHv3eeP0tH4urFpu2ydVIgRhPM0IZpDAFQQuVeZuIDSycKp/6TJcbLZJeNIHw21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFVdDTvX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFVdDTvX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7650202fso8677029f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777389766; x=1777994566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JaZn2ogdCpK165bUWKFg9Ofa9m5TU5nDLpQsKfK5onk=;
        b=SFVdDTvX3o2+qa2Q7Tvh7lAyiKnMVc5WrGnp4Ya1QUH+dOXiUAMykNvDXFI6KU5jlF
         Xrk/+gJNJB1DhKqdT78/DEk58zcDUQn0DRtxn4BSRDe3zmAeEa384+VTr/1LnWr6LqE8
         tc1Md3kmrsFyCS+x4WSoGdZO9L54HJjjqviVo/JmTzSm9Xw9kuHP/I1MySOyga1cYkNQ
         joSVV93eJXFcS7vFMk2PlJqqmzTYwSfMFiB6CHczyxTwHSh2KWUR0POrbjN8VSNFvXM4
         SFas8gcEOs9Ilg4PquEwsNUk1P2cTepUdCfrrzrc0Kwk5eI+Wde1wC4sEl9dVtH62+iy
         HJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777389766; x=1777994566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaZn2ogdCpK165bUWKFg9Ofa9m5TU5nDLpQsKfK5onk=;
        b=irIIPCViyRCuZvZWZnGn4jlVSthDq/JWT1xuYb0XeejjYMKdw30uMJR61Wh0K6MqQh
         m55mopiyY0RbK06uRFw9KyJe3Ot4Ora/WGiJKU6VZRrzqpXQe1dCZfXsx5hqlN4fuafO
         a0unv+mkSH/HW4HgZTBX3hb7FnCLBQEQxwzPkegIurzJW+DuckB8zrO34aYZlxLv80v5
         dUOlwWm3miQFsnzGx2+KOsFDryPW2RuJU3COmB3GsK+Gn3P/50FUUHNVtf5bLD0NKcKr
         NvRExy2pBUUOZLsUzfo47Gkw+al2duznPqBvQtETJRwFDrDcPvhv302RP13/nEE0jhN/
         K5sA==
X-Gm-Message-State: AOJu0YzQLo4y5ESd+2816RovQ0vQuK3MVMTLUppOOvrM+qnhWLrrndOP
	cRgVdCih0TiLSWsZrfQPz6RIAEec4sY2PdIKuOZPRgOGiM5QNQYeSOL5
X-Gm-Gg: AeBDietu8NbY3ajcmLpoJgfVadP0Sg4j5LBjoSVPR7dcPxHBsgSCBxAENcmK39Ofo3g
	EU+QoHxC9TcqByDdhT12x8OlUuAe08rePGLGtceFtHm24M49V09o3dZelmcyLDdxmThbznnXzmF
	Q7FeUdFBgWeWNORFP2j38CynLFuhP5FDmVsZwnwNOYRj4s707A8RzMSBbDgFurChsnCSaEh837+
	sjE4iHpsa+KfWIgJX5iCYBFQffwuTvJf6/+WSMJIgjU6FtYQioauupBb9kefU4FFt3Tc0OePvcP
	DlXDmyRhXONTpb/wPHPkaXJnYzjxDg9Bc7BNjgP/yBpNooiVw0HTqd/oaMci6x/WCfljyt2F/D/
	A55gkAoiAzUJVM98w+5Xl96o6rDTAYT0FtDLADVu8NOYhHYR0UVRPGQ8HbtxO5WpCgA7JBOsZT2
	p/PTE8LN5Ryxyf99HgIXH2j5V0XnL7Sgwx0SGrZ08BfYDDuLpI
X-Received: by 2002:a5d:5f51:0:b0:441:1df5:480c with SMTP id ffacd0b85a97d-4464a070032mr6623907f8f.42.1777389766141;
        Tue, 28 Apr 2026 08:22:46 -0700 (PDT)
Received: from localhost.localdomain ([165.51.114.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f4c0a35sm8229702f8f.22.2026.04.28.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:22:45 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: temperature: tsys01: fix broken PROM checksum validation
Date: Tue, 28 Apr 2026 16:22:39 +0100
Message-ID: <20260428152239.66213-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CRC check function was incorrectly using only the first word of the
PROM (n_prom[0]) instead of iterating through all words. This caused
the driver to fail probing on most devices due to incorrect checksum
calculation.

- Fix loop to use the correct index n_prom[cnt].
- Ensure all bytes are summed as per the datasheet specification.

Fixes: 43e53407f680 ("Add tsys01 meas-spec driver support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/temperature/tsys01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 334bba6fdae6..104dd45598b0 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -119,7 +119,7 @@ static bool tsys01_crc_valid(u16 *n_prom)
 	u8 sum = 0;
 
 	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
-		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
+		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
 
 	return (sum == 0);
 }
-- 
2.43.0

