Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166471;
	b=A6XziO15pRc8BFouX54SZ7Bffjvhz+Iu0mMA0C/EhuHPg+hmT+XnCC6gAAZ0MXY2g5gd
	 88psjKi4uEsu9h/Z8/p66nh4r4GnK7zL5BiVzEdEsDN8ICgSBokauNAu8AMqOMHtL+3Tv
	 9o+4GLV0N3yWowCfKr40EG1KqdtOaeMhyEuUWVVYbBEcA3iyETwAaaS7T5G6Qb07No2lS
	 zQc5G8IzB7pU5SyCduzeEuxdt76wuxCa2Mm+BPvf151nmXsNG2zgoJVURbbcU/jzULcp2
	 xWBCHnn5KHxCuI2DUj3PkTqKh54eY9q13+Jk8CLzKHwtaPVigcHDj9RjIisLhiMoogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mahhSk0PmR2ezEj2NwFomLCrdaTaXFYTI0YszKpQWiY=;
	b=ZUYGucSMBEFdyn556ZiBJOn8mz8D968g2GWsOThSmWYw6zNsowbHcGLhILLQa4CJWQkL
	 hbJZGKbyu4LnM9O1BOCQP+wzr42iVMnlKOkVl2FhYwgabmmru0tZds4/TNuFbvrn8+u4O
	 OgnYM9r6V0RqOZOKWSaWjvyhw/nJAt/9+m3k1rW0UisXEwTXySjgcwnXKoBSvbQQ64GCf
	 UhOl6nsN6XUEqJ4f4cyazfTDC4yRCTGZx/HaXkf3uf1ukzziVfiAqZ6JjLOmPuItFY9bS
	 UbKixrtfoVtzNLD2mm+yCnov3vKbigzNhtev39lDwbTY5t9HyfudbpEh+h4WUQIG10A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pFhEPrN6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NqgzgaSM;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8160A2605
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC8160A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pFhEPrN6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NqgzgaSM
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK80co5692109
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mahhSk0PmR2ezEj2NwFomLCrdaTaXFYTI0YszKpQWiY=; b=pFhEPrN6iFGZr7FS
	VvJbym3P0aDFC5Mm6QmYQ8JuMe/VB09m9wlAzsRa6YXsLv9lQxEcdrboAUZD/FP+
	lSI6JC7Rb+kVErWHaE+h0B0AMvwzWFIpigt3Lcz8tYuAa3QraZgVqROZE0LynpG3
	0MiUlzT3RGFGqGNpbcstpbV6su1AOdrH8Gkottn+AuSS+f3Zb0Hn0kG3361s6+fX
	zojyQky2l4mhLXaSxt/XbfupAvTyws6dpx3ec5nJ8+asBghjUTN0R4t0ZRsaVP41
	x9F0nR9w6T2uQixjZTFmtRAoHs2N9rT2xQIPjIflbnsSKBqH3NcqGb1cekVKFwq2
	VVlTrA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fyjx1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:21:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b5e3b5daffso965836b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 01:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795166469; x=1795771269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mahhSk0PmR2ezEj2NwFomLCrdaTaXFYTI0YszKpQWiY=;
        b=NqgzgaSMvMKItkCV353z87f29wbYiq/T7WdMxZVKhxWSarZZPDjFBGo3bmketF6U2/
         b7LtGGKC3CzdTz0qLh06aurC0I8P0poVho9MtfeUUR0rpcsPeDMqPTAqaN5q3dEgYgi9
         4vCc4G/zUVb4yPni45baGh/SiurwtCDSA9zNLROOCpGBpY+tp+qDlpSF8OxskRn16g0d
         yC4wQntfXZyYsGIuGlH0EOYkjZu7Onpej/DzG38WSwsDHRALfrszLKX5flqUuMBK5dyr
         s/hD0mkcqoRx3z/5QLmCVObkD0cRjAARUjeRLwKZrQEKPzQXGEw93abQpq51fJn4Zda6
         AqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166469; x=1795771269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mahhSk0PmR2ezEj2NwFomLCrdaTaXFYTI0YszKpQWiY=;
        b=1/NbNa4dqbl4bEKstGf3oSpexzpRZHC3+gYCDTpOKGiZT+dUV26lSIWkQC+y6VL4NA
         nw3PiF9N2GnMPFq/vTDhywvPpLsazN5batNTCfrnH2MPvz6JEbEuC//bvbHm7caeUeub
         IBzeT17cPUhWIneGVTI2JfD0Tuqw2Uc2C/GXnlc/ArAMOCZ5irO29aCPllFHIw5ZMjs2
         Ar3Xkikv+/Nxp9E3fc2LJGctsfewHcy14HJ1IxnjutF/1wUWkV62k4wmD/8j3D7Wp0J6
         QmV8Pt3kRQ0pvsZjhX4f6jzTphQ63UE9sERLh+2Gh/HUaZ7mvw/UIXmHBERmeVJy4u0d
         Nf0Q==
X-Gm-Message-State: APuU4Z/DTdQWqBXuomz4sqFMyv/Ovz2K1eIoXYMQj6q4JDeyxnALgm3h
	OJs1zSzJWCExqIAtwq9OEncamK33KLU+xH6fPGShiSiscG4F7snOp+7sZvXKmiXh7ns66ixFnll
	PZo5AxLQe5KIG1FtGUHbcsmZDxiX84t9wIim9LF2Pkh4bKFXyQyNdnDLaVhsHueY=
