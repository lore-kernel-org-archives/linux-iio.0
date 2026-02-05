Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206441C309
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304075; cv=none; b=fBQmVxzryiYHmZha3uOOW1HFYslmcJKLeCm8yDUV92IuZMIjgq1Pyj9UttOP9b9M8CEkOu9wyH+WpyvH/9UUJloqrD2GJg3a1zWWUdn5dcHnlXgYJ7FfRoluBS2FVcAohfA9nIV0nOqDX9AvoFL6EaJmPEKEJD8DJY91bDyifVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304075; c=relaxed/simple;
	bh=Ibk1eOjo5LGn26U6FufNlY5QjJb1y2/gbBlzQkx6zzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHIWce0lc4f3xjBoPNowNLt0YQ3dFqRKi9KG0hs/nm+xgS8jHRNbPQJ9NYXzNvljtotFdbycJ/Xos0Zkqpgp6pq9KDpl5c/muf2aQtJmQ2jeEMp3Ff1yTOOBi5cpsT3o6p+SMGmUEhmDdnMZ/IkQLPaaUgGR4BvZOYne1lZEHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9kRNWpf; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9kRNWpf"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233c155a42so1427144c88.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 07:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770304074; x=1770908874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw49c4EKLVMdAdrwNMly/hTBXaftlDCgL111wVcMz+Y=;
        b=Q9kRNWpfhtY9vZNSfwNWkl0AL9CA/uARornpQwMyryTmjd6nkMRZ1wWfFqWRjIhV0B
         tKUdQVcKqi8ZJGrF94dei7Cl1aBKoXzh2PZX9rvDktTNT0nQxCpnQQJUNWGFq0aXWpMm
         ZnF90fh8TyBrqN9DNnSsgujHt915TUKocngxnLPK1xkEQ8D0kHKBBEuiX2wjoqUjJIYI
         8CRr5Jw/XgRPKt/65hUrpzus9puotmwp2mQERYxTkU+mwI+VXGKmihSA6moYPBPgdWnd
         upTSL58wWdSxid0O0cUJjHq6Yt+G4k1zYAFXzTq42c/YyEfHjl0FJ+E6fkFqMGqDv8dv
         2OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770304074; x=1770908874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tw49c4EKLVMdAdrwNMly/hTBXaftlDCgL111wVcMz+Y=;
        b=CCba3COY0XgvSSHHWxspRKtoZneqR9e5iayGNApUba2r/k6HPb2i9TYzqGJMidDugb
         aVyibBObf8G3s/Z+i9H4IQF7JxyfdQ4IO+B9628dxnIjvr4kEfIk1rEARKpkp4YBy6em
         l+f7ci9Hq2PI1SGitu766qOU2eDaIlNSZiT3mhzNVadUXmjibHGu+wlBnreuaGsz7r4b
         sXtlAt6BMd5SR/0KJq49QGn4a9hIFVvk6IsorxoDvo8YPAdtj9kWC8AQKsBIVDeUUlui
         7YRNJuWZPZUjTd4EFJQTO+neusnvGFS064DmM4clO3tp5oAmq34vy178zqg0fqjqWq2q
         bXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaAvsbOIZrAxpIZx9mg1n6Y729dsRd1qLrQxPBp0iWWoQlQmVhwA7M8WkEanoFywI+025VRixVkaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3tK9qORpUjK/y1MluBq/rAvlmewW4j8ROiABkC1UO+RyuIRU
	H3CS5J3utI/5I3QYmD4NXX5GoindpKD88ybfgzmwKq1YI9gneHzDT+2K
X-Gm-Gg: AZuq6aJa3DzNujZubqVvITMXykNVtURi3q7v8BDEGRGI5zTxkgYIdY6jubqTJJpf2gd
	qbJAULPnl+ALRv2LUE6QwlstmjQokQL1vn1ojDHNPcg5GZTP/ZH2VhZpYrKq+rj/r0IgyCn5cWR
	/nuxW+daC73BhgBwUR1LW6PHSjTjp/60SOpwyGOHjXSwL55Xj6gPtjr1ceKHO2iWf32OwrPZcJY
	skYXC2Y8lePzehWnVMeMseIAj5/tP/xyawIAq0f4zj5f18CZJlDlUKvyXq0URX3szIxw+O7eOgW
	YLOmaeKMgdnXMuljz1XrWiiSi+leKtI5Wa9nRxOtCtdgaRGiJCMxG+Avyf/iiMJUrajCz/f9zWf
	BoLjsmvnudbEhmalLB/I70ozLggdma8Z7yPxLkffoO0gMud6cNuVTvFYm6oaPw4BNQ30TNjetw6
	F4ugXYOnp5
X-Received: by 2002:a05:7022:41a5:b0:11b:c86b:386a with SMTP id a92af1059eb24-126f4780af6mr2507315c88.5.1770304073773;
        Thu, 05 Feb 2026 07:07:53 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e04467sm3909693c88.2.2026.02.05.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:07:53 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v4 2/3] dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055 magnetometer binding
Date: Thu,  5 Feb 2026 23:07:29 +0800
Message-ID: <20260205150734.525947-3-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205150734.525947-1-jerrysteve1101@gmail.com>
References: <20260205150734.525947-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device-tree binding for the bosch BMX055 IMU (magnetometer
part), which is compatible with bmc150_magn.

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 .../iio/magnetometer/bosch,bmc150_magn.yaml        | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
index a3838ab0c524..c1a6892b0194 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
@@ -21,11 +21,15 @@ properties:
     description:
       Note the bmm150_magn is a deprecated compatible as this part contains only
       a magnetometer.
-    enum:
-      - bosch,bmc150_magn
-      - bosch,bmc156_magn
-      - bosch,bmm150
-      - bosch,bmm150_magn
+    oneOf:
+      - enum:
+          - bosch,bmc150_magn
+          - bosch,bmc156_magn
+          - bosch,bmm150
+          - bosch,bmm150_magn
+      - items:
+          - const: bosch,bmx055-magn
+          - const: bosch,bmc150_magn
 
   reg:
     maxItems: 1
-- 
2.52.0

