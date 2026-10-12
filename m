Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCF41B8C7;
	Mon, 12 Oct 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803689; cv=none; b=dBRCrE5GaCDzqqFwaQJ8g4f4RmONkmhyRJe1Xe8wA6ecpZV+7IUEO7EjSt/ozvDxBKY+fpda1k8pSBDxsfhCqlOfIPJjcHY3vKyFp8L1ripVeCo/zfbk2AigQab67dmJpwv5alzGTtgE4Cj2g+1OeajaS5lsUmGQY0QO2lgURSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803689; c=relaxed/simple;
	bh=8fkjAHI1stfCBBGhIht/mzIv5dbZqvOGYwQhIjGBoI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJErlYARACqSf9rJ4m0ysEc5HGQF8XabnXccdjWDf8YS7ZNjv1XfwXZqmo7hOrjI5caQjG49NplbSnpyAAFCkCbDARCspxLVYr9tj7qVQ2esVxppe9CUpAOucr7r+5BPetAfvQAL38FJkG/1CzqzNzS6AFMyaImNc13m8uEsF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=hKTakj/6; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Xlb5meDW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="hKTakj/6";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Xlb5meDW"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8O4Hg1120779;
	Mon, 12 Oct 2026 07:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=A3YU0
	R5Tzmocv/BPrf7fbhY9aGUzlogk3+YZn07Urzc=; b=hKTakj/6yWL4hHcXdNDnc
	k/HpF78TC3f0j6i9NAEneRkf3Pf4PSMODNGJMml2cPHpjgDic4W3HAlfxQbKmS0X
	VkGc04vY0wru9iGarM28tMefmGriv5lfUCKSr7uAP1OpdCR97EY22lY0J7N8YSV8
	Q4e+buOiqyEUjIzo8pG+Ssd2vrHRfoMKW6YCz5JkR+/57N1xmFsdaOcAyyT18tKl
	aHCvQx0lNraPzrKhpbT+389j5zXxzWxISBbwTyAlNt/FZhh/l/24hrzf09IIGlfc
	r453uDMjv2OL1VTEPPGjZlxDeULPllRj5ll1kTgCMNIbP+W1yx7iOYYpJacT0Mb4
	A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=A3YU0
	R5Tzmocv/BPrf7fbhY9aGUzlogk3+YZn07Urzc=; b=Xlb5meDWiT1lRyyn3Lzl/
	TEk/qaCj3+cB2hw6Ga5sV/uez10q/V5Ppjs6Rrhlt0rbtV/YhB5gSHFwb26wjAfS
	tTJOesIjQ0lHKbG6IR32W2lFI5hjnaG6eo8Dtp6dsyTAaj8rt++6NFd728cL2OEo
	IwGZhnZ/xzCO7Oqjmu5k94/kcG91SQgiRnrFtDkDKuCKp3C6T+T48/dSFKfXrZ2j
	d9b4uTEpMJLVqX+sw1u0QHnVXtE1gIIYPjInHbsqMOErevjmZkbhXRDTu/o+7IpU
	ovsGyr7NI8rE8f3vv+nwWgelTtu9+aPI+QxqQOLxbQZze3JYv6+dj7bsrKla7X37
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h83pe74dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:14:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69CBEYh1036763
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 07:14:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 12 Oct
 2026 07:14:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 12 Oct 2026 07:14:34 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69CBE1Wx024898;
	Mon, 12 Oct 2026 07:14:23 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Janani Sunil
	<janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Jishnu Prakash
	<jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 1/4] iio: adc: ade9000: parameterise the reactive power channel
