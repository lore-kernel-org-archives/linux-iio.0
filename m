Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667927;
	b=v/ppstupZ/kMlrZQ7cR08QcGgDOxEvgVFWknXEzx8Nfm3htC3+QJ0sGxW5vdZdE4YLbw
	 jregiY+omSd92xEKhHaKnHg/wxr6SPyqAmY1kvLpTvC7UNtPoHPCxrVkJMipnvRE0ObhF
	 7595bHYAXpkFxzH+9CFK5/2dsdvwNZ9jM7umo6qehcp52SBVP7M/Ss8rl7rengVzVQEWj
	 GRMcj90RcndiDQoyRoR+eeVTLl25bosEQosJ4rj4ZegZA1CbfptCCptqJ2TJ/XSM9w3W8
	 Ouz9DFR6AIor5pUsd0tmRpuBHq1QvXto20xz2KEmDIpOr7mX850Ju2YZzkCtxfMnduQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667927;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AdEU80TitjMHrKkuBHE8Zu0KYCNoq2++sT7G+pQ//1I=;
	b=xwRGrweDV4VbDWaX0H2OxP04skPTND2jZVQ5GVofhS5wGsCYhIWLW5g8eDd1F7KZbcez
	 cARmEiGsM4m1GXuBn3PHD5P2jkbHAQ+KTa/kyIRJ2RqwziiaR4DFm1XuYZAPGfa+HZ7Mv
	 +TDV/PDu2mYpSMcAaGpnfrGzNdpp0nl4Yrta3WnPc/BIAjGHKg0m4047mdWP0pDXfDBIo
	 4ra+ybo7ZSpYVieoJA9IJKFnZ/XQ2Yk0iErA8Yf2KiqzokEXiyq88P+qzEIXq0icx0lts
	 JIb3J3OQdBkDQrba6EzhURPgJ4KlGzpPZtccUJe9deR38Uy+LdEyWhbQv0NIfqwa8lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rZhXJnnj;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=v7lJ22zn;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD6606A320;
	Thu, 22 Oct 2026 11:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3DD6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rZhXJnnj;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=v7lJ22zn
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1sWW1591238;
	Thu, 22 Oct 2026 07:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AdEU8
	0TitjMHrKkuBHE8Zu0KYCNoq2++sT7G+pQ//1I=; b=rZhXJnnjZW4S5Pcj45UFw
	zMxo+WaRt1nhVCbww0DS1oude3LLpayhMFvLtBYtmyNu2Bm6ZZe9oACtUDF+dt3z
	mFDmR++9BZGBSQSJVIqTJGXTLfk+2h50qQ84vx0jVe8FkWMQhTMaZ+KRujbgdeXJ
	ShQ323QnQXkaoOke2HEYh4pLsuSpdCwHEyHn41Am8YkBzgJgVMSAMIDAadtQf+vY
	gbbksipEQuYIC89Y9d4LP7vzHz2PKU0OAwBTIobAE23J7E9jVTMSHQ4NsAQ1ude7
	A3z0Q/Hh3zTGm+RLdksr06/GqSxPrpv47QPu4daHf6ck6wye/z1Qq207gbloSy4X
	w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AdEU8
	0TitjMHrKkuBHE8Zu0KYCNoq2++sT7G+pQ//1I=; b=v7lJ22znuldzLobf2ssZL
	zpeeKkts6ZaraUUt/D3hSHtpvw0Ug7Cqy9N6TT8eTIrzItihRgrOCe2mwBYk1hnB
	lFyYYhvR78YN8NmBWepKSCXiqHzAWH03KWbntU6J9XwIeDXbATcHv+mZGexv71Z6
	2Qp8S8CzeFOSSeOmB5sO5OLgnsznBy83f1bcRYITOjSnobzgW+c1y5gw1IXIGYx5
	8dh8MaYRYeCtvjuGatKrRplWz/zVzfqSqrJorFOW5AHv/oZ9YPdkD7NmG+DOGtlT
	V7HP4GetDj2a7S47kYQPlzvv5C1XyhY43kWHafEvWlqCwNTAg2uJjZA0JPPl2Wxz
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hf927tpx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 07:18:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69MBITnx055327
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 07:18:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 22 Oct
 2026 07:18:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 22 Oct 2026 07:18:29 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69MBI6LF005667;
	Thu, 22 Oct 2026 07:18:23 -0400
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
        Joshua Crofts <joshua.crofts1@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Janani
 Sunil <janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Jishnu
 Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 1/4] iio: adc: ade9000: parameterise the reactive power channel
Date: Thu, 22 Oct 2026 14:17:54 +0300
Message-ID: <20261022111759.6019-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022111759.6019-1-antoniu.miclaus@analog.com>
References: <20261022111759.6019-1-antoniu.miclaus@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfXx8NLpLAdDXci
 v0AMgbE5BiUCPqSfw3f475AU2DymhWvUhR0Ny6wip7bu+Y2Nn+9PfUxZnGeS8rZYoIjKp7M0ezg
 dlZfhmaoappTqHc4bcK3IQl/14AI61KdtTHkVBnK9FtPYILdbEnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NCBTYWx0ZWRfXwUVf2f6Og9t+
 eXk3t2EwFzZRN6BpUkmg1hNlY69rXsd9P5b3GrLhm172jGVtp4VelDFn7/aXGHQccDPIYyxJFXW
 P4JIvEVtP/C7vm34Sflg8kLHXNIQg66c8Yj92wsu4AQiOW7yLHjcftRkopnk/WrBKoC94CC5vWI
 Bf1HIleO+goztURDg5j460DEg6/l04q+FCBD0oqhOF9FOzIARaCJYt6f54KfyLULJbj60MMWbXX
 W+Te71nQ0kkKxEqT3aZJwUnpq+rcx3UxBy0EC2LNUuP2hHsiiYPXNsZBmMrx02Jjln4s04gkVMP
 PKXywwbfzwHvu00BjX9MJzTdxj/JyxOD9GwPiG8vVWHBL3Mo/D6kY3hg7DnxBalGEv0j7s/BzZv
 tqtA2FuHIQOLTW8D/cU1T69LDF8Z8kjK/t6HfuNMQsUeRQ+t1gWruAtD5L6s8rO/BYN6IoN0IfC
 qmfHIE6/TjXWQKTEX3A==
X-Proofpoint-GUID: 9sd_jtKu269EPNQJkIZj54G6XJJMiUsT
X-Authority-Analysis: v=2.4 cv=U/cHnuru c=1 sm=1 tr=0 ts=6ad9f107 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=y2iMgJnqLeesTMF4eTAA:9
X-Proofpoint-ORIG-GUID: 9sd_jtKu269EPNQJkIZj54G6XJJMiUsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220044

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
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
 - None.

 drivers/iio/adc/ade9000.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index c10b8c3f679c..fb69cbbb38fc 100644
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

