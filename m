Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E793FD13D
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692638; cv=none; b=Qy3p5SYo9kS8KGYjf+/Oayu+jM5+r53q1twZN0SbmyU088w0xm+tNGhwlhzZXrwg5u7/6RxyaeztBwc9JCTuQHF+f1ZBwHe+3gXNkk5HatcEc2ccoGbR9biob4Icev+qjFcmcmHrl+O9EE4pGjmrw/D4l0b7f8YUivFIxaozDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692638; c=relaxed/simple;
	bh=O7ZY1AdiQuRGIWpyaBs7jFB0+sTG7KoUgEQpHyRFuKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elZTK5jOmi+gXJYCwuCi13tkbpeXdqOhm6N8/OfPchtAQJp+s5aYVsztxZLvJbv6uEIshNcwwDPQ2fLi1gmMZbcjW3iDc8OVBEsy/tnS8B4I46YF5hKadbCj3tQgcpCgVx4SMJ94h+nT4D0zM1FplGh2GUjr+lFekon57XRW2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a/Ber0gZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aTGc/y5R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/Ber0gZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aTGc/y5R"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGvrQd2321368
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mphgcl1+U0NC2VWtzWc6ce3S3u0PqqqNtDbXw6C9h80=; b=a/Ber0gZAjGFbcyA
	DcLnT3cvWA0zHeuNw4CkdOV9sEaTHQ/CC5QhPsSiBi0HD/gY+hUW42xDhJmRWHr6
	DK7/4Qt+fclHFLvyZXWSuA23qblGmuo8QNq7M0vhEkaF9NZCBHKAKdreKyf4tpep
	9YZEw+OxxdKy8jFsPUIQhmdBlueZ1UXJCZ+aL8DByt4dO3SgGrp51ypjJfQS9qiy
	iGGcIlr2wWoqGp3TnDLw/f5mpt5kgXvR76/zbPTo63RfRtrPH1v3fPErVKt07jtH
	seb8k8GGNF4ttDv15ylzVPG/Yt6I1fkP/N147zI5Wl7OIHVQL/vxs111nUqC3pv9
	Y8hhEg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgub533-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so14226706eec.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778692625; x=1779297425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mphgcl1+U0NC2VWtzWc6ce3S3u0PqqqNtDbXw6C9h80=;
        b=aTGc/y5RfbNYvSnddW4ZatQyEy/Z2ZfzC6xyzHkm9VFfOUsi6tdubGOpoICmSz06TA
         py8zTZuMdlVtwCyFF1JW9V38Gy9pd9fa0ofR8FhIYzg/Y8nHkuyVu/iAQ0B7b+0SkJac
         DrCQzUL/KX4aFUK/xF3VjdUFbh7LGEPHsEkQuKTzpaAvZOGqFpFjYkS99mG5HoMnjtSu
         dI9FVrhxQVpw5PBqJf+fwL9zSfYahLjY0K3OAKMTquEt5i9EkoS9S/KMkQ6cAhAhfYEK
         YIU+RpHZltw348Tj4jadh2RKdQ3XaWsRaelvKbt1hqIk92lOewjWfC6uvV6EQrJV7vBr
         ZPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692625; x=1779297425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mphgcl1+U0NC2VWtzWc6ce3S3u0PqqqNtDbXw6C9h80=;
        b=FYOelj7WwiRfZ4ladOuWECAIBv1fYNx6g98WW2nv8UW5Xp1GFvqL0MTk6GpKifDBlP
         +cHHh3LDgGS1y4zk2B26pWvFfQ5UvxcOkPB30M+0vnxUeIvKa4N7yHWkcQI1GX6O+IZx
         NVreGNDut8b6VRz8GaDemDBIV3X5Ip0Kto9eKI6sI2C/j582Wwi7qyCAuy6NQBhEMIj3
         FCnSJjsxnS7bt6K9MRpC9AkOq8PcQ7GVa4RtSh54e5I8DFUSNTeKoz1QdtmXvP33030D
         L0Aaze5EZP/uFeYFTZpCQLqiWtnszPVennS8anDMA13LfJtCAegapPONwG5jxFXLRaYf
         ZT+A==
X-Gm-Message-State: AOJu0YwvDayHdqg38+A+tQKJCJFyvUHC+zKJ5NSo8/ifQ0iLPhkRXNYV
	739qSC92qObX3agDceg+E3kazFrHRvRyhOqmQOd5D+gNOBzjmxIAHdNUXponJTI8nrLww+vT4JD
	1I1cmHrSGppVF+TqafUDoF1xXwKt3jxP5acyt+hc4jnIZM7BIKOGvMMRL7N9JgN0=
