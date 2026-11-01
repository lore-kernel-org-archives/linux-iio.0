Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502559;
	b=Br7E4lStmJ69iH0+VznnoRO0cZwePHo7on5lpyLuOD5JtJ1FRIQRvva+DSkuZ0PeUHaT
	 qGxvCtw8xLv6KIPC9oUevEgRnV0N7eEME2TfLa9LA/yKKzTMpJxSCdRlVF2qnKNX5LKMZ
	 HkUYaw8vclAdv6nQEDoHemoklhNzFEH/PzHKEEKFfbD9ja3w3WzUe/0Mo6jGe1FuIfifH
	 NDUlsq8qyC0pfS2XkFn2h557u9HehJO2mrwjf2bH9ruXv4yGEgY+jihYIKpxQAKDt+Cfy
	 LyI+L6+udu2qQj0yH5/gskXK4gnqb/n59S5tmYXB/DGQems8lm2gLMuWYkEEZX1VJQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502559;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=q0jHwfNVFh3slirz73VjZLLnlDGT14N7xEqd/JdTqoo=;
	b=ljb3/iICkCav+Xx2nrRnhMhmx6MwPkpoovnSMQ+IQxT7HGb8AFh26aX8kvC7hW+N8fvh
	 I9CarQph0FEckR1DARQXOqHuqUwfOxWsCFDqjoBUh3CtGnG9cg2Ti4JThYkFWrVWlDzBP
	 fBAjrfXDfGGHgDBVr7I2mqgKl04YryZimiKePDEgZyweMxQbK1bVYTEYSELkCNCvVNc4l
	 6jCw7VecAdfGPakrtbc3p3D9X4LIL5hf3j7i4gy2/bY/nsqbl/z3CZBixP1/m3ALSP4yw
	 TOiDgKZRo4h3ig3Ysqs3+vTFBnSoNUx2lkhmu+M7CFtAxP/RPcquqgpGkDYgXHRRpDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bMJ+yuQZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eHyN7F7Y;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CE606A324
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 03:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B67CE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bMJ+yuQZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eHyN7F7Y
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1203O13740304
	for <linux-iio@vger.kernel.org>; Sun, 1 Nov 2026 03:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=q0jHwfNVFh3slirz73VjZLLnlDGT14N7xEq
	d/JdTqoo=; b=bMJ+yuQZI5dzc6xhVfHgqnI14aoiI6XgEhbaq+L8j2t4GdDRL+B
	ML6Xn/sBpBUTrzvgdxpGAyNRTVebyIR3DqnUo/lAXqxAdy9HWnjgvN36BeLXMixf
	S7JaMSkK2pSuw1vtR/hx6vUq5n3F+Q58NSGUcJkKyPWht04GmDxc6k/1UUromGq6
	+FuRTLnPq3M9vlpZF0UMU0u2YkVuMmid95yfTDOwe3P8phjESIjOj62h1i8GaODS
	42Kn3mLOKe1yMS00SZTtptSoWl1PaZxANCOs1R8Pg+OFhPM5fBOI3xq+egRTY9rK
	Tvy3RA8lM5mw54fbCUkKe9NKRa4axxjbNFg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8j2tjfb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 03:09:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so3144313c88.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793502557; x=1794107357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q0jHwfNVFh3slirz73VjZLLnlDGT14N7xEqd/JdTqoo=;
        b=eHyN7F7YKbQjVlgXeV88ThJT9gM3h6I8CIjDWvkBQsC6zCszOaw1FPi77L136beH8C
         X+kNPsXmLDNoo0gEeK2ZanxJoRWXu7R9h3JlOpt4gWHAW7LKnH2hW/OY+s2m1QUHTTfT
         9pmBOrp4r6veyAJn6WUGqi3sLJkK/ejd8UifHBIkS0a6rVJGI7nLno44V7qFLM1LXbqF
         z62qtKzag21KkPi84BLiiY77hmUfp5i5pjLpqKYw3o6h4dnWNQXfrotdtEHbuBvsHP/m
         mymrmhdEi8tHJZlqx1YyiJRXHNDlJK9s3qXOVsTnJrmcF1oIiK5NaI9JsWWphM0nLO5D
         FaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502557; x=1794107357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0jHwfNVFh3slirz73VjZLLnlDGT14N7xEqd/JdTqoo=;
        b=SO1EyoaaMlvwt4/zGexZ7vxBYD+ZI6unLyZ+K7XwarlBzUOT9Sy2Mpwn6rGb+r4aQx
         8XvO2WnoL2BQ3jTP5ROloAoFnN6y5LFdot8MIqto+Epi5dpntkXS2nrqk4VXLHXALrGG
         m9Ix/Ezqtwau1aG7UoHgc/70YOld7aEK+lM1xJSA5fjMYIgrj475Dj9+eDOYSYs2qeG4
         4HMpWCJmIpH5Syuel/nRJ9JjkS7Tt2tC9S0YWSs07JeNwCtSjYxuUWzVEtsjq0rTAeUa
         vtfOFK7WTHkN1uO2ndeZPvkEE75vlao+Z/UPl14LjbWw8PTt0OWszc4jgVg7OTmuFJIO
         rdqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkfuxGUxi+P5Ko4Ki55gU3u+syx/QE2tOpuJFwoKvURRHfIedG92m5IRz3Da/Ob5J+PPBl9PcvLu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAxiVbJkYq1XciLCTZ+lliG1YJFL2PI/nLgiESumQ9QuW78Y1T
	XIcQmk0LaoIudMSh1gkEvWxxKSUyZQS2mLN2K1xV5Ls/JqcDGRQdUHkzZMFIdMnR/oxRtMqaD9G
	FAgLpfptLOFyAIgSIVEFa0ecFCaCXkhzdN3lBNHfAzm9iIIAD05zRhwfc4TgnlTY=
