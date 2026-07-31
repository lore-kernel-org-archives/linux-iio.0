Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207324519B3
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521273; cv=none; b=mrOVp7lHo1qUXDY9gg4u6jLyn3dj836M3Efz9C3LUlcjoSth3xVW9ASnbM7s/SPDYWZ00Xw9Hwkm2F+h5IM1WaVVbsnJkGJsSD8g0/doXVv/pfKrKhar8nTIQ1QxWIuY8htMEFc53I9OCJC8qMoAsg5BlT/YA+lYXqtNYzdNLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521273; c=relaxed/simple;
	bh=UFSKypV+EtK0Ea55Kg/sZknatS3o/XIcr3mC/cv7DuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R42tV42WK/28/MCtwx0ubz4f8IMDwY23VAjdmGCcd388evAKwNTbENTEqz2ev6q5AUNAKzuFp5AmB2g4FI6OmLhQcD8nPknMwIzHbFrXouphufPyDlTsz9ErFl+CPqlYPID5bmEebgG4Y8k6JuHUfVbclrOqw7h2qwBszM4Erpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=idHl4gYc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DPgEDUTC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="idHl4gYc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DPgEDUTC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOcrQ403962
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VFIJP606ztFdpHXf6vk++n59DLq9jYBouMDkD7WGQC8=; b=idHl4gYcXDX4SbuY
	1vmGhPxR7xvEPyw0YieDkMX7DMr60DN5jo7kwUn9u08ql5nxoQft3ednsFN4fOmq
	2rCYrORMEmgBBCltZ07SQ9+oP12GFHgoPn3nXofiZaoYv9qFXFVMC34T8DHj/+tP
	NuEE4Eo3ksJRPFAw+8hPDqA2mzhLck8+M/VQEsAL0/XQeQu5gXrKAR++iWGFHI1Q
	nfkErx/ESRSq2Z6gGnPD37Kj0Olrp4nowCm7ApgrMpkM9Wx0d+uFcunBL6sG6JkV
	nmfpTC2VZWLg0okmhtD3WAOJl6ePteCD/gFj00KIrVFqvBqsHu20YDNS2oXUHrch
	PzcWHg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frufkhne5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:07:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso805604a12.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785521269; x=1786126069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VFIJP606ztFdpHXf6vk++n59DLq9jYBouMDkD7WGQC8=;
        b=DPgEDUTCWFeTKFMYlMJmI+6tKerqoXKT94ltrj4kgFVLF4C9E50ud+qdkudcSgiR6M
         kmCWo6oWNUM0jFfiP8kIC34CCzTyp3+04BQhd+1QYAFZ5iJ9LHGpQ12g5GaLLbsuL1cD
         N1lsKzVU0MQzamTbNAFYemXwOU13l//zP+4kulAsa06zbqbCLwXRfigq8cY8X+oUOEVE
         lHfvjKFfy8fOCCSVnh62kivKPJoqD8w9sE80dpAId0VOSMWsjAwbCU6XFGqVJAamZqu4
         HfGqRQMrSVeJV1arbRdo/l8kdDWyHVfKY6JY0JFIVQBDPf8VNufiVva4FXxtscIhBT0j
         BYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521269; x=1786126069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFIJP606ztFdpHXf6vk++n59DLq9jYBouMDkD7WGQC8=;
        b=fH+dH0P/gcb8fHONHhdyvBgFQWYVOv/+65LHQLA+nK5eeg3AoVozytkM2M7H60IKBw
         T1VgkyBu3qFH2vAegfj67IhU2Wh9HH3iQjzvwaptpeAXKLyKustqvZqCTHFP+619RFqk
         QOoLCCKHDAqTaiTZP+bUW54C5ET3n5C2C5l9LeIspKwg3Vs1gjMiKTzUrtEh4TKqQ8P7
         wU0P/n4vciMlWDN73Wut+1W2b4jKMmnAlnsmhNb1Tx04jd4+01fB6z3Dfgf6HyoOl624
         W4JbGxLldd5oCMnAGPoljpnlKOj7PrfLSQXqd4+C/HNZljw4NOy3PU/t6rRtCGYku+cZ
         oOJw==
