Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E130F806
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690671; cv=none; b=Ndc1OAfeou4Ir1WwA30C38W85zNL8sTHKsYfQV//BkWyoAvGTyBepObCvjlo74K9Kqd5vzbKsjYnTj8VmOZX0Eu4/Kl8I583soZxWmY0BjhIoszwiU73GreMMdsQ+gUwYRXL7+AMYvy8D0ZzAtILkBxLxZhTNwSXM4AAdFn5kLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690671; c=relaxed/simple;
	bh=owGm+6Ms1s9d1BVzLgyFp+un8WuAsYAf6l9Aw77jkfw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iY0NIbB8WdoGS5C8X+M53C0fZQR8DU4yX/VnZ/+LVpFjyf1i2hhFn6Epa4davUXqgqGo6S7aJ8PT+gKPO7wUIAvIrvxxojhsM7BJcsmURwVxWsTDKHuRIrh8S1lS2144axfvA9oNMaCH39Z21H2liR2RG0/efOn8y9XzoCIpL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okBjSjsH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaJ+tAFG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okBjSjsH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaJ+tAFG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGgAYf2338782
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GxOv3DEpeFsG7lGsUZy6wV
	j3hN4O8w4tkjgP0Pww0/o=; b=okBjSjsHw5BOpXgK5ziJusqTYibbI6kIQpYBmk
	giLoWevafMpybboM+vGfOD8xMjXNy+ZJYLOlAp/kUl+r5c7wWiR9KQdGYb79jycM
	lQNyyEXf7OmwbBPmAY1I+y2lvbbfywFHr1Ab7fVNKgfozyXdCbIIKiSVRydK6EG5
	kyGJsXRxg9Yu1MB4g/QOuLeykYBO6s+qq3CwguXGfoDFzRx3bp8kTSPei/ObVaQs
	WufDZauE0fbf9DThk9H+PV2/DPmFCYv0xumXye7sKq6P+EquzGF3rwkf45D7y87c
	G5VU4h/3Cz6JoKoVgS+WacJW5ycpsfgeF42ZX5KNZfV2JPwQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vxcfyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2fded513994so12306581eec.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690667; x=1779295467; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GxOv3DEpeFsG7lGsUZy6wVj3hN4O8w4tkjgP0Pww0/o=;
        b=QaJ+tAFG4J/pTJsaDGEHOy6rpQ0+R+z6nDS0NTS/n+uBq6RmJ+19fNdttXAQ42bwEo
         yAV0wDsmq7vuIAlGmG/3hN7DOkq7bMkcjcmOQATUv9z8R7IzgfgYIA98n3fVfyfTvP30
         aBC6EZuQAfBUyClVTm+kq0VvmZ1AyFtILI30zYBgD+fO50QtXoTSbjs714J6lRve9JBX
         VKeAmAQSdsybKg1Xru5b7W8ClEswVSYkSjVYgyx8LOzkJOnE19kpjmar5/XLGBHfVGH3
         xoQsch484dlIqgU0ZyvOA6RdAOUj0HrN72WDAVYUNhc/vuUwFvSgKOeVozZjiUwep8hG
         Qrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690667; x=1779295467;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxOv3DEpeFsG7lGsUZy6wVj3hN4O8w4tkjgP0Pww0/o=;
        b=CM2NtLUlfmLojwHVmou9lsQX8olSNRKrlwvsfHS3VnTmCFr3ksdRi8jvUOWbsAJBlI
         iW9We8laRS17gArLoRRmTK0sb8NrmR8WC+x/02aMy2GTZiomxoBCCinelTYcVbgCTXDI
         LX5bywCKJEj6rmvvw6ls2cpuGbigpfrtHKOOmfoWYHog6Ct6/iIdMoKbvqO/XgwLBxyM
         0BgTzNN+btE/+GNQvRs/d0qLuOsVMmtZL6LkY5wrn2hympQ8Q13tLPd1STGLjeImdwzD
         0zzosaHeDQ+3WECmPhR4lcZh2WEVi8zA3hmfHqfPMDhvEAUlIKp268VFXtv+YnyVh0DZ
         HoJw==
X-Gm-Message-State: AOJu0Yx/QZ5co6ncEZr/nYpRKscnBR/T7BEwZUtWBqMDMSJhC2Mf/mE/
	mYetZjHbpAjLezkdsIHyUtQr6k3DcnYZCeb9CCr5hRf0jY/E8t6wuoU4nRqDTv1WYnntH8Jzr2K
	GK8OHI95Pf80vNHImShZ2jSRDNIXfrrUOujcZ8zPfoa+UZ2V4V5RVewKcIbWnvj8=
