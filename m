Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DC3F65FC
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789977; cv=none; b=t1UWEDIs2/opLpCFdt32VVyAw765bsRnXgN8lVAgBxbIw1s+LTIkJ+vVsejKU9NDoSoWIJodmj0I4WJhTM5/JehFJVzGn4AIhmshGp4osLC9amn6+Kg97tONWaSS0VwZwlo0DRbf5AOHl9euOz6SA/gLh5h4/VRs49DWJvXyrpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789977; c=relaxed/simple;
	bh=4dM1evO6mevasb9VEJZzj39UyIUZj0TgsTs6USorWfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFea5X8X5T/+dQo/slDbefUXPMWiWTxMf3OT2+gk3W9eG1o2UUG2nI9pCToB5y+07eALJ6RJRJz41omVM0ZYeSd00VsztJGFe5F6N+XgXPpgHk4iKPxvdp6oO3IGlD2ESSHEd5ncsGyjfDEXWgQejGowoGjrB9nrmRjwQhCEs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8pC8+TE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8pC8+TE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2addb31945aso48624655ad.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789974; x=1774394774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEDOBzod6EyW+d389//yTAK4IQGF1tCpnJcK+pS+3Aw=;
        b=Y8pC8+TEO9NMEMshqkLaHpFQAzOrQvqx5YQYfwL9gTdLH8HgYeHKpNvKqWAbvH55CP
         ykENLtC86cy73zYC/th9ADcLn5Px+rbOR3yAPkmFCtARX8plUH3+R3xZSR+5bRWLcJac
         q8xc5q0ohcW+vocRKrWrPfUqvNMnNh2+xSQ1uxOTPnqE8geko6d4RyyyfFWcJUZ6WS9i
         CVNZD5ZkI6pwb8JA8KoN1nYDnQ69HMuS6X1vO+7+9gc/0LIgtzN5FsBQxFlufEm/ZY1i
         gmH9MM6VdIsxGKFdKescAdcVJ5pl1vFic1O8w8H1luSYjaRxbunkWkyj+pYw7X7Vroyr
         MMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789974; x=1774394774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEDOBzod6EyW+d389//yTAK4IQGF1tCpnJcK+pS+3Aw=;
        b=bruCL+0klJcjtq2W2t+3LcEWOfIufIUIxu1ebT/8nCStf6ekzMZpfxcegTsYG/yPtl
         NzNer3I/MSm2nZxeDCe51ZvwIsCkXMN42k8h1zSJIr7S6Z68zxhnYluO+R32TU31JxUB
         wrhOyZ244kOsJbhmpEN04/2zty0oI4x0Ej+OnjIakxLumMIxBIA5JRiN2JwAhuCqs2tI
         9RotM6ISiqghvDtPX8wYkCaQm48WWe0UGYPxWPhEhlNf6THgdKQYawNiVMDRNqcr4v3L
         nuciQ5gtwTiXAHgjVMD/hxWgCuR/c1eEBqya7rI8ws6V4QlM1YxaKlFnh4XOow6E9JZB
         9eBA==
X-Gm-Message-State: AOJu0YzIRppLry3Jthc5nC1Y8HLddiVYtEH5qPRMBrmOY+LC5MO60CXU
	eXC2sey0rDkl8TGVCYrrHZUsB4uO2gjYJZ3bQIfccDn2wuUlNY4YnHlJJQ8BOg==
X-Gm-Gg: ATEYQzxCtk6QkLea/9I1JKL5JUjHcLueeuHbB8Rh0eJ3jnME07oVV/d7MeJEw4A8Abb
	VjJGskAbKohRsCuLLQmuQUEPV/xxsiOc9YEFhr5m7eTSm/9jHBFos7hofnD2rU/n5ngKxCYTisB
	7YMCSpKflrbX72Zw7VfjU9aUsjMT/4QSf288Lt0KZp4C3DcjSGMAwkeTOTycz1dTya8hA6FKJ2J
	2yitnzpG0f5HUTRtoKuVtg2zygTtX18W+i+PYkuAfHHZE/rvqw2PtrIQIXMYprBeRpavmUs9huI
	M9NawL2NaMktIn9VmuTpcFUp/M8TO0dnVEowApB2BJbEKqWTP/P5e0SEHRyVFPWbg+Z4fYLlPS9
	QMXuVLnKDWkWpcxG+g7Yu1Xyb8dKUhPJHbK3GiEUIGoQUSNCfmVO1sfjE26IXBBVbLw1d3rrldV
	5pG1NcB2NhpP2vIxTtxoEnpgM=
X-Received: by 2002:a17:903:1a83:b0:2b0:58a8:5f9b with SMTP id d9443c01a7336-2b06e43d446mr13526465ad.49.1773789973936;
        Tue, 17 Mar 2026 16:26:13 -0700 (PDT)
Received: from arch ([2409:40c2:5004:9b1f:c2b:f32d:d22e:ca20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e41a29dsm6582635ad.13.2026.03.17.16.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:26:13 -0700 (PDT)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH] iio: frequency: ad9523: check return value of ad9523_io_update()
Date: Wed, 18 Mar 2026 04:55:52 +0530
Message-ID: <20260317232552.28485-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions in ad9523 driver calls ad9523_io_update() to apply
register changes but fail to check its return value.

If the function fails, driver silently ignore the error and returns
success. This results in user-space assuming register changes even if
they are failed.

Fix this by properly catching and returning the error code from
ad9523_io_update() in ad9523_sync(), ad9523_write_raw(), and
ad9523_reg_access()

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
 drivers/iio/frequency/ad9523.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 63c485e9e44c..66bba37fb199 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -495,7 +495,10 @@ static int ad9523_sync(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	ad9523_io_update(indio_dev);
+	ret = ad9523_io_update(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	tmp &= ~AD9523_STATUS_SIGNALS_SYNC_MAN_CTRL;
 
 	ret = ad9523_write(indio_dev, AD9523_STATUS_SIGNALS, tmp);
@@ -716,7 +719,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto out;
 
-	ad9523_io_update(indio_dev);
+	ret = ad9523_io_update(indio_dev);
 out:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -732,7 +735,9 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
 	mutex_lock(&st->lock);
 	if (readval == NULL) {
 		ret = ad9523_write(indio_dev, reg | AD9523_R1B, writeval);
-		ad9523_io_update(indio_dev);
+		if (ret < 0)
+			goto out_unlock;
+		ret = ad9523_io_update(indio_dev);
 	} else {
 		ret = ad9523_read(indio_dev, reg | AD9523_R1B);
 		if (ret < 0)
-- 
2.53.0