X-Gm-Message-State: AOJu0Yzv/ZkHGpvUVXaIy+rUHq4RSBjRspz54rLI8TzMqnDwumONhQD2
	mStkPziRn0hiusVsTN7GGqjQ2vwW8D3Fk7vhB38ZAP7fHpIiMyGnttk8sR6ICSDXf41JNb5Rbw4
	tImBLIm3Zg87o4amcTgL8cHoXQG1SCl3sifShM+I4KAyq+2/ezeo3LSUCnPGiFc1l2GEJAQo=
X-Gm-Gg: AR+sD12pbbPVHTPpe+3gRvXZHZPB3u46fLBGZU46qM3BJf0qisjBR8MZCdvV0Gsc6pg
	qZJ035mJt//C56S9denNAxOxf5FBwRNXVMV3G7eMmhYupIYPlUsseO6cEN5RDXOXnwBzyfeF6Y7
	kSoPWC+/w6Y+Bs32OuF8rSqmstGGShUEvU3BKc3qw341IQX53Mnx2/P+pm9G2Zz3cdR3ZdDhHHa
	e8C35vMwPZTU5dXv8GBzsYSdRKNfheY0RB50TwbfsB3zBxxQ4MhPSsSIQqPrToEzDe6UJwTxwRJ
	klknABZrr3tS1Y+zxNvPnmcQTquBHBnt5pIy0eAQ8emYJuCBe7rXZjUXijOdxTOSrzVtnEI7kLP
	CcskL76m09XUAXdpp4AM=
X-Received: by 2002:a05:6a21:1bc2:b0:3c3:abd4:ac74 with SMTP id adf61e73a8af0-3c92a8400eamr726844637.39.1785521268373;
        Fri, 31 Jul 2026 11:07:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:1bc2:b0:3c3:abd4:ac74 with SMTP id adf61e73a8af0-3c92a8400eamr726802637.39.1785521267728;
        Fri, 31 Jul 2026 11:07:47 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fe9fsm7069923eec.25.2026.07.31.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:07:47 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:36:15 +0530
Subject: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785521244; l=18544;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=UFSKypV+EtK0Ea55Kg/sZknatS3o/XIcr3mC/cv7DuI=;
 b=puidsO+/c7J+yEyqr1nMvupJ0PizizTg5F1oxK22bAIwy5BC4MFWMMvpVmm7OwOgPvQ9H8rxK
 CuDarxx3dY3DdBxLQQEN+M+xOZZ6MG7Bnq8a9t101gCa8ShM4iW2jAw
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfX8YrRyvODMfZe
 2CnAmaPHnIV1PudMxqmY3gnthLPbZzZgkSdLhc3TGPnfGv+mqB79DJhp27tF9fnFMk3ezmiYw5R
 53crKA30WesC+AlSTStjSn1rqj/S6qw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfXwnB9pZGE/IDH
 tK+6S8v+1YuThq3UJiKvKjtBHiA1vqwb1aDWoxN1SDJrWyBxfKo8E8jpI8bUhEunPD/jnn893M5
 IuMkK4NcDp1hue5RN+93EIJhd+/HKr/oS4AQpW6o/QoUXYIWOf1AnTSLgoKztKKeAjNnEGUPJCC
 MFaiLp1KEwlipcnnn7r1L7eBow9FBB++ziF3HL1BVdwvcxeT5ITsN2qCopr+uU9wR10QIYpZzal
 hgNkz0PI0Tf4E1fM4DHuOFDP5sHIIwXBH8grx/FsP7FStwWPxiXhyirLyxaQ3zDeJDhPSPRw9f5
 Yhx75DCdmEzv9RbRmzXA0JKSO30Hh7doJ2b3Vyb3mYMgocP6VmtltYaCQT+J81mBKJubPLhfZPT
 ayLwN6Rh75cH2vwxpyGirChXjde7fBshoiCvusw0+xIc+8Y/77OgL3nxPNMroOP0oAQxQg/A7Bb
 1MurLXZqYsWdwj7IX8g==
