Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD31D6DB5
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965753; cv=none; b=ctBmVc6PwDdpSoBqjMvGAXnzysK08HfU7e8ZJOEYMA+nptCSDMAfJN8rFEACB1b5e1AilDFvAOYM5HTSiPHKRlfjlfXKmdmYd2kGHImpKo6+4VgPAB8nouBDgs3sGv2fgKRNLc9Kks4NqOXGyy266O3wkGRsJ5THcpo3RYaDzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965753; c=relaxed/simple;
	bh=M1bSMEuMwavTkVMlnKwpWhUr8Rc0F8yHb272lSkqvBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T49V8d2Ug0h2BCbCgPjHGTKw9S3ba+VsKEpE+XFtyIrd4Bb22cfmoSF00on8xW7+0+TJrnijYcjBsRtakiV4u6+dcllvOAVEEPp9NC9Htk99lgPlYNWzXDOF4tgboKNT6A5XA5xJOvDzfMPbsV4y4SntGNEumvQ9Uc+K/htahCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDTkaXPc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CscpW3AW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDTkaXPc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CscpW3AW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NGE7vt366166
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 17:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Sjqdpq7K1sJqnlPifhmO7wc+iVfNkL6W+jn
	jLLcTwoI=; b=DDTkaXPcHW9H7RbxKmHCqoeoItn88LEUCSazFM7o9Cc3/XmX5hv
	K1a6GU5L1sNF9I1Yz84Fpz7hNCgdAcSXBU9yXDmkoOYvY3bxawNq/oJLey0SkyRJ
	OJJgEWoFm4hyHHbDFdbvezvOLGeohxcgEFD4mEiCxGgpguVi4m0IKl74E5oCshoU
	gSShCPPftviUWzaPqKaN3FMcpWepNJeybBAvoyBypaZltiVatYcpJ3XfaCSkp/dl
	L8saTjPIv2MgcMhDzr4gaMcXCm3q5uviuCL2wtnaFWMM5MREZoYujqtojCMfnhWE
	cVZ4uG8JqW+9CO1YJ3u4mC9D6PSpnqmxCiA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35rcpc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 17:35:50 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5fc74c6634aso6111720137.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776965750; x=1777570550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjqdpq7K1sJqnlPifhmO7wc+iVfNkL6W+jnjLLcTwoI=;
        b=CscpW3AWiq9s/umuwyu/NUYouPyUbZqTVlvFa7Iai9q1A5likgBzSArGCK7G1hW5uX
         n4zO6LuICKPBs+hrQmK2AhU2yBzRdM0P/Sjpa2hb/IKgy8shCff/2AZKk473PbIH0X0G
         l00f9V8V/Y10g9mPvmCgwD+WDygOvjnDFN2jMfXC+X6x34xJq6nTSPFHHuoeMnKPRjYR
         GunFZSXMai4LDnju57Eptzd0Qh7yLgXdTfV+NTZhiD40iaUdM8MyKLWEWQPcEjj5uqF3
         Esm9XT5bxxa+ZwMSj7dp6zmM2yaoPf+mcWqCdgWa5HDw3Hut9VW9zVg4bwX4tNmPHItR
         6sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965750; x=1777570550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjqdpq7K1sJqnlPifhmO7wc+iVfNkL6W+jnjLLcTwoI=;
        b=hqD4HwA5pJTTbUqlnKHBFLkDJLrYNnpHhoRSzdVYVR4QdzLurq5foQNVzfvQhbHsAa
         hHSiNYeB6SydDYqXAr1ANR8TeZWQs3d4rPK7Poa970nL9mi2wfWbnamXRso9wUToagCb
         fAf4h5NC3DYFJbXcqFfOnUtpBymmmoMjZQIo9up2PU+/ezCShrO0eicFODvws+dybyLa
         M5K7PimD8PmxlnTpuOaB4lV/AFBGELJXjw8+fmmXMB3c2iao4XYtr6Oo5MnFUeWPhZFi
         xeAcufuUvM3U6xk6skJnnvGnK/a1RSI1Vs7GzSO97sK2RLIaWRgZF6S7CSI7jodIlqGw
         kpbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qvsJpgLkzQ4A9J14qj/vT88wJfDVi55HRmF7uuvIetbn6xAopXb7kBsJFT2u8UOSqX0pJ7RtbDYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/AqHXYJ06Pehdnt4upkRIvlbD2SQYCXGoAT7QUXfj6RwdxOM
	PFNnVNUq1vVSCsQFXirtMHzP9R4LaxpgbdOJ0oRi1gdRVFzBq8B6FmyVYELlUXwqVWfZuj1ytXZ
	cwiYrrRWteVIfz+zbpTxLRi/hZdJ6heLKBuE2kS6myNcjN/EfKPBpG7UR3CGghLY=
X-Gm-Gg: AeBDievGkItL1fdpnkiq+E/Z46PVueDNG+9OR5OI6otv3SDDbSaVxy4Sg//GDswaU3i
	R4azJKxNTY0fpdnLNmI8AZLU/pAd6EvogP0WT9NSeie5ZMWng8/Mne46xheyKXOiD5Xc8JLUV2I
	uYVQYhcQrlUfii307Z+SWYGwJMS2AEBjR6C4P3qTV2wucwoxKKbZy2gGPiMNqUZtx9BlCacskm4
	8GrPeUKGvw1Pbv+rzCB0LKpI/mDmGpIr/GRpKzcUrSQbiDa8UaE2PR7kDq/JYmzwp6X+1ig50ij
	6nAyfdlGs2DvpIFpoJDPrYtoMUdU15KoHnzga8kgSqBbRJ4t7PgFnDv/L2Z4bq1wuzjLdFkA0uy
	HcxgY68M52V//WcngfYGYnG41EEc79hNRwD5qbqke2U1iKOg=
