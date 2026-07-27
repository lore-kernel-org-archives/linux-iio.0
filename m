Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3C3EB10C
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144308; cv=none; b=EQT05kd5BcDxUlmtrGQfhEzyohPMTq9K8UQKsd69PRASI+9VCsX4uU20/l+vgm/Kh2HPXpAcerXvlLvNWBIfbnnFrSyMQvaUFVFEy0yKoGRrDIkcPmuizuA03P9LgzBSLb6wAnvVux4XkArjOjOjNg7ceEvBCdUdgOOWWDrPMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144308; c=relaxed/simple;
	bh=KGGXByqAct727YELO9+LMLusE8CCPOyq0E5LFYrQetM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MlHi/rxNuRJkWaXJ54qrtZdFhHZqDPtjp6c3fe4JwEVjPTDrPQtK669Vvrc46T8bkS0Yqc+EMhvgLrxLfT0l3Z9dbd+pou3n3TWK78k2/RtCZGE9HuKwCf8AqmOu4pqd44gOYlZBdqQlEoypULCthBcKov7bqRP/5sY+/PL8du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TgS0JFL9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M1C+XGln; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TgS0JFL9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M1C+XGln"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R8gVPH2721547
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BXNIjjE8d2VbhCtEzyZftO
	Rf3rk1HhEtHYt3oWL5j/8=; b=TgS0JFL9/ZiSVLj1b2/j3GnUbaHIya4eBavJML
	4mL+XoVCYWEy5cKH3Jw1ESK0BQ1gE+IxUV2bFgd3TXk87n4DlkBgLGtOxZtKXNJD
	NWpSnbwrs0cFkbVGXQdBb+GPSaatK8rFSFE7soNU80GX6UBfsR4vtJRIb8BbX0Xi
	ztuyeFQfQvcPneG35kyvEaRtM2n6Ha5obHXE4C/EiS1AE5OSzVR9u73Oie9B/hFX
	9mALBZAgP8Mr2QSxqYnzBD1rndOpLrh9E7t6SwoVP6i/XtGjCUoNasxcDvafdcLu
	bcT4M1r+MUvIfSl0/1LxiVRBew4t8ToOhEMckcbIAJ2ZVdgg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajnb0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:25:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a23afcbso24637951cf.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785144304; x=1785749104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXNIjjE8d2VbhCtEzyZftORf3rk1HhEtHYt3oWL5j/8=;
        b=M1C+XGlnSs4qfa0dTCr0/5Zjv3QSUFriNIkLLcZlsI+yr01YL3/uHesU1WbVDErVHN
         066aXMJMFcVkXCgmP/4+qK6JPGZMNSDTqvkWFSpPQ8YCc9BQks3e23hm0X9UcnJ4beZ8
         X7FRGCTHZDtBHlTsn3jFLx13FfxtOXh2H4+px5cm0MTaMn4FUF9ESA3YzHPOsn0zXhLP
         0OwOLD5tyG/i7jfrC5fRNxYRppK7AQSWujmk9JqxMeittxjhzr/zABD5b50nwK9mAVr8
         jPKqUOCeMwG2DZlBP5e2+I7rKLZoRGyaWzEtKfqyqRBx3Lg8wduHB/DEQ4nndU7smvSd
         kexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144304; x=1785749104;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BXNIjjE8d2VbhCtEzyZftORf3rk1HhEtHYt3oWL5j/8=;
        b=FHtKfKRvxXnqWiAg9XYuKH4xV4ugo0Qe6856g1kRRePel0ZeMeTYazfkpPmCZhkjrJ
         a7iR2S24lWX2gV558OHQ8CU3Wol/lPDJ3IxskQ1fGnr9Pv0AXbMGlu7Q6OocWay3If/g
         FhC8DOWbBdE6lGccGp6fd6GEn1HcsRUvgOdUtwa83XJ0n5Wr3m6Yxzr1zYpN8+QXvYnd
         gxrpuL0IgZzY4zBbcTW6/i74jtVKDQ5m2J/HuUmrXYrJ9FbcsEI5ehul2edhlhxXrNKL
         MIx5RukvBAt+8ipCEVm7iDDigK9kpFOMFyGBGLx5wivSagA4eHYYe4YqtwJBZXJdYbRP
         FW2A==
