Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AB3BBA05
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157998; cv=none; b=SJU0E10EiBNVg6mrdgYhvI3Kh2xhUE6fDwJE6OufAWISpcT8nml+ZoiMTomzrXsi1x254hsG+m6TkvuH6n5FDU61nY0+qT3GSRImhvLiB/U12pXxoW82/YmiIs1GrGn4Z5Zl0eHwBVhOjjfS3SPpEwh8glJAy4lk/SIjRTapcx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157998; c=relaxed/simple;
	bh=EvacC9LihmYC+Bhnd8QXaJhFbVwPcP1wyH9ZW1zD+RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew8XLQpNW2fWUQdRqTQn8DhcHHInrKfH/B3/LaED1+nuXP1qE532q5Pbz7zOr0IPvU4h6e5NysYjiwCT/UEREEkKZYy7yEp+SmB+m6N0xt81/zSlK34OWt6XoLOf/tpQX9rPV1/NwRDFA5qRmWbS/7ra9Q2hGuE21K/ZK2yuP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwlY1oN9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwlY1oN9"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358bc9c50so695546466b.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157995; x=1776762795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLmOOVSobQdxpdV2CxzDrMXixIXpcrGizwFUI8g1ioo=;
        b=nwlY1oN9Tqt+LzCPmCACkGzekJKJ844VF9D7BC44LL2lwXR9sqUf1JFNO3ItU4uAto
         rxdUt1geK0VcE70XL7sVvQchcSXCJdAsMICtiKGaPaImo7vcfcg553V1Q3U90JPZDngg
         1R6GBvut0IT1J0KyCa8NyndxhuXq2Y5xA0JVizDkvT/TjmEgjmhr6DO6fu1sWDzh+zr+
         HleBggpikQkW9KfJZwuJe993myuBfuzvfgn8EinUSZzcAJi9zmJ5Pl3fw/ZxbpUXGH40
         z3Uri58MtgM38OjKkxiBAx3rRR+GHgkm/2PtuLtQIFJLHZs9eFApV9o3HVtA1wgmEZpf
         gbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157995; x=1776762795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLmOOVSobQdxpdV2CxzDrMXixIXpcrGizwFUI8g1ioo=;
        b=N4XkHdkn968R2iKEuW9MPW5CQdmZ6YaMoTqfI8SCEHOKciDf7OYBsH0I3ZViJjfnSH
         iG91ktnlYpHEH8V/3Uxq7gwp096JWJbz8DLkMCwPbanrzdIPrF5gzKH7YnWWGdfG5iAH
         laI8h07ZnyLr8GpAZ8GfRZhnX3PgjuQ1VTAKb3EX4kNfp7npprDIqyLnDlR+T/Ob2G8P
         NE/r9bXM5fnmDxD6fw+v6uTLmHyKGj8As++n4DxAwJEGe5JaAej7LTcAE8IIfYDWgmNk
         rj6/EZLN4MBYO0W8FKs+uxN5pNOwHDPssiYZRrbBlig+YQ9Ye70oTKIDKvA92Y6ly6YM
         s+Kw==
X-Forwarded-Encrypted: i=1; AFNElJ/wjeBHgJnocIvLulBfPXGCU7U5NQX8ohYyXccEPFXkLUghcSWoI3X1mBe98iLl7mbRFiQ6oXildO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUt5FsBqCoDOMsLBbP3H1ozJwkyN5QrfRCZNGhw+MRAUx9NhH
	Ver5AoiJpkFSRAQ3H8GUyQs2aiBcwBtxXQhY8IuLdCI3A8hlzRMsJRzd
X-Gm-Gg: AeBDievR0qQmPW28K1qp548a0nfWLRpM26pEI8JD3kTj28o/K7xVgc8ixZDhzCYWTBR
	IQc5b3BgGLGgOREZaXCb/KY9s+cs+cHdOmA27i664uICGsu06ZCx4ryYUJ5DY/3C98UYiTsz3SY
	aQ75uTmJYh/rnvjq6SdLri72sIUCM2m6rAOJtSgMxUeEQlv/xr0XTZONHX/+ouqBbRmJpxwYiuy
	1NbY/THJovEyQ24As4N+gHeVtnD+LB/BZ5VNDJBEmEPt9wS1NWRYAayW0lY9PNlqopln3QNhPcI
	799VkT9uWO7caypItwaUOaideeUgMoYQHaaqV/O0niGwFYAqQIuTV4jaTzSMZzSZ/CxUkkZPjgK
	rMqY/JSgvtIlogQ/iI2qSMSE7Zq946a8uXtLkxFWwGfTVeonPF/QuX8dcyDfEC9I6e4o88qEOOv
	4JTjDSjgtxMFU7pZZbhU/a3n+7GLmvqWtKDqhrGs/QX0/Q7K4up7RghcPHqYV0CI7251rEgMDm/
	eCtmpp7zgGd5P8b7WM+rz4zXaBdHm3kdPYwnmy09IZTLUDu83H+SbJtowbWSLHA6mNSSGF9Bvli
	f6TjWXDOCWklvXoCatQfMywPP6+RyyznmRnniownpyPrKkIiwncr4JBDTTK1trWPCEe5mHXInr3
	UGn1QkXqDGTVRmvfE+a1HMKD4UAZiqHzde9cRKfOy0100eI5fM35SrcCaGDx++7hmJoxq+09/oU
	dMZ9rFjek=
X-Received: by 2002:a17:906:fe05:b0:b88:6164:6421 with SMTP id a640c23a62f3a-b9d72495353mr915644666b.16.1776157994816;
        Tue, 14 Apr 2026 02:13:14 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (63.152.141.34.bc.googleusercontent.com. [34.141.152.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a44sm384466866b.52.2026.04.14.02.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:13:14 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 2/3] iio: frequency: ad9834: change sprintf() to sysfs_emit()
Date: Tue, 14 Apr 2026 09:12:49 +0000
Message-ID: <20260414091250.1295-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414091250.1295-1-joshua.crofts1@gmail.com>
References: <20260414091250.1295-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change instances of sprintf() to sysfs_emit() as returning
formatted values to user space should be done using this
function.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index eed4e08920..9499e05a73 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -290,7 +290,7 @@ ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 	else
 		str = "sine triangle";
 
-	return sprintf(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", str);
 }
 
 static IIO_DEVICE_ATTR(out_altvoltage0_out0_wavetype_available, 0444,
@@ -310,7 +310,7 @@ ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
 	else
 		str = "square";
 
-	return sprintf(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", str);
 }
 
 static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
-- 
2.47.3

