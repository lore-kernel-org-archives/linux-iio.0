Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18733429817
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605626; cv=none; b=D0kdv8TOYk4mpWe7Zfuq2aGl3+trTs/m2tnnqM+61f+R3JkxF38J/hsMKjNL7ng2bWnuC7y8mX7zlaVDkmVf2+jJsbTAEi0361acoAjSHLdYQUVEYuCiIlutNWTay5e2dM+cZj4Iu/TNi35HT8FRKScxhHQ24t/C33jPrhLzLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605626; c=relaxed/simple;
	bh=z0lO429YQ1YHaPWQ01cs7ofc9fO22/E13jQ+Br2+zXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4NQsl7aVi1wfkhnnXp7xKwE1llLZP0cUvTdlg2UzfpsoDcVQzEAVTqRsqTz5hKcDDoqjA+9gidplouBowcv3d7gzz0ZesNmPe0BZhlPb0NPXL1CwSVW31P0C+Bmu8p5UAqD8ZCTuJr77yXAK8UWXnqzmL196H1l/YzonfQO4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTS14k0j; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTS14k0j"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so1626609a91.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605624; x=1782210424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46CYN65gcFvANab5ciZl32HW4FwZDx2iL3RnqKbWKCY=;
        b=RTS14k0jlxuSrUHUZMbG+PNgHHdUIJksOOKP9kEnMVSKJHlk/2yzyHfHnTKVjPfLG2
         tkXUS+2qOZ6p8qlfyyPcYWmpdLf8pBxuCYtclh+tY7+9o9MkQjW/IS55G2dH0UZ2Ad4y
         9vUnEAnO4g9pcbta6VIdH8YTkYaeqKgMLzUtUGthAqSA1F3lel2SK4JswMKo2BezhtjG
         6C6dpJ78ejlDG2S2sUzjqqtkuJiUalrhNH8w0i9PNKb29WXDZe1xwzKHTNJecMdxzam/
         hMXpJLsRdYqY9tTuwQVfstcnv8JhXllgrhkUGJw0koxwamBEVlPqJ5z4gwUYVFDO+pRJ
         XdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605624; x=1782210424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=46CYN65gcFvANab5ciZl32HW4FwZDx2iL3RnqKbWKCY=;
        b=Bn3YEh5f+YEsSjc0hAOMX2irvr/JNaBCb+ue7/OlPT+fVtoF6FigM8U2ElRr/VcwxE
         dZO1qtoevSa7ymFFdL2klQaSYZlWyBCeOaHIxQV9OmArvxQPbB3yK0OGmOiCRgzjGOm5
         aYlVBlD7xxlfAnTf5Y63ZEjlIGs5zy6UtxDV4iU4RKllT40Zkj/mw9MWbDTFT6YDsIHW
         tQNphz6p3lK/yXKdR3vwYy4f8mtL65awUVgQ2CKweuaCfzLzixpnNPDXU7Gpur+vJpIm
         r1l/YmqPRn1UdHMsuWwVnmB0zvSAHtw9/De1O4LjwpjrxYKsdcIj7iBuiIq6FYo6cYtF
         3uUw==
X-Gm-Message-State: AOJu0Yyjc/ypQ9ZZmaMxobnvMWGSAN7xATUKHOfO8I8p0dWdvDDIJMva
	xdqeSvUP9n9iXcuOgAAb5/vXrauqotsxhf0Hmz94Vz30VVlgv7cNXKpN
X-Gm-Gg: Acq92OFoKLQPkT3rIprZIm6hL3zHO/LTieK7dsNVuIPxG3XnZJAyR5JN3toNIqsocev
	ws7eIqZm/93PhOXye32o/ZzMWs2YJBa9Lmiwz+hRkx3lMvXmCKiQCt3slS1qsLF/n5QHOuwDuv5
	mDiOXNjQrS3/mEn7cc4eOlDku54/4SxtUcbqbb6p8Lun5czGjuEnPccQ/+qb8NxJcpg8JMHPU68
	09KYUC/X0qtLrVRX/3fJvCj4o20/4Tgr96qsWFvKJpnJHeYBv8PXJ4CnoL/e2R54gd2u56/fEj2
	nSziZp8RG54csZr3EsRx7WanxMLX2iSbqoxh3/jOFPSrWfp5qwjMQmFiQljrYmwMDG/fdZ+73GM
	ENtBpH/OGTt0Bq6XeD+iYfBhgX94c9XoDGySumvy6RFZvwehXknGxwzc1Nl3vxtTRYFRyWJ+eor
	Ys0rnUrSVFF319/8BZZWnzrJgBJBRpJpEPiWu9euz+RMcUmG24
X-Received: by 2002:a17:90b:3142:b0:36d:b662:708e with SMTP id 98e67ed59e1d1-37c5231b9d3mr3363257a91.9.1781605624499;
        Tue, 16 Jun 2026 03:27:04 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:27:04 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:13 +0530
Subject: [PATCH 08/11] iio: hid-sensor-magn-3d: use ! instead of explicit
 NULL check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-8-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
the preferred kernel style.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 82507297c55b..8f7a0b2bd795 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -467,7 +467,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct magn_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1

