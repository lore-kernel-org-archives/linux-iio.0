Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732B313E38
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302909; cv=none; b=VBm3rpoax0p+vdeiQAhWg10xi2rG1gLpeOsYTWBGo/O1M2VH4Jm4NJdfFbY/Gm1KwXSYsZBwTR9Hvt2deZUVA23u+6ETlI/q8sHyjdJijQNLhjk1Kg6fZNtJ389c5o/tkTK/Qx+9Qb7Ju3Ff1Pnu85hAXKgJ8jifSIm/1o+94Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302909; c=relaxed/simple;
	bh=pPsUwuCE0OIyID5Rkoox2ckN0qwOMUhQqBDgvn0H4SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ir/J64zgYDiNqg3VTIxmyJYc/7Yeqlvjo1mhlAIqNgsRiZoea5qIw+sdJropv/v9DKLMNcEpxBXp0tr29TFuQT0Id5x0bpTZFDKZei/c0Fc2B+RqkirVS2qtCeFOVRQJUvHPLWph+AL36p8f192+F92Uv3aSJNXASOmylLsjS54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q393CBi1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q393CBi1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so540585e9.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773302907; x=1773907707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUHqpfrOYm/GvHN+1Ujy5OT9Jy0iD9txswie42a2qXg=;
        b=Q393CBi1Em49CfsU+avcwoXTdLVvPpbd0q5tPaBOckAHxqcdyqbl5bxaHDFDSLsCQN
         O+Q2iRdPsiTgxy/D8RYootl2x9WAaFNujOIU+2S2sv9RJWlVkvf8KOtK8jIpwLr19GF/
         GLnhYhlT/eQLgkjETNWAwlPnUFCVdaPuIc5jyn1Yw82ilfIsT/x125p86tGGvn7LbO90
         Pzd03aHqWqG5c8VVIME9hrgYbV5rRnY4e3/jcGu8bF161GIyAaEx9XNe9d1E2tLmhr1n
         gp+ENO2eSlceoS/+cRyuBqVV7fX+IpZdTBVw4eDGULjMSB21DXgLFtgNvsBsqojPdRwK
         /YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773302907; x=1773907707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUHqpfrOYm/GvHN+1Ujy5OT9Jy0iD9txswie42a2qXg=;
        b=pRcL2O7Pjs/DF3SUozrRY0+7yqqN4ZGtLSIgfNQBCYYUOvU67kMFowtvhTYQ1panK6
         UddeRf5iu6pVNfSy/rfm1xKUG/b+lyi3ZHXMgPFBWySF60wRNkI1y8J66yGa5uADDchH
         w9twUcrSta1ZDHAHc6+o0u2RdZOfqa1q9Q9Ev/3h7wYYRqO94xYAF+f1YjSO0dx/aiFK
         1EOtYtveLenozCcyUXxDHWzlx3uwhmdjjkqsOchhw4tJ5RU4G42p0NKzZnTRQmtUk2LT
         MbtPWpDvHOvR/yZjW0z5icfqIji5XED1klT+qbxGKpCaHCYR0Q6xka0FdetJrpOm4J94
         1wrg==
X-Forwarded-Encrypted: i=1; AJvYcCXGVf8mx8GoQl0lsCIvw1r4ubo7Kp9I/KFvDuI7JY7mFjBzITbWC6oUeQa/VQ0ajGTLRoKZOrOCokM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywti77nQD/k8SpCI/3dIltqzWI5m98y5Flwfsn5YXLHRJPs/95I
	djRa6LKd+W5ojQPeobJNbKIq5drAmURDS9f2w1gotr+I1Am4AozJ+Bug
X-Gm-Gg: ATEYQzxKYE/DuohDbzPZbQsDJcPzrU+xDik0PDCSMitvtk3Qt6IgFJ/HIBcvofa20q8
	LrRYjvAJ4TZ41RPCRyKjRPZFTb0A+V2312AcqN7eece02PZ3r3Q/Cl0wELZUW3dTU1dcSJKJK2m
	Rsp18uKWqBmyJ2FRB8EQlKtUV1OJoATh4JDn0rSFALV1S6Ls6t4jKKXCo/vlf/WWfzCPiiNBcV3
	qDeWCTUkpm5JyIMUDvl3txYGKJ/+NmukFtXTNHSYleWwMYvvVelURrae0V84MiEp+keIB0cp5Tt
	zu8120Gpltauhn7hCwxIJ92iRAJI6MjokgygtB17BzKAqhzTCaBZe5kGml8Cg9OPsbAG7qR0LJ6
	hkm3B6ASdA829pSxA0gGnoFFnxj4taZGE5dZ922ZAm2Pw7i748gcN0tVxEug37UPQBASgKkApWs
	am50TsnDZnUz7E1TPZQgMZ3P7/yC6vkLckOeIm9JDagiaCqYU40SlYhjYqlfLydV/OcYgDlg40w
	Nw10WwUTtxpYJ/ji8sVw8m8XMDQz6IE0EyAH3uN+CCDNE6zHeUe
X-Received: by 2002:a05:600c:5394:b0:485:2af3:3f8b with SMTP id 5b1f17b1804b1-4854b0a8dd5mr49988445e9.1.1773302906502;
        Thu, 12 Mar 2026 01:08:26 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6b95sm106160155e9.6.2026.03.12.01.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:08:26 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH 3/3] iio: adc: twl6030-gpadc: Format block comments
Date: Thu, 12 Mar 2026 12:07:53 +0400
Message-ID: <20260312080752.48091-5-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the trailing "*/" of multi-line block comments to a separate
line to comply with the kernel comment style.

This resolves checkpatch warnings:

  WARNING: Block comments use a trailing */ on a separate line

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 7810d6b2b668..b6fdb8a896ae 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -263,8 +263,7 @@ static const struct twl6030_ideal_code
 		.volt1 = 660,
 		.volt2 = 1500,
 	},
-	[3] = { /* ch 3, external, temperature with external diode/general
-								purpose */
+	[3] = { /* ch 3, external, temperature with external diode/general purpose */
 		.channel = 3,
 		.code1 = 1441,
 		.code2 = 3276,
-- 
2.52.0