X-Gm-Gg: Acq92OGtLLQYwl6fH3YXw8W9ZWj7yf98QdQYdOqRKRBbI2e2HGMiDcNwYkd0iq2kpuX
	vdt9xLJllZMZF3frCxPQO5TLx3gF99TylUAKTAjL2NKzFEKDIh53vtRQ6DwUh7avCdmWIYMVmKn
	zsinERPZBSRg42F4f5Ml6NWXepLf4v28pelgCRIQ7SpnJ0sS+y5WdGNsKVjVfsSZCX8rQB9JZ8W
	gYMunin07ZWKTjk83/Ni9zAVAIpUW7h+nQQnHR0P3pA2PCqpJb95Yf46J6kKf7YkXX2x4YR2lfJ
	2DRqStv5Hc9C22jNFJ3hjQ5C+H+Ypi9ZC6bdS50cQ7czcZfPE4NLQkRrX8UkHs8E+sjZq/b8LhB
	KdQcf+FzHiylY8v9QkeJV9CYvPyybBEQyBvzq3ixiRxnDaqc/uVmMAkl8+ulZmQFIc0gWy+3gKg
	yRCY5cHw==
X-Received: by 2002:a05:7300:d706:b0:2f1:6252:f8ef with SMTP id 5a478bee46e88-30116f8cbdfmr2657875eec.1.1778692624710;
        Wed, 13 May 2026 10:17:04 -0700 (PDT)
X-Received: by 2002:a05:7300:d706:b0:2f1:6252:f8ef with SMTP id 5a478bee46e88-30116f8cbdfmr2657833eec.1.1778692624174;
        Wed, 13 May 2026 10:17:04 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm23075939eec.25.2026.05.13.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:17:03 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:16:57 -0700
Subject: [PATCH v2 4/5] reset: reset-scmi: Log number of reset domains
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v2-4-36607e9dd540@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778692619; l=1390;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=O7ZY1AdiQuRGIWpyaBs7jFB0+sTG7KoUgEQpHyRFuKM=;
 b=jxL4jV0oBZIyrWaKzHWraW6cLXO/KQj3WbcU2TE/4/0plegLFbNVGLvl0thcoqS0D2Btudgxl
 UpfJ6sQLaoJDGpSTD2IgN9J/pGAioz38x5frXs1rnPofpkMniCZtxas
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04b211 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wud5Z5ZUIjVBoUaN5zEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: q9AWMrxB6RnfrRtsZn29HPtYCTxHjRgJ
X-Proofpoint-ORIG-GUID: q9AWMrxB6RnfrRtsZn29HPtYCTxHjRgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NCBTYWx0ZWRfX3bRObq7bVPNy
 9avumhU+TlX86IDL5tz6X+dOM1P1WWFNsWTXYfGhFgq9XdDDoff5sKfpdQRx3ZhluROxZAHm1Zx
 qoD3D5gTPH7js4En4CxFkn2y+CrfwPvSyyxv2NRCEaOLIJ/hj6L59ybdna0fWkAwMMCmgZxy//z
 MEgmoBoYohKpjHP8Ams3c5QLtGp2OsvRblhbX3KjMZEGuT6XHX4j1D6Q+exwmeXKOCmF8qrW+Sn
 AOlBqm8OyMK9AgHxIvmfRT6yA1nPXEEzKRrZwzIpTlFQZURMc1p9vgbST0M5egnj82MTGKj2uZM
 ZJbitY2rcJ3B3qRrDLGG1xfi2Zn0gwhzNA2SN7ITY6QagQusyHgZpjsuzgJzT2b1dtIK+eZT4QS
 6hLG6SHt9FYUblDl1xvtgTAtD00qo2ICzjO4j14JJmCwIOA9l+0iL1SE3oehS2J/76h9cYhVafn
 Dk3m8r0EWSIUXOBY4Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130174

The SCMI reset driver does not currently report how many reset domains
were discovered from firmware during probe. This makes it harder to
confirm the firmware reset resources during debugging.

Log the reset domain count after a successful probe, aligning the driver
with the existing SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/reset/reset-scmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index 4335811e0cfa..114470c12931 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -93,6 +93,7 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_protocol_handle *ph;
+	int ret;
 
 	if (!handle)
 		return -ENODEV;
@@ -111,7 +112,12 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	data->rcdev.nr_resets = reset_ops->num_domains_get(ph);
 	data->ph = ph;
 
-	return devm_reset_controller_register(dev, &data->rcdev);
+	ret = devm_reset_controller_register(dev, &data->rcdev);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "Initialized %d reset domains\n", data->rcdev.nr_resets);
+	return 0;
 }
 
 static const struct scmi_device_id scmi_id_table[] = {

-- 
2.43.0

