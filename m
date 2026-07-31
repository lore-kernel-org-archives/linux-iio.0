Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9FC440A3E
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521302; cv=none; b=mXRUmCVfcRHwFV+HdMrqpbbdCM7JYlL0NmowBpEjeUSNMLh7pGVdwhuwXSBytnBIHLTtejhtHrZV55flUn4Og3pPHYrt2wBPcpEOE6gFngwIXtVS3ruKZ9A6cZlk03McNMql9hI+k0n2hAjampJ87czZRRZK/6pA6x7tOf/7faU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521302; c=relaxed/simple;
	bh=S+EobW3O5hrZzd0tPDHsUgvQlB6X46UCq86l0i+Tvjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVcVyvQXUToFUF1+9tPyd9+OKT8Wei4IY98NdpTtqQt3zISSdUlYmvnaQF2FHJKCwv60Mxi4ZJ+KWUf74eF9uB8VOGpREuUI6O3IYUmHZ4+GumRTszyWSyt6hCXH44NfreLJdeD+qkCyAOZWhJ55b+FF48J2ts45q5lStxDIGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEU1nyLu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PVI0FwKa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dEU1nyLu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PVI0FwKa"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOl7I404153
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ust5X1tIMOedO4gHVuIHuV8JiuJV8EhnI9b28qSX07g=; b=dEU1nyLuOoPcVrc+
	mxJ32ICsmltJ9VvZTm/Xc3/WMDgkKgo2i7VVhbb7FKOT6IxSdzHhZ1SQDlJbRIZU
	a/CEOCoZxcmFqmoyNOtk0YYUK8NTJcJqdWMGWutqNQmSL3TVLGYeAwo0hr34qpQw
	fSGY3K+vSHWedHvdqrzudcOU0byXwe44EJ/c06xD4ZXJQ8mKqFveH8flaCPJTizx
	v3m6MwvzzcNV0AViHCL+blBderPS17Y2NhG3GEjqf2gfnYG6KFJlkJxcYcPU4MzA
	bQVtG025hnvRnpA3KAL/5PMt61F1PJtL0mSS/yEYSfH4vDCfrZjkj4Fumxx7zc8P
	YkgvaQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frufkhnh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:08:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so873224a12.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785521299; x=1786126099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ust5X1tIMOedO4gHVuIHuV8JiuJV8EhnI9b28qSX07g=;
        b=PVI0FwKatJLdPAD1JDLAj8n/WHh9xorflZT9gk1NaNYcwxfnNaEL+BOCq5nURfDxNP
         SsOAVpW30murgS1mnxDWHcwCZ7sRotzuWAXVJcshJIBrCM7afyIbH5UBSg2QQCPhVd/9
         kzDCe0fNj+TlMw1JCiuHMivuyruB1qBhFk+W/iIdSc2v/mXJTnVZexjuUaSQ5ED39zMt
         NnCk/VxA6f5+OQ3hZEJyVHidbxdI5IcTBJzQjDT4HQT15AZLQMM7H0WMIhcBLny8cG/B
         42tt+XQZ20cKp+Rird1wgqSJYNHiAoznUaLOTM3MYCjz0v88ghNkdGXfAUiT+JGSungX
         wUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521299; x=1786126099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ust5X1tIMOedO4gHVuIHuV8JiuJV8EhnI9b28qSX07g=;
        b=kvvGZ+N1HWa2FkC5LOMnCO/L6NNkK5BZRrng1fiZ310s/8ZTtDq0qsKIqs9CGUErM9
         qlGVO9FZRzCG4FgZN2jMB84urmjzLCkPSYGsc3LZHaQJpCY9ZULhsOmY16JPatv+p5AM
         qKBgQ2IDU3RywSNeIHcIt673VhZduwrPPgbg2uz6UxLBZveBqMb1KEyOEPbJxI0VvDBS
         eheIOHxjnw5CUpO65TpFdps9oYcbcwCefG9HXbEjNN2gZrbMTZMvirrp8fAQrqztY/s2
         vkfm3FyreWCDQ7A00L7zB5fVyjczsVwG4yRcLY514Lfa+4o6wEMp1KPI06X7qbcCp2jO
         XHyg==
X-Gm-Message-State: AOJu0YzF4mVSQtY+VoZM/eInHmfoOwl+LgWfUVWzaZkBhHianCWTKEqw
	ORxsGS21oFkKSjNRdeXuEiuwOsK/2PUOpmx8B9F1k6rxzcmWbFZbYrJ1mmpq/GB8xhk3wJlaAYV
	soEthQ/3pMQI9WzKQRha12F7m5ByLxKVtNaHqD+Em8KAsZQFo/sXqH0gYLN9276o=
