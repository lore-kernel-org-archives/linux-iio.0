Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E53A2E36
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692637; cv=none; b=EfaFxZg73vCK6ehfPO1cTNXEqqG/eMZOMaEpYHfPCfT/eigP2X3XdyP0H/tjk4mbKWgYry/ImLQ8Ofw5neLeVEL8zJMOYGlho8nE5jhHzYyVEdiXNx8Q7goCKoX0XNYvM5xzEQVYe1NUbErdORWv+l/YI4RLYpzT7AQ0mMPB5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692637; c=relaxed/simple;
	bh=IWeomyOh1Ae5xTrTn3KT0pUIoKGaJ6fwTgGzVci0FIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3WasF73AwtXTLOYaqRS2FOi6Wqx7iUcqjbQAkS0WwvOG3B9sTpPJ4p2cyMeWMVdpb/g3u9HPhn3LxPJgW68gD4/wgVqo+O+FeMpw4AJYnU8dNY0+UN09QBuaS7GHykG/w20YZDsdhAyclCrncXFrS8vt77UQM7aOdQbkJHtZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQxQq+og; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CxSTIzqY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQxQq+og";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxSTIzqY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAhqXm1393176
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZhqeTaO2TDEjcP66wfCrkDg+Koq/B3QkWrfrf2cS9lQ=; b=fQxQq+ogkG0kthGh
	83i0eWPeE8JdizI4q8NsjOSv25cMCXMfjG9C8NIJem68Z34SEDrIgMZ+AGG6OSjl
	DgFFyOYmxWP1JJDx/TXLFlXQDc58BkOsHdeIMoNnhWGkrkNz/IAS8RzCsELMMq0J
	jGoKWs6nCVaamf6Aj4YKX0puFEnbGpLmeI8cbdg9meGFixdKckeOnBm4/YRpNGjW
	3XSyf98t4OIxbgi3D1B0/8psNXix6XDNN7w7Eo3nYiKwGu1ZM0GtNB00r/KYGYOg
	NW903jrcHRD95MEMQCcBK2GoA1BKk/xtzxDFVYp4GQFp7pxOgL0xZpHlkblMopRi
	jlIS1A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k262tdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so1240588eec.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778692622; x=1779297422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhqeTaO2TDEjcP66wfCrkDg+Koq/B3QkWrfrf2cS9lQ=;
        b=CxSTIzqYAker85rLxqf/ZJJtEBkCrNVKcu1A/mojRmrK5mGJ9wcW2DW1avTQzgni+t
         J7GOX/DNsPbO+i7Vggj9Z1BShTQqNLN/UQZXq+Tr5S4MSY1XtkieDOEj5qm0BUE5+jI1
         b7mqW9lcOWk9n8N4W+o7TUxvR/Y9vyswnxREYdc+UY2wsfALW55V3tYk4ADGeZWf2STY
         +3224PI+f7+viekHt8v2xJh8xbBPa+eYA0qk/CtGm4ANCu/0r2GY9jnf22gR/Bjd4D3g
         BDWlcYrsRl8mH8kG8bmCV80wLAr5wqUda0X2KwdcIkb7kdiaK2lPFDcQUEY2o2k3PMhx
         bH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692622; x=1779297422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhqeTaO2TDEjcP66wfCrkDg+Koq/B3QkWrfrf2cS9lQ=;
        b=b92VBUJZppzfMUDOl1SmLSR2K9apWHS52+bChhJHY8JD+fn/6QlRyXmkpGjM2Dmoej
         xFQp3tKiaYV2rJfA7952u9NckpVsov2O5TGxkvLS3p+gAh1Zav8blDnOEf+HwSLTKiJA
         Zx6jI72ZH4jNrEly8wDBhDjz3N7fwpTrHk3xVU0GylW0xF9aLxLEl3Y2hCvtpy9Olj1h
         0ZDhe0jpkGimSX29TYmxUQ0dXVRPVzHlqqt4txcTbxE6Z1xGCllRb5uPmWFaGOYWCMZK
         jRgT6+C6OpiOc3RLkWtWAUlvDXu05Ns388Qm41Y1UJ4emjyxDRVtPOZ+vkddACYSOJo4
         6bQw==
X-Gm-Message-State: AOJu0YxV23ZO8MRcBo5fsB42/yYwNACaDz0UljY9CCoCzHLGwFafRqee
	4j2WenptxCesgH2X0NPqouVP/Tr+QSVGH7+AeU9kQllIGt39PbjZw/xxLRGQ96MfhIRCCg+4EOA
	WF0jeCgFYDpeFdQDwTQO8KiKmKfeIwY+RBGjIa9FCBhDj6OEIoaPKJUtYXoYTjtA=
