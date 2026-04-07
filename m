Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BE38A71E
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545267; cv=none; b=mUdGG9gAUuH7cqph3VtIwtwvurxwqu1+usZ1EBI9Wcj1eOLFUiTIEnT+69Ymj2WPe7UjMUIr4hEFPdJpEnIV5fAQxOY0TVq24O60t5jfKcOOQQwvJQ2SlJuM+8rlnmhKmlEe3uu+kChvmXyPiAjLBOF4a8WfyrJjF6cD+Dlv6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545267; c=relaxed/simple;
	bh=aSwGS1w+ZfXoSis95cwWOn4rxKpecTfKYrW/bnEVBdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJJLs/h1OTjp91d+X/0H4qsizCPU5c/2V/VFlmcT0A7cpykMPwmGje94nMcvQr+5izS3q5kZCDsRAF7LrwjRPNTxd8P7CwB1DMEncEAjdU8FC01p20cVcSpwZuDweFVhwaCahVuFf6avxKxLigT4LrfKQHkCNZ+jrxpZx4ekAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1CG14QI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1CG14QI"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d03db7f87so2490966f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775545264; x=1776150064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEY1NxXfmQL2tnAV7Ne9RR9XDQ3JvcVvXSPGw7dtyYE=;
        b=Z1CG14QIOliwjthfUFQOnHK1ONfNWpKHBbm8rd05/kPSpXmnqvLref6HrfQI2gecz+
         9t1FYecB0c1uinF4m7gUcZfBHbF2jOP8zEZNZ3leammdqIg0P0/oJqXEeEgekQmiOHw4
         LYN8s2syereuoFT2KtbR/H/+3zZWhO6wCBxn40bHhLuMky1ff8xjkobmALqSotb813Oy
         pkCnBgx5D9GKIcLiMc+t2ldeJ/plgcrcrPsCojLEq+aSEjjcVbB/O1pPgaN4v+nJYUxS
         Trt7OlCds9+6Fk9eq7KXwM7dC6V15i+V1ft1CKh/sbQ9Qm1D+ZNExmhBaueKlfZtazYm
         lIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775545264; x=1776150064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEY1NxXfmQL2tnAV7Ne9RR9XDQ3JvcVvXSPGw7dtyYE=;
        b=B2UJSfc5VfPP/h39xmMVv4ZVbIOLOhMDMBUTOeiAOQvFSFUqiylzodgdIjSCH8EAyw
         AjJGt6nqdAY6rdOLqMAHsTS2yNDyJ/tcL+n1sPhyUSMp/8rbXDRwzVumgAiEqdRhENZD
         Kv6eAfRXXqGBCive2q7FB0mFwrbq+K/H+yUh8ofFHqb7TpNrB67Vt5CkXg3u7cZfAa+x
         0qQgV5v+7pURK8/ZlqarEN43d1wZZUJTNWubM1+7MUm2U1+M0ivxwIQ9EUBDntWetzOE
         0/Grwf+B+LnIDHkS/XfUvEJuufQcroe777W4gF1KaARPbCTHB+IFd5lt4kN5HfPDmH8c
         H5pg==
X-Forwarded-Encrypted: i=1; AJvYcCUBtuCh6t9JlbuTL28DTh48DjlER4dX49gJ85vUhXKPamnhVEFr9PUzHws5RZXVJ90DarsGChpiPx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtTQz9yBHgHQ4kjibhlrBTupOPmt2jLKB/YYSUbE5GhLL7TPs
	gSWU9Q9NpPu/xeBoIJOtOVMJaW+kraKw7dm2UrZindzZKHniCj/5gJoChX15zw==
X-Gm-Gg: AeBDiesDh3pY2SnV5HPqj4iR5dicAiYiTC1o2Pb4SRtEFOr99PdmNL5vuqJg4AROT2S
	pzO8ANDrscusNThtlGQg9uWZsWf9y1eafOxX0/HCcrY4F2yFNj2PXdFjDu0xRKu6F3C7gartN9o
	Gk9qoZMKcdvI/3E7LgAZFvqsykADTc60tF4Q2BdScupegSOglGZU0SVwnY790ciSEBkFZhcmJeA
	Oh6jjGXy21wjsVOQd0oAlDsCaMjE9WcdXFL/6V9eCOY8aMVtvFyWPbIPlzTR4vpcNdu0idkFaOx
	8jWR4ZHmhe4zqqOChWQak6UgzF5hTnIlAucC1IC0GbjyOA1Zgl3cWvE6Oy1LXK7tHg49fu+XpJD
	8SyL4uN/F7uA9qJdpE+tm2hr1RtTJYckk0KYId4h03MAkM+Opy9UF38m/l8fTaSa/g2AWejj+Jx
	yP8gFMuTab0S6u4oXbFcKR1HGsFQgLdXX2GvnIMMvYKxYJVBWDNbFX
X-Received: by 2002:a5d:5f92:0:b0:43d:184:8aa2 with SMTP id ffacd0b85a97d-43d2928f9a2mr22347092f8f.16.1775545263749;
        Tue, 07 Apr 2026 00:01:03 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm42167576f8f.9.2026.04.07.00.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:01:03 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 0/2] iio: light: cm3323: fix and cleanup
Date: Tue,  7 Apr 2026 09:00:51 +0200
Message-ID: <20260407070053.9359-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series fixes a bug and does a cleanup of the CM3323 
color light sensor driver.

Patch 1 fixes data->reg_conf being incorrectly initialized with the 
return value of the i2c_smbus_write_word_data() instead of the actual 	
register value. Tested with i2c-stub on a Raspberri Pi 3B.

Patch 2 converts dev_err() to dev_err_probe() in the probe path.

Changes in v3:
- Patch 2: remove extra blank line after cm3323_init() error path
  in cm3323_probe()
  
Changes in v2:
- Patch 1: fix typos in commit message
- Patch 2: add struct device *dev to shorten dev_err_probe() calls
  to one-liners (suggested by Andy Shevchenko)

Aldo Conte (2):
  iio: light: cm3323: fix reg_conf not being initialized correctly
  iio: light: cm3323: use dev_err_probe() in probe path

 drivers/iio/light/cm3323.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

-- 
2.53.0

