Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D798429831
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690676; cv=none; b=hIk4qViN53ahMkw0ir3SaHR0abhw0iXCCIAhmTIErejfniXNQlZO/w9xVv3Nac2IuhLNd1mKBD6UblzezO5adWR3irs7cQMZQA4DKkjk+1nx62MWvp43GdRT3H5tqn8F5rEjR/nMy3NvM2MsNZyv1HByGZfbcXgguEJd07of5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690676; c=relaxed/simple;
	bh=kkkJUN2duKjg2tEPhVJygQCN5sNnHuJItWMYlqkT/wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2j7HPCxvIgqDiQsb+Zcdqy0dWbZHu/DMbzD13za1VHFcsoVwJJyDnxf1f6Ic9NMhS8At8St2eEOUpvHAd2BYBqcJdZLH0TTTx0YBceXVgMtogW3z0nsDoWppJY8FjYnC/ElJI1yo0pZRXooe2xR7u0hsut4PXaf4emZ+xmh1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lt1bVYRo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cZplFx2H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lt1bVYRo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cZplFx2H"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGXvh02321468
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6NGzEn4QHnOns3GVJPYdbSr45vl6CTrSg1yOeRmRags=; b=Lt1bVYRowP5qG43u
	feMZAugbkgbmaoauVWkYsoFwKUZc1ImdfR4eUSXuqzHTyyu/EfSO07EM+TgdnuNq
	eh//W5u9d9zIpGlcl89COws7rP5oCQIOpMvfV9W7xZ40al8bZE+4CHHqbWci1mJ4
	vvOgXrsNeI3wdPxsly0eDGDa5BAk5m3rgwJwQ56q3/3RZDeZSFnG6K1Ek7Hhth1O
	WfPURlDIy9MwSQNijroZCoQQsIn6o8fD5mHkRI5imwNG6nVclDfeH7uMGHE7PIfq
	P14RBWkDbTz8v86ehMAl0ecGaB8VtqZCD0lY4w6Mmu76EG6yMy7yQeZlVjghSVJz
	TenaQQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgub0yd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:32 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1329791f18fso10247117c88.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690672; x=1779295472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NGzEn4QHnOns3GVJPYdbSr45vl6CTrSg1yOeRmRags=;
        b=cZplFx2HtgMVOWhPPae2oTW1f/JW/YUEDXnp2u4TG5GzbZx6srhVLtP8m85FGvPVq+
         jD8QOBkueL+LcluJ3Wy6AgzsJVhasA70MOd84IPNepcMyVbZRK9Pr541LnPNrpvzr9ZS
         MRFQtQ11G/q/MaYAxyrqlCAOXREp8cih9yHXQoqA1Rt8ZwE+dnlTTxlz/D3n4+D3TZKM
         f0ja668rxbPp3MCWmkVr+vjUcxUzfwjst5o9vHcNjXDMCCRnUicXd05w1El1CFndXU6e
         LPsAsc1fuTNJXUYCf79ERFoF+GY6StJ+hiHyYS93jhMycbAhScJuVn9vy4XYCdG2TV1F
         yYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690672; x=1779295472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6NGzEn4QHnOns3GVJPYdbSr45vl6CTrSg1yOeRmRags=;
        b=hKOB+O8+aZ4jc57yE/TcivwBgffEcJy/kcT/AdUjXJwn5JJIl3R+nt/mh2PGhmHrN+
         GlHjRpRoE3OXdjbGIGk0NwOlVe4wjjllmZUFW2JVaeDSfXW85MgQu5rnYN/vzhesklLY
         tnKQFZqrpZ8tX4aCvO6cOsOVvCj4qzQtYWxhKsakD3AFAWPRg/mcNucuzDWag02ewbNt
         NhBS+RyXQRLSqp7An6CEWhr5jGOLvyde10CBrofaYwSvDO+pQQBlRCv2KxuMcSpaPxnN
         zAjhcdJ3lEa1d9TA2uksHA93MbWak4LiQO2pXRRMSbXFFGT4wpW3UsszRUjjm5iPDO5Z
         BzdQ==