X-Gm-Gg: Acq92OFuHzy94E9/SSoecMayellSLEV5ApKApsKwQf02MTrGtJMro2TCxwiePU6Rb+U
	80NGBhQ/WW7wzD8znEzg2QoeXBwYPWPGjQ2ko6QSu+HKvDVgAmWSuLCX/e1sPCzwLMARJjd/vv6
	EcUevxWC6b15DDvPEkqoJYCCSD7sXbsjKKsOjVp8S2vzMUosExG9AltPinlAwj/52SYryTqo/ut
	gEf7EF3kwOPx8oYMdYY/MbIKIB44x9o57FisTBZ1iWVxRzbo9GLEKVx0H0T8KRtPEVohG8vZB03
	dUoN2b6A2dMpPgig8WPLzF6RR7Xaubo8rJkYMqKT3h0dYMmVbIlrG4ZIkISuEJ1MJ2QN4YH/6aw
	umXukBHK2m9afoMoNMV/0jv11uojU6q+3lKHoFhmGAY3hTH6REXrsNveJd4NWPx4BSJVw9Ms=
X-Received: by 2002:a05:7300:a504:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-30155e304dbmr1975312eec.28.1778690667514;
        Wed, 13 May 2026 09:44:27 -0700 (PDT)
X-Received: by 2002:a05:7300:a504:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-30155e304dbmr1975276eec.28.1778690666940;
        Wed, 13 May 2026 09:44:26 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:26 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Subject: [PATCH 0/5] scmi: Log client subsystem entity counts
Date: Wed, 13 May 2026 09:44:18 -0700
Message-Id: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGOqBGoC/x3MTQqAIBBA4avErBuwQvu5SrQoHWugNDQiCO+et
 PwW770QKTBFGIoXAt0c2buMqixAb7NbCdlkQy1qJaToMeqDUe9M7sIz+IVw9ytWbaNtJ42UqoH
 cnoEsP/93nFL6AFz84YxnAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690665; l=1343;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=owGm+6Ms1s9d1BVzLgyFp+un8WuAsYAf6l9Aw77jkfw=;
 b=W/Xp+gageC3TE/YpgFXFLe+pQ267y6ZmcjgpS00EQKpFmnevoEgeH6XSr277h756bxENsa6q3
 0CHZJDNRK41CRyitjcc/SiRtRARtb3XvVyWqFikd3hYiupPgngaWxsP
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-ORIG-GUID: 08igo0goFZCJ34oh7MKuRrGWvSB8fwxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfXyzpUUs8aeqY+
 hZaJPJl3i/iecIG7zsaiERdgYMHjoelTTewp2ncijpTz1qQP0Vt2MFGD//+i5C1Q5jlkGsNCBuX
 Ja3gVSHihbj9Mla5lEn6qUuztz0oCmUssQBth65/Ks+XAOvYso8+/zGCmSvsvcPbIHkMIZRp81M
 wv6okzfasyCAUn5SM0r6rz+vMgSB9GBPQzIe4iDWrh7WFzLOydpKgS1Oe27ukojpLNTqgIlACjr
 k7c1xV2igEu1A5bKNAL7M1+FISHx5kuafw3KU6wEqb0FyIn6umQXGwCZUMt4jq90K2Ri79/cUc7
 JaOKNhmDAgfYmkKlmxDd/dZtCkx5LZYEqlmuonQx8L7DehiuYi0Yj7wRqJYVULam14wGrvIaJuN
 3s+cz9Jpx+nNbAOTtx/iS4FGUpRxBovPsxqpGZPZO/SspfsnNvftp5kFc04/y1yzr/u7SRwgd48
 58SbAjVAQI6Yn7n2JLg==
X-Proofpoint-GUID: 08igo0goFZCJ34oh7MKuRrGWvSB8fwxa
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a04aa6c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0wi9YMwNQcJCIsSnl6QA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130169

SCMI client drivers do not consistently log the number of supported
entities discovered from firmware. This information is useful during
debugging because it shows which domains or resources were exposed by
firmware during probe.

Add logging of the number of supported entities to the SCMI cpufreq,
pinctrl, reset, hwmon, and powercap client drivers after a successful
probe. This aligns these drivers with the existing logging in the SCMI
power and performance domain drivers.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
Alex Tran (5):
      powercap: arm_scmi_powercap: Log number of powercap domains
      cpufreq: scmi-cpufreq: Log number of perf domains
      hwmon: scmi-hwmon: Log number of sensors
      reset: reset-scmi: Log number of reset domains
      pinctrl: pinctrl-scmi: Log number of pins, groups, functions

 drivers/cpufreq/scmi-cpufreq.c       |  5 ++++-
 drivers/hwmon/scmi-hwmon.c           |  1 +
 drivers/pinctrl/pinctrl-scmi.c       | 11 ++++++++++-
 drivers/powercap/arm_scmi_powercap.c |  1 +
 drivers/reset/reset-scmi.c           |  8 +++++++-
 5 files changed, 23 insertions(+), 3 deletions(-)
---
base-commit: 1bfaee9d3351b9b32a99766bbfb1f5baed60ddef
change-id: 20260509-scmi-client-probe-log-173cf85d5563

Best regards,
-- 
Alex Tran <alex.tran@oss.qualcomm.com>

