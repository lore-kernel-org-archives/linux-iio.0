Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B0399880
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692633; cv=none; b=e1ZxSmkw+0+iBUEqTr2tkkni4QLbU3uLZXH/h0u6rb+nhvrRcNTvLDc2QQCPpTu0tDtRRfvPnc2vbgArTuk2g27r00yjufgvuX0qEjcjHpggl2twcIkHep2+UQ1A++etl/dELa0+6pDjQxvMmSdlO7ajoM4gEz02R+C/GUpCGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692633; c=relaxed/simple;
	bh=3u12ZFfeWx/fiqk59TYJupRQ0n5DvmJHNYpFAAetJB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urQbQgV05Ef/qdNwgfPWao/p5jfH181dM+Cfi453xRQ6mHY/aG5Z0wuhb4ChZ1DcYQ1lzMTFDzeNeRqsZfJncfbrjGzJQsZlKzncXEB55vqNpS4DV7hIux5JLGFgEEowcWa321TJzVcX2DwvN4Xu7hlGl4xB0emz8c95JIXPHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b0Z3rieG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fv7QtOPY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0Z3rieG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fv7QtOPY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGuI803995531
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8jMP2TqROTeV+TiFaVGks9cJcMR3oF9GuGRUSfBYhhM=; b=b0Z3rieG2EfD/BoZ
	T3kWa4Z0iSk71q8mvLzrcE/5+q6RWrATg2PHtZdT4gEXnfEpd2ifpFK/OhLkyJM1
	jKezqu4feWh5iy1I+CwZ4dftZq6yX0cRVolF5xvYpCKhe36Y673sXn3pEqbp6wLY
	IlqTG02j4opHoogiL+oLpj1BjrBhcZUTaYr3G5Z3JH2fW04iXVDSAYft+h9dZpqM
	2FtDN3qAbdComPMRGgMWKGmKTwP51dbpEBsXuy8gWuIrGkKSlYT8tcx2WY6i3EBs
	kHLoJj4/VfbweYqOPzdeaU79oGddXe24hjTHMv14niTiQFEc1oHFFQPuLWsmvK4v
	3jOxTQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4w8ur37n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 17:17:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bda35eab74so5515038eec.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778692624; x=1779297424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jMP2TqROTeV+TiFaVGks9cJcMR3oF9GuGRUSfBYhhM=;
        b=fv7QtOPYZoxiA3g9m1d1hStkFN9D5om/e2bxi0+krSblX3o9/AGlEZRuwAJw7h2oIb
         DrmK6kj/EcSIlHLJZEmD/l/o4w3s0dvgvy3Na+T6346srpIDs0rjXGM6fRR7G+lB8NCa
         BUZMnj0rtt00RjwTjIj2EJZ5qXSDD/ZeDJk/NTZSBuk9mtGHXFjlyzcnVrYRY+VbyFhL
         olvKY1/BpVvwBhD0u6UXqU5sUuw7g/3PPJ+xqFObrsa1ldl7MZBYbgA2WDusJZw605TV
         aNXAwNgchDxs5CG0lwXHCUnn97hW91bIlCBUd6gPGymAzt1PoC2yStm5wmRqQrvtFifr
         8ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692624; x=1779297424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jMP2TqROTeV+TiFaVGks9cJcMR3oF9GuGRUSfBYhhM=;
        b=F9JGZXzYeBjp04QTGrYAOPUWKZoJCFo3D9jvKU/JYH8g42M8Lok+PxV74HTdiHWE8G
         s7+bf8n/AGIFtQ+y4/FfODJdJmXf9yjS8jdLD9D85j3h34ACK/yN817FExKLjoT2mmHA
         E1QjvssVjJrq7skfxyovdYCHQTyuGd1J+bwwnt1GJIMu3qiW2vXIswUsaawkq+XR9fW/
         hdiiREPl5TdhzVsBwEO0Sc+hKsfu2tzn8v4/7LxVNCB4qSGIHLMq2paGnbT/rXVTQ1Zo
         SDlPbFX9cEkbOYDZSTPGJTwvu6YuECqc53cdU4GnNruUcqqOdsSCwCaIsL/wfy3oytZ9
         PQOQ==
X-Gm-Message-State: AOJu0Yxs7RVlDI6D6g2OHTtRX2aKuelDYTHCAShl4i1/54tkHvByknUi
	BE6maRAmfs+v6Hj7dAIY2oh0yBE16YYEBdAx3So+NbBdKXy5eHrxoWanVfQlJ2ArhYCGp7S7vQt
	FeIFgo/yBm+oX19xxAQcNJoA5pgd3lsjnol4FJUyye9+F1PmYLTT7CwAJmhhYjhQ=
