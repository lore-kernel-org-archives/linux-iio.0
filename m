Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268537107E
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670826; cv=none; b=jF6UVhdo08iyNhziHv9ZAaDfFQ4KAATt9ZitTLjtzOE+VpOKevfXLQs80qI2cfsr/Ao7xioWyUT6lcvJOIaCcTcCdbcs7hXB9t+kVZBUx0BoAGqlnYPGBq1oSRA73r0HeOVDIySKX90ZFCe4iVwbacdhpmhldlWjvw+qnZXITys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670826; c=relaxed/simple;
	bh=+r3hWxTQXkysroPqwDcpguL9tVZJRMtLqKa2esXah9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE0s4wmQ8/EBIdRO4skwzJh1Z/I+gUCl7q3Nc2DCfJWlIC00QoGSecntOu1oUwLNMA4/GEGV4mDwEa263qy/uYin5vtNKAHexP4oCM5RyBP+nsJ2zVGhoKjfN+9Ncr4W53zr8ep3GFxioKeYev/4OgMae7oYV1PN5vTssIavhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLywQ36S; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLywQ36S"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c56188aef06so285129a12.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 23:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670824; x=1770275624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64sw4lRVrQf0B6aWfzaMXonO9NSfuQEIJN4X/VHgUHg=;
        b=WLywQ36SDsrHaV6i33tdE9MKpQuPzroHY6iKUHxEdZpS5V38YtBwj5FBxQp2M+P2su
         /4XfvisPGfTdUU8UmY2c7vVzOq8G2CKIpF8uzooE9dKeLTXOvLW4woDIZM1kiqq1pG9a
         U43sGhY1MaNvG+JxpIB4y4ev/KVyeOFqtmNMsobFaq7ktLqOKPO1w+Y/PzanGKnh5PSB
         sK9WRi8zMAizMLFtNpchycEC39CBTg3SgcXvZEgw9xZlLLgvVWx3K7CbLWHTXfZTKDI2
         4ZbnjaD8u9qirc4TrTvXg2MRucUf4mtZfniSfopQVbbBP30JOZBclu9y5KtpUyGlrWM8
         OU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670824; x=1770275624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=64sw4lRVrQf0B6aWfzaMXonO9NSfuQEIJN4X/VHgUHg=;
        b=tBoD21mDGN/isEsLH72ECgbsGgM9AcuoONVDoz7qBj/2k+NhfbbLCbXJlPb6zfOVit
         Otn6wvf7J642IoarT+UhH5Ee3x3+czyNs6w8dl672i3S2jduaSk74Cnh3HpiPDSjIGBG
         84+BOdGe5ThJPd0KjbU/+giMwDq7Qiy8WwjPgqijzfExYBoDEX2Qw3NA4WXMCjgE+Xud
         /pljyrDqXsJaYr7KzhRNzopSMNkcPpnLY8QrfZu9jD1yU49iggy0Pu1Ad7uH6OcEunaY
         b4i7TkRCxkXO+EEoGjq/rVADrwxEI9r0/moosVd3WiD7yBGfP9eO796AkAiA4NvWgKl7
         bmNg==
X-Gm-Message-State: AOJu0YwHSzXljnnr2jU8LZYsuScR96F8XU5D0vdVvBhHpQjWQbe9IQsM
	p+34yhMKORiK8zmgZLhDqAzbie6GdaPow05hFujurTBovQ18+kUT/n60roG6qhK+
X-Gm-Gg: AZuq6aKKm2VB9ypf7mxbQMWnvOXHo2HNHLpMiX1x9N5oIsFgzCfjZHytyW0A2Os80dQ
	wPYnzXxvYlLyTceriRvHb2omgC9elmxrtUTU3aZ0ZCcNJ3F4N9bRbA+DV+mV4j1T4IJ/ulvSJ4F
	LaklaYD2TYVQDPanhspx6+sXhXyn89AlEICHx+4ZsCwqzEyw8lN7YCEF8mKTohinLkb2zucRGOB
	a4ZnAHnRgWrsi+9liy3hSUW0r/K6A4W7L9Vym5aps8QZK2O2xSPX6pNgs9PwGaWxNE8D/o2o/yp
	OOekdE9OMyl8g2i+TIC8ueJYw0yzvyiwVOoxeNNr6lNyNqSmcBEaNMlwEHFh9Shn2olei33B6T9
	2K/GDzE58cOtOCunND7024wqys5/cQlA5nfOtqvYz9kGl8xYUb0V9rQhIkZCHvwObZoKxl7r7io
	qH1cDpoRHY16MwbXbN+i+gxS2KJEW9bpxgiOC3ccRtVJyrZ8o9
X-Received: by 2002:a17:902:ec8a:b0:295:8a2a:9595 with SMTP id d9443c01a7336-2a870de207bmr72371065ad.39.1769670824085;
        Wed, 28 Jan 2026 23:13:44 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm44160135ad.93.2026.01.28.23.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:13:43 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH 5/6] dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope binding
Date: Thu, 29 Jan 2026 15:11:01 +0800
Message-ID: <20260129071105.389493-6-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129071105.389493-1-jerrysteve1101@gmail.com>
References: <20260129071105.389493-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device-tree binding for the bosch BMX055 IMU (gyroscope part).

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index 3c6fe74af0b8..907fca4e5895 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -15,6 +15,7 @@ properties:
       - bosch,bmg160
       - bosch,bmi055_gyro
       - bosch,bmi088_gyro
+      - bosch,bmx055_gyro
 
   reg:
     maxItems: 1
-- 
2.52.0

