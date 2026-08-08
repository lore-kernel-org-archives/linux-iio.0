Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4535C699
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.82.102.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786157156; cv=none; b=aIbLJhnWBzcMdNHWkwOusebcP01kJj1a1B9iakt78U0QxBgwfQP14PUKY8rIL8hT/JpglEC/pwwyVFT5hGl0/ccdTZ5K9EJiEpK/RjF2kpRdbC/SjSVPje4F2V75GipLlCy9WeZDM7JULzZo+M2vnCu4JFHd7MFd0FYVm2jhXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786157156; c=relaxed/simple;
	bh=TtaLkog6I66g6v4MH+dZ40tuxTnXZ/tCxB3cXkkNyBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgN2vDwsrb7+mS8DzKwEP3/a4L8+dMvMId97baPSwh2JEZykl0CtrDczGPMjj5MNP90jXKYyxA3dXitbIMijM0bhtRuz89cQOFUYWHkgEY38EQTl1enhXqW/MDOZUE5y9IeqWEsA45y9dCo1AEB4C562q4GYBcRBPT8JvoOiLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=holtechnik.com; spf=pass smtp.mailfrom=holtechnik.com; dkim=pass (1024-bit key) header.d=holtechnik.com header.i=@holtechnik.com header.b=ue9yatzX; arc=none smtp.client-ip=35.82.102.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=holtechnik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtechnik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=holtechnik.com header.i=@holtechnik.com header.b="ue9yatzX"
Received: from localhost.localdomain (192-184-175-24.fiber.dynamic.sonic.net [192.184.175.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: phollinsky@holtechnik.com)
	by hognose1.porkbun.com (Postfix) with ESMTPSA id AABA047CEC0;
	Sat,  8 Aug 2026 02:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holtechnik.com;
	s=default; t=1786157153;
	bh=4IMInZ+M2f7yXs+SHa9tJ8pApnmxuMXar7MxhiEiLw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ue9yatzXMKoFUV3Cs4+LEGaiPHxf9nfPNjUvPcg0fcNSmrjsAIUWZkgP9duXf1Mso
	 llMesqUNA4A+Vxroh5fnylE9vJW45n6ixzXwHFeSipJvnt+7CytZDEcmTa5DKslzd0
	 SBM7edMhzfQsQ4DFgM1OhGM5tMChKITq70xBoSFc=
From: Paul Hollinsky <phollinsky@holtechnik.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] thermal: qcom-spmi-adc-tm5: fix all temperature reads failing with -EINVAL
Date: Fri,  7 Aug 2026 19:45:52 -0700
Message-ID: <20260808024552.57496-1-phollinsky@holtechnik.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260808023938.57146-1-phollinsky@holtechnik.com>
References: <20260808023938.57146-1-phollinsky@holtechnik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

adc_tm5_get_temp() rejects any iio_read_channel_processed() return value
that is not IIO_VAL_INT. Since commit bb21ee31f575 ("iio: Fix
iio_multiply_value use in iio_read_channel_processed_scale"),
iio_read_channel_processed() returns 0 on success, per its documented
contract, instead of passing through the value type from the underlying
read.

Since IIO_VAL_INT is 1, every successful read now takes the error path,
so get_temp() returns -EINVAL unconditionally and every ADC-TM5 thermal
zone is dead: with no valid temperature readings the core cannot
evaluate trip points. Observed on a SC7180 Trogdor Chromebook (Lenovo
IdeaPad Duet 3 / wormdingler), where the charger and skin-temp zones
report an error on every read.

The check no longer serves its original defensive purpose either: since
commit 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale()
precision"), fractional value types are folded into the integer result
by iio_multiply_value() inside the IIO core, so the return value carries
no information beyond success or failure. Just drop the check and rely
on the ret < 0 test above it.

qcom-spmi-adc-tm5 is the only iio_read_channel_processed() consumer in
tree still testing the return value this way.

Fixes: bb21ee31f575 ("iio: Fix iio_multiply_value use in iio_read_channel_processed_scale")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Paul Hollinsky <phollinsky@holtechnik.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index bb6222c8cc5f..af72db6299cd 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -369,9 +369,6 @@ static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (ret < 0)
 		return ret;
 
-	if (ret != IIO_VAL_INT)
-		return -EINVAL;
-
 	return 0;
 }
 
-- 
2.55.0