X-Gm-Gg: AZFdTZddYa3jwz0FNh8wq/gzYRp1qd7kw/+s4IJ1euhO3qtaOmT15E9BsCBAJOfCeGV
	bIqw3mDyyzhFxfUHu5W8HwaY0TZsPvdfeQCxiJH9Bx8ld365QlUuHX5XCRudMzJ7xCEOu/cKHZc
	homE6GPxfWBnaK1GEIIUvfH3Jx4dVGWUfEkJw8Wnhmo+zJUCxOQSeuDoJ7sYeuPOybpshjq6C2W
	sre9hq4K6pa7eK3BwZw2TFj7ikP0W63gAyuiTV408UBzkPqGjsqrd3DyRBKswD2bXt7xkxqNWqv
	MJ8Rd58vAcNaIbnw9oX9T171N7iBgboT2+x4/XC/cJmpzAXvFgPS+TLNt3ogqEasCvFL+ck26G+
	+2lgTPk8NbVjeq4J04BYF+7OQsdsOnV2OxbcIB0QTxvSFiZW1BHohg1pLmxBN4EB0K2xc
X-Received: by 2002:a05:6a00:13a4:b0:886:3827:c4a2 with SMTP id d2e1a72fcca58-8c8792b5df2mr2197442b3a.3.1795166468783;
        Fri, 20 Nov 2026 01:21:08 -0800 (PST)
X-Received: by 2002:a05:6a00:13a4:b0:886:3827:c4a2 with SMTP id d2e1a72fcca58-8c8792b5df2mr2197402b3a.3.1795166468320;
        Fri, 20 Nov 2026 01:21:08 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfa0sm1186994b3a.48.2026.11.20.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:21:08 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:49:47 +0530
Subject: [PATCH v2 7/7] iio: adc: qcom-spmi-adc5-gen3: Add support for Gen4
 ADC master PMICs
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-pmic5_gen4_adc-v2-7-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795166413; l=1816;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=8tKiHC9A/M3XzU0T08Uaoa2wdw40KkBqDDzliwqYNnU=;
 b=BKiM0wm2FEu3QaMv6oPG6DNGe1n0UDqLZHy1I0BEjBtQuV7N70QOdKz+q2TF2AotRmVplAnqC
 nByof0nMIoGA1wh3QC9cGllTN1Cfc0pQV4XI23sX18Mn9k1isyv2Rhn
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfXx0HbreP6qnX/
 inBAyysib35OvH/AfzfryekY5qjpTeDsvxq4zbIcrjxkuGhBHmQW8nxBvlEjIpnE5bBpMOfCY9z
 +/7ewMP05bYuksv6+BDXe/MeDlf45Dk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX8dd8Ee3zzaMZ
 gun1hzSQfthFjFVH06ReeVhtb1DIlUjAlQD+LyGGGcJRDlW7YS+8O0tvlU42ONuf1/Kh3jOmMnt
 HB+q/Lz12Qu/cDwE29ZkU706A0tb96ICGQJ3HSUvwcH64OjI6DBJSJ4Q3uHoDTCilUAfBFXLDgf
 hpAd4N6oMryysqLybzegj9dFo1wkdLAvBBJuQ3ojKZVAPoyEXJhXTneAunn1JWNJ50vOCcprq0P
 IDYSNmfiTbUMykFdGvEfRkjsBSF6FmhHd2mERRSH2gFj48ItShSYvmLX01ViOp3hXYnHk5sYN/y
 oDC3jSS3yo+faK2sa2o1MN6qdRHh1YO0EYFytjqwT0sS7jFE6+f0ag9y2HubVHs/+vnQ0va4JfA
 CU86M2qPXjmCjqKzLpV0UC0G/F3x/O1YK66JQGxtK+mIxUQ0DO9rwDHkXEJgx/oGHvoDEAsdUzI
 qF86Sq2v/vRWno+hjOw==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6b001105 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=c7yoL7TMHuxufLz7hX4A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Z6vi6d4RtdMudARo9qtXNbpyUMZFDsGJ
X-Proofpoint-GUID: Z6vi6d4RtdMudARo9qtXNbpyUMZFDsGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200037

At present, support is present for Gen4 ADC channels under a master PMIC
with Gen3 ADC, through the ADC channel property "qcom,adc5-gen4". Add a
compatible string "qcom,spmi-adc5-gen4" to support a master PMIC with Gen4
ADC.

For Gen4 master PMIC, add a new DT property "qcom,adc5-gen3" to distinguish
Gen3 channels under a Gen4 master, similar to the channel property
"qcom,adc5-gen4". A channel without either of these properties is
considered to be of the same type indicated by the top-level compatible
string.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index aa06d4d1083a..6782e0ab3993 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -521,9 +521,13 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 	if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen4")) {
 		prop->common_props.generation = ADC5_GEN4;
 		data = &adc5_gen4_data_pmic;
-	} else {
+	} else if (fwnode_property_read_bool(fwnode, "qcom,adc5-gen3")) {
 		prop->common_props.generation = ADC5_GEN3;
 		data = &adc5_gen3_data_pmic;
+	} else {
+		prop->common_props.generation = (adc->data == &adc5_gen3_data_pmic) ?
+						 ADC5_GEN3 : ADC5_GEN4;
+		data = adc->data;
 	}
 	prop->common_props.data = data;
 
@@ -596,6 +600,10 @@ static const struct of_device_id adc5_match_table[] = {
 		.compatible = "qcom,spmi-adc5-gen3",
 		.data = &adc5_gen3_data_pmic,
 	},
+	{
+		.compatible = "qcom,spmi-adc5-gen4",
+		.data = &adc5_gen4_data_pmic,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc5_match_table);

-- 
2.43.0