X-Gm-Gg: Acq92OEDvAGTtG/+YfjYmw4L7Qlv3RxosM8PFFSO/AyL11J99cytN52SL+JjrMUCj16
	7M1TwYCnI3B+DtnYFIuZlURCc6A4zAGEHyYXCI27ecM9J1md73hOjTx45wJCrif4tb15P/lKvC4
	iaUfLJFA4WVxOQJkJLDg9UAvFe/V7SMh1VeTUkSPqdK7l29wdCk8ct8xZyr8zQmT/zXeFQiCOFd
	h1LXxxde7U8c+z5P7MK5nmCRTcrcZyDKkmYJ/kLP9AHHSyDZzmwsR8HEVEeI8PhlYivc9Pm5QtY
	e+X4jNtiS+9ZZ9TLlFyyQXU7HcQ8hwkrxuB8CHHHPUDshsA/4l4+6C292xeNXF41wv1/+icJ/jW
	70PGshMecSQMNCt7TccV4EZASTucRW8YJn54z14PS+pJSrjSbg+gmrEcXaE21ZbR1PptR5GI=
X-Received: by 2002:a05:7300:a146:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-3011708531cmr2740278eec.3.1778692621904;
        Wed, 13 May 2026 10:17:01 -0700 (PDT)
X-Received: by 2002:a05:7300:a146:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-3011708531cmr2740240eec.3.1778692621289;
        Wed, 13 May 2026 10:17:01 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm23075939eec.25.2026.05.13.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:17:00 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:16:54 -0700
Subject: [PATCH v2 1/5] powercap: arm_scmi_powercap: Log number of powercap
 domains
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v2-1-36607e9dd540@oss.qualcomm.com>
References: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
In-Reply-To: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778692619; l=941;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=IWeomyOh1Ae5xTrTn3KT0pUIoKGaJ6fwTgGzVci0FIE=;
 b=eYcVU7i936b/87IEJANq3Fe77/zHJ+AvzRNx5TeCA/mVoSm099367r2A/+6SswcY3A1YG+/rf
 uHQ/wReFD31CuchIdzYXXVih9AwybSWgz42qZ6LDlL0I/3GrPN1/A04
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a04b20e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Bjf1dfg4zo7KOAcPRCoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NCBTYWx0ZWRfX8LpRKV1oMtgl
 ociEMPfRrJQRyVIYGtgB11TzrIg3w3mji+WRm2Fb+kv6p1SY1UOZpC0+TYE2q18gBTpvGGabRQ8
 Cjqm4v9MQ/V1YcJ6QVW82o9jF9NaGfuB7AGEvJH8vmEjvGY+sKnL47OhOXShTNfJy3TRBvklDj8
 gIgDdkS0c3mNonTXIBgyT6KHvPqN3saT19r4puaHvXpBfHVq2Q1Fcv5SGe3mKO+X9GdjZnJ4LXP
 np3ntOMRSl5GKiH3jUKdVE6hdHvBJrsrdFY4xjTC14fEZo3CE+M/GskjVL4OwRoLz3JkRGsfNAI
 R2cD7YWvwbNLg70OP1BGRJvEoLglljdOV1wRxdnwcyR1GhP+a9PJmDSJhpBBIIujGtqunbibKFw
 DDgWv/AwwHlk7hXzsOwtQiuN9JGZalqvX+5hFABv9Am66fhgL89TObLixEcK8PV+fbzxKcPlEOY
 n+VGWcVc3Sy7aYt7dEw==
X-Proofpoint-ORIG-GUID: f4-FBGb2oBy1p9JS85Dx739eqFoqtqyg
X-Proofpoint-GUID: f4-FBGb2oBy1p9JS85Dx739eqFoqtqyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130174

The SCMI powercap driver does not currently report how many powercap
domains were discovered from firmware during probe. This makes it harder
to confirm the firmware exposed powercap resources during debugging.

Log the powercap domain count after a successful probe, aligning the
driver with the existing SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ab66e9a3b1e2..3efe3743cce0 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -496,6 +496,7 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		return ret;
 
 	dev_set_drvdata(dev, pr);
+	dev_dbg(dev, "Initialized %d powercap domains\n", pr->num_zones);
 
 	return ret;
 }

-- 
2.43.0

