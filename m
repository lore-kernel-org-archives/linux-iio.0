Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39F3793CE
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883829; cv=none; b=cFA8iW2yZOMlkpyBvmi3aepnasx3I2Cxv0yGGHzq2wiXvQfVIC91dvL9qNStL8LbmJC/3scL0kbyxhxnnk2FO376HphxyW7BqOt2ll83eeJQTZEK6mejITNVUOZ2gYu6WFYDmmrPiqx7X/FDDjwKsqgQtx+4uLVZODp0UDF1EpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883829; c=relaxed/simple;
	bh=4+poao6g9z5837WQ0SxEfN4nx7nNrEHOJs6OpKVNsko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3ISZICwgXdWcYlX3zzQii+PybSgg8B4mmT6r1uBZuHwsArYR/QRX1Fr7tT7bloWh2/2T+pNpv6W6FO5UAMw1i80O54QKflGxqGdvs4IL4ot9uIbJ/1oKm2+g1T85Et/BrMXJ0rqtIfAbQsWCKG0GcNv8tYjSaE3YWn8CwBt2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZGHBBRD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZGHBBRD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3530715386cso4018128a91.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771883828; x=1772488628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aatuCGhrp0J7wRpUsFxXEN/eRddtkdqYMThGtyi9KSU=;
        b=XZGHBBRDbQV40asTZGC3TfUWGTGYKKHiym1rEBAKxYf2KxDpDrsy374oWG9Z6YMFVs
         YFNCnV4aa1ak8rkOqG+ptZM+pbZR5yCDhEntRIx18ypuaeJqeHDSxpINCZCBtX8O5OWy
         FZEDYXDMvoS1c3BAg6dmLKfuc/5mswvzcBmay9wWJSOC788DVTEBlJ86SVM7kDO9yAUj
         0XLcEaAAGQNUBhra2Dl73j21AKZo44rxVM88Q6HnDTu+RwiX2udJDOJ31+xMW1doa9dn
         5GyJ4HS6VKuswo6QRul/luNB75aIcdNbKHF+lLCgHN+zU1MXx+axA864caSODSS+soF7
         pUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883828; x=1772488628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aatuCGhrp0J7wRpUsFxXEN/eRddtkdqYMThGtyi9KSU=;
        b=hDk9eliesW/f7lJlLayC4KI1K94ZOSBXd3ffKy8G/sI8GZYUksD0SclrVVMmfW9FKo
         vMpWe8Svn7MNbKrbtYzu+iNJh2kjVN7qJHFeBCdDRZvza4cBI7O3+NYgEXPSweq9rdEr
         VO7VFhwDbMw519fq4CdHaE1CHtQ4YAfchi9p/s5dC4bvLlVIktl5LprC66e60iROU2dA
         7sGObA37sM6nm907fLcsxgpca/lEbt428X7WgR9krQf8LaFR9q1Nm0ao2n5CX8dpxNEG
         E3bf0Jegb7dLGAixuerdJ4rsypf6UHj1gZmst+HFLNzFV6g3bNMWdSwd/7TbkAUdhiYt
         p+7A==
X-Forwarded-Encrypted: i=1; AJvYcCUFhtCZqaFnuZWUf9OrMF8Rm/lARRfv6Kr/Fl2YYIGvTyMGorEwaJpcEZ5M3iZGTOA75QKru8oTZTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5CjcclH+zB5BdM0EBX4kkdFvJrAp6mBgoR/s/zeJuErpQEaq
	xEFHI1P9v39qeSuDgOyttbPT3B6nBOSrOGUB3/M+tVp1ou9YUi/+GaFf
X-Gm-Gg: ATEYQzyzrFVmmYI7srQ93Gnk/fiKfAu/ZQsRYXVH9jHUfgOsrVYAv8SyrguThDWjhBF
	mU7qKErcKrihh96JuvIzJI6v7y0iPs3UF9/qQpjlYFzuqm+ukjJUN1meWSFfESVFZ/v/VLobniz
	RuwvvsmoA/v5ua5T+NjjqBqVXXBXQAOLsXHR+gxbNje5L+rVGuwGJrwfntL8oHZEMJt0PnCI2VF
	8jIWBfeAkXrUtXI1UA0gOCXDXzHtjh0AOtBf+S8Dd8VQd144NaA41b5NNHBb1TqsHXcaw1bwDUd
	QuOnFjt1SNXIEipq+2iMP5j24XHASDKwqq1l0a4mGv/HvjDG7lUPPUQ72kdM/d762R71Rqw4Kwx
	2Mpcah6CXBrqkYHjHZtx2OIJeU4M0TBfInibqxWsAHm399UNfnR4dP7HTvWYHKoQsj4K/8lsya2
	5UFK/EW6kMq9ABjykkns1KiA==
X-Received: by 2002:a17:90b:3881:b0:354:c629:efaf with SMTP id 98e67ed59e1d1-358ae8dc667mr7792807a91.35.1771883827901;
        Mon, 23 Feb 2026 13:57:07 -0800 (PST)
Received: from arch ([2409:40c2:5428:afe:6feb:bc4:5ef7:1700])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358dc0092d1sm352772a91.5.2026.02.23.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:57:07 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v4 0/3] iio: frequency: ad9523: fix checkpatch
Date: Tue, 24 Feb 2026 03:26:33 +0530
Message-ID: <20260223215636.18606-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
-Patch 1: updated macros to use '(x)' instead of 'x'.
-Patch 2: collected reviewed-by (no code changes).
-Patch 3: fixed vertical spacing and broken indentation.

These patches address several checkpatch warnings in the ad9523 driver.

Patch 1: Updated the macros to properly use their argument x.
Patch 2: Fixed the multi-line pointer dereferences.
Patch 3: Updated symbolic permissions to octal (0444/0200).


Bhargav Joshi (3):
  iio: frequency: ad9523: fix implicit variable usage in macros
  iio: frequency: ad9523: avoid multiple line dereferences for pdata
  iio: frequency: ad9523: fix checkpatch warnings for symbolic
    permissions

 drivers/iio/frequency/ad9523.c | 88 +++++++++++++---------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

-- 
2.53.0