X-Proofpoint-GUID: zMUrgcEypOtM8x3qjBu0k54FF1GxL2Jt
X-Authority-Analysis: v=2.4 cv=BpOtB4X5 c=1 sm=1 tr=0 ts=6a6ce476 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VL9c4Isk2NYVz5x_yekA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: zMUrgcEypOtM8x3qjBu0k54FF1GxL2Jt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310139

PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
for improved performance, mostly at the hardware level.

One significant software change is that ratiometric conversion resolution
has been increased from 14 bits to 16 bits, so the maximum value of
these measurements needs to be updated for Gen4. Add a new scaling
function for thermistor channels which use this type of conversion.

In the latest PMIC arbiter version (v8), there can be up to 4 buses
under the PMIC arbiter and 32 PMICs under each bus. In order to
support communication between ADC on the master PMIC and ADCs on any
of the other PMICs, a field of width 2 bits is added for bus index
and the bits for SID are extended from 4 to 5 bits, in the SID
register. Add support for this.

In addition, it is possible that the master PMIC has ADC of one generation
and it needs to communicate with another PMIC with ADC of a different
generation. Add new DT properties "qcom,adc5-gen3" and "qcom,adc5-gen4",
to distinguish Gen3 channels under a Gen4 master and Gen4 channels
under a Gen3 master respectively, to ensure that their conversions are handled
correctly.

Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 165 +++++++++++++++++++-------
 drivers/iio/adc/qcom-vadc-common.c            |  32 +++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h |  44 ++++++-
 include/linux/iio/adc/qcom-vadc-common.h      |   4 +
 4 files changed, 195 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c68c6c5f6aca..810d25b665b1 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -86,7 +86,9 @@ int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
 }
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_write, "QCOM_SPMI_ADC5_GEN3");
 