X-Forwarded-Encrypted: i=1; AHgh+RpRNiN1QLU5Bz3kAyCAsolbFPYFfT2+aiaoUUWSmSCtWEjwfG6MW9kvc6qq2GHjlJHTsTirV0pidUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTV1SScKvQNR80OF4rHK+iJme7AgtQj1s0euk1iG43HRmJHakd
	Nu1G3ir1hPO6aOE+lQmxnr+ZHssrILkglbxX3Z1ZMSZ2Mcuiuo9pxWFczO/vUXThlQcCapZGFx+
	Tpze8WvJgLtXRAOWg+1svnwXEs1PFe21DtmtA9+GyrNd6ribpN4j755y200vFkF4=
X-Gm-Gg: AR+sD10U/WbtKhPHsvyAvRhIwp+BvUWlMfrrxU5RMIUgoyUQF3gbHG8vaIsFYBfdBw2
	Z6W3uQ/TZgMq2h1myLl/hPRqkkeSWN9fjF/xzs/cu9ujScznt9wA/SGkjVKVJMxGs5eLApjVLzf
	gRo0njorMO6fjtHXjI0uK4fLk+y6Rzdi5l/6joiyo/Ev88J4thTRrW6Dvws0zwNHCthMZbgqU1M
	zJtlB9HxAAIY8+FFpFoOibjdT7LaHDsNF24zl+BE+XNrn2qSRTvQNzqS2vBuf7isWxAqXC1H1YX
	Xfi9tnEZ7IOtnAHJalk7M5R8cZss1N2MBznkBuADMPTYETDL0XdjybKtv2MA07hlO+U8Td2mrjq
	R+WtT5yIGjPJVIJQ0
X-Received: by 2002:a05:622a:15c2:b0:51b:f340:d2be with SMTP id d75a77b69052e-529a86c8ff8mr79521421cf.53.1785144304582;
        Mon, 27 Jul 2026 02:25:04 -0700 (PDT)
X-Received: by 2002:a05:622a:15c2:b0:51b:f340:d2be with SMTP id d75a77b69052e-529a86c8ff8mr79521241cf.53.1785144304129;
        Mon, 27 Jul 2026 02:25:04 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb51c9691sm2357592a12.7.2026.07.27.02.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:25:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Drop redundant lists from various Samsung entries
Date: Mon, 27 Jul 2026 11:24:49 +0200
Message-ID: <20260727092451.43570-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7712; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=KGGXByqAct727YELO9+LMLusE8CCPOyq0E5LFYrQetM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqZyPjA9yT9eGEDRhvFAGE7uhiZW2bvNIcf6f8e
 O1XxR3eutaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCamcj4wAKCRDBN2bmhouD
 10oAD/4yLRNM7s3tOckBrgt5Pg7P2Tib75a89Po47kqTT/2LhKNvjgqQmnVTaBt3YSWJWPFjXyg
 cfFS7znMfWRlnFGFinKAcKFQWneELRjFiyhQwUb/JaT6uupHrk2k6kM55TdZm3z/vnPGziCXE+G
 oDkzEt5+xINPzRWapw8XdYoxlMR/A1wpaj7aEq/ePnCcJwKDnVoW73cCSNWHbfdOH1CqHlxWXHv
 gKHbEzhflwbdX4JawPpHRGODGVR5+18fRiUKedwvv8MI9P13aqZ7c3iVCk52pJL8e/74FAuw2ES
 mPl+KZ2c0hetj3+mHKJ+68adE1wUhqPNp3EanfaKWZZVdqpmNQqU9wwePmIdnfh0KokxAwi4i1D
 +R71AavhU02UD0AY/B5DlB7pvvaYOcyCkTHFnLCIwqGmXp5dqX8UiR3eaLyrr7znGrPaRQFXrhU
 m+j6I/38QkfqpYIfG2/er40v3hCjopvZZ2yaZJ2QPTZZ98fQng8v0nSR+jJhle5YzGfZlw359Mp
 xnEjw1EO5M/sCCo0v+24EXbpbfR+9icuMS1Obn5SJBB1hRjqpEG2NWf+G1KN9UXSQKYevQ91Tom
 A9Ayaihfad617aK39Krc2dX8ICCQ6FrqTZEIb5OSxxPhSM89zy1jzdDha2gIx+FgTXeQBmGl+w2 06LYqfTlCR7wNgw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tppSntwuW-ywIqWNbjn7sg-E7FWIIEV2
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a6723f1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=xq3W2uTSAAAA:8 a=KKAkSRfTAAAA:8 a=hD80L64hAAAA:8
 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=6J6j7_AOAAAA:8 a=sLuR29lIkFDoGf37nhcA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=P5L7wpMTXyg1GfFA3Gwx:22
 a=cvBusfyB2V15izCimMoJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=DoBsnWhqfNmTxX1QClym:22
