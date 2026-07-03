Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA12F532C
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099415; cv=none; b=IDnoZ2yhb+v2Z+WsPvii+qOcOBVZ8xH9/XoMpG8cX6HqgUB/Rt9Kox9HCyT7J+06sf1eafCxSwgEF4eM1opgWzZJrTGN1TMwl0sMG5Mlp90mYB0yZTbDDuADbC37VzhPMdTc/eirwntICRb+d140k2Xc53kk49ZBL5SvjC/3bbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099415; c=relaxed/simple;
	bh=xmKlrc7d1HKMVV88bng+H4A1GhSTzkA1lPEahMkJSdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CbVUP08AxSPlZWBwIn+rCbRB8ijW6f+jjTuY6/XZDZhG009W40VRHapnYbLpprfFdnbQx+e4UFxg+IqmlOfrJicG/tX28kmWQaitmqpszjMWUHWPUYMY3VdIvQmj6RVcAWquu2pl/TgFmtLOsJE80I9D6Vk7gPPwurynZAJyisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqUylmdo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqUylmdo"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847a5528b33so387897b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783099414; x=1783704214; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7jGWPqmaXNVBnCqPFIOavEqxkjqjQO61YLrLNd1b9aA=;
        b=ZqUylmdoODQL58EsANQ0vW0+FyxnZVckLX/v7JUFzTGUchClltkXEYTNVHhbshu/zi
         cM3OIJLCTeBpe4+7xZBxuXkU2T7xnmlqlMnrLLxrGP0srH0Ln4CZ4FAS8PqI+aFiMPz3
         zGtDOTTjHV/qGqI3+wWZF5B/WBFQEd2QjBy1UmrpQw4yOpJvMFl5uYrMs/2ujmLiet7N
         WRq2ha8fxh5RyvQBX1rsEuz+PDU8VrLkLbmREebi78cAtvZLw5b8ECijiiS+ecQ7uvA+
         DIUGG16sChfT8SNeejFdq0995ZfUo01WxCfGF2uDKRqbd1aIjDwHfogxeaLftyXkS0jW
         NGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099414; x=1783704214;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7jGWPqmaXNVBnCqPFIOavEqxkjqjQO61YLrLNd1b9aA=;
        b=NPGnJFHkHU+fX+daHzmoDtjH2ax3du79rfG7ZOx4hAbGQo5zEXeZEq5Xj80uAr7wwm
         uWkMXmSIzpV53wVmlMjg8eNgiiLUfKBeyWK62b4CB7CXp+U4ur5EgNA/jSayCdU8AxjB
         YC5/0LxabL1XOfcTHXCbIX/2r4vNzw+vlme1cZSdXQLx83SnaPzQ/SHPt2mZB2vhOVAJ
         8Vb0sWDW2Sw7+H4rGsgjRBwNDn2SIp7FkUlDQ/wdCUTkB51VNMe/89kQwnyJJiCzhx2X
         I5SyV9v83bhhMDjG3RwII+tedBCQF/z/CZaQISsVAvJbaciZLzewL7omuCsfQWeYWXTN
         HARw==
X-Gm-Message-State: AOJu0YycFVEr9P9oLpJWo6oBhsnjmmDm31wDOFL3Neorad9tGGcHwXuD
	XFesxY3QuXLpHizF9/mg8ImtZOpN0S3/0AZIrFd+iecgoV1mFiFNrrGUjUxknnxC
X-Gm-Gg: AfdE7cnfHw4RBPbZYgHuzNkxTh7jxY42S2TC4ODrDCM/l2MBqiqc5k2qCbg4Jl7VFbm
	P3qMD6216Rk0Muf3u+PZnTw96agfOYY0rfZ2Ox0nVIJiyzMv5ea/jssYjGox8hGD5rfQCxjSKUv
	XXRP0NN4RhTnB6SykX9oGvoUaus6XoA+28dFILGkEqcCY628UtJk9KyrzTWTAOWcoZcA5+OjM8U
	jwa6beelrRdzuXV/jF2WkybBmWV51/GUabGGPGMYkqHGu536T+NwW14tO6vS17UgpgmNSYs9ot1
	GrBT8EehdNFyH3wSxEfPHsBj2EnxA2sf5z8snqwL+c43k1H+JbRbtFS6U4DRgSEkhwA1J+TjxTx
	7hHux6T5R5b7zW8YRyuBmkFzkxN+IiMPXnIxw0ZhdEtShKn0roARxZ82rbXYqZETrvgpn2WN/Ou
	pLNGdWlytvypLi5muUmgFrNoehgzHNckZBqq8/1l3TfMzDjE0=
X-Received: by 2002:a05:6a20:9f96:b0:3bf:bde7:d679 with SMTP id adf61e73a8af0-3c03e572be8mr276253637.40.1783099413818;
        Fri, 03 Jul 2026 10:23:33 -0700 (PDT)
Received: from birens-macbook-air.local ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb843fasm22278176eec.18.2026.07.03.10.23.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2026 10:23:33 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH 0/2] iio: accel: kxsd9: fix use-after-free and PM leaks
Date: Fri, 03 Jul 2026 22:53:21 +0530
Message-Id: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAnwR2oC/yXMQQ5EQBBA0atIrVXSjTYxVxELWhk1k9CpQiTi7
 ppZvsX/BygJk8I7OUBoY+V5irBpAn5spw8h99GQmaw0L5Pjb9e+wi3HIHMgQWdbOxjni8pZiFU
 QGnh/jnXzt67dl/xyb+A8L7G+hRpzAAAA
X-Change-ID: 20260703-kxsd9-v3-proper-51a1f05c4951
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Biren Pandya <birenpandya@gmail.com>
X-Mailer: b4 0.15.2

This series fixes a use-after-free during device removal and resolves 
multiple runtime PM reference leaks.

Changes in v3:
- Split the fixes into two patches (UAF fix and PM leaks fix) as 
  requested by Jonathan Cameron.
- remove(): Dropped the early return on PM resume failure. The driver now 
  makes a best-effort attempt to power down the device unconditionally, 
  addressing feedback from Andy Shevchenko and Jonathan Cameron.
- read_raw(): Mirrored the -EINVAL reset fix from write_raw() to ensure 
  symmetric error handling on invalid masks.
- Dropped redundant pm_runtime_mark_last_busy() calls, relying instead
  on pm_runtime_put_autosuspend().

Link to v2: https://lore.kernel.org/linux-iio/20260621193036.78549-2-birenpandya@gmail.com/

---
Biren Pandya (2):
      iio: accel: kxsd9: fix use-after-free on remove
      iio: accel: kxsd9: fix runtime PM leaks and unchecked returns

 drivers/iio/accel/kxsd9.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)
---
base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
change-id: 20260703-kxsd9-v3-proper-51a1f05c4951

Best regards,
--  
Biren Pandya <birenpandya@gmail.com>