Date: Mon, 12 Oct 2026 14:13:37 +0300
Message-ID: <20261012111342.48040-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012111342.48040-1-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX84vUV08pfEjo
 tU59GdS9YwFExtUK00YQjv5P5YyhVQ1Ae3EJh7J19g8ExzmL5X+pP9qK1EvqN/apWSP9RsRmr5b
 qYH8/nL8ZYmUwTXdL5W6FHTHo2PaMnT3f4YmQT9QrqfDx+MWTFda6moYsP1NwC931yTGNIgSJx8
 Jc22DxMcP/k3/stDBgUm16F1AX8oFO6GmY3JxKdSKQWUZcFfRP2qdSUO3D4gRSdpF4FeKqdSUZx
 aSGX40vRdMy/iwMcSQOqjpgjBEy6MLic0SevkCSFU8+gQjUBq+V+sTG6mKMiwXvar9QCG74l3Y0
 MocYLWI71R+GEcE6Aragsr7RhfTzTWZ/n5to2W+iXbkuVHpx/7sculC4ChT5HLCcyyHxat2ZdAI
 Vp6e3p/Lr0S4WmSVeuQta0MJ9cS4gwq1HGHBb/Z/uIci5u13Zerqbh0n/IZaQRaANQblDog+bp0
 9jywmJtgDzhCv4V0kMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXwbvXW4s2ZQcH
 yNEsS4c9eDjkskEbIexyH5WOpXaWJ4jQ0MayB+jY/Pwxw+r8O54O73i53oAJLf4GsgRQjUdiEnn
 1rdOKiwsW4u0jBDSOk2+/KQfZGNNfJDPboyGeJAKA/IRhLuHsd7f
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6accc11c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=y2iMgJnqLeesTMF4eTAA:9
X-Proofpoint-ORIG-GUID: wt6q4btToRzbWfgS6QT7hw-yH3nFRK9h
X-Proofpoint-GUID: wt6q4btToRzbWfgS6QT7hw-yH3nFRK9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120044

The channel array is declared once by ADE9000_DECLARE_CHANNELS() and
specialised per part through the altvoltage_rms argument, which lets parts
without dip/swell hardware drop those events. Some parts in the family do
not compute total reactive power at all and have no AVAR register, so they
need to drop the reactive power channel as well.

Add a second argument that selects the reactive power entry and introduce
the ADE9000_POWER_REACTIVE_ENTRY()/ADE9000_NO_POWER_REACTIVE_ENTRY() pair
for it. The entry macros include their own trailing comma so that the
variant for parts lacking the register can expand to nothing.

No functional change: the preprocessed ade9000_channels and
ade9078_channels tables are unchanged.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ade9000.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index e0113b62a261..03b69556b62f 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -561,6 +561,15 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 	.scan_index = -1						\
 }
 
+/*
+ * The entry macros below carry their own trailing comma so that parts without
+ * a total reactive power register can expand to nothing.
+ */
+#define ADE9000_POWER_REACTIVE_ENTRY(num)				\
+	ADE9000_POWER_REACTIVE_CHANNEL(num),
+
+#define ADE9000_NO_POWER_REACTIVE_ENTRY(num)
+
 #define ADE9000_POWER_APPARENT_CHANNEL(num) {				\
 	.type = IIO_POWER,						\
 	.channel = num,							\
@@ -618,8 +627,10 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 /*
  * Declare a full channel array. @altvoltage_rms picks the RMS voltage channel
  * variant so parts without dip/swell hardware (e.g. ADE9078) omit those events.
+ * @power_reactive picks the total reactive power entry so parts that only
+ * compute fundamental reactive power omit that channel.
  */
-#define ADE9000_DECLARE_CHANNELS(_name, altvoltage_rms)			      \
+#define ADE9000_DECLARE_CHANNELS(_name, altvoltage_rms, power_reactive)	      \
 	static const struct iio_chan_spec _name[] = {			      \
 		/* Phase A channels */					      \
 		ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_A_NR),		      \
@@ -627,7 +638,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_A_NR),	      \
 		altvoltage_rms(ADE9000_PHASE_A_NR),			      \
 		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR),	      \
-		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR),	      \
+		power_reactive(ADE9000_PHASE_A_NR)			      \
 		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_A_NR),	      \
 		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR,	      \
 					      ADE9000_REG_AWATTHR_LO),	      \
@@ -642,7 +653,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_B_NR),	      \
 		altvoltage_rms(ADE9000_PHASE_B_NR),			      \
 		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR),	      \
-		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR),	      \
+		power_reactive(ADE9000_PHASE_B_NR)			      \
 		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_B_NR),	      \
 		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR,	      \
 					      ADE9000_REG_BWATTHR_LO),	      \
@@ -657,7 +668,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_C_NR),	      \
 		altvoltage_rms(ADE9000_PHASE_C_NR),			      \
 		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR),	      \
-		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR),	      \
+		power_reactive(ADE9000_PHASE_C_NR)			      \
 		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_C_NR),	      \
 		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR,	      \
 					      ADE9000_REG_CWATTHR_LO),	      \
@@ -668,8 +679,10 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 		ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_C_NR),	      \
 	}
 
-ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL);
-ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS);
+ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL,
+			 ADE9000_POWER_REACTIVE_ENTRY);
+ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS,
+			 ADE9000_POWER_REACTIVE_ENTRY);
 
 /*
  * Full-scale codes referred from the respective datasheets. These are the
-- 
2.43.0

