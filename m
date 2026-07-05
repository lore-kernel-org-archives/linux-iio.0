Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7829346F
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272290; cv=none; b=BhYlNyzo2R8KWi+CFl+8OLH5knUaWc4JZHHswncqGmHd++3njTQH4GkKZFkMBPL61/pFw1BDkcspHwpMHQsUFpYEbvdk3tzrpyNRvqSATLFcbTaO6vZlgt73igiuAwYkEhRcJqWtFyQZ+pXcSJJqUpWTe0INrumqQ3ZfUO+M8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272290; c=relaxed/simple;
	bh=L9y7YEPrTkyHWrOe8STGEbvO8rfCzNkCqe7irLsX2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8F9btp5onD0fuKmeHwllxWCrFI3U9eZmAp9LLlpiDQiOxuO7YTcKRzHcEO0diBzfu7xw1vpxvAhywD22ca96SrvW5CryFlGvuGSIAuDtdPe5kbF7YMuW7o/wkIEgonCkWyoXu0z348JoYxh4APv3kCryfqYsa7nalWZwHtXyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HBYGbCby; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hpirwsGK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HBYGbCby";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hpirwsGK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665GU2Ag1983026
	for <linux-iio@vger.kernel.org>; Sun, 5 Jul 2026 17:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BIjEgp1Eh+p
	5B0AVI9k0GOk4cdzzWqq6lTqxAW3lcdY=; b=HBYGbCbyZwVA+5YTly6efOVDXZ1
	jQz1uNWjAbWfGuEvGBbfZXCGsOEsYxVzf3lyz+nQMtRfxJhS6szyE0fwnUPEdrBb
	exWItD7LlsZsxMBAHCb2BUTKeGeEvxdAjGBB8ODzd75nerQF8noChy7psd1seMex
	N0Tt6MOP3aWpZPLI5F/8gmaIbrM4clrLzQJ1bJj2X88LAWOBI0VbrFvGu64+9f+k
	Ue3/0vudhH8H8QbnMIOKbbDPBl4BOtsUunGt24gxd4Pw4snkTLLbfSj7p+R4f4IA
	ExW1KkRaqJDgYB0zCqqNIlD+2X8UxESmJi4YLTSWw8gf0i7v2WIfq7xck6A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgjxke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 17:24:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e53b8a302so209589985a.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272287; x=1783877087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIjEgp1Eh+p5B0AVI9k0GOk4cdzzWqq6lTqxAW3lcdY=;
        b=hpirwsGK4Px8wJT105NF3asAJyafNoAdRgwmZUoN3n2m79T/BoDMubiuVFPIQKB365
         joBOTvg0CpGsJJahRibjfWxx/HQvpu5CrVZWdZdU6djZPQpPlR5V9c4DF34Exl7c1e7A
         zxb37Fcy0bhGl0r18HUThhzi80cvAaAbmeZ/yCVcqB0t/YYnsbIrMLMAw6rdLoyF85wL
         e73I32zZifx4qrnROP4sauZ81hjSCMJTINrhu3C+AhkvyJWZfthWAX2J6IRcKowQdOV6
         dMss5gjGKcHzO+T6wAwtTROlWkhN6RHhnjbYU2hbu6cN/NRNgmWNKcBD4U6kLhr+/0PD
         2WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272287; x=1783877087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIjEgp1Eh+p5B0AVI9k0GOk4cdzzWqq6lTqxAW3lcdY=;
        b=LuDe0rVT/DT0orF0Rjv/rd41JUGBRPXnEg+V2YlREx8vEZuvN/NP6rSqMLia1oefFo
         i49/K6VjV4PI9mLpvIR/tiFnv7Jt1kw5NYMSv7YhdmrnUW55IDM07d42HBPZmSivV08g
         hihsUgjvjJ5UFCWaJTw7+gzc4wBzjEPxWNWvIxEn+yZOU/+1qnIsBUdok0NRa7GhRzDt
         e1dGJ9htF4UTJvhUUXzx+xneNCr0PT0p+s4NUf82yfpi8v9WSBKiirHuBrGmTeb+Hg3R
         ivw0PnkazdsgWt6bl8JNrUzi5/sCniLemOyZXQJmUrTuSUQSkWtOWqricXnuB8xKP/Mt
         tKmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLBDN72j7Lrxd9IL1Bm1elcZxiVhQ3WAssCQOmZZJDEEhMn8L9/WUKq1m6aszA8Tv6mqITzBz50xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkQzTf8afO8bYzhbZUcVNrofwDsPx71f7sm6FdDnTx/BYO3Yb
	ePrANCjrqz7yXaoVPdBRkoCrRoI9UWToGE5IlopnuwqHO8k57wnf0VpDbDuH+09Ep8pS+9RMZU2
	/LZT6t6ENdjYoMvdh7ZY2AVLtePv0AZWIyapdHb6s8kY3gH+rzG1wmWO7HUP4FOw=
