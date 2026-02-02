Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFC2E8E07
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030212; cv=none; b=SwQn+sIlJqUJ/5tMR4ugsP3oI4KQWTe+VO/vIf4fXKfXYlqDlFDYxzqGrHNz753REprlQTRPJL+qrvnkB8pBX6FHFrFKB4Mjn//l6K70QRvP2SHXP3mlFigGVY9aUzPijCedHpNyWk6afF4jfyyhQDhKHXRT+myACt2+BkbXFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030212; c=relaxed/simple;
	bh=m/ziyU4HLGC5IQ7uzs5nBrRKBSwg2S1LdvZuY/kbNk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUL0UJzRUhClNa2usIreGnutetcpqt/nKzvAAZEreDEn6TLFc9JTkRt74cDM7ATajG6qRxOGr+WEAoYnJZ9aF9uk6/0P2Tpum3D9h2NCJZTB8OoUCh8cEPI80rGg2Oetf2doTH0lQ4o3NxbWVb4KJ7VeKFjj9XqcH7a1dVRmD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpsF76+G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpsF76+G"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a12ed4d205so25499805ad.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 03:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770030209; x=1770635009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXDwaifGC6j2k9hfNfLuDwLHZpRvyVgqB/72HtEhxLQ=;
        b=LpsF76+GzOXQD+ZbuWYWnj2bSNLAS2z2uS9tw7wjGrXld7RjE3uohc+BKGGnExTEQK
         6OkkOlyEfVrOzUKT7X3+UXZaOy5BF9zc2zMq4WaY1JzDvaIom7Y3K659GSNcZeYkiVYU
         x3ImLxKD8l5x1ktMf1DtrSZ+z4ppbHgriAjsINTfvl1jLzUCW46Rj7mavOhxXI+VO3u8
         6xOJCrpNl2Wtk5felRRm4J1UIAK8WLNAfJdEc+FvvbdjC/E+UV8of39p/Gn+e1JVPbs3
         8Eo1AHqBOsOaPnXMDwyPlQR3/1UtSZr3OKnCV5CnR25qEE1Ri5MWul4DH1VvT8h/HG/M
         aJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030209; x=1770635009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YXDwaifGC6j2k9hfNfLuDwLHZpRvyVgqB/72HtEhxLQ=;
        b=BLX9m4jdo2sXWLeZC31kVjoNFqxIKQCg4cYW+Dwo6uYoUHWkrhWSq6GbwUTGEEQo5n
         PxpfathfyKjCPZR30Kwht4rKc9hRqL2HrOYHM820I5LuX13551pZrsSHhw8WP8Oa6QQ1
         ckk6rBgvHkPnH8kvaKtY4G6JDNcVTp18ZXYV1RJLGnbDEBbdfkhkGWRkpCboTHj5gq+L
         dQLBXfC8I8pP+QyUCUmi+JXo+yBDtQvr7XdIS+9tpubxefTnzKbNXLKNVZPqKTLB2zRr
         G+3hFcB/aRMcvHl3S8adAQ8il3Wa5675XtyAVYnvpkcBzHPUqCTXwiPYJBT6qyjnA1Au
         IT/w==
X-Gm-Message-State: AOJu0YwMqne/JK6C4L+8fkGn0wJRQdqNZ75rmRtEdpw+3g7AqER/UbpK
	8bJV54F5pmH6Pd5KmkkoWDYLf045h78VEeRUenvvDvbekXjxSZrxaCtevK1K7ab6Z8c=
X-Gm-Gg: AZuq6aJsLhCjNq39/nXxy7behxWjJltNlgRCM5eknqETLzhZ3mtUNjdTHCBTiCCAbOW
	HlNdpckReReb3tprHEynY8+n6sN4ruMzxP/EbNGwiloT8HWt1wFL+jpKZBwA1siHPqdyDSWdk11
	h5gH8V1A2m8pUHMZ9mjICIK1gHaSkxrmNH0ldI8/TL4AVJn4cs8RcHLX7YdHD97ebAQD0UcLleb
	LZtZjoxBFKwB7mbd3WVpEJqfmxC3hXuB1plmi4Rix8W3R8VQWCc1XYkj9GtJXVS+skJ4CptnZ4K
	/rKeDoEkzn27WedJeOZQ2aNsywP2579wMhj8lpCizJHOjPIMdiK4mlORAJ4KDoodKgTJdcSDCg1
	+lprRINJgmz3MBtevPoiJnDBGq3B0oH/cbTHuYMB0wrd1geyYWZxiUYHBBrRyqm6BTY8yC7J3FM
	8WF6UzzsHF
X-Received: by 2002:a17:903:1211:b0:295:6e0:7b0d with SMTP id d9443c01a7336-2a8d995847bmr122089875ad.56.1770030208659;
        Mon, 02 Feb 2026 03:03:28 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5df0desm144007105ad.82.2026.02.02.03.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:03:28 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope binding
Date: Mon,  2 Feb 2026 19:03:00 +0800
Message-ID: <20260202110304.236320-4-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202110304.236320-1-jerrysteve1101@gmail.com>
References: <20260202110304.236320-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device-tree binding for the bosch BMX055 IMU (gyroscope part),
which is compatible with bmg160.

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../bindings/iio/gyroscope/bosch,bmg160.yaml         | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index 3c6fe74af0b8..e19aa1797f14 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -11,10 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - bosch,bmg160
-      - bosch,bmi055_gyro
-      - bosch,bmi088_gyro
+    oneOf:
+      - enum:
+          - bosch,bmg160
+          - bosch,bmi055_gyro
+          - bosch,bmi088_gyro
+      - items:
+          - const: bosch,bmx055_gyro
+          - const: bosch,bmg160
 
   reg:
     maxItems: 1
-- 
2.52.0

