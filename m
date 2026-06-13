Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC01B983F
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781321500; cv=none; b=Ct5JNVuc01M0wDIf0dnyrO9R5CXcoCzCQ6ySNNqVbmCN6slHXXTiTP4OB8qDJZIf1nvQUoQt7Ri+cUmzw5uWwf2qXbHTKot6iM9fFynwNuNY7sEkLZGY7n9XWahrJfJapMaAHRWhTY+GGnSsdnQ54g5h8o28iLWhjAL7z+qyLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781321500; c=relaxed/simple;
	bh=3QcTyECCLOCka24VJfZAkp7UFl5yFcqwWb2J5pZl44I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cfHyhuAb6r6B7oV6PcvC4IUaEYbWEIzRpL/grAaXv+dQRI3mNpW1AWNBB/HNYWQP5jHMhdzRsFi7r3ye6h8U72X98T6vgVnlarekACj0tVSnOlUOAR2MLSPVPUH7vJlbANdqpdPodCreokyfpDkPIfpdElDUfuYTfkM994+AfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9624W6D; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9624W6D"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so1185087b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 20:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781321498; x=1781926298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDY//a8rpdrcO/gjVmj6uG+7B05UN/rgwOnkWQY0HtM=;
        b=b9624W6DOc03ozn/05I6W8mPQhuqhGrtnk0zFI3pWNK7QXNbJh9erAPw9BChtT6lFw
         XwGyIQM+YQOxYEWNCS5XUFK0uGjrTHSgqFxPlCHlczp5ovbph8V8Vltc3UlPFpci4LFS
         9c/iWduOBAnjr65rC6cWD66usCHMvKWHsQyWvRt+yG8YnPy1iFSL6OOyylmQqAPDmKTT
         8M1N6kBpf+pyAa0RAZroY1kBeRuKpc1NPdAUXFVlWcnuCWZ2HJayaB8mGMjsbEZQiNl0
         hJ0B2gAV4QZ9lYG/cyc+McLakKiQY3+fQAZw/a648M+rT2R5tAumYDh0lp1GWj4MLXlw
         6GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781321498; x=1781926298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDY//a8rpdrcO/gjVmj6uG+7B05UN/rgwOnkWQY0HtM=;
        b=Lw3UczcFJ294Q8R4D2LML9MP+LY+bSZX9H4wg4dMx30qQ4DemGeFzf1vqRo1rAvnhc
         l73iPxCtTUvexbxuiyDu9JxE44Q+Hj3o33T5DcxRqPZnCNmkY/sK+DW9R+UaeXC1CIUq
         F5gWc5v4zuO21A8wU9c1Ue2V9dTjhv4/qAqHgWzhSNSCp9qUc36o1XuMoiXcQ1mknM1r
         0QuK9Ve20zKeKC810UGdNal0ZZI8kznpwlHfC0/LaMQNePwLO/DNDaNmjISQFMcH45Wt
         2BUE2+zyOxZy4exGzb211HIbVIdrOqwqJKsZ4k8jpO4DS5bRw4dAn8zYjT3KdRp/Ixss
         wm6w==
X-Forwarded-Encrypted: i=1; AFNElJ8vzkvRO5URdy92KmDLm0tK5KLb/9QLxwoJM6KLDeMlmLQlvj0HlJWulqD7LxEIWIxX+/N8v93AgTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvj7w4n9qwEZ5q5Wu5Lbhzo5SEcMi/aF/CctJ8f43Fw7tYmFzH
	aPOEGuP8amimPf7YBDyPjPHUd6ZzwnEFxcItDlt2ca2OoZQcQohCc5oNX1X9UQ==
X-Gm-Gg: Acq92OHlesGgu0uTXRPN8yv1GuR3GjsMaN9PXg2f9rDnvkfgLXKZULHzU7kTUF5+h+F
	xahSda3/pUBLe5U9wdLM2YOk7lvpVPqyp0FplOqjMjVSOoqAwW4tf9q/Zsq7osaf5aJIcNg+PTN
	hLmpazXosWNGA6v4WzohDvd98PA255N9GrqIugLfsgQAHTlrOXa6vkN9NBY8fUrWJV1Yd9dUz8l
	+iZyuWQScT9jnc3/12zEFGo/HzZPCm9bB6eYfMZCV2+xu5zkGiDZNP29H19R04Bo1boYg5e8NHy
	WIsZBQIUeF7sxyVYJ1N/Ij7kMUWEfm99G8NVvvUQUuP0OniJI5orltN6/T3gOQuxyTfzU9raHsJ
	CeCxAi+dDvNd/I/aAKjxDgiZcWoMR7MnqTMcfjKdvpzSCk0tVp6Hf2luAQn+6dGDpcjnuFi2fZW
	EDDdGkMBXta8g1fTyUzFff7Wpk4uwBefyNo+kS5o306NENrFFj
X-Received: by 2002:a05:6a00:3e29:b0:842:6ec3:2352 with SMTP id d2e1a72fcca58-8434cd73dfemr5736712b3a.18.1781321497673;
        Fri, 12 Jun 2026 20:31:37 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm4010727b3a.32.2026.06.12.20.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 20:31:37 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: todo: fix typo and refine resource management items
Date: Sat, 13 Jun 2026 09:01:32 +0530
Message-Id: <20260613033132.2344644-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Fix a typo in the staging documentation path and adjust formatting of
existing entries for readability.

Add TODO items to track conversion of selected drivers to device managed
resource APIs and evaluate usage of cleanup.h helpers for simplifying
resource management.

These updates aim to better reflect ongoing cleanup efforts within the
IIO subsystem.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v2:
- rectify sentences/info following input comment from Andy and Jonathan
- v1 link: https://lore.kernel.org/all/20260601190836.2766703-1-sanjayembedded@gmail.com/
---
 drivers/iio/TODO | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/TODO b/drivers/iio/TODO
index 2ace27d1ac62..7b05308248d7 100644
--- a/drivers/iio/TODO
+++ b/drivers/iio/TODO
@@ -5,12 +5,17 @@ Documentation
 tree
   - Yaml conversions for abandoned drivers
   - ABI Documentation
-  - Audit driviers/iio/staging/Documentation
+  - Audit drivers/staging/iio/Documentation
 
-- Converting drivers from device tree centric to more generic
-property handlers.
+- Converting drivers from device tree centric to generic property handlers.
 
 - Refactor old platform_data constructs from drivers and convert it
-to state struct and using property handlers and readers.
+  to state struct and using property handlers and readers.
+
+- Convert selected IIO drivers to use fully device managed resource APIs.
+
+- Evaluate and possibly adopt cleanup.h helpers (guard()(), __free(), et cetera)
+  in drivers where manual resource management is still used and there is a
+  significant improvement to the code flow and complexity to be had.
 
 Mailing list: linux-iio@vger.kernel.org
-- 
--