X-Gm-Message-State: AOJu0YwkXuG/DZ/c45QHbokfl5wKpkWB8+6F5Zw5ML8O/VBhUDgMox0d
	agpAOqBYJCsIUBskZ6cNKk8tOq+KizK/JfgUrslRLnhoRwJYIGvhp3ViN0B6reuSgqLdg7gfv81
	qxuVn3yQngy0sM+qp5zgx3C27Z7qLUOvOaBgvz1uxt+gj7LmxFJodWA70kJD3W6U=
X-Gm-Gg: Acq92OEfAlgs5SNXAd1qFEcbdP8nZjQX89fWANagTNKwCDWuiF5DutzK+NMvpnfYexk
	dyt3XM6t/UPL/w+3INGPCldEVN9nKBWl8qBozq1TUg5T9TYzT9Xkh3f3p9lrDAXGnvypAtzLsk7
	lGFjrm59numbrUJ5K++6iC2w0b3e1tqaLI4+MWQEZdy0o4+pyfiJKygRGIW6ihmfqe6vhK6yHew
	XQ8ld6+7DHUjSphOC5yV/6H2jXXXtfe+MsCt1AsVD4x5N1RG2/q4vYxSXCUjn9Fhsavscwj/I9l
	p6TFVX1qetBhKl1VvUbUSyEz68cpwf7jhgRgW/MQcd2pb9mnMMBjo/ufatZZXbf+RBNw4vajqbD
	H1/dswdFMzKf0Z/lpu/6l/iZRid2rhTpiaZ6ToHtSHNxlY1R0zWKoeo5HisEv3VFFcBMlA/U=
X-Received: by 2002:a05:7022:ec88:b0:132:956b:3c6 with SMTP id a92af1059eb24-1349ad870cemr2111975c88.33.1778690671487;
        Wed, 13 May 2026 09:44:31 -0700 (PDT)
X-Received: by 2002:a05:7022:ec88:b0:132:956b:3c6 with SMTP id a92af1059eb24-1349ad870cemr2111944c88.33.1778690670855;
        Wed, 13 May 2026 09:44:30 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:30 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:44:22 -0700
Subject: [PATCH 4/5] reset: reset-scmi: Log number of reset domains
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v1-4-00b47b1be009@oss.qualcomm.com>
References: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
In-Reply-To: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690666; l=1391;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=kkkJUN2duKjg2tEPhVJygQCN5sNnHuJItWMYlqkT/wc=;
 b=+zDDnh3MxrImSIBbNC9dHdn17TxKkBrO3UxSfoKVDiRqAoPHX67PJnTILBR8G6xc1OVPmBa9v
 QzLeLBss5/3DRkX2f8GlrLsX4oJLNM+GlL2wId5D0DyBXYzzWOZZr6I
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04aa70 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wud5Z5ZUIjVBoUaN5zEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: fEA-2Sh9m-E38xRvbWERswvjI0RcriW_
X-Proofpoint-ORIG-GUID: fEA-2Sh9m-E38xRvbWERswvjI0RcriW_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfX7oVjgT79J/w1
 bXgtiYYjRfane6zvCg3TzOnQfpL47dikJVnnni9YJlgs/+7ntqNLrbeRxJVWH6FBZtIEPdRs0I+
 JYVje2i1Hl3o4+aDmMyaYFi8yRsn6b7jTx0dLF4kY5nOGyf+ctrbyhLHG8JGbegSmicBjJlT9HK
 97+srTxWzSLwqkGzqhcQS5ekGCmbHl+FsgzqFuIWR6WZtm5YVVhER6K3v5OQ+bdGMK5HChYuxzM
 8LIjHleXLA7Idb9qkvONumK9EMpdkZ3Uqkc+8duTt74fxlYnn8/LBlLKRt8QbOhQvyeQ9mMGSNs
 mJJi140l/AZN1Tx06qngXBPKNuCSPkIoWdgMujQtryMSqJB6KPfRC3zsmbJ/6/sUMgEZ31KAbXq
 oVK9GC26HssOJo94j6BplOjln2sJI7R+Ierfa+Tuotdw8i3Eg50EYnUf+6ZhdE6IrBSvrQd5I5i
 FJsU4UOg2HSUvLuKl3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130169

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
index 4335811e0cfa..f26fad0dc726 100644
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
+	dev_info(dev, "Initialized %d reset domains\n", data->rcdev.nr_resets);
+	return 0;
 }
 
 static const struct scmi_device_id scmi_id_table[] = {

-- 
2.43.0

