Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00338E129
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666927; cv=none; b=EiulzSMCOpMDk7RbugQgh4vmbsprtKWtjaD4widyryWCJ8LIfohfqVxy3LXadKoAAUAGz7A+lSEwS9KnlXJZftzN2YViRz1qmpJWw6dxDfcBvA769eQj5ChMbpDVF7MIzXDptes2j1hDjmCZG6E/9YO5FPF0Vws1ctCFJ6Ft+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666927; c=relaxed/simple;
	bh=BP9Y5imhZt6VwYElQw38JPEeaJUeu8Okg3buEiViLRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oSdAGaQVB/NF9L1JU8wV8DrrTNmPM4kzjnh/rw/DF31L2AL54eDw+sACOknlICC9Jbpp2E/AuJENrz8UDUQ9omjaRCEIDSl94+7hmMGjpjkj6vU+1cRIwo0YeR0SeLenBkFRduosVdH2GZKmB0TBkAi/1ZfxCqymG/GOCYd5+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXdM+jcj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXdM+jcj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e69e60063so5839305e9.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778666921; x=1779271721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3pj/SqZbiUAT6znzy+V1YyumfwhBsFna/m8RoWol8M=;
        b=lXdM+jcj6k9y52qmqpFklpYwA20y2jr3C3AEH7rGzHKPquwb4jRe4lyXlZW3NkVmcx
         t1DsySXX0JD7hkIpRhJYyWGFmQB/wCChqDqpZ3ryRfNt96gP6TMr3fyMgjgqPmU7lbyv
         ElrNpyEzkNDEzJWMwBbEwkTW1lYbXrh0ejrpzp9DObnvbAck98XAU23u4q42Rg9ubxXp
         KxyZBDQWjnQ+vHttgd64FA3BRsgNXFDIuyftMb0JYrK1Bt7Ehe87KGHIhXx2G3kbIroO
         LbUTda7vTRyY11x6EmQY5nsgw8y1JQ3McMO8cklW6z/CLJWIQmNosgTpoMc3Ms+Wide8
         MPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666921; x=1779271721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3pj/SqZbiUAT6znzy+V1YyumfwhBsFna/m8RoWol8M=;
        b=h74hLfByLlxq6S4vDWTh3jECOdRI+pLfxeFApmhywFVmYtD+TMOnj3UPZvvU63VjnR
         YCDyU3p4x2iWRdxG2TD0e3g2dzSSG4E7I5U0CK1qT+VCBy4Nwky8KVMcLOeALW/sG4oG
         NQiUhPU6FAbQR9TXnoHY94v6tjPM7ty3u+ejfzVGLPEun4EZznbRsBkNqVD7zT3lSSup
         TmGJ+DQvpeS8LcrkQSWSuRcN0ZpcMJCeaRLXr+TfoDuCNoOLovJeltKHMecVFSlDjXI7
         cbMvATmHZ2WuN6jmFRSM4Aq+Nf/uA710WI5Jl9RkVTGv8mHkiLWvPVV7xxLUWR9FY7bS
         Fl4A==
X-Forwarded-Encrypted: i=1; AFNElJ8v97QkfU3a6dpLIDmoX7Q+ufokmO/jKJ3Hc0PpUMfFYEIZw6W4warXgTER9J0eIjA+6gkQ/SRPm3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBuAFDAV0eX58/OW6sR8hMPEcp+ofzNkR+/u07eqmNOPgD/OyT
	8NFe3seUACinQ1M9vho4TlNMN1YVPq4A228IXZqKswTbpnCpo80SH9Bm
