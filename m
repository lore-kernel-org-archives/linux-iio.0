Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F0372EF9
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892465; cv=none; b=oTSLhi8U2r4mU2ccZLrJWWk7OoneWR27RS+dtF0wWGKz4aBQOcahzrPZxBEGvrOAA5SAq2HOJNh1G0wSdxStRnna0NzKYRIeAhY3ialPCzJsn6XSeujuyulaRJkCuOLTPQA9IJiHKd5M0QnPYkUuR3KHrybgiF9BFhr6GA/ycI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892465; c=relaxed/simple;
	bh=88ZM+t1K/1lR4CXqOTdLV+/TyBjxHD/qP13b/YAWW+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFaEck9CEQC504ZW8qHB+DGncI4nc9gfIZBgD3a5Gu3RbN67/5d/KYwF3f96Pc+pdtKIHcln44f9cS3fQXHIl4KD6iBIJ3XMfKEIvLUm48CNkndo7P9VGnoig1NkCbJvGyhwSKjEKJPI3nefuKF+5Ind3/XSrS/WHIoJw3jRnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxR1+cKr; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxR1+cKr"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82985f42664so2677801b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774892462; x=1775497262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVy602CnFkEAsjnffDl6n+Q2QuDxV7ckhIIG5PyOqtw=;
        b=TxR1+cKr+6VB7QTEqLbkMRvM9aNcuRbcRen6q2ctgT+Hukrjpbk3g36APXdkw01MJK
         YPMe5gYqn66dnCUjH3XCDWj8oQoSo4JB/4sJB3fpyVGHSUF6+RzdETnkS2uxdf8w0SG9
         0G0L1mJOzmCbD80rA/85yzItzYWeLOaFajKJm5ZqLDfIqmw1Ny8lsqNP96rToKpCeqCd
         M0QVHI8zEzSPXhsF9PXLD7wTDvEU7r7vnnbTUCA4RATMNmS+Zuan+EThxrhTMV6p0Yfy
         sBFPDUHXyKvxasnZftNo2/RmxbNUjiNnBjJY6gEbD0k/wOxmEGUXjKGAK1HyARNoDYKB
         Iu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892462; x=1775497262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVy602CnFkEAsjnffDl6n+Q2QuDxV7ckhIIG5PyOqtw=;
        b=ihRtYQNyKea+ygOA2QmF/opNJcsq9G4dgOdB8LBWRYAfCvYkZvWtyAZyQq/020tUIQ
         jJGadcQdO5tDDpzjNnu6fwcD6qgnFBcQcWFLNhkTf0IZMxV25c51aOGXXR+en6gV4bjc
         rLeciFt0O0eT6IgqkCOYf10IyYZPRooztDz3owhYJE/ZLTK+Oa9JtJwm92ejp4eWpDzC
         KNwNn9OGEO/RHzKIO0y2qCwxS8cdUjJzClLytdLxJ3y36UKSvQyHVVgOmETQrUHF0jRj
         diZnl9IyWenx8nZmDUWhRqqr/l5pxW/f0nmKAUcWwr/82WpZLdPdiKlbScqbvCu7wuvp
         UzIw==
X-Forwarded-Encrypted: i=1; AJvYcCWHnBqG4KXvvYJHArGAW73B+LCBm9VCX6VowtSY13sYMoG0Bq3hOZHaQtOtCXA/5RQEFKrlI6l9toU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuTNpCUkMSnBF2tsA/IlcW+cHtGK8l8rUgW8y+7x+WGZKlvajT
	TVcMcxLB7dnwBSjfn6ZACTFuTf+EK26XrQPYElst+fwvKTpsItXEeW5l
X-Gm-Gg: ATEYQzxlABYO8ETDQecFrgpJNN8gMpOnNNmq5s0Z4mpYjqA/TINHhoPE9kr267Fu8FW
	Fg45zte5bJ1qYqMDdlv8MY70rV4tsJP9Wkse+RM9YTRuCXVRNUGmhc6a5qQiwHDCHJ+nQ4s2uxW
	/oytSPQM5274Whjv80E/jYxNPE7ctPBB1C7lH066P23GwHN9Sqzw748sV9tzGZjNAMWLNOAVT3Q
	DjEnImGJrbzCyUwXc/PO+rWaz3Sx6QoZbHZTp4bChaNzZBifLuZssAkB+va7Lt2jovXZG/NavYj
	70PsX7zCebe4+uaJ28l3TjyQ/EVqFWR+CHQjpfNM3mC4R9Cef/ZHwPrrzyHKEU2okfi0pkA5oT8
	XOWi3GcF6Yrx5OTqlAWDmgp29dkGY9Xj+Mgem9sMlQTmmkST56Pgds4Euu1ZCCgdSGO04pgZ3I5
	yslgOU/kTWrGeWYpw+1RzITfDLaUxFCzgtZQ7018VR
X-Received: by 2002:a05:6a00:408c:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-82c95c234e9mr12931073b3a.16.1774892462084;
        Mon, 30 Mar 2026 10:41:02 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca860b125sm7844052b3a.50.2026.03.30.10.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:41:01 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v2 1/4] staging: iio: adc: ad7816: redefine mode constants to start from 0
Date: Mon, 30 Mar 2026 23:40:21 +0600
Message-Id: <20260330174024.20712-2-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330174024.20712-1-mdmahmudulhasan1511@gmail.com>
References: <20260330174024.20712-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/staging/iio/adc/ad7816.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135..5acfceb90 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -22,8 +22,8 @@
 /*
  * AD7816 config masks
  */
-#define AD7816_FULL			0x1
-#define AD7816_PD			0x2
+#define AD7816_FULL			0
+#define AD7816_PD			1
 #define AD7816_CS_MASK			0x7
 #define AD7816_CS_MAX			0x4
 
-- 
2.34.1

