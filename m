Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4D2E888A
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670810; cv=none; b=dFzvZb96CnCbujeqEvf4PRo6KM8nsoN/kz8qN8hOtNZ04J3PYRvCVqPYzb8NXqPnacaC3X4+ShBmEhfnxrNVDA2OcCDinqODeC7EcV6qiA09PvqWUZQjS/F3UQFw4MtO2/lPdVrCHi1EZV+t9W8akNqy7KXSERWH8TlKYF/m/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670810; c=relaxed/simple;
	bh=Pl3LsGXAU1w0hUE/eJ0/7aCXI39BmRJFYyqFT2Rojlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQe4z54l8niF61dDJD32qKhvF5F/hV4ndwNdJxjy6yx6D2h75Jz3p9eN4flFm09dUl1BFYQFb8xG2yhWsAPmYvXAyXRwxZlYQiUSDlW1DhLJcEJ1XEW/2rLEA6o9nyg8kRUnEql3KcqrzUrFiupnSn2/nU+EUNy1UwaJt6heMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U82NEPsr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U82NEPsr"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a76f90872cso3255865ad.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 23:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670808; x=1770275608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEMvCNVdZBz7QayGJ2jMAB9DSKFLF0OAwSH3cf8ofWc=;
        b=U82NEPsr8YqEU532ibncrHHXZR53igAw/XoZ33drTbv/dQYUfH8M3f3EmrLkNWyccf
         hJUw1SvS8SFCYMFqb5d99fdw1pEZSszjAG+H+Idv0gA0O/PZCPzDe3H4y3McJ/CChu/u
         TSfMVWzPqz+uyGBOxCyjpZca6boohh3ouP+CsZ8gIIxLAHSFzZ5/JphoRc6P/TxECDi7
         imxJ6bWk8Kl1hQyoVywey7OEa35Hz7aDEmzYntKP1BqbFREnRkSpKpfMqSgYpasbujKU
         MY6JAmscWklVHLZMZCMXQMTCZfyDDlKD6/Z4/pvbkFUmUgNlKWJDRBYfReC9yIIFf9V4
         JLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670808; x=1770275608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VEMvCNVdZBz7QayGJ2jMAB9DSKFLF0OAwSH3cf8ofWc=;
        b=fvoFbIxEzb/lBy71vL8klsALWrqbF3tJaxFV/R8s2nDFSD5NrsvG9lYtjPqjMwL70R
         d8g0Fjj0SOIcR0ajOW2KqX3EUfb0rZ/zZ99bq/jyDYO1rw1QnlUURROj6b9COI0+Dz23
         SbBhLssi9C3qKW0NhokyEgkCEAbvK4dbhzJn74SM88wimRBQRtNxWa7uX3cuLgVEHFjM
         RxOmbCDCKUPlilpti9F+7VtKV9k6P9gCGTeAhjsI66kTFEUc3mP+v/TuP9SVl4nct1+X
         abmBwtvtwHJBDC9//EovdKgl0jEB0yeh3/SK5SkwtvOrlrc6oFRyY9AizcfwIVuC7Io7
         KY9A==
X-Gm-Message-State: AOJu0YzIQOQr50gdd29GDPHIszhpj7iiC6brjbemuzHcsYg7gNbzXM6z
	bB+FL0hzvCoW/bURKcTzIgshlyQigv0HTGSkMJvtohiSKGkS/letHr853m3W9w==
X-Gm-Gg: AZuq6aK5qPx5z20ezgsBHzdbQMqLBkwVQ7kh50GDVPrjAxJt88VxLlK+xdhxpQA/0xV
	trUr/voNclyLo45DyWrQUWhSQA+cNUBYnRe0JBueT2FSO/C2ux/UVKLVL2/GIfi6+sZjPmPZUw2
	mE3+WUqZ76iYyFIpmMD7XHoa9vTNCcfS2X0q60I7Bdtyxwn5ruGy5+KZBoiRy8BCvJEHXO2hOh0
	xNn7WH2wLmifeVZXe56oEIFgRkS9Sb0qBVl8yDD5A2mpCYi3rGnHn+jx4kN6aaAhgdLRqDLluJg
	brtXQd/7AHAvp/ynUYPnkWisNd3RFRRQZ4m+lCMTXhANDJsHUuFW2TRJ+EHZ3w+i2yi5JjqCNRP
	BprQjQW93S/UyP9S4UWTQj6EAgqHQa+gF0MGXeaS5tGo3j6yT0b4pDmkedIDGauMaYkO6KR3fdm
	CCBJ3rPfepjTpxmYZQWi53cobvXY14UY6RgxLGs7g3Mzxaw59S
X-Received: by 2002:a17:902:e784:b0:295:5132:1a99 with SMTP id d9443c01a7336-2a870dfc964mr85505815ad.44.1769670807796;
        Wed, 28 Jan 2026 23:13:27 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm44160135ad.93.2026.01.28.23.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:13:27 -0800 (PST)
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
Subject: [PATCH 1/6] dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
Date: Thu, 29 Jan 2026 15:10:57 +0800
Message-ID: <20260129071105.389493-2-jerrysteve1101@gmail.com>
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

Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part).

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index c1387e02eb82..78f043c38e98 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -28,6 +28,7 @@ properties:
       - bosch,bmc150_accel
       - bosch,bmc156_accel
       - bosch,bmi055_accel
+      - bosch,bmx055_accel
 
       # bma180 driver in Linux
       - bosch,bma023
-- 
2.52.0