X-Gm-Gg: AYBFou0wlU20SsZ51MIMNk58xunzyUzOZlrIdPN9nYuaD1J+05hcqvCnuxA4b5SWFIn
	Ym5z3BW1n11FUxYoX6lzE66t8uuRSDLRw56GD/krC8gh6QFEa/tB0L7aMjhAyBzfoxwv+kYfzI2
	rfsKJHaLH+KntVJs8KfhLpbwVK4X7VRyfMRgPg4SkqWdqupaV9qWIBC4h99ubx8MWQXJ/SCpQUt
	xctRHTukmJKlj6+OV5C1bQA8mcSC1P4acDLolQ6oLwEycXB4MCOs9Jsra/qBDpOO9S4Mf5a5Jhp
	BWXnOOqdIjS4zcsQnych7cE7b94+1uVPi2Hn0Lf8cNp+l4UvggEwv9P/8LxEvs0t8D7dNi9yjhq
	Qv0NAbeQEh1Epb9FYfFtci/Z/9RIDbflhBqIO9cXKLuPsICgZUYZtuFf1TDAYJTH9no3szmeacI
	E3UeEMfVD34urgAq8YvgRESqZ5Hosa0ZVs
X-Received: by 2002:a05:701b:2702:b0:186:3f0c:bd09 with SMTP id a92af1059eb24-1ac55777071mr9201360c88.5.1793502557255;
        Sat, 31 Oct 2026 20:09:17 -0700 (PDT)
X-Received: by 2002:a05:701b:2702:b0:186:3f0c:bd09 with SMTP id a92af1059eb24-1ac55777071mr9201318c88.5.1793502556399;
        Sat, 31 Oct 2026 20:09:16 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a9e2ed3sm19577174c88.19.2026.10.31.20.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:09:15 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Reuse IIO device ID for ADC_TM aux device
