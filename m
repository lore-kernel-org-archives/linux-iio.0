Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4E387373
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877024; cv=none; b=KgsqY7jiUqn4+BWMCfplUI16q9WoQmciYsdZeJqbYrMR3Ogur4i9AD9RIJ7oGSdNYfQkj/eMg/Er63WHzcvfphgaRsPVLiafMDbZmMJhbES3IkstzTOUXpp6GhXKH39IcFEQUOXdeGb3hqJ/ODsd3HIwCuM/Jy3GOQtMcHGXt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877024; c=relaxed/simple;
	bh=OOT211Qg5Ti/MMGkmp30LRLc49w8nKu+eUOAg3LHjQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGQMrUVpJmG7vIAZSb+aAInvHnuLYZtSh2NtBdjImKN3uih/wPyezU/o2rGVd8gNlu0gUFUofn6Gw967Mn9ObNvYpSkTjDbomN8/YbH3whWIhGWjHFNKMZvIhhdB/G5qE/c2MkC1qY1S8s9KhPZgOZv2B8Io2+XnSp/MtbdRzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esgEjj1/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esgEjj1/"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76b9efc299so2299919a12.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877022; x=1777481822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riaMk8etyq0rzfYVnIkS4yGsS6/2CNoO7Rh/WBiTOh0=;
        b=esgEjj1/sphdPN6y2Q/ZD5qfPd9ywxli8mMYH1Q2D8mVSkfWcVArLquiOLyvmaL1vN
         oSR8fFsS5VYIOIJ2wt6zfDCWN/VG5JDLhk7o3vHVwLfP0/6qgrqbn4pBuzzzHUL3jOw2
         3QZOWU+8o8EmvyHvQ5f7bEgUY3XI5RfGnJmPhDpLNRfog9DYL+2droTT5A6RmMHMjztr
         f0s153tnWFxGpteO2EBbkGy5Hujy+NRV0cYgv49XJJGIUZYwQbbT2rO4ONQI2tYpYUPo
         4mm2uLUKdElqcW0nQm3Kn/iryQ8CfhAcc+UIA1irRmQs6dQ5XK1ESOvSKL/V4xftER3m
         jPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877022; x=1777481822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=riaMk8etyq0rzfYVnIkS4yGsS6/2CNoO7Rh/WBiTOh0=;
        b=Ljv5GFzT6wVNHi+iTxH6vS5s3IGBtaE4szJoi0U5UUZwWSI4U9faz/OnT3VmSp/oAz
         SPPrm5L2RDqeyG1WAQh3JuWz40EAGQGGOPfwS2iDLxzYuWtt04ZE625XOLhZFmz63f+g
         Ke+lRoVeih7ETmyMw9FrvMVB0em2yiMNEl3UtJaNKpJySSQJKmNgLAb554BwYMU9m+Wj
         qSDj3IrqrQEWrHlEuqYTbfSFEJyq0kpGJYYhjUkDT+bFykRf0/tHi6/8gQIbtiPmH5d3
         mWk4RVyhb5he/zyNEq9nPp+21V9ezeqJrO/e23hpVg3Cr7rPDSPoOhPy6Jv27Ww9qMyi
         HL6A==
X-Forwarded-Encrypted: i=1; AFNElJ9mS2vYPhrVr6kNrCUxv2oEpUhvjDhmHnCQBS3L35mOzPmfD4XvM9omoF2sA5SOzxCiRAdwp6tjFWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXVGUtGrhG6F/HM/fkcIASWZf+tMtiSMtLMIB+JSkzbrLlADe
	evhonfZkOazvvmk8e++uD5Tds5Ve8mual9AG9N4JTXCfY/uLHtXW99+k
X-Gm-Gg: AeBDievNCV1ejKmF1c4utWw+260OuKmDIYtjBjBmEfoz6pFDA9yI8BPv6rdCJh/ZTvH
	+vADMreL81BuFdURr6/0XFFMPFLU5aqmsmgK6k79anyeqyT++EYBNNWhQ0KjFSmIc6h2DomAcUv
	e/WXIsLkEd9JlXeUuyQ4YgzTV2eAnWatc8KJvl22+XoPRrxc4+rgHlux9YLispf3Ls8jIxTYU7E
	Kw3XtFObPTh1XuVGhCa7/dlVD1qJN/KH6EhATy7GlBpiH4UEr9nVIMTLh6pzof6aN877LjTicr0
	ImgepLNtiyl7o+Z8g49B/Bu0RcwUtwe5C4Q5md7YOB+oozlxmfCRcccYT0LmQy9zfKx3uJmS5ag
	M32Rj5E5mEFHZnV+r32PmGEizfPNsdILoAVwDaq/MKrhVwK0lRt6kw3zhh5Ggwlh/Z0b8+NMCio
	FUSDat4mUgLpxFulqD1+A2+w15x4I6lU+5T4P752sutL+GPVHKOgYytBK6Z1E=
X-Received: by 2002:a05:6a20:3d85:b0:39b:989e:6d39 with SMTP id adf61e73a8af0-3a08d8a947dmr28481466637.35.1776877022097;
        Wed, 22 Apr 2026 09:57:02 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm11908675a12.14.2026.04.22.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:57:01 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] iio: accel: mma8452: Use dev_err_probe()
Date: Wed, 22 Apr 2026 22:26:41 +0530
Message-Id: <20260422165643.2148195-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422165643.2148195-1-sanjayembedded@gmail.com>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

dev_err_probe() makes error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 99f7763b84ac..d1ae2bf37409 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1563,8 +1563,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(dev, -ENODEV,
-				     "unknown device model\n");
+		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
@@ -1581,14 +1580,12 @@ static int mma8452_probe(struct i2c_client *client)
 				     "failed to get VDDIO regulator!\n");
 
 	ret = regulator_enable(data->vdd_reg);
-	if (ret) {
-		dev_err(dev, "failed to enable VDD regulator!\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable VDD regulator!\n");
 
 	ret = regulator_enable(data->vddio_reg);
 	if (ret) {
-		dev_err(dev, "failed to enable VDDIO regulator!\n");
+		dev_err_probe(dev, ret, "failed to enable VDDIO regulator!\n");
 		goto disable_regulator_vdd;
 	}
 
-- 
2.34.1

