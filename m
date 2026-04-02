Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03D2C21C7
	for <linux-iio@vger.kernel.org>; Thu,  2 Apr 2026 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143056; cv=none; b=MuZ3eY9Tbk5wAnGtWTWjheOG8UYdwbhr9/XLnYiRH4CuLwfwfdr9PfsXYBIH9f6hePBnY83/ES5rcZm64cb5KniPpicrjxT6MjiPF3g8p/bFY84hFypGDT76Nv/Y06MbLrzhzMbVGbZybgPC/NEumww4FGuLsV882W1DvbLe+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143056; c=relaxed/simple;
	bh=aHlNdC7p4DbRc/CSG+7y5M1Es1dchVp3/OjYYcQIzik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9BbW+Q9p2EhNrJAMytXsZ5UMAzVLJqroEjn+IwE0gBrrwkZP2W68zGq70zfCNLb4bw9LhEsc3q07nYhyXmPjVvyekPKTe2x6iJh+sVPYfQzxl6yp9kxUWCj73PoAiWS5k3BCrqE8LOJdyX4ZZlwFKm5HIHRFVcqFd1mB7zDInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1J5V1CL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1J5V1CL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso8312225e9.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Apr 2026 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775143053; x=1775747853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mntd8M4unC7CNIQW3NEt3PPWaslHcdDa4XbiAqvFdwc=;
        b=D1J5V1CL+RbUIMNpS/eFVkg0LfnRl8NyLHRRIMhKxNzvaNiBDgMdn1fnao6hY+K18p
         RzSFPqsAoiOyBXds8Z1ZYlUCjZsbOK3uMp2sLhgW3IYwXPdIM8xmwHvbFtW/WGuAXEh9
         GdvH0aDZsHO4LiHCvIu+J7QwMXh6R+zaFeYstmRy4HPTczNClagRiqGULBvTEG1ylBGS
         kj4HbH9AwVPyz+rqtvjN3HSL+tweUrGl9wEUaU3U9HCkAcuC/zTAtF4548Q1dm84Md76
         i2qHqpGWd6QEhzAf/rwYONvEOp62YAaZzQsaNuiiUbmbJ4fs3Owo4lKFesaRMN8SyJgQ
         TkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143053; x=1775747853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mntd8M4unC7CNIQW3NEt3PPWaslHcdDa4XbiAqvFdwc=;
        b=STRusMUG932Mx9RJvDy1A+FDTqv7HiIPJ2fM+be807xOqidsEYqbFRovQts7Fq2wuo
         BmCQ2jQPnve23SiUJ0zBt6RLNq35unpTglIBW7YItQeI+1/TZpg2cPT1A7KcGZYMEHTY
         EtMqtdqmtWRENXz3i9TnuALBffQfczCBfjbk/MFZlJGRWep1poIQi0xxeW94FZX6jYxf
         OS9oJsdnGiS/GbT6TF4w6MlfBAFVA902Wx6gKJnipeeau7AKC5Ty/d0xg17SgJ8Fh8V0
         gm3d2APRMeYoIHnq5Ka5dVC6O55qN4htUjBcCg/WrJo5EIjFhvwRJmhlkvB2M4Upq5Gz
         zMUg==
X-Forwarded-Encrypted: i=1; AJvYcCUR81ucfAfleIL7hbK1MFk8gy12trVZG6l0o8xh8cDEAh+AV+3/GuSaZWvx8cpTyurYnesfnlM13mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMF6CEzHex6CsgQoD7tuv6VBAjzuVhbn9qZRXOgKmTyWixz1OQ
	ayUaAP4yYuFHx/FIuiQ8rjKBM9KAeRmqPKb0mp2zFP3Lq2YWwSYMvkuI
X-Gm-Gg: ATEYQzyNQV/uwDcL79dM50oYyMRqNIYNfuEnN7ywMApfXyoNb4EjsyIfryT/5tflswW
	HEotHutebceudSHxsDhgUVDDnDZcpMftjBTlL6m8USUQHhBITFCIf/OfNXPHO0BoBwOmAxqzYcz
	Mfs1r30HmyvYDCBq9fbFi8HpG1+pLhcedxa1x9tX8GzDLyf4YD1ivDZ8IuG653LTAT9WfNTael1
	Hg+Iu4rRruHOfqKz8xjpNuYHVVtM7dU9QzTCnK3HOIKRg2U3Xnd4MRsQAafej614h7DkoRLWNNK
	Kguk1P8VihEbW6naktZrfembEBLPYLDcrO27djsVxKP/mKNiBQCaBBqbbXr1k2k94iUSWn8Ybo1
	hUQqsxnkwYeAgY75ea08x/jEJBemUaMqP+3PbFC4WOYnliBiWXNC5IdVH3wQfcUrFH5MG0ZBTY9
	Gl0GAsJQf++yWdotKIURrepPUMywpC3Oq6FC0P7hmTRa5AAgtprXKd
X-Received: by 2002:a05:600c:1e85:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-4888b5112admr64270425e9.0.1775143052811;
        Thu, 02 Apr 2026 08:17:32 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm327405075e9.2.2026.04.02.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:17:32 -0700 (PDT)
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
Subject: [PATCH 0/2] Subject: [PATCH 0/2] iio: light: cm3323: fix and cleanup
Date: Thu,  2 Apr 2026 17:17:28 +0200
Message-ID: <20260402151730.18901-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug and does a cleanup of the CM3323 
color light sensor driver.

Patch 1 fixes data->reg_conf being incorrectly initialized with the 
return value of the i2c_smbus_write_word_data() instead of the actual 	
register value. Tested with i2c-stub on a Raspberri Pi 3B.

Patch 2 converts dev_err() to dev_err_probe() in the probe path.


Aldo Conte (2):
  iio: light: cm3323: fix reg_conf not being initialized correctly
  iio: light: cm3323: use dev_err_probe() in probe path

 drivers/iio/light/cm3323.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.53.0

