Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC074D90D7
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690676; cv=none; b=OQUIjb8gyQUHJpGWRsNTqf2wQVyXcHM2MAWJbAIPi3ZiH7/rEFmJx9+TYfbQPAZ10UFbM40tNPuIUesIM1q4pGz3dnxQb11zcKcSJVC0C5BxdAU2NV0k2eKHiSqTSzVe6jrQXq5ZTVzJ2T6ZgEDxZdYuS9DYFoX4LGIvamaO5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690676; c=relaxed/simple;
	bh=vAmyCpUIu9IUlplJc4rGmydGdjUb6w4tYNaPIxlBDiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJ8VQdm6KOaWdgKl4INq8Z6hdcb+BQpKKZW4S1zJEADQ3LBL72a5CePS4nz4FsKKhlyrAd85oKqMGgV6IFOuIbW91cAJaCshb+7OpKzI803qr3TEMGAL9MQxzBPhwcQNSDYrRxLjDxu7PCXoJU1oZHMVphcvGl0v8UyBffDVQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cf3SfnnL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ToXzwvRY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cf3SfnnL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ToXzwvRY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGAsxV2524326
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/yocMUcQeW0PxY80907g0p8nmDgbrIZycpfry1XcMUU=; b=cf3SfnnLkQ+pkgYE
	MS33afG6mXyDivAhUfoDnbMgQdWM5SSnBmh/t+YQKOk0CzSS/H/p5gqggy/bz+Ld
	kUoeG/PH+P+Eie4YA/PuNweQtcaYkDgPM0jm7xDzeEYM7+OiwaPXJH62mTGO8gBV
	HkYv3MlyhmuzTA3I4+Y9vOzgWX/YB10Y3VMfzdwYDL78aVMwcC7J/KI372xBw8a8
	kSKyv6hUieVWgbKOybaOU4o76LKGM0LUtBCFKhnR4PqdlM6igEomq6tPPCAIFHil
	f6CH3F03k4IRfc171OnKO4bJwhW4Dz05WUK7ZrOvWveSOSxSzVof79L1LLSz6o7N
	w8YjVw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjg494-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so6051115eec.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690670; x=1779295470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yocMUcQeW0PxY80907g0p8nmDgbrIZycpfry1XcMUU=;
        b=ToXzwvRY73EYoxvby89bNOhglHuAmWspKwPbnjoFHnQVXYiTUCfWsHGjAB0b//pfas
         ZPqZZF9dz60NsHH1IEJjPzxVx1HYcyxUckzWbMPToJwZELBL8lpoS1127a9y81G2bQTS
         2dvPBP+4hcGQNL9LoC/YyARtFlYHYIg+Jcv8FQYr7GIQdjHLbz4/K9ximKMvz7Sdvr+q
         aT95BE5JKt8JXTb7lC1iLDanTzDP6fzJuQsSYT8AcL3FJQ9Na5L+EoGis7RfKMPWAXil
         lWFpSwHLZCbE8yb55Hgj39+9rktZx32gOWbA1kEdu6rXAkaqE4sfD3nDXJO5Df+70HCV
         0G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690670; x=1779295470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/yocMUcQeW0PxY80907g0p8nmDgbrIZycpfry1XcMUU=;
        b=mtIOUZ7aa1N5kTuO4Y9vPgI35StEH7jrTUfBg1wLs3cANEfE1oyM2BM9SKSaSJO7+F
         9jFdKQir6ZLTBqRHxgWTUts7d2sjKpJXPwFUneH/fNhRAylvELMvWBqob8VLLythJFa9
         Epw996gfyGEOO0EQrJACXU+yUR5E0WPzVG8D5OU3YDxL32xDu9Wh2ZnETCfjQtxDxGsy
         pZXzdSG2Ins+B1LbMdSGgxiUpEKRTdu90gFOaTJRcMfUJ+ghDWselZ1ajSxRMkcgpsqo
         r8wZxKg8QCb7N05bTNY/yYlQqeh0MHcQ+Cs0YPyBid56g5GPthL2TjX+BGPN+lTtni7q
         wXsQ==
