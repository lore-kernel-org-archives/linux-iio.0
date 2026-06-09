Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB573AFD10
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021855; cv=none; b=BmqN8CSbM23JO/1B8jYtFYOtrV7ONxwJvT0K5buSQxNkbgPTiHHEdOik5fjBqMVF1inHF1VANT7MZ92lwSOa9zd70yykVHSDhv2QUvaitXPaB9cvRz6nY4PLym6UAJf204kZMc6u+leB9LVq6IWsRPz6lUw/JTEZusv8mJ6aFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021855; c=relaxed/simple;
	bh=e1qWhQtJcMNAri/ExRMPn8OMwkFTMrLndHl7ML8jUXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaAVc/X/fjnpH9PVqJKT4mX8nDZKXbMqQxu0w8BBiKB2LY8peGKT1uoxelk+/qbziBcID5JqcI8hUmoL3izmDvBgRAxaKk/xvOUM7kLszElt1Hfu0N9mmCyT5RLMS0vV1uHse6V/9Coin22sWjAMxenlngXy1AtLmtB4vCzJe7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyYHxY3+; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyYHxY3+"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e8a8608d7so1498018eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781021853; x=1781626653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExJ9aOV9PvUXbz2FXXaIoYeN8C+DD7DPJ40uiTsqRJU=;
        b=MyYHxY3+9HmTrtTsen1zbXv0W1L9bNmkCqBV7w6/q60DNr8BNJHaGx6unJzYe9ESMO
         3KUC8uvi83LPHjWEZKkl8uUkjk/1rRJiBA8s8G3h7KlAAO8vzR8uLqtiW+hXpSR6ivMz
         appQMP6iA8eHUT+mfnsO16EubSPLxnlL/tYpHWscyZ/dOBD/hmHlUzg+xJcpNZt9rRH+
         70GVamA0m+HThYgq+5an3CN1DSqo+l+KZ9hjqWj7H2WhSHRpHl2Jf37GTsq1/SViQcDP
         CJLVfyQVlOm8v5dleCoRhvyLQqFi9dsWOmo6HRwV7CxNqihHtnSgVLLQ1idcWP8DU90d
         ALUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021853; x=1781626653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ExJ9aOV9PvUXbz2FXXaIoYeN8C+DD7DPJ40uiTsqRJU=;
        b=QWTaKyT2SpAeijNMsVM4hZTLlFsaUm6L7zoZyBxE1pbjBroI5jvviW2bj6A8EQodR4
         BDdsUP2q6lfmeCnvZlSckkQWLEwWV1nh7QiCk1UzqckE3nLS/IgNE8FEMM9JA48kENb+
         e4JLou/TMv37YgsVr7EO5MCzhB8eZYsG1vs+p6gGH1f5KXjtKrRVbMzSyf38tU9OD8pm
         XPOHrOUCxkxrdpmE6fbpn/0HrlZl9IN30EW5wotOavnCYVM+oMadZWljWrQ9fVPE0FvA
         6HBK2oeWdtkBK8/fVlp9N99oMAws+FalMFNuJPtqYnZqkVTOo0i6svusWvWkNYOD6J66
         xiDQ==
X-Gm-Message-State: AOJu0Yz92+11GGMOWiddB8o/rNKhJMaBQUOzYq+fLm7ePKe66PVHqO/j
	Edm9oeQF29GG09Rk7y5zXSwVloh1k1SkVr9tCepWBEKBuPbCSbYHiLgz
X-Gm-Gg: Acq92OECsp9/taSKvfFzaSzPVlRnUdd8/uV6Yz4p0JO8oDbgCKOCKTw0HaSeQEEaaNP
	5jEJJL2TasomyruJOJBq67+UZ6CbYpy8bPq2AnYUi70SIQRk+MWciITc1Y7AqMy0zoEDD8vXg7Z
	B8Q8QP2RwhNJ/C7IyBGavGUIsSmU3ctg3kHRupeoSpD9dG/XNjOxWRcBAl25vXlJqrMJ2yJLfXH
	ZOYf74HCn7Md33ZYA6es8ubkbKqHOskv6Wa6MHKH141Ttj/OgAR5Vuhv+KMctMM6T5Gl5MytjJo
	Q3CIMMv87ucR7BTQNT+MRuDaqv3xr0r+RYozeBCpgdU0E5Ny4KeGAWtbZsnDp60aKIB+eUVDejq
	XBibOEwhklvR8yTLMqm76r5rKCoU2o0xz9N4HELKNxCA4JDps1ZSM078dd4v6lqdd5u2/Sgumwm
	UZQb0sAzEwFKFAtZ5IXENS+vkFw0N0uAJveSGb1jI6dqjm2yNnAzvQRR6gEDgtHMJ00hmLWfUn9
	0i4zZg=
X-Received: by 2002:a05:6820:1907:b0:69d:c156:b9e with SMTP id 006d021491bc7-69e68b51ac9mr12375469eaf.20.1781021853216;
        Tue, 09 Jun 2026 09:17:33 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8448e3csm18797906fac.13.2026.06.09.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:17:32 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for SPS30
Date: Tue,  9 Jun 2026 11:17:01 -0500
Message-ID: <20260609161701.52513-4-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609161701.52513-2-m32285159@gmail.com>
References: <20260609161701.52513-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tomasz's entry is no longer valid, as he is not active anymore. Add
myself as maintainer of the SPS30 to replace his entry.

Link: https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/
Cc: Tomasz Duszynski <tduszyns@gmail.com>
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1b0a40c02e0..49ca275410c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24262,7 +24262,7 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 F:	drivers/iio/chemical/sgp40.c
 
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
-M:	Tomasz Duszynski <tduszyns@gmail.com>
+M:	Maxwell Doose <m32285159@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
 F:	drivers/iio/chemical/sps30.c
-- 
2.54.0