X-Proofpoint-GUID: tppSntwuW-ywIqWNbjn7sg-E7FWIIEV2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5MiBTYWx0ZWRfX00XgvgGO7+T4
 YuCFXSjZii9DpMK77QAW7bTuA5+1aMY9icstNXlBuKSaXUDVaZlgIyetPt9n8baD1kjCbNUqYAr
 diJeDQnQHKZIrNoa1D4jTrLN50uelR88QOqZZl+FXy/sIZEPLNCcngFgX/GaEl0sZ9HYJ+EISEm
 75JTuTbhgPpWwSLGfsWJHgx1XVJ2HPq9nv9Z4xbRrmFfMa7+v82Gwu8rw+BXn3dbLAz2LktlmIq
 ZoBvcBQCA/zI/i0ar/iILyiE2gOmUfL1nC2d/VwvHV7G/56JDNN5c6+QGA2OkRaCgmQAmMxYVRd
 KhW3RE36eAFBsA0pnWPjifVqxm5JSwX+zXe57KxI+skD39lzEck3b9mgMzFSpJPuSkke7E1c3st
 WbvLgcB9Vah/30XtrOY07t+VKM8xGSw0ikjBw2vjyR74JnnTVd1JU/8O9Yu5LWQ2bP02Tb+mbKs
 P2xiYTUR/xNUqBFwJmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5MiBTYWx0ZWRfX59cdK8rHLqNx
 ER6UKXmcwHuauSCp4urknnIbsTA4FxQRBeB+uerSJcWDxTAxv+EOi4FZt4s4PoGP9FM//cGYcxF
 g/QfIlMaGhybxZIkn71bUe/diW08wsg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270092

Individual driver maintainer entries (not subsystem) do not need to
repeat the generic subsystem mailing lists in "L:", because
get_maintainers.pl will get them from the subsystem entry.  They only
need to mention additional lists specific to Samsung stuff, like
linux-samsung-soc@vger.kernel.org.

Drop generic lists from almost all of the Samsung entries where all the
files are already covered by the subsystem entry.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Cc: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-media@vger.kernel.org

I will take the patch through Samsung SoC tree.
---
 MAINTAINERS | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c8aadac544d..761cdf667471 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3591,14 +3591,12 @@ N:	s5pv210
 ARM/SAMSUNG S5P SERIES 2D GRAPHICS ACCELERATION (G2D) SUPPORT
 M:	Łukasz Stelmach <l.stelmach@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/samsung/s5p-g2d/
 
 ARM/SAMSUNG S5P SERIES HDMI CEC SUBSYSTEM SUPPORT
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
-L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/cec/samsung,s5p-cec.yaml
 F:	drivers/media/cec/platform/s5p/
@@ -3608,7 +3606,6 @@ M:	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
 M:	Jacek Anaszewski <jacek.anaszewski@gmail.com>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/samsung,s5pv210-jpeg.yaml
 F:	drivers/media/platform/samsung/s5p-jpeg/
