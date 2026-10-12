Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B48466B58
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805612; cv=none; b=Jrj6N9Rw6tuAYuXDE2QcGdXIwbR6eTl+qmD+iONhjzlEvujqXJH95RBSgzUkVBSUmrV8c29LwzdWg5P+HzzK2zwO12pHR/wd0/0kWBs10whHY+GbYL6v8cJvfTvmQIxwXTMtS//tiBnzt4QOQM4L/TN5WNPu2GA+ZdwTKUEKdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805612; c=relaxed/simple;
	bh=PJ6jdbT1y7bX58fvx+BQKUdf++vjDv25ipv+YCgsA1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gV1olKpN3PwOH1cM+z4drUXPQVid2hJCorC0dpLB9WZO4wkZh9aM6/kbUHt3WAlfoGmS3hxd/law9i2HWfUoflD0C//XhiCZ8/68oSRY1NasrrHwKFLYOjMI7AHNK9lmxuEuuJIeKxU5p9ebSgi5uUDfPalnsRg/ONQj3T6gLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDyzY9U1; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDyzY9U1"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso4607723eec.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791805610; x=1792410410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/pFIA4JhU+T4tfga+MhmKf2vHHiyKNlOYgyfnrmVZS4=;
        b=hDyzY9U1q47drqyIBjdlUhEFQPd1QtALcCQHb2+su3zQHj/zCIqMflm4HbGP4aTQpc
         /XBovgdqSck2gbYkGOIAkpd1ytjJznyGKHsq/JHwwvLIc5ViAxJvLd+bv6e7BFNMrcvW
         DFXP1s8aJXDIAKblzlI2Pst89FnOm/r+aUMRH7GKJaD6OMX4O+asZGB2Y79W3024/4H9
         v8h5TLVw+Jor/bpy9tJuIQ3xP+sEPCNlLN9CbVYS2f/mMYgJquvUbLVLaHQF4aATNP6m
         LZ1L/OGhknfJeZorZMqkgSEnA3Z6jRR6tHDveDnN5wuach3bY9mc2pMiGt5PhPHQy0DE
         PPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805610; x=1792410410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pFIA4JhU+T4tfga+MhmKf2vHHiyKNlOYgyfnrmVZS4=;
        b=uBV5nB4bgi185hZ8K2x3urywIiRly3d7WMZ822J2m5NMxRPi/iLMrRSYCY2EL0v40l
         nygQqlfuL7eNxv1l48aZ9qkNE+hSPn4OBz4ifEcecysHbwiCPlzWteJ4qRKbeSCOk9LF
         MckMi1z8ITXBBYK3oXId+WgYJRWiOzQ2hEfzmz6p6LNBwUv5uVKwrCnlKLcO7Kv3oaLt
         A55fD3nTyVcPDAOpOhV/MvVbMktO6GUEUNPueAIeIeCSc6Ualw2d4ZQiQGi1Cjno8j8F
         2zdKjK/pJkK+5cv5HJli201vGCHW1xVLpZoiIPpb8xJ+EITeX2/fFEDMNsrwluwvDizH
         /f/Q==
X-Gm-Message-State: AFq9FYI/+Hak8DuYqZrSoxB+PX3/hRQppIyAqwuzhTnNGGuXV/mvWrRL
	8FVvI7nbBlNl4Txc5ucYrtAy01HU5ADt308EOG3YD+37Rwc4edGHTarMR2e+3uI6Kg==
X-Gm-Gg: AYBFou1xjSCQe0srrF6PRnuWiX6IXoIyjwX9jBIJCfulRQmOLzIFvLcuPUCsF55gWwN
	QcXMdKUb3xaS22Unv6GMgh+KhKYhB8f+RlzSVM4KIAsPKHFYRu8mtjjb7GOQY0LwEmE1AfFp1SD
	TsDZpHTcD5MiZ0hKtfLzbzNgmvLaYPvdTT4NfX6HRQkvc1JAEzRL1by+nDM2devsT/+gAAC3SUp
	muHlSRfIki2X2oOG+O9fNppCkbt/AQmJoaitY/lAEk/bgErzGny5f+wFjAxzhuEnWxGe/T5Xy1D
	CdfmI2ltmY4+jHPvhMnMWfnS/J1OoHiornmadlsVSiooCAuulaAj/nNfkPBnsiEx9Qnc9Nj7Mls
	FiwskkWsdrkM/aBBf4Gg9bef+qMqgH10Ji190raWWkLQRfiIMb3B614g/ShCKMtWKijxxpo1vIk
	NbnJZo26yNpJ7Rz6vuI2MXNNlU/TXxJnhz1ZKxHivOAiqiSqfL+Fc20pnz05vKgLiVcTp0sPu2P
	4mrHah+G0XfEhoQnmy+HmfN7sF7ndZSEh9KLQ==
X-Received: by 2002:a05:693c:66d2:10b0:356:9345:a07a with SMTP id 5a478bee46e88-3569345a94fmr9735696eec.24.1791805610252;
        Mon, 12 Oct 2026 04:46:50 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm37311334eec.3.2026.10.12.04.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:46:49 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH 0/1] iio: atlas-ezo: Fix humidity channel read support
Date: Mon, 12 Oct 2026 17:15:52 +0530
Message-Id: <20261012114553.3327-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atlas_ezo_read_raw() function currently rejects channels whose
type is not IIO_CONCENTRATION. As a result, the relative humidity channel
cannot access the raw or scale values, even though the driver defines support
for IIO_HUMIDITYRELATIVE.

Remove the early channel type check so that both concentration and
relative humidity channels can be handled by the existing mask-specific logic.

Nikhil Gautam (1):
  iio: atlas-ezo: Fix humidity channel read support

 drivers/iio/chemical/atlas-ezo-sensor.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.39.5