X-Gm-Gg: Acq92OHdNQJvLKvrxfPA5yPu6ckrd0rZQeNlcnFCXaCsYg0OCpP45AVH/7en6dnIJsS
	E0ND9bU+4lXhbX446R/ZOOO+De2jvTjwuAmI3U8ANPQzcGXO/62f88W73h+GQzRQbydbY+i6E3y
	g9wq+h8cj3Hum84s33ba/as6nlVnM4By8UC/X8fDSG7wtZOAoKXNdM5S4RJjs64kKNLyIUuQTaK
	1HYKVznGdRAU+C1XYVKgKZWtvAg6AmL+g4rOmeFRIJf7csUTFbeFYwfoy0w20mUC7P0bxnWPjMJ
	NVultUHNbGsx4xbcg/Dv2I4SwzRqhmj+WNfb20oDzhGrkP6r7mVuXaVPQx4K3Jz7tRMXn3Gv5bI
	gTrpFOjHjWZGc1SyayN8n8gDk1EMLqWO4BAhQy3FjuximvR84wgk5h1aZQvB5MlmdWfk8qnVSDI
	WtuCtfPgvuq/8ak8FVJNxpPgC+DOTMznqe3WlenVjupzXiRwdIyqh1EMU=
X-Received: by 2002:a05:600c:630e:b0:489:6c28:dbb4 with SMTP id 5b1f17b1804b1-48fc9a3dd2bmr17266015e9.5.1778666920522;
        Wed, 13 May 2026 03:08:40 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6be40sm40982619f8f.12.2026.05.13.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:08:39 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] Documentation: iio: make ADXL Y-axis calibbias description consistent
Date: Wed, 13 May 2026 15:07:52 +0500
Message-Id: <20260513100752.8559-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Y-axis calibbias rows in adxl345.rst, adxl313.rst and adxl380.rst
use a different wording than the matching X-axis and Z-axis rows in
the same tables: the X/Z rows say "Calibration offset for the
X/Z-axis accelerometer channel." while the Y row says "Y-axis (or
y-axis) acceleration offset correction".

Make the Y-axis row match the other two so each driver's sysfs
table has consistent capitalisation and wording.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 Documentation/iio/adxl313.rst | 2 +-
 Documentation/iio/adxl345.rst | 2 +-
 Documentation/iio/adxl380.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
index 966e72c01..b18b54e47 100644
--- a/Documentation/iio/adxl313.rst
+++ b/Documentation/iio/adxl313.rst
@@ -38,7 +38,7 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +---------------------------------------------------+----------------------------------------------------------+
 | in_accel_x_raw                                    | Raw X-axis accelerometer channel value.                  |
 +---------------------------------------------------+----------------------------------------------------------+
-| in_accel_y_calibbias                              | y-axis acceleration offset correction                    |
+| in_accel_y_calibbias                              | Calibration offset for the Y-axis accelerometer channel. |
 +---------------------------------------------------+----------------------------------------------------------+
 | in_accel_y_raw                                    | Raw Y-axis accelerometer channel value.                  |
 +---------------------------------------------------+----------------------------------------------------------+
diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index 978f746a8..0aa33a852 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -47,7 +47,7 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +-------------------------------------------+----------------------------------------------------------+
 | in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
 +-------------------------------------------+----------------------------------------------------------+
-| in_accel_y_calibbias                      | Y-axis acceleration offset correction                    |
+| in_accel_y_calibbias                      | Calibration offset for the Y-axis accelerometer channel. |
 +-------------------------------------------+----------------------------------------------------------+
 | in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
 +-------------------------------------------+----------------------------------------------------------+
diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
index 61cafa2f9..654d4c0e8 100644
--- a/Documentation/iio/adxl380.rst
+++ b/Documentation/iio/adxl380.rst
@@ -51,7 +51,7 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +---------------------------------------------------+----------------------------------------------------------+
 | in_accel_x_raw                                    | Raw X-axis accelerometer channel value.                  |
 +---------------------------------------------------+----------------------------------------------------------+
-| in_accel_y_calibbias                              | y-axis acceleration offset correction                    |
+| in_accel_y_calibbias                              | Calibration offset for the Y-axis accelerometer channel. |
 +---------------------------------------------------+----------------------------------------------------------+
 | in_accel_y_raw                                    | Raw Y-axis accelerometer channel value.                  |
 +---------------------------------------------------+----------------------------------------------------------+
-- 
2.43.0