X-Gm-Message-State: AOJu0YzHyvozIGzLOO9QZhIfPyLsde6ZXSDZHBwG0I2xbcQer0Bg5nyF
	tpEpDxGJ2txcHfrawg/dUI0eSHV/XSVRSrUJ62jTCHTbJPcIi8fs+Vgiv5VjP8BtpAMlQnqONoM
	lJYy6kIU21er5I0a9JHOZmEoDBJdtTlU/S++h30lMmSp4/vjiEjpK7TzB3DQLIZ8=
X-Gm-Gg: Acq92OHE6CEToT6ENAL9949iJvcAlot2mXt8LoV7Yw0KGh/lnKjxhUDYODa2sUCgPVl
	+x4mw8H7cvgzZcDURGlu5HXXz6k4mKTeWN7i+vDLXcoQtPDk7VEqEmy/8HWfCeNtCDEC6afucGp
	hXvGWY26nlulyN6b5wDxM7r8CFMgXWI6J91KWMQjyMYknaRFNuLiGBaMmXNp0+ZSLiL++cOqwCf
	HOeum840UMJW40XbKTfJsJXasamzG9nq9078gqbwifOR3v3pDr4Dfc6uhdKDIyGj/B3wMuOof3m
	a/jO/p2rw19vTaya+yVdAeg8GDpZaIeTcjIer6OKkxriOuK0STaCvpmuS2ajmVCPaUjwY3VomuC
	ySRJLxvk2ZzN6kj8cZl3owWI8lz9VtXK0gy9/dcU3V/6haJpunLvi6VeOgm2PReZhAJXy1AE=
X-Received: by 2002:a05:7301:608a:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-30119874a96mr2588013eec.20.1778690670406;
        Wed, 13 May 2026 09:44:30 -0700 (PDT)
X-Received: by 2002:a05:7301:608a:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-30119874a96mr2587973eec.20.1778690669842;
        Wed, 13 May 2026 09:44:29 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:29 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:44:21 -0700
Subject: [PATCH 3/5] hwmon: scmi-hwmon: Log number of sensors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v1-3-00b47b1be009@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690666; l=818;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=vAmyCpUIu9IUlplJc4rGmydGdjUb6w4tYNaPIxlBDiw=;
 b=aHNXRLWpAchmivoKZfcxADgDkm5hnjgWYXKl8nVGRM6MkaZazLd056E8o8GAQELBgC4mw8qtn
 4cXbX3/bAUJB7GVGGgv4IJUzsVLQmNc0vvFg694a4U9/07cs9TUFFk2
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-GUID: -rjKIMI9nj-gnG5rrN-akY1hG_jQj5MX
X-Proofpoint-ORIG-GUID: -rjKIMI9nj-gnG5rrN-akY1hG_jQj5MX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfXw7XY8qVIxYjO
 JYf1k2yoKjhBiuJ8VgXUiKkVKdQm3KNV5z4Gi9mm+xOw6/ll6HP8f9Ql71K6u6GvsMdfBNt4Cc6
 YolKm1HgFUC6xWTZgxy9kCAUKHTRejCzHO1djvM4JgPUBzS9xodN6z7atv1LbPwYMihC3z4spsA
 xV8XgdiDc0CZSvgmV2SMTnM3zhbPusqC5XPR1yzCwrHW4TZ1QkMjiKIFj0ud8D6L1CpVhpaSMXI
 E53WXBdvHx7ttrMVg1I0SOUhfZmvGrhos2BS4cy87IoyViQLiw/VgI2pK9r9AVFJkAiQuvNZLk8
 v8Gg7R0q6K70X4kh266sqOuRjzCOg5qLXTeBmvz5R4xZSBJAmyMQtzrjuCDanCiSOK53++snlRH
 qYkquwP+4wVGbHkr/m4TyzfCfHs3EaRyGsq6snRr/3Ueha+uWewDxZrfLgOgd/ZvL1d+KVrbZ9r
 rYqzY2EadQD945fSLYw==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04aa6f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=U6dIrDiPZIM1rF_tHS4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130169

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
index eec223d174c0..6f1b0559d5c2 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -362,6 +362,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 		}
 	}
 
+	dev_info(dev, "Initialized %d sensors\n", nr_sensors);
 	return 0;
 }
 

-- 
2.43.0

