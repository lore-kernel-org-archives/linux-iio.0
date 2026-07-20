Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19992C236B
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576361; cv=none; b=dceTOk8ruiXGb3ASufLxJXzAHZH6C6b6Q6AbvEeH6UCeE5ZKlle7nHWTYq20B1JTWd5RcNEnvh5IDWqoRcvUXA9153XjN6hCp/OvfTfgozgsoiyeQir9odHBQwrQUCbBWmxj0I/d3maOx6mn5JbWXPL4oqPFw/CYdKiI7JD6+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576361; c=relaxed/simple;
	bh=qDc3AlSScBw3OQOXz0BZRSMN8wZ1Twz3mKkNI11JtN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vs+9I3XHD0bDvkmfg0a6uA39J8Y4VokAbUjZauTOTosN3c2fAFaRcNAigWhMHzlYOeH9rN3T+b6ukPH2fEH3nSunmBjSkx4+M6NfhAgkU/dUqhAcueFVYxOlKBRe2asw5oNCCZAT36I/ZOf0phl+gmz8LojcH4FOUt2aD5e90po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/qBXhL0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/qBXhL0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso10711881a91.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784576359; x=1785181159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EcyVfxcq2geJ8Bf2wMsig3NqHmAOQY3C0n//w3EpO5A=;
        b=j/qBXhL0DOOK9jr3Ckr6JYBoMLzQfw3fji7T1MriJIV1KiaLwu3Aq2qTQ7PgaNXpg+
         fVUOOxkw3XZlWKNj5f1ADl/8pTLHg62mRUrkvgJs69KX606Lp4d/rLnyukeKH5FYsi3P
         kW3DMjoueGncr4DselEc/wAFu3wk7bUzRfYtCbriYTz5N1vzlxkpjcp8vhqaPRanrOPT
         l+izTY6dTh8FP0izLRLeiabgO50gR5nUoz8d4th4ke2iQIaP1dsKlEqP3KYltxkdVJTY
         BLvyPZsOAPZNcNlwVDhXIAnD+YMaTWdqrsaR5Ry/5T7JlO4WyiDO9JhmF047AjxnbflX
         dHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576359; x=1785181159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcyVfxcq2geJ8Bf2wMsig3NqHmAOQY3C0n//w3EpO5A=;
        b=r8k4aHZH8oNNRJFWaCG7aWb8Lz+FMjWO9I19Y28+FGEKGRRE91qU7eIA0C/CEhKCpg
         GxGoO2SzbgC8l9Cuv5qYTPX5JkBald+m5TJK3vEKu5oJXZR3N2p+tYsX0l/Vqy/bEY8O
         x4pgxi/uqoXOsCC0AmXrt9+0FhbyYsHr1tg6pqLkrbuwgfU1KvVFCki2PLcqvbrw3wDo
         mUgfjysDj8Oavhfa/fQNiud/vHZSlRTNVLliX5iBu3mPNx1y8nqHdBJBYeg1qsdYHVSS
         0QfGDNtzfuArz6dURFCGvGPWyjgAezTUynZ8oJgxxgbL6jw+lbSwzlx7eFe/o2pQDdrP
         +V+A==
X-Forwarded-Encrypted: i=1; AHgh+Rr6jwe8wCwhYA89uB8JAJyxCaIfFjhroE/JsssvbfTQ7oPNosFAiRzik7Nnc1+SYuntCeb7oEl5CY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyregEZC9nXn98ARiVE3dbDhQivzRHqpfvdXuIv4AcUGGuQQipo
	J0/ihd70ae1bhH6gUaNYWo/r7uWmRzFa6COWhrrtM3BVOsAVzcHuAMY=
X-Gm-Gg: AR+sD11kiORB+m7mBL67/F2OvCHxKxf/6+rCcU9f5gBeEoD4BR5lElAuXoWlfC1Gnpq
	ADx89qJXcMr+vqnOcrrW8arj5CoT2VBLSduPaX6WKwmK+TzDqkA2TN7Cr15iknXCL4ITwth9fHO
	hHH/2771XZuNwoKXsaHr7vacq+PKGoeUmFGtXtFiUwEnMbns7zIcMDz3UhYCHHTwXBRbSSTVsp4
	o17qwIIU3xKjBwUlBppOW0OznScDATggUweOv82RLdcs9dRrCEo+fHh1TJJ7SgXPjzy5dH1WWWZ
	cSZK54iNKWR0lAQRm2/G4l7y1CwWXjq9shAYmnAz43JhTExy0P7cbn5+r/zRzhbMVj10iJ2J+Pn
	VFOdzkpEcGi9QRNXIFgTFXgM5FdXzrmlED2fG7s9yS49BPjwVUFUeYdNLQPnY1ev4Q4sNedTDHM
	4vhOMFtFh+CCawiU2f3Jty5lnHh/vVFNTWy90iYAG5
X-Received: by 2002:a17:90b:1844:b0:37f:9ce1:cdb2 with SMTP id 98e67ed59e1d1-38e4b55aeebmr16485807a91.32.1784576359189;
        Mon, 20 Jul 2026 12:39:19 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29ffb13sm33935340c88.6.2026.07.20.12.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:39:18 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v1 0/3] iio: light: gp2ap002: runtime PM and error path fixes
Date: Tue, 21 Jul 2026 01:09:08 +0530
Message-Id: <20260720193911.74919-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes three issues in the gp2ap002 driver, all present
since the driver was introduced.

Patch 1 fixes an unbalanced runtime PM reference count reachable from
userspace by writing the event enable attribute twice with the same
value, as the IIO core does not deduplicate such writes.

Patch 2 fixes the runtime suspend error path leaving the IRQ disable
depth unbalanced, permanently disabling proximity events after a
failed suspend.

Patch 3 fixes regulator enable leaks in the runtime resume error
paths, which matters as the supplies may be shared with other
devices.

Regards,
Nikhil Gautam

Nikhil Gautam (3):
  iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event
    writes
  iio: light: gp2ap002: re-enable irq if runtime suspend fails
  iio: light: gp2ap002: Fix regulator leaks in runtime resume error path

 drivers/iio/light/gp2ap002.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.39.5