-static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
+static int adc5_gen3_read_voltage_data(struct adc5_chip *adc,
+				       struct adc5_channel_common_prop *prop,
+				       u16 *data)
 {
 	u8 rslt[2];
 	int ret;
@@ -99,8 +101,10 @@ static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
 	*data = get_unaligned_le16(rslt);
 
 	if (*data == ADC5_USR_DATA_CHECK) {
-		dev_err(adc->dev, "Invalid data:%#x\n", *data);
-		return -EINVAL;
+		if (!(prop->generation == ADC5_GEN4 && prop->cal_method == ADC5_RATIOMETRIC_CAL)) {
+			dev_err(adc->dev, "Invalid data:%#x\n", *data);
+			return -EINVAL;
+		}
 	}
 
 	dev_dbg(adc->dev, "voltage raw code:%#x\n", *data);
@@ -131,8 +135,9 @@ static int adc5_gen3_configure(struct adc5_chip *adc,
 	if (ret)
 		return ret;
 
-	/* Write SID */
-	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
+	/* Write SID and bus_id*/
+	buf[0] = FIELD_PREP(ADC5_GEN4_BUS_INDEX_MASK, prop->bus_index) |
+		 FIELD_PREP(ADC5_GEN4_SID_MASK, prop->sid);
 
 	/*
 	 * Use channel 0 by default for immediate conversion and to indicate
@@ -268,7 +273,7 @@ static int adc5_gen3_do_conversion(struct adc5_chip *adc,
 		return -ETIMEDOUT;
 	}
 
-	ret = adc5_gen3_read_voltage_data(adc, data_volt);
+	ret = adc5_gen3_read_voltage_data(adc, prop, data_volt);
 	if (ret)
 		return ret;
 
@@ -325,7 +330,7 @@ static int adc5_gen3_fwnode_xlate(struct iio_dev *indio_dev,
 	int i, v_channel;
 
 	for (i = 0; i < adc->nchannels; i++) {
-		v_channel = ADC5_GEN3_V_CHAN(adc->chan_props[i].common_props);
+		v_channel = ADC5_GEN4_V_CHAN(adc->chan_props[i].common_props);
 		if (v_channel == iiospec->args[0])
 			return i;
 	}
@@ -351,7 +356,7 @@ static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = qcom_adc5_hw_scale(prop->scale_fn_type, prop->prescale,
-					 adc->data, adc_code_volt, val);
+					 prop->data, adc_code_volt, val);
 		if (ret)
 			return ret;
 
@@ -433,15 +438,89 @@ static const struct adc5_channels adc5_gen3_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_THERM_100K_PU_PM7)
 };
 
+static const struct adc5_channels adc5_gen4_chans_pmic[ADC5_MAX_CHANNEL] = {
+	[ADC5_GEN4_OFFSET_REF]		= ADC5_CHAN_VOLT(0,
+						SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN4_1P25VREF]		= ADC5_CHAN_VOLT(0,
+						SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN4_VPH_PWR]		= ADC5_CHAN_VOLT(1,
+						SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN4_VBAT_SNS_QBG]	= ADC5_CHAN_VOLT(1,
+						SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN4_DIE_TEMP]		= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_PMIC_THERM_PM7)
+	[ADC5_GEN4_AMUX1_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX2_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX3_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX4_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX5_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX6_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX1_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX2_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX3_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX4_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+	[ADC5_GEN4_AMUX5_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
+};
+
+static const struct adc5_data adc5_gen3_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.adc_chans = adc5_gen3_chans_pmic,
+	.info = &adc5_gen3_info,
+	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
+			   { 85, 340, 1360 },
+	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
+			   { 15, 100, 200, 300,
+			     400, 500, 600, 700,
+			     1000, 2000, 4000, 8000,
+			     16000, 32000, 64000, 128000 },
+};
+
+static const struct adc5_data adc5_gen4_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.adc_chans = adc5_gen4_chans_pmic,
+	.info = &adc5_gen3_info,
+	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
+			   { 85, 340, 1360 },
+	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
+			   { 15, 100, 200, 300,
+			     400, 500, 600, 700,
+			     1000, 2000, 4000, 8000,
+			     16000, 32000, 64000, 128000 },
+};
+
+static const struct of_device_id adc5_match_table[] = {
+	{
+		.compatible = "qcom,spmi-adc5-gen3",
+		.data = &adc5_gen3_data_pmic,
+	},
+	{
+		.compatible = "qcom,spmi-adc5-gen4",
+		.data = &adc5_gen4_data_pmic,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adc5_match_table);
+
 static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 					 struct adc5_channel_prop *prop,
 					 struct fwnode_handle *fwnode)
 {
 	const char *name = fwnode_get_name(fwnode);
-	const struct adc5_data *data = adc->data;
+	const struct adc5_data *data;
+	u32 chan, value, sid, bus_index;
 	struct device *dev = adc->dev;
 	const char *channel_name;
-	u32 chan, value, sid;
 	u32 varr[2];
 	int ret;
 
@@ -452,27 +531,46 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 
 	/*
 	 * Value read from "reg" is virtual channel number
-	 * virtual channel number = sid << 8 | channel number
+	 * virtual channel number = bus index << 13 | sid << 8 | channel number
+	 * For ADC5 GEN3 channels, bus index = 0
 	 */
-	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
-	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
+	bus_index = FIELD_GET(ADC5_GEN4_V_CHAN_BUS_INDEX_MASK, chan);
+	sid = FIELD_GET(ADC5_GEN4_V_CHAN_SID_MASK, chan);
+	chan = FIELD_GET(ADC5_GEN4_V_CHAN_CHANNEL_MASK, chan);
 
 	if (chan >= ADC5_MAX_CHANNEL)
 		return dev_err_probe(dev, -EINVAL,
 				     "%s invalid channel number %d\n",
 				     name, chan);
 
+	prop->common_props.bus_index = bus_index;
 	prop->common_props.channel = chan;
 	prop->common_props.sid = sid;
 
-	if (!adc->data->adc_chans[chan].info_mask)
+	if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen4")) {
+		prop->common_props.generation = ADC5_GEN4;
+		data = &adc5_gen4_data_pmic;
+	} else if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen3")) {
+		prop->common_props.generation = ADC5_GEN3;
+		data = &adc5_gen3_data_pmic;
+	} else {
+		prop->common_props.generation = (adc->data == &adc5_gen3_data_pmic) ?
+						 ADC5_GEN3 : ADC5_GEN4;
+		data = adc->data;
+	}
+	prop->common_props.data = data;
+
+	if (!data->adc_chans[chan].info_mask)
 		return dev_err_probe(dev, -EINVAL, "Channel %#x not supported\n", chan);
 
 	channel_name = name;
 	fwnode_property_read_string(fwnode, "label", &channel_name);
 	prop->common_props.label = channel_name;
 