X-Gm-Gg: AR+sD10dKUq2m4X10zpDRPG+5HeYMDRmMj9kgEd0gTlZH02HzuFIUmcgPJW5gTvielg
	akAQyIlq5zTxwzfUzkSlGfX5lCQpekuHXI/shEcc/NjsZns3dgTRIPSqopAPpgPaK54dilDB83k
	xeWVfraHu4KwwV75hxkuE3dhjGBLCJ3aP5O4A0ATt0tzI5heP4IJmJm/I9/6/sVMrd/2+a/+Y15
	5Ul/v4IIpWe5IOkZ+gh80jQOuKsb4Y3lMyvSSgW8062NN5LpNL6D7j//RqEfWauaK9H5nJj57HO
	Q5tAlxvYGwFGyErjkGcQ5BUenk4t19dev4zSW9S9e0Fuz/QScPg5sRxIzTgNEIsILin9H/WSsaT
	1kthDkUB9JuOIPCpWPJo=
X-Received: by 2002:a05:6a20:9f46:b0:3c3:b656:4f5b with SMTP id adf61e73a8af0-3c92a8f424fmr699406637.56.1785521299311;
        Fri, 31 Jul 2026 11:08:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f46:b0:3c3:b656:4f5b with SMTP id adf61e73a8af0-3c92a8f424fmr699355637.56.1785521298847;
        Fri, 31 Jul 2026 11:08:18 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fe9fsm7069923eec.25.2026.07.31.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:08:18 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:36:19 +0530
Subject: [PATCH 6/7] arm64: dts: qcom: glymur: Add ADC support for Glymur
 CRD
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-pmic5_gen4_adc-v1-6-9c49b2eea6f9@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785521244; l=4776;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=S+EobW3O5hrZzd0tPDHsUgvQlB6X46UCq86l0i+Tvjo=;
 b=3P4scQyme6DdYri9pwWZB5rOTKiP/bE297LZBjo3s2t716tlK2LLhHOiHxydPNnyrVWqw8Cw7
 YM+mRnShlgoBDYJ3I3CkjQ2sp0NhU0tYcTzLb02O24EGBHZGNLoRydC
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfX7twJ8WciXTC+
 1v99qh9MbDEUEPmVQ6lMIUlgdp6CsEWsMTKzDhh+hYgcyimuN1P1FCNAG8y2SxAkORPJy9qSAsT
 DgGA1YDPVi5Uh6rtLyXGKZAtzzl266Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfX/QS87io+1pZz
 2o7GI2zg3WfGlgCmJ2RD13ZZdcL0CeeVi2UTdFaUoDnKaKjDbZrMNBLRQWsINEWHN7D1klsiiUu
 4LvBGc4YYIohrHlpXSqwdW37m/xLFziz4mhj6C4bPUSJemV4ZziMryNDhjLIlBVpNTuMNUDsMew
 Wy6RuPjrnYjM9/1H0u7y6wMg56iS/UaAgnOImIvQvLO8lufWEV3TlVWo4MjMHagZ/amZMXvJLsM
 coyh4qs4H0GRLkVkyShAZsm8eWypZC2QsL/4IVGPjE3mSM2A0uY/JaTUYQsQgJNSgos5LbvjvHh
 U2/dzt0EUn6dDXR/BkK810q84Pfn6IfaY1RNDYrLPA/nrT8gVpVNJMJImnZorilDJbcp7SxJjjX
 lzwPv1RpH6EgWrFCwyRPeruOIek5PegSmYoE5qeUuZwRAPsfHsSPndCDySGOX65QtfbV5jARMSk
 /wxeHGFhkpDneG2YPSA==
X-Proofpoint-GUID: P5tcFE0RlHT98LHqDVmgFyzGLBvbQTYa
X-Authority-Analysis: v=2.4 cv=BpOtB4X5 c=1 sm=1 tr=0 ts=6a6ce494 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=btccbUnoZnnoeDETn68A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: P5tcFE0RlHT98LHqDVmgFyzGLBvbQTYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310139

Add the ADC channels under the PMK8850 ADC node for the
other PMICS on the board with ADC peripherals. This includes
die temperature and VPH power channels per PMIC.

Add a thermal zone corresponding to the PMK8850 xo_therm
ADC thermistor channel to enable temperature monitoring.

Also add io-channels and io-channel-names properties to the
temp_alarm nodes so that they can get temperature reading
from the newly added ADC die_temp channels.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 143 +++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index e784b538f42e..1487864482f8 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -11,6 +11,7 @@
 #include "smb2370.dtsi"         /* SPMI2: SID-9/10/11            */
 
 #include <dt-bindings/input/gpio-keys.h>