X-Received: by 2002:a05:6102:4426:b0:605:2a07:65e5 with SMTP id ada2fe7eead31-616f67c7eb0mr15148167137.18.1776965750012;
        Thu, 23 Apr 2026 10:35:50 -0700 (PDT)
X-Received: by 2002:a05:6102:4426:b0:605:2a07:65e5 with SMTP id ada2fe7eead31-616f67c7eb0mr15148137137.18.1776965749518;
        Thu, 23 Apr 2026 10:35:49 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46471sm52632244f8f.28.2026.04.23.10.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:35:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] iio: adc: qcom: Unify user-visible "Qualcomm" name
Date: Thu, 23 Apr 2026 19:35:46 +0200
Message-ID: <20260423173545.92271-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=M1bSMEuMwavTkVMlnKwpWhUr8Rc0F8yHb272lSkqvBY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp6lhyXCJEdgeZayHceQTFnLobmrBeyNZAeRjKc
 Gv+5HyEmNmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaepYcgAKCRDBN2bmhouD
 1ylDD/9gEI53VrBLIaLeJ7HYwFdgMm+Rmn2TV2fw0gucfCPtzWKEXx7QVCm/m31SBKOYdYB2nRh
 Ogk90SWtf03c5WVI42PwRbvhnRcpkFTJK6ipu7jq6mkZX+XpWy7/IIkI3hx4txCDU9wm4ZwLo4U
 qzUEyFWovgd8jJXvaOLLH8ZkoF61+WKc5Rw9C6b5yOtsjGHH7rK+yYFusGdfCcoSy02UP0p/2yr
 L5TXeZCJyW1NDpChZF7g5okltIuHHoWTM8bFffVG+LKoEsdQPZ7QkkytTcdaC8YTl09iA+qQTKh
 lGTRAPoES3qBvV10nPE4BkTKkIETFEP26Pz/ieioAwXBc4yX6IRLyyx+p7eKjFJHqHvB66gxz+s
 m8yG+T+eN8E6qW+1O611iIYz3YhPmq7gD7Yvy6kk7/5Z7FFoYuE5m6T0psRcOe2b2yiIU/E/MQP
 C0uZu+Yj6JGITIUYWPz+xmFfu7Nu/f8ydNi/a2PRLjUKvkMSayj0FUoFUWVbPnWBeDAkjraaGtO
 L+wi49fBPe8it6nBon+Dosd1W82JxrVhn330m7R1BWOA5EHyQEZZPv21wf1cK86J5knyQ73nrzc
 +wEhpHU/x1WYwhRzn81gspEwl0Pk3Ks8DQRfgtfvXT7zBaWaesMKZn88zbTxJnr010OW7W5m3Yn UegPWdBPAHKB2KQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MSBTYWx0ZWRfX2d0JCytGW0gI
 hy7V11klc3XErEyyLNO2pSAkXG/dQH7kaDZs1qlwofUQuyOOuxq3qIsvrvmpM9acKyYmiZI7JW7
 IVu0n2RXIKXVuBd0dSSjlUiH1NHXcP9BZgTQuKUBBDIKZGDeu+RycEodZ9es9Shebq30m94HjHm
 Qdwnv7ylh+LmwupDHOsAgmrxAXR5SlzpKogkr8MwE4v5welBW9ymw293PYUFqIRYw+fswYQKL5D
 dZYwen1olL+RAe8NW7e7TsadxdZTzaHE/yNBPQq12Bx5fKOSzgeWjyVEIIZDV3c8uzMyqenZIp9
 yq75xgGQzFbFWUyw58YDFvzSR+Gfirt3v36PXnm9CElno18gOiOaJu75KqHDYIxuyw3WQsBbCfT
 gIIeaO8IbsS7Td8Wpxuui0GfJ9vr5oQVu9j1BU3gT15FTnRUrw8d3Uk4bKVnDRw2aw8MGRbz3Ke
 7SFYcXlVwD98UBkSWiw==
X-Proofpoint-ORIG-GUID: kJyoz_0C1-0rbHJYEMgszirkS15h4aFh
X-Proofpoint-GUID: kJyoz_0C1-0rbHJYEMgszirkS15h4aFh
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69ea5876 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=89dWTnP0534NunzvFJkA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230171

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/iio/adc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..1115e81ac45b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1354,7 +1354,7 @@ config QCOM_SPMI_VADC
 	  be called qcom-spmi-vadc.
 
 config QCOM_SPMI_ADC5
-	tristate "Qualcomm Technologies Inc. SPMI PMIC5 ADC"
+	tristate "Qualcomm SPMI PMIC5 ADC"
 	depends on SPMI
 	select REGMAP_SPMI
 	select QCOM_VADC_COMMON
@@ -1374,7 +1374,7 @@ config QCOM_SPMI_ADC5
 	  be called qcom-spmi-adc5.
 
 config QCOM_SPMI_ADC5_GEN3
-	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
+	tristate "Qualcomm SPMI PMIC5 GEN3 ADC"
 	depends on SPMI && THERMAL
 	select REGMAP_SPMI
 	select QCOM_VADC_COMMON
-- 
2.51.0