-	value = data->decimation[ADC5_DECIMATION_DEFAULT];
+	if (prop->common_props.generation == ADC5_GEN3)
+		value = data->decimation[ADC5_DECIMATION_DEFAULT];
+	else
+		value = data->decimation[ADC5_GEN4_DECIMATION_DEFAULT];
 	fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
 	ret = qcom_adc5_decimation_from_dt(value, data->decimation);
 	if (ret < 0)
@@ -480,7 +578,7 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 				     chan, value);
 	prop->common_props.decimation = ret;
 
-	prop->common_props.prescale = adc->data->adc_chans[chan].prescale_index;
+	prop->common_props.prescale = data->adc_chans[chan].prescale_index;
 	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
 	if (!ret) {
 		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
@@ -526,34 +624,13 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 	return 0;
 }
 
-static const struct adc5_data adc5_gen3_data_pmic = {
-	.full_scale_code_volt = 0x70e4,
-	.adc_chans = adc5_gen3_chans_pmic,
-	.info = &adc5_gen3_info,
-	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
-			   { 85, 340, 1360 },
-	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
-			   { 15, 100, 200, 300,
-			     400, 500, 600, 700,
-			     1000, 2000, 4000, 8000,
-			     16000, 32000, 64000, 128000 },
-};
-
-static const struct of_device_id adc5_match_table[] = {
-	{
-		.compatible = "qcom,spmi-adc5-gen3",
-		.data = &adc5_gen3_data_pmic,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, adc5_match_table);
-
 static int adc5_get_fw_data(struct adc5_chip *adc)
 {
 	const struct adc5_channels *adc_chan;
 	struct adc5_channel_prop *chan_props;
 	struct iio_chan_spec *iio_chan;
 	struct device *dev = adc->dev;
+	const struct adc5_data *data;
 	unsigned int index = 0;
 	int ret;
 
@@ -582,10 +659,11 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
 			return ret;
 
 		chan_props->chip = adc;
-		adc_chan = &adc->data->adc_chans[chan_props->common_props.channel];
+		data = chan_props->common_props.data;
+		adc_chan = &data->adc_chans[chan_props->common_props.channel];
 		chan_props->common_props.scale_fn_type = adc_chan->scale_fn_type;
 
-		iio_chan->channel = ADC5_GEN3_V_CHAN(chan_props->common_props);
+		iio_chan->channel = ADC5_GEN4_V_CHAN(chan_props->common_props);
 		iio_chan->info_mask_separate = adc_chan->info_mask;
 		iio_chan->type = adc_chan->type;
 		iio_chan->address = index;
@@ -697,7 +775,7 @@ int adc5_gen3_get_scaled_reading(struct device *dev,
 
 	return qcom_adc5_hw_scale(common_props->scale_fn_type,
 				  common_props->prescale,
-				  adc->data, adc_code_volt, val);
+				  common_props->data, adc_code_volt, val);
 }
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_get_scaled_reading, "QCOM_SPMI_ADC5_GEN3");
 
@@ -705,12 +783,9 @@ int adc5_gen3_therm_code_to_temp(struct device *dev,
 				 struct adc5_channel_common_prop *common_props,
 				 u16 code, int *val)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
