Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A3380FCD
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684467; cv=none; b=kVPCpMDYOWe4/gNxeBiySrPDh74TFte2DuQkPHuDFpImn0diOZZjH/7aSphLHNoHSqLWeDJB4gUy/yW1sIdNTM3auhpm2pbcSobTAGUXRuoTK1tztNi12vMJf5EMR/bWP66ToCKMbrHDy12FIwZ6PkscgUmV2pGP3G+42rE0lT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684467; c=relaxed/simple;
	bh=737MpTrt2lXFYNctz0+SsM88UxOw6A1EzSUNkASCvF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kojRfNJIoIS5+tzVQA85VmMME3SmKtxrr/fJxo7dBr71yJbrqbe0kOEDDTWsdhLKYHfekFf9GTTmOUKalzWJkEHeH2ByPf8doJxOnXGQPdwUAOMXTTcNHKHhgl+TjXOFHOIjLJxlKayJzq3SEGcWGLTCXWGsHRwI6GaJ4egDsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erIt+M5R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erIt+M5R"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c2d792c8so35362455ad.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781684466; x=1782289266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zghmFFV9Y1GywLSUIs6y2LVn/WcpsOY8xBp24UabOr0=;
        b=erIt+M5RdUCcy4uKWzb7bn+d2/rxJz848oK30iNPwTcOrC1BcbAXpv2r2YelQlJwcR
         LnLUK9XCDdVXLxRF2fYx/qsrEibT39tj6j3mbIHP2Ax9R2rTHOiDdWHjgA7Iy9YVeZLN
         zArEDmCdK2ob3bYjHQT+SJSTFUTXQNh9nnS2SRT89gmYClVBaU/g2bMZE0a2qLOEq1HT
         zlLZ2YqYkuqgoSQb4fucuFH2JxyTAhrEZTZQTiO8LtVOZK0KrASyIrB4c/sQHpgAR/QP
         vuiXEhFVc38QbKiWVSzfZTi3ooDA4T2Z/oBh83lrcf0JedB2GkDwclsK0PN+nO2MTXHh
         Vipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781684466; x=1782289266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zghmFFV9Y1GywLSUIs6y2LVn/WcpsOY8xBp24UabOr0=;
        b=XOXP33LDXkVISTwRqir7tXT+yhTxFj7jIjrbtRXJO897gtyGy8xtNRjDbeMYX4RPdt
         PWgiXcZf1vLv5tgZhScYl0PMG2gRSr+cihXXj2SNBlr5qbd9AfqneLGsaArgQI1QiYFZ
         AmCI/9yi7IaeNTo0wf3xiNTIIEbOWCf2qJnT/ySv3F0NRuZkHpfu9SVr6fzTrxapphwk
         slBh3OjWO6feQxntcxYQwHs3F2zTFO9sRcaUQvLCnl2LYSYmTwSMKbhkM5E9nl9oECIo
         lO7TU/zu/PkWuLaBsBUPvBGynLV0rxOEcHV03DyhfJ6+OO7rgunuBmKhrY3WgIdmWnKO
         SCEw==
X-Forwarded-Encrypted: i=1; AFNElJ/nn1rmMRY63wxK1g+RW8Tn45Ax58HKp75979l0ZrY7wWlk5TJKu2BIm2zIPl03lgY54Ij23Yujg/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84H0UEyZPsA6VMs4XPHNHDaZX6svuDokxYNe7gdyOF05c4QtJ
	urAGEtBm1ftbx8yayqItvD6qFlS0hnLexseWBhJBFjm/i4NXJXeZXRkJ
X-Gm-Gg: AfdE7cnstm1SzhogKKO+ZsvO9E3T3Ntv+4aCw4lZgm3qZxpzW8qcmCltQX3QIVlaDSd
	kL8/MV+LzCQRlEDtYvsKzLF3zOWbmTQk9su6lpatnwiT0+vm8gZ3PAlQw2Byg8cb0NHTAZYMQIN
	WYNg+VXWzqqcbbHFynB2jRSHdLDZcLf1bo/sEJF0tELwnbiNzvKUjOwTjc4+xYetVlos3VgmBT4
	mS6w0HZIkdKzZDt82nzipCsOHM/EBOUA2mPRcuFrDT3LBEqFaSkafG3brj5ePQblXxgiXAlAgsg
	XF/9D9XDz6RLAr7xrR0PVAskg95JsDw5ni7cfxzRh0WthylzVAqeP35edVCeopm4uDnNOArKZMc
	iEDrYe03CHJ+YmbAXnrOFBUlowCgQ6/6m2slIXV6boowKWos0sldEEtIES1ihD5W2XlagVwxyup
	miRJRY6Q0yjpZ2ytaXQfIz1jSxpjW7ZuYCPA==
X-Received: by 2002:a17:903:1a6b:b0:2c0:a9b3:bdc6 with SMTP id d9443c01a7336-2c6bc258777mr26934785ad.30.1781684465820;
        Wed, 17 Jun 2026 01:21:05 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327aca78sm163289045ad.54.2026.06.17.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:21:05 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Achim.Gratz@stromeko.de,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	sakari.ailus@linux.intel.com,
	salah.triki@gmail.com,
	yashsuthar983@gmail.com
Subject: Re: [PATCH v2] iio: pressure: bmp280: return on runtime PM resume failure
Date: Wed, 17 Jun 2026 13:50:58 +0530
Message-ID: <20260617082058.30659-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ajJFkNWEdLaIMUcX@ashevche-desk.local>
References: <ajJFkNWEdLaIMUcX@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Restore the blank line after the variable.
- Simplify the error path in bmp280_buffer_preenable().
- Drop the bmp280_pm_disable() change, because no
  caller to propagate the error.

Sincerely,
Yash Suthar