X-Gm-Gg: Acq92OG2KismlZ36WXicsfCqmxPYl6P2mIdn61gnbGcmEkzcdgKlDSLNsb/B8NHn5lD
	y5FEF0spjtb5kdCXqdksTrzBQNr7DWwv1sG5UbnsNrtwfwWpYc86esKhigdeHonUoHFX5pUpjx9
	kYB3iRJZo6dUy98YsWPA5RiZ4yQY6N4HwMMkKA1xJ5AWr7Sd+ZKoeu4csaVRl+ifIZbtnWg2hr2
	TWzuetR6ypzGX88/SWTjT1UMYz/x3ChyoWy+eBQMbxtw7fgkYooICMRO9QZzZjCUj7L5jUfYLjS
	OcHZr28KhuEqXXL418CDMmgZEYcAmNfq2fFzzLDfzW8sl0TqrtAwsCoSmByVQmnBhhH8QcU0N79
	13wZ5KbA2bWhQIVe0dv5L+Rtb1s12wU+WOJU0RNj9AMV7ewg9/yUpJwJvhSsdFrK003NLhdI=
X-Received: by 2002:a05:7300:d511:b0:2f9:1004:b2cd with SMTP id 5a478bee46e88-30262f3895emr226703eec.20.1778692623974;
        Wed, 13 May 2026 10:17:03 -0700 (PDT)
X-Received: by 2002:a05:7300:d511:b0:2f9:1004:b2cd with SMTP id 5a478bee46e88-30262f3895emr226653eec.20.1778692623279;
        Wed, 13 May 2026 10:17:03 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm23075939eec.25.2026.05.13.10.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:17:02 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:16:56 -0700
Subject: [PATCH v2 3/5] hwmon: scmi-hwmon: Log number of sensors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v2-3-36607e9dd540@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778692619; l=817;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=3u12ZFfeWx/fiqk59TYJupRQ0n5DvmJHNYpFAAetJB8=;
 b=drMsL9zyJtm9O0u5u71mfEb7eSjVSIhSmM0g7YOeZ35sVG8AknsYYy0u0vN6Wrm6jfxOHGdtg
 gHPXVlMeN7JCUSGfnbjCErOB7V68Chpm7qkXicucNIo/rWqXvEyxQR9
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Authority-Analysis: v=2.4 cv=WP1PmHsR c=1 sm=1 tr=0 ts=6a04b210 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=U6dIrDiPZIM1rF_tHS4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Ge1t6zZmnLN2JU06OeyAGqS5XvF0Qemc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NCBTYWx0ZWRfX3EcVXVIHGZbs
 Db7hzJQxZIGQWDzvJn0uKSaiBRtnioiKv9P0VKMVYpUDc51DvjEg2zbqTmYivj/T5NVmjckmhmR
 aN83CDmdOE5qrCA3Lgc1H0Fx7Sph7ExzTkqztV1fY+wTsRxQm359KXX6ng28XmpI4fUG0QDJNGb
 Zcg0arOaHXgpqzfk1oULbVGGsNiOntr5xA8wIgLuWPJD0COvkupbc7lCpwKMXXjKPXlt8gP7UNO
 llha3i11TewH+5nBVGR+AwVkQU5WBMETXr66AY2vu9ehT7Y+Bm8YSX/bE9Y+6jiGQPwm/evxqbf
 DIYd45yW93u/lJn4KikY1S2LCWe+rZYLoI+bi/qpq+Euo6/zhvvkpZ+ROevGRdG4sPJW/m+gyFd
 g4Dlq4MmxF3+H/aXNc7bDjLUPOsoiOJlfPaoYD0rUSJXSgb0Cc7oEjed4HsnSqDRo9tFLRKfSiE
 BVE+OGjb5d1I+jlJbZg==
X-Proofpoint-ORIG-GUID: Ge1t6zZmnLN2JU06OeyAGqS5XvF0Qemc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130174

The SCMI hwmon driver does not currently report how many sensors were
discovered from firmware during probe. This makes it harder to confirm
the firmware exposed sensor resources during debugging.

Log the sensor count after a successful probe, aligning the driver with
the existing SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/hwmon/scmi-hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index eec223d174c0..456ce11d050c 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -362,6 +362,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 		}
 	}
 
+	dev_dbg(dev, "Initialized %d sensors\n", nr_sensors);
 	return 0;
 }
 

-- 
2.43.0