-	struct adc5_chip *adc = iio_priv(indio_dev);
-
 	return qcom_adc5_hw_scale(common_props->scale_fn_type,
 				  common_props->prescale,
-				  adc->data, code, val);
+				  common_props->data, code, val);
 }
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
 
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index b03cf584b165..cb23d0d178c7 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -301,6 +301,10 @@ static const struct u32_fract adc5_prescale_ratios[] = {
 	{ .numerator =  1, .denominator = 16 },
 };
 
+static int qcom_adc5_gen4_scale_hw_calib_therm(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec);
 static int qcom_vadc_scale_hw_calib_volt(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
@@ -341,6 +345,8 @@ static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
 					qcom_vadc7_scale_hw_calib_die_temp},
 	[SCALE_HW_CALIB_PM5_CHG_TEMP] = {qcom_vadc_scale_hw_chg5_temp},
 	[SCALE_HW_CALIB_PM5_SMB_TEMP] = {qcom_vadc_scale_hw_smb_temp},
+	[SCALE_HW_CALIB_THERM_100K_PU_GEN4] = {
+					qcom_adc5_gen4_scale_hw_calib_therm},
 };
 
 static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
@@ -556,6 +562,32 @@ static int qcom_vadc7_scale_hw_calib_therm(
 	return 0;
 }
 