@@ -3617,7 +3614,6 @@ ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 M:	Andrzej Hajda <andrzej.hajda@intel.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
 F:	drivers/media/platform/samsung/s5p-mfc/
@@ -5696,7 +5692,6 @@ F:	drivers/media/pci/bt8xx/bttv*
 
 BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
 M:	Chanwoo Choi <cw00.choi@samsung.com>
-L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
@@ -16125,7 +16120,6 @@ F:	drivers/power/supply/max77976_charger.c
 
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-L:	linux-pm@vger.kernel.org
 S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
@@ -20859,7 +20853,6 @@ F:	drivers/pci/controller/dwc/*rcar*
 
 PCI DRIVER FOR SAMSUNG EXYNOS
 M:	Jingoo Han <jingoohan1@gmail.com>
-L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
@@ -24152,7 +24145,6 @@ F:	arch/arm64/boot/dts/exynos/exynos8855*
 
 SAMSUNG EXYNOS ACPM MAILBOX PROTOCOL
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
-L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
@@ -24162,7 +24154,6 @@ F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
-L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mailbox/google,gs101-mbox.yaml
@@ -24192,7 +24183,6 @@ F:	drivers/platform/x86/samsung-galaxybook.c
 SAMSUNG INTERCONNECT DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Artur Świgoń <a.swigon@samsung.com>
-L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	drivers/interconnect/samsung/
@@ -24205,7 +24195,6 @@ F:	drivers/platform/x86/samsung-laptop.c
 
 SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	André Draszik <andre.draszik@linaro.org>
-L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
@@ -24224,7 +24213,6 @@ F:	include/linux/mfd/samsung/
 
 SAMSUNG S3C24XX/S3C64XX SOC SERIES CAMIF DRIVER
 M:	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
-L:	linux-media@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/samsung/s3c-camif/
@@ -24239,14 +24227,12 @@ F:	drivers/nfc/s3fwrn5
 SAMSUNG S5C73M3 CAMERA DRIVER
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Andrzej Hajda <andrzej.hajda@intel.com>
-L:	linux-media@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
 F:	drivers/media/i2c/s5c73m3/*
 
 SAMSUNG S5K3M5 CAMERA DRIVER
 M:	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
-L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/samsung,s5k3m5.yaml
@@ -24255,13 +24241,11 @@ F:	drivers/media/i2c/s5k3m5.c
 SAMSUNG S5K5BAF CAMERA DRIVER
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Andrzej Hajda <andrzej.hajda@intel.com>
-L:	linux-media@vger.kernel.org
 S:	Supported
 F:	drivers/media/i2c/s5k5baf.c
 
 SAMSUNG S5KJN1 CAMERA DRIVER
 M:	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
-L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/samsung,s5kjn1.yaml
@@ -24270,7 +24254,6 @@ F:	drivers/media/i2c/s5kjn1.c
 SAMSUNG S5P Security SubSystem (SSS) DRIVER
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 M:	Vladimir Zapolskiy <vz@mleia.com>
-L:	linux-crypto@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/samsung-slimsss.yaml
@@ -24279,7 +24262,6 @@ F:	drivers/crypto/s5p-sss.c
 
 SAMSUNG S5P/EXYNOS4 SOC SERIES CAMERA SUBSYSTEM DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
-L:	linux-media@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
@@ -24309,7 +24291,6 @@ F:	include/linux/clk/samsung.h
 SAMSUNG SPI DRIVERS
 M:	Andi Shyti <andi.shyti@kernel.org>
 R:	Tudor Ambarus <tudor.ambarus@linaro.org>
-L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/samsung,spi*.yaml
@@ -24325,7 +24306,6 @@ F:	drivers/net/ethernet/samsung/sxgbe/
 SAMSUNG THERMAL DRIVER
 M:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -27924,7 +27904,6 @@ F:	drivers/ufs/host/*dwc*
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER EXYNOS HOOKS
 M:	Alim Akhtar <alim.akhtar@samsung.com>
 R:	Peter Griffin <peter.griffin@linaro.org>
-L:	linux-scsi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/ufs/host/ufs-exynos*
-- 
2.53.0