X-Gm-Gg: AfdE7cmnom7RVb2SiQTlDgkVeOUA556GXi4lDZ2eZRyuJj/1CGhk5VS9oTyAsHQrHU0
	WhTl8NFIraRkR7PeADjr5Amvqt5U3LNGx1oNNKvthHTfnSSR5QHGuRnwRaOSniBJYdwp4VxWHyQ
	AWEoaDAQriGmcN/mAGtcoFwCGuUMvohJzVVzHs6C+8qN6Ixd2hifgx3+lW3DFljB0dxN5LyXMFH
	srpwJ8dR6RWwVWAsiG0FEXOVk7/wRoT2rZxlNMCYDDemWmwu6QT9cMRUHJNqnLSHLp57iAUFUS2
	/xSdx/iTwbxwSHFKAn2EAmY+YrIajGo6KUNoG8tY9kuqheBLsOMq/8OG9tyQ8k80q89olhpXa0I
	OTx3zDqy9ifHLJ/pVs+fQbUfCZH0=
X-Received: by 2002:a05:620a:8909:b0:92e:5a5c:6582 with SMTP id af79cd13be357-92e9a53ce5emr968863285a.73.1783272287441;
        Sun, 05 Jul 2026 10:24:47 -0700 (PDT)
X-Received: by 2002:a05:620a:8909:b0:92e:5a5c:6582 with SMTP id af79cd13be357-92e9a53ce5emr968859985a.73.1783272287005;
        Sun, 05 Jul 2026 10:24:47 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21328sm17638411f8f.32.2026.07.05.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 10:24:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/2] iio: adc: ade9000: Drop incorrect kerneldoc marker
Date: Sun,  5 Jul 2026 19:24:40 +0200
Message-ID: <20260705172438.119204-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=710; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=L9y7YEPrTkyHWrOe8STGEbvO8rfCzNkCqe7irLsX2SY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqSpNXUER5mTwC9XJEihsOeJcXHFzq9vYP+guRC
 k9Y7C3kSmWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakqTVwAKCRDBN2bmhouD
 140hD/9aAWldLkwR6FEXyJ0uDrURZmHlqnmCDh25vgukoLrfKFCH5Xb6dR/YwHidREQCXsqxsSw
 /SdytE4ZNVhRqwhx+6SM7Jh31G42RxJqWdEM772OVVAvHlNlsBjzsneerSeLgDvhj0206TaAXFV
 eFdx/FwawWAnbbmboMbxhEPFy63JT5BGG+cSlVmps/xh54A6E/J0WT1mvcv78y8Wydjk2zZ4rlx
 I+7TSKn7mXL+ru/ax5JCruGKfdJG7YpTTos9Rssd+TfMgD9n/l2k6gnbrjyuE0ezjA/4OGgWHIi
 LEG9pZbwMkQvov5zZLCsMGWH8VqheSKNQqC5+RfEkQOrwcZhTfl6cfNiRe7D4aLIO8Y/Qslz4aV
 ewb4QYn4ogELoMKGZngbVKlGm5PWwE9+E063TcW9j3fAJettxeYfdWf9dVdsSTBdmW7h8ZqUvFM
 lihnJVUlbcXL0dne6/DzuYrx07jE4gzjNg1C8HzZcFPSGK2iXdHxzNtLRrQ1tKQXSyMSwBeXwmj
 rHpJFbXYxGtpz+K1XfHc8sVQUEYZ51zaOFzFZY0Jdkt4NbfbZegrAi+8FjsITYGYPMWc41Ey1KH
 2a8fYCd+sgZq+ZY23mn3UdVZNL3sbHXuLvrIMUQAeBKpNGmVL9QjsthwLzRdtpJlWIpKz6Uu9r6 lGhW7TlBnKbzx3g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX4RjUrlnKqu0Y
 z8iIHrYq9ESIH9BHLgeU3S4yUjG2GGpylRF+KOcL3POmFRDGh6owDKxQW+gUUigKmMp84BETxbm
 Jh7jdqvkX29kgOD869bKxFu2hUX08Cg=
X-Proofpoint-ORIG-GUID: 5ya0uNvSlQe1CXrTqW0JOA0b-M-3tMeZ
X-Proofpoint-GUID: 5ya0uNvSlQe1CXrTqW0JOA0b-M-3tMeZ
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4a9360 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=8I8PVE6lHkN7-UzJ8BsA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX6UCIFL2KEXLv
 R4El3ItAlUP3Ls0MX6DcElPurjBzp2UYnAT1kt2Y5ZOb8Rg9Stot+NRClauhw8hojc03RewnNzC
 IUCT7xk1UXIRtNAv+n1UVCr3MzSzaoIdBQytIcsT619mG9r+Y/BxYs7gSz80OLLvtjs7/Z5Tyc1
 xahhhlXlMyDunVk0abugOR5pHKfax03e2B1w7R+QMbDHKyB0ugILRVhL3N0qvtEqHmPHrSaW9yr
 SJpAbrkPnQZWarn2mtrEqKTRt9kuiaLViJepkop6f5SFRa1j1zBN4UuPKJ2pE3IONj7xxgnFPxY
 XydfOtTBoehKdSpEKBFYEhI6807u4rTagp6o7j2TatoqaMvTXSdrMVO4dffn85Fw4eQwnMQSp7N
 YGDbhXot5Png/BZQZqIvxJ4dxcbHL3FS4q6FS+FdoqtEpr4DEkVy/cprGeWsVK5i1SqJ91ImQ20
 5/AoTp9hUVb/nSv8c2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050187

Top-level comment is not a kerneldoc, so drop marker to fix W=1 warning:

  drivers/iio/adc/ade9000.c:2 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index b80cdd8ad982..c6c3ea953fea 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * ADE9000 driver
  *
  * Copyright 2025 Analog Devices Inc.
-- 
2.53.0