+static int qcom_adc5_gen4_scale_hw_calib_therm(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec)
+{
+	s64 resistance = adc_code;
+	int ret, result;
+
+	if (adc_code >= RATIO_MAX_ADC5_GEN4)
+		return -EINVAL;
+
+	/* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/
+	resistance *= R_PU_100K;
+	resistance = div64_s64(resistance, RATIO_MAX_ADC5_GEN4 - adc_code);
+
+	ret = qcom_vadc_map_voltage_temp(adcmap7_100k,
+					 ARRAY_SIZE(adcmap7_100k),
+					 resistance, &result);
+	if (ret)
+		return ret;
+
+	*result_mdec = result;
+
+	return 0;
+}
+
 static int qcom_vadc_scale_hw_calib_volt(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
index 39cbfcbdb101..5d8e38350827 100644
--- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -40,7 +40,8 @@
 #define ADC5_GEN3_CONV_ERR_CLR_REQ		BIT(0)
 
 #define ADC5_GEN3_SID				0x4f
-#define ADC5_GEN3_SID_MASK			GENMASK(3, 0)
+#define ADC5_GEN4_SID_MASK			GENMASK(4, 0)
+#define ADC5_GEN4_BUS_INDEX_MASK		GENMASK(6, 5)
 
 #define ADC5_GEN3_PERPH_CH			0x50
 #define ADC5_GEN3_CHAN_CONV_REQ			BIT(7)
@@ -51,6 +52,7 @@
 #define ADC5_GEN3_DIG_PARAM			0x52
 #define ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK	GENMASK(5, 4)
 #define ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK	GENMASK(3, 2)
+#define ADC5_GEN4_DECIMATION_DEFAULT	1
 
 #define ADC5_GEN3_FAST_AVG			0x53
 #define ADC5_GEN3_FAST_AVG_CTL_EN		BIT(7)
@@ -75,10 +77,13 @@
 #define ADC5_GEN3_CONV_REQ			0xe5
 #define ADC5_GEN3_CONV_REQ_REQ			BIT(0)
 
-#define ADC5_GEN3_VIRTUAL_SID_MASK		GENMASK(15, 8)
-#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
-#define ADC5_GEN3_V_CHAN(x)		\
-	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)
+#define ADC5_GEN4_V_CHAN_BUS_INDEX_MASK		GENMASK(14, 13)
+#define ADC5_GEN4_V_CHAN_SID_MASK		GENMASK(12, 8)
+#define ADC5_GEN4_V_CHAN_CHANNEL_MASK		GENMASK(7, 0)
+#define ADC5_GEN4_V_CHAN(x) \
+	(FIELD_PREP(ADC5_GEN4_V_CHAN_BUS_INDEX_MASK, (x).bus_index) | \
+	 FIELD_PREP(ADC5_GEN4_V_CHAN_SID_MASK, (x).sid) | \
+	 FIELD_PREP(ADC5_GEN4_V_CHAN_CHANNEL_MASK, (x).channel))
 
 /* ADC channels for PMIC5 Gen3 */
 #define ADC5_GEN3_REF_GND			0x00
@@ -102,6 +107,27 @@
 
 #define ADC5_MAX_CHANNEL			0xc0
 
+/* ADC channels for PMIC5 Gen4 */
+#define ADC5_GEN4_OFFSET_REF		0x00
+#define ADC5_GEN4_1P25VREF			0x01
+#define ADC5_GEN4_DIE_TEMP			0x03
+#define ADC5_GEN4_USB_SNS_DIV20			0x11
+#define ADC5_GEN4_VIN_DIV20_MUX			0x12
+#define ADC5_GEN4_VPH_PWR			0x8e
+#define ADC5_GEN4_VBAT_SNS_QBG			0x8f
+/* 100k pull-up channels */
+#define ADC5_GEN4_AMUX1_THM_100K_PU		0x44
+#define ADC5_GEN4_AMUX2_THM_100K_PU		0x45
+#define ADC5_GEN4_AMUX3_THM_100K_PU		0x46
+#define ADC5_GEN4_AMUX4_THM_100K_PU		0x47
+#define ADC5_GEN4_AMUX5_THM_100K_PU		0x48
+#define ADC5_GEN4_AMUX6_THM_100K_PU		0x49
+#define ADC5_GEN4_AMUX1_GPIO_100K_PU		0x4a
+#define ADC5_GEN4_AMUX2_GPIO_100K_PU		0x4b
+#define ADC5_GEN4_AMUX3_GPIO_100K_PU		0x4c
+#define ADC5_GEN4_AMUX4_GPIO_100K_PU		0x4d
+#define ADC5_GEN4_AMUX5_GPIO_100K_PU		0x5e
+
 enum adc5_cal_method {
 	ADC5_NO_CAL = 0,
 	ADC5_RATIOMETRIC_CAL,
@@ -117,6 +143,11 @@ enum adc5_time_select {
 	MEAS_INT_NONE,
 };
 
+enum adc_generation {
+	ADC5_GEN3 = 0,
+	ADC5_GEN4,
+};
+
 /**
  * struct adc5_sdam_data - data per SDAM allocated for adc usage
  * @base_addr: base address for the ADC SDAM peripheral.
@@ -166,6 +197,9 @@ struct adc5_channel_common_prop {
 	unsigned int hw_settle_time_us;
 	unsigned int avg_samples;
 	enum vadc_scale_fn_type scale_fn_type;
+	enum adc_generation generation;
+	unsigned int bus_index;
+	const struct adc5_data *data;
 };
 
 /**
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 3bf4c49726a7..4be682083843 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -54,6 +54,7 @@
 
 #define R_PU_100K				100000
 #define RATIO_MAX_ADC7				BIT(14)
+#define RATIO_MAX_ADC5_GEN4			0xffff
 
 /*
  * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
@@ -105,6 +106,8 @@ struct vadc_linear_graph {
  *	charger temperature.
  * @SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
  *	SMB1390 temperature.
+ * @SCALE_HW_CALIB_THERM_100K_PU_GEN4: Returns temperature in millidegC using
+ *	lookup table for PMIC5 Gen4 ADC. The hardware applies offset/slope to adc code.
  */
 enum vadc_scale_fn_type {
 	SCALE_DEFAULT = 0,
@@ -120,6 +123,7 @@ enum vadc_scale_fn_type {
 	SCALE_HW_CALIB_PMIC_THERM_PM7,
 	SCALE_HW_CALIB_PM5_CHG_TEMP,
 	SCALE_HW_CALIB_PM5_SMB_TEMP,
+	SCALE_HW_CALIB_THERM_100K_PU_GEN4,
 	/* private: */
 	SCALE_HW_CALIB_INVALID,
 };

-- 
2.43.0