Date: Sun,  1 Nov 2026 11:09:02 +0800
Message-ID: <20261101030902.1387122-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-GUID: ghGOiz1kl3FDwmuQIvBAA9siaiACWq_j
X-Proofpoint-ORIG-GUID: ghGOiz1kl3FDwmuQIvBAA9siaiACWq_j
X-Authority-Analysis: v=2.4 cv=S5RMU4sP c=1 sm=1 tr=0 ts=6ae6ad5d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RKMC9uL6Q2GlzZAgUaEA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAxMiBTYWx0ZWRfX7/W6Ff6esP2M
 0EPa8xGJvT2L1AaACSMirLS7OmvGJpQP6DLe9JHJm8WI3MSRZqUtm1pAWM0YS+jw9C3h+Juur3D
 +BumZw5maR7outUoeDlVJUdnyLrZg8I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAxMiBTYWx0ZWRfX/R2dpR3cMtvk
 anAL8QPOnU4IO8urvQeCl5WJsYtiz+dsfP7fWQpFPwuKOUbM6j1qA+iBb7Kj6Z65fucjJxeNwBo
 x0ok3H0yhOomNtM/Z6pcGpY8MPLN/UiaYedxlisczZY13VLyC/p9/YzvDAGbq2Kw3RHsSHFtqoX
 /UJ3M/cXBOVoS/mY6pPBQkNzpVQZpCh4o59bxgnjKPlJxBOVx78PfdDci88Z7SqdnXXIk31Y5PM
 tZFQXFkfL9WnIQ7uVyro/sy0688cKYPizm9VrJk23i3dznZoOKlupNIMEgNawxWMd3gKm1K1Kui
 d7/scwcKUSsv2/fdLySHAQsi9EJmLDXg6stpOJNiaAFVxqRu1UcqEYMcO85DkQUpo6Ect5zi2Vr
 +uRfcfNgGk8/x+YNuqcaI9UiQgBQUv43SWK/NhJEnZC/gZrNo1lUGvm4Whe0AfCoK9fqkIact8y
 luGD2OqieE8IQ5LeMNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010012

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
to register the same device name. With ADC_TM channels on more than
one PMIC, the second instance to probe fails:

  sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_spmi_adc5_gen3.adc5_tm_gen3.0'
  ...
  auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device failed!: -17
  qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Failed to add auxiliary TM device

The ADC probe then fails as a whole, so that PMIC loses both its IIO
channels and its thermal zones. This shows up on Nord, which has
thermistor channels on two PMAU0102 PMICs.

Each ADC instance already has a unique IIO device ID. Use it as the
auxiliary device id instead of allocating one from a separate driver-wide
IDA, which removes the custom ID allocation and release handling. The
ADC_TM driver matches on the device name only, so the instance number
does not affect binding.

Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
This is the squashed version as requsted by Jonathan at:
https://lore.kernel.org/all/20261101020047.66034613@jic23-hlaptop/

 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c68c6c5f6aca..a23eb5c9096d 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -610,7 +610,7 @@ static void adc5_gen3_delete_aux(void *data)
 
 static void adc5_gen3_aux_device_release(struct device *dev) {}
 
-static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
+static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 {
 	struct tm5_aux_dev_wrapper *aux_device;
 	int i, ret, i_tm = 0;
@@ -620,6 +620,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 		return -ENOMEM;
 
 	aux_device->aux_dev.name = "adc5_tm_gen3";
+	aux_device->aux_dev.id = id;
 	aux_device->aux_dev.dev.parent = adc->dev;
 	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
 
@@ -799,7 +800,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 		return ret;
 
 	if (adc->n_tm_channels > 0) {
-		ret = adc5_gen3_add_aux_tm_device(adc);
+		ret = adc5_gen3_add_aux_tm_device(adc, iio_device_id(indio_dev));
 		if (ret)
 			dev_err_probe(dev, ret,
 				      "Failed to add auxiliary TM device\n");
-- 
2.43.0

