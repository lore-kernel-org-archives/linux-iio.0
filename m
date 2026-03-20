Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31331F9BF
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045471; cv=none; b=Tzk1gXzct2yjTUrOiZO1nWRtwr3VeMrqAnNczQcxOFHR9GNF7FtdsYdUma+6zIoXbwWZK2/Wo0dNT7pJs1xLbOzwxTaA7Py+sANcv/zhTRlMqz1V9EOWe++pHSYqkuuks0stuUQsE0BW/j5Dg/Nty7mwQHsh24UkfYr8M429jjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045471; c=relaxed/simple;
	bh=bW5hXjc9OlxURFU4kk4Cob6ovzZ9WrBLweKyot0XKRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFHsQuXE8w0RsHuGDkAyFELy1HZpac2mp0N/3vxBzn7tTuUPXWXJZDrF/nhnULlTUN3Je3p5cumv7KFJaruK6kP9hf+1k4e9YaIG0RwpHclVxBA8ZYSkwqTodZNZYPawaU+P5ReVXYHyxjHDNksVHloy7DHh2L+koljGfnJv3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/iqy9KQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/iqy9KQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so18809185e9.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774045468; x=1774650268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv0fn6kQsVTouvLE5GNhR8tGbxcquMyrqZ+KJnhTDe8=;
        b=b/iqy9KQ9/xtjWMX9NQ33C59o8M77FD916lwjYIwejHiAxh3AZC6tUTzbbZrX/8i03
         91NOWVlCE68EDt1w56vzLH5KPm5vJoRUtq7LwgPQtwI1ui9bIuDx71CAjPVd1YAk2yX6
         zv9Fu9Yh90XNNBXqWVJe5yjSDDnv7/vdQv0SezEcTWuX+JpBwQShzWIwg2UC9Tf+f2l2
         7+IcHOIe6k8SRmsQIxN7v8aGzSDH4Z87Pg7yy+00bCLvOPHJPqetCGw8nbSMf/9KUNdB
         O0N4uyUdmlr2ac6RykFIFOW0xDXYbdNlo8T813cMaQFlc+XNwSjh8KJ9AsBolzrcfBCh
         03Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774045468; x=1774650268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tv0fn6kQsVTouvLE5GNhR8tGbxcquMyrqZ+KJnhTDe8=;
        b=hnjByQPBwxCTfvI3awMV+CxbeJIglmjcJ010pQ2p0Y7fDD4W5eT69CqwWwjgmG3MJ6
         ZekNf/73fVYrBUhH1DE8mmUimkY+WQ0y5m9Fum7FbD76ByLF86IXr7kxWMevjkkTO36+
         iHO4RVXoqdgsZjs2Ca093eU5j6ygN8zWdCRthZzwS9gduPDr6k7m7z0QqUupUgRPfuYK
         wgVO2aVkrhClx0HHu/+M4pFq0XNBPJ/6U7Vhuhg5FEAu1vkNMt0z3HmUnv8eXvP0vbwp
         33MAkvjpe7qfoAuvIq+dYkPswNOSGH9u1rX78imQ6o1vUW6p1gfh94eBiMPNmtiZ5Ab+
         6YzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3ihmnnCpFwhdPlh1anbmfi4AUE6rVsRk3aa6a3cBYqyY6SOGlsM+PGd00Gw0MrrZNFFkYXNCFPAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNoMd4j2uVB2D7roPwcMYQaVbfwsk2c4fOvTUnn7RmhlaeMLf
	C4MuLyIKbfNfxrikgaRrn3JrbdUJzQHS/mMIzgPgJd0SrL7VmB9wvvb/fKa+c2rXn9s=
X-Gm-Gg: ATEYQzxo5tp4ht2hdAtDHIgjLdi6vxduAl22QO02CuDEl/Z2EUWLKfCvlkELyxfzNwB
	GXuX4dNKmyNy2HZcXkHXcQ68fsQSFF9+3H/g5Y4tv8VEc+tR0TaQyFkbfrOkMTd+2nS5Rm/YoX/
	bkJb/Oka1bxUh/9psmMdOJD+xiE1Dip85wtQBMjo30sOOLDK2+ybkNntFwxhyQmtvySmy3eviIf
	2UQM36C1Y7Xxj5HwxVt2YNVmDZXmfMKUopPRbOOFTbJrFF9ur1VXukHaK+2pkj8eXAdwqr6fX1r
	WVkw+1gFBilkrewZjvWprhR8OQNOE07ZP7FTPX/xSwddEf3tCCBtKqRlrBIUWnhvu4M8YLfUFPp
	7NeFzYLPKQYcraV71dqiJuuY/JT+l/fprHDVMhsNAdpKxCmPvwCUIy3hdYsHlbvMSrWvMZhMvVz
	QJdJ+88X1yGYek7MXV57zKkvZiL+R8XTWUQjSkltTAULnT/go03rwx7rH+LA==
X-Received: by 2002:a05:600c:a4a:b0:485:4eaf:eb14 with SMTP id 5b1f17b1804b1-486fee0fbf6mr60854665e9.21.1774045468001;
        Fri, 20 Mar 2026 15:24:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:bc11:6b0a:79ed:3d9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm9290237f8f.4.2026.03.20.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 15:24:27 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: iio: replace sprintf() with sysfs_emit()
Date: Fri, 20 Mar 2026 22:24:21 +0000
Message-Id: <20260320222424.53294-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260319225719.73587-1-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the remaining sprintf() calls with sysfs_emit() in sysfs
show functions across three staging IIO drivers: ad7816, ad5933, and
ad9834.

sysfs_emit() is the preferred API for sysfs callbacks as it is aware
of the PAGE_SIZE buffer limit. Build tested with gcc 13.3.

Changes since v1:
- ad5933: remove unnecessary (int) cast in ad5933_show_frequency()
  and use %llu format specifier for unsigned long long (Andy Shevchenko)
- ad9834: simplify wavetype_available show functions by removing
  intermediate string variable and returning directly (Andy Shevchenko)

Gabriel Rondon (3):
  staging: iio: ad7816: use sysfs_emit() in show functions
  staging: iio: ad5933: use sysfs_emit() in show functions
  staging: iio: ad9834: use sysfs_emit() and simplify show functions

 drivers/staging/iio/adc/ad7816.c              | 16 ++++++-------
 drivers/staging/iio/frequency/ad9834.c        | 20 +++++-----------
 .../staging/iio/impedance-analyzer/ad5933.c   | 24 +++++++++----------
 3 files changed, 26 insertions(+), 34 deletions(-)

-- 
2.33.0