+#include "qcom-adc5-gen4.h"
 
 / {
 	model = "Qualcomm Technologies, Inc. Glymur CRD";
@@ -68,6 +69,26 @@ switch-lid {
 		};
 	};
 
+	thermal-zones {
+		sys-0-thermal {
+			thermal-sensors = <&pmk8850_vadc ADC5_GEN4_AMUX1_THM_100K_PU(0, 0)>;
+
+			trips {
+				trip0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				trip1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+	};
+
 	vreg_nvme: regulator-nvme {
 		compatible = "regulator-fixed";
 
@@ -537,6 +558,26 @@ &pcie6_port0 {
 	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
 };
 
+&pmcx0102_c_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 2)>;
+	io-channel-names = "thermal";
+};
+
+&pmcx0102_c_e1_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 2)>;
+	io-channel-names = "thermal";
+};
+
+&pmcx0102_d_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 3)>;
+	io-channel-names = "thermal";
+};
+
+&pmcx0102_d_e1_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 3)>;
+	io-channel-names = "thermal";
+};
+
 &pmh0101_gpios {
 	nvme_reg_en: nvme-reg-en-state {
 		pins = "gpio14";
@@ -545,6 +586,11 @@ nvme_reg_en: nvme-reg-en-state {
 	};
 };
 
+&pmh0101_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 1)>;
+	io-channel-names = "thermal";
+};
+
 &pmh0110_f_e1_gpios {
 	nvme_sec_reg_en: nvme-reg-en-state {
 		pins = "gpio14";
@@ -562,10 +608,107 @@ key_vol_up_default: key-vol-up-default-state {
 	};
 };
 
+&pmh0110_f_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 5)>;
+	io-channel-names = "thermal";
+};
+
+&pmh0110_f_e1_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 5)>;
+	io-channel-names = "thermal";
+};
+
+&pmh0110_h_e0_temp_alarm {
+	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 7)>;
+	io-channel-names = "thermal";
+};
+
 &pmk8850_rtc {
 	qcom,no-alarm;
 };
 
+&pmk8850_vadc {
+	channel@103 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 1)>;
+		label = "pmh0101_die_temp";
+	};
+
+	channel@18e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 1)>;
+		label = "pmh0101_vph_pwr";
+	};
+
+	channel@203 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 2)>;
+		label = "pmcx0102_c_e0_die_temp";
+	};
+
+	channel@28e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 2)>;
+		label = "pmcx0102_c_e0_vph_pwr";
+	};
+
+	channel@303 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 3)>;
+		label = "pmcx0102_d_e0_die_temp";
+	};
+
+	channel@38e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 3)>;
+		label = "pmcx0102_d_e0_vph_pwr";
+	};
+
+	channel@503 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 5)>;
+		label = "pmh0110_f_e0_die_temp";
+	};
+
+	channel@58e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 5)>;
+		label = "pmh0110_f_e0_vph_pwr";
+	};
+
+	channel@703 {
+		reg = <ADC5_GEN4_DIE_TEMP(0, 7)>;
+		label = "pmh0110_h_e0_die_temp";
+	};
+
+	channel@78e {
+		reg = <ADC5_GEN4_VPH_PWR(0, 7)>;
+		label = "pmh0110_h_e0_vph_pwr";
+	};
+
+	channel@2203 {
+		reg = <ADC5_GEN4_DIE_TEMP(1, 2)>;
+		label = "pmcx0102_c_e1_die_temp";
+	};
+
+	channel@228e {
+		reg = <ADC5_GEN4_VPH_PWR(1, 2)>;
+		label = "pmcx0102_c_e1_vph_pwr";
+	};
+
+	channel@2303 {
+		reg = <ADC5_GEN4_DIE_TEMP(1, 3)>;
+		label = "pmcx0102_d_e1_die_temp";
+	};
+
+	channel@238e {
+		reg = <ADC5_GEN4_VPH_PWR(1, 3)>;
+		label = "pmcx0102_d_e1_vph_pwr";
+	};
+
+	channel@2503 {
+		reg = <ADC5_GEN4_DIE_TEMP(1, 5)>;
+		label = "pmh0110_f_e1_die_temp";
+	};
+
+	channel@258e {
+		reg = <ADC5_GEN4_VPH_PWR(1, 5)>;
+		label = "pmh0110_f_e1_vph_pwr";
+	};
+};
+
 &pon_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";

-- 
2.43.0

