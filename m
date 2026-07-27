Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA33CB56C
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180080; cv=none; b=bOZWqRHiAXE4rywRTMjLhq2zHN3HOsFKl3gOv6QjhlKvUoOhsDFBy33eBjuXAOaV8tLU6kMYUtJhhRCPjfs70k+U5cxNkWVMyAJqy05LSJ/5bF/e5vXvLqLoINZHK0siB6yt8qLDkUZaqP2vMqe9Q37z1ZHtwsZmZIbwcwsrSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180080; c=relaxed/simple;
	bh=7nIC945Sv334N3OjbUN6ZCwKSgY6D/5noyhIzwHrKkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=phOdDKjKshhN2ZLoly2F5x6LhUn1LOEtO01vqOLTdvRAcimVaPmybzjw4tYPZPAG7Sd1J+21Yk/4qrbEZiM/cEw1sCew9D1QMsPbFY2yDlfoRv07HLIpenoHmsak4Tdh+xhP9aQhCR8xWkw6grmxEuoL0pubVr4pAVFFr28z584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZyqosgq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZyqosgq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceab75934dso39048165ad.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785180078; x=1785784878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z4mNCG9beTSG/GAQNF32mwCuWY/ZfBeusHCM5eRg8Sk=;
        b=FZyqosgqh6ColgWb3jWIBVyolZsuPHRyIOpVW1Jxr/2pVzIxAyPedzIyWAKPQqnW1W
         9aLHfjXw5C956cqO1T9M1/pxB2P/ifscCX4VLQ070V0i+08tDt3zNaFAs5Zfpa/krVCI
         5g1Zj1IAsyx3vHObw2xyGp27ULk4BcPzNy1zzSWJHNhXYOqR8l8BUm4xZKedCJv6FM5z
         JOCSa+OD2zr7X1nUDyy1L73atb5KTlAyGwZVWiMNAtBOmHri2oR33k+NAeJb8VFJT2Bf
         tfSFWS7IzWNjxUHYwYpEoQlJfpapcZAkM9fuVh3jqwdqXOVKP+CvhxnPMCyBuvXwoz9m
         6hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180078; x=1785784878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4mNCG9beTSG/GAQNF32mwCuWY/ZfBeusHCM5eRg8Sk=;
        b=jgdq9Gd5JoROZW3t+qWOvk5YYllAxQjZmtVqezUeSFF7kQtCVn1H0ZCCw38Fqs885k
         8uTkYTkAzq7ZQn5tjQXHEYn7YdMOHB7lILJpIJJxtSAHHQaFWcyKmdSHQNWbDbbpUN86
         lJF46yXaUODR4HMRG51RgzSm15OMXqcYmDjOhWO94hTw1FoG1/F4QAYZAod9D9Vz+ahx
         oZvui1Wq6J7K8plmN42grBNTNj69taJPb3r2VZpn8CcG7wKw6paP6N4OhZAV0HdByHHx
         wdhEz1bil86qhqDpRXeQfLZbFpmOvrY7DWgi+ythSJ7zPZExM0PZLFI1GQwkSmQYwA8H
         F/iw==
X-Forwarded-Encrypted: i=1; AHgh+RqX9/MgVOf6ULc5Z899MmgzCPKByhZB58f6vdzo6QWvqmY7hBo7MFRQ2iwt1Ff716qcUOVAd2VAFDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxec0uhUzcxNsRSlCTOn2dJYdBoJZ3sUiShPPDdP8DVkR7goiq/
	t4EpcIMnlulsyJcNKnQHSe/J4VvB28kKQ8CfeilTGQ7SHEriZDu1TSj+
X-Gm-Gg: AR+sD10X8aZZWzmCxo+sB61URBIHPRMVkb7D4AinjU4t0SskDpLIdxuF0kOrJQ4ctoI
	jRLkVSyzgwwFZnCjZMkNjy+VeTQ8feYPHHPGAyqcXmLG9D6LEtcN1l2x0vtrQpvYSFJfEuOclXb
	JrCKQIr5wj4h66HAVwY0/s15PKKEkOfow++Hm4fBYIxP+4Rm4xt0shFbs5Ubo2ZlVCzZSBqsEuY
	Rg0UJ/9Dm/8qxQyJAHICItfYdiMKViARyM/J5bvuQ7I/vAnPt7GqHHwynAvg9tc3CbhvQfNoFX2
	TZk7EAfLsCSGXGxmUbIFst30h1pijvTDZAOGgOlD40Q2J8ll+5sCgF+swYi4TLH12pggikd1a4w
	lAAQgS8w83OmGvITDmFJg1uyLIg06qcJ2Y/s1kwrupj40pdzk3o7QZXDA5SYVsgk0bo9lYnHNLi
	E4sDMXfLY+7nYt0/faYBqESowB4t/7CYhMoBv29qUeB/iCYJhgQCxM
X-Received: by 2002:a05:6a21:7107:b0:3bf:6c08:fb83 with SMTP id adf61e73a8af0-3c67e0e2d3bmr9083960637.51.1785180078287;
        Mon, 27 Jul 2026 12:21:18 -0700 (PDT)
Received: from debian.ari ([152.58.178.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm37595470eec.18.2026.07.27.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:21:17 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2 0/6] iio: adc: ti-ads1015: modernize resource management
Date: Tue, 28 Jul 2026 00:50:56 +0530
Message-Id: <20260727192102.37968-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ti-ads1015 by transitioning it
to a fully devm_ architecture.

By moving resource allocation, device registration, and runtime power
management to the devm_ infrastructure, the teardown sequence is now
guaranteed to execute safely in the reverse order of initialization.
This allows for the complete removal of the ads1015_remove() function,
eliminating boilerplate code and reducing the risk of future resource
leaks.

Additionally, housekeeping patches are included to ensure header
includes remain alphabetically sorted, dev_err_probe() is used
consistently, and PM macros are updated to modern standards.

Changes in v2:
- Split the monolithic v1 patch into a 6-patch series to isolate
  housekeeping, bug fixes, and API modernizations for easier review
  and backporting.
- Patch 1: Added to modernize PM ops and remove #ifdef CONFIG_PM.
- Patch 2: Added to fix a pre-existing PM leak on probe failure
  identified by Jonathan Cameron.
- Patch 3: Extracted header sorting into a prerequisite patch.
- Patch 4 & 5: Extracted the introduction of the local 'dev' pointer
  and dev_err_probe() conversions, suggested by Jonathan Cameron.
- Patch 6: Now contains only the devm_ conversions and the removal
  of ads1015_remove().

Archit Anant (6):
  iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
  iio: adc: ti-ads1015: fix PM leak on probe failure
  iio: adc: ti-ads1015: sort headers alphabetically
  iio: adc: ti-ads1015: use local device pointer in probe
  iio: adc: ti-ads1015: use dev_err_probe() for error handling
  iio: adc: ti-ads1015: convert to fully managed resources

 drivers/iio/adc/ti-ads1015.c | 114 +++++++++++++++--------------------
 1 file changed, 50 insertions(+), 64 deletions(-)

-- 
2.39.5

