Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766C23EA8A
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766053; cv=none; b=Z9f7jFjNsy6JZTmrfFdPzVvUq4aGiNlmOJRp3ZO1c0s34FUVdUE4JsTCmEhRQDPxxz7/OAL9koRNKFtYvMIRX4/CYeYj2luPBI9yvhNu9hajZN95x/q16G/KeLUCWkLz4r4RYwaT7W8hTC/76scTwO2T+7cygxckgfKZ01NKs50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766053; c=relaxed/simple;
	bh=jv5le2D5EbAVobcQl4K8mICiTBy2Y5lGGpeklsY0EIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orl2E/2qwZmAz72B9SX5oi+PLEyfX0w4omSX/i/IoCJusJkve0WhYb4gfg9IQMx/m32Ma+FSVXJffkzq+qRSQlBwfzshZ1mbfpBQRuJehTyr1ffqJr1/sV87EIsUNWP2Dkb/y6ujpXZPChkNTzKyTpALUb8poOlOQlZ/vAiFdhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSelN3ay; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSelN3ay"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba6838e76f2so305405966b.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776766049; x=1777370849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWhq7zuQ7ZD7wnMDRQ+VFtxgKDNHDIDYxhdC6tKzuNw=;
        b=SSelN3ayYBTJJ0QW4VTOejFpXLmGj8SZqg3J3PhDHiseJ+1IaMyDxnsP2IPVkaxYqB
         HpSN1UzbwK5t/j8gxGZcL1+0HxpTINXBbPCLu2UrCcrXPFgZ8umcu9khfD8v5xh7WRxj
         M95X8HT6fBrtifhqNClzbUy8HATOxDZ0bjywzBQ63zriIN0xH8bdUc9Rll0d5uLVsdxK
         xe36wE9F6vyI0miXw8nwizJteTBY94hfrZE3WEbBVbuhrN5/3Vqd3QvZS/Lv4r17MxQ0
         zIiw0yKLK9/EXHRL6ysKpI9lulXDCZ37+pivUbXs6OvAOhwkAQQCFEQX+hqY65gmURlM
         V2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776766049; x=1777370849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oWhq7zuQ7ZD7wnMDRQ+VFtxgKDNHDIDYxhdC6tKzuNw=;
        b=WuyCaSb/9fM3RxGm3ZmS+X048UeLXtO7tAt98MAH/cm9i7byqqJ4colyZY+jaLz9Lf
         Wnu0Xc656rzZmSp6Hlvc/pzZbQ149rNLsVTLpFb3uJ2CPNZ/dCK6U/JeAE02ptZwlkg8
         yk0eXDLIUKzKtPmxEVYW31g5ppZTRFVs5yFB4TJarmYp2zF1gDkpwwGt9I+CWayda86d
         vjHAt1Wl6pcRVCHiaNCmFHKbDbEPoJx+fVmGGUje6SSsR3vGfKhclrKYRnt95VUWXPSx
         IOiPxS65UnmAh+T62nqQiQ8SX4YgCcSDcb39SOa8/c5uYNRuNeJ9GEROLZcMPZWNBqNw
         YkPA==
X-Forwarded-Encrypted: i=1; AFNElJ8wP9LKLLcO7tDr1zD5En7L74PzVG1bsl9y+vGwubssPLl+Lf8a6YpHSHYJ22duFHsQY99wAgkW9VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqYqD0gsA+dSLPokM8A6u15vNHnZ65F7Jt9v/Xeag7nEQ0uf/
	r/FSsCCyeshD+USFIdQSMX8Xw1EjQxI+CgX1NBiV1lbT79v3ylur2BEl
X-Gm-Gg: AeBDievV5cHd806taxrYgK+N2MSrcy34ykfQNlt+yDuwDvxMAzvTYMycKYvRLjGZCw2
	64A7Pyu3q/UMHd7HEMfjYxvx03k+XEgvHKeOxXwmHOlEA6T16q7ZzvU1w5y4ZwqxY2woc9aBX5F
	nMe5aLFdMPY+QxMYKRKDV+WYe8I92Cy0YLFnU1CfxaenuaUYC/qvnnkWXIDx13sRhVYEPd+/rdy
	ML+mBdJ11VdWMQsT3Sz8sAWBEf/BhK+WABlfGyL8A02gsKaTnf8vm+zauCsfDDDGttlj6tj3h/d
	xWWjrTECO+I1Wm6ffug4yM2BWtkp0pLxq5A3am5pcjQAnvZFuMejBcfh71a0XBzA26G6UusmHFM
	CQ1qygIZZtq/UvWhr5D2ZmWIE6TGMOkUBGS4cZX4qnegOPcYJVcV8EI7u1ROsmDuYzeSQLEw/Tc
	9WVK6GfGyxR75PQHVBst0T5ctS7l/MPz8YYiwGdtVJQKkSy9rGTn0NDFflfn5zFMjdRDWsHeK06
	1+gulWl5XN543SDg+OAnbDKU0H6qIC/ujdlHVFPOjGQ4oW1WywXA+UcW3XPxB+Kn/5tgHChahzN
	+ycAViTT5oa6251EwJa30fOfibi3jVH6GG76xb1m3cgLn6SjM4iNGFaBP5gByc7h6Q9J2QLm9gd
	xRULtXl+/KHObzr5n+u49ZtbiqXWsVVuf3qcyxEPr5zP4VIbSf+Y/TRynFYQP+IMx0CgbsoMofZ
	NBAgsYH80=
X-Received: by 2002:a17:907:60cf:b0:ba6:be92:a595 with SMTP id a640c23a62f3a-ba6be92a79emr486075966b.37.1776766048491;
        Tue, 21 Apr 2026 03:07:28 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (238.77.147.34.bc.googleusercontent.com. [34.147.77.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4550468d6sm428078766b.52.2026.04.21.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:07:27 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 2/4] iio: magnetometer: ak8975: replace usleep_range() with fsleep()
Date: Tue, 21 Apr 2026 10:07:20 +0000
Message-ID: <20260421100722.1296-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421100722.1296-1-joshua.crofts1@gmail.com>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace usleep_range() calls with fsleep(), passing the minimum value
required by the sensor for hardware delays.

fsleep() automatically selects the optimal sleep mechanism, simplifying
driver code and time management.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index a829bee4cf8..7c37faaa4d9 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -462,7 +462,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	 * and the minimum wait time before mode setting is 100us, in
 	 * total 300us. Add some margin and say minimum 500us here.
 	 */
-	usleep_range(500, 1000);
+	fsleep(500);
+
 	return 0;
 }
 
@@ -552,7 +553,7 @@ static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
 
 	data->cntl_cache = regval;
 	/* After mode change wait at least 100us */
-	usleep_range(100, 500);
+	fsleep(100);
 
 	return 0;
 }
-- 
2.47.3

