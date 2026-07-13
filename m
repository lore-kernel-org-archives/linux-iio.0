Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBF3F4829
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943937; cv=none; b=CAWrKtv1eFLHMnZ+YVoMCy/dia+9hoNEqYxibfn8kxgCG6cAY73b2+UKr+xDw6STvXou6iXrvWUGNCP76YtnEsUugnvGxF0Dnl4iUxEOjwWVNlnv6Q+fno160nensTo1BQ6geAltqi7mfCFeqK5ZGgIEJnnN7TJTpyh4Xb7Icto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943937; c=relaxed/simple;
	bh=tuUhSWsXBqBlAORq9TsPaWcw9THuG6DmItaa24bC9j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwYDekP8RPSpE4Tt+sw5G8clb40JpaElrCAbqlCtn8zV6puF8qwtleVoJ98WZ3LKfp4m9ycLxVWlsrGz2D1myC22pq3e+x6fR8CwxIJvGuxJz+nw1lUnEl2CP1NUd6QstNDJREF+PL14d6Nsw3/DbFNdGd431Ulfh0uHsAL9/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQ3koeVZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ3koeVZ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca965de53baso1542633a12.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783943935; x=1784548735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KMCqb0ZisPZZmgRadRDvZ258fCl2AulK6nt/+PSX+EE=;
        b=oQ3koeVZm2Uhecwla8mFrrCalllMBVjNw5s6yHgY5AbXHCaVTHFeOKBG5Q7ARQjazP
         otuQBww6bvPbbkOAWW5XszWjdbJp8cjc3GCNZ2lqoV/ME6q1YaZlcf/bEa6xIS4GYp5y
         wObkYTzLgqJcwopsFSmtrS3SlUu2Gzgq6sfPMfCieknesCoiYViAe8COZFwo28RfFFr4
         tCiKY2bqBJ+rxmcOpeBWFYCvqfMmvsTc1ImPnyKR8E4bF+F0A/u+osxZzRl74DkQxY/M
         gJKjiwhEBVtDzR/GIQOFAuzuYF4s7JXAWfxEH+ku+zK6yYO0rnjCEGImTGJsII0m6ddx
         AmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783943935; x=1784548735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMCqb0ZisPZZmgRadRDvZ258fCl2AulK6nt/+PSX+EE=;
        b=YNUYBU2f7znC7L525Ma9EMDJidj5j2SSsNg5kKInAKSIccXXrIHCGiUC9uG+nKDHt8
         wfsJ8waotWtEQDB4KOK9d/zHsyvHoe3K0YYqkEt6kQ1yBqp4WgsbpJTEisakRGkB+QR9
         H05U6Bt5nJAE2URI0j6qfX6M4QvAySBWuYjSWqW5Kd2KdcLXZakIYJrv1rf7RYkN4ouj
         cWLkQXINWLXxepCrvYYITYIcpaKoeE9Q1Wtk0bmiVLRGdmBcQdQ6XT5MWxWsCoVZvwxh
         CvdY27ePikgcOuw7OoIWWyb67o5HZ1JulQzYMvTEL+QumwQ3CkmThJYOoWyuB7yBMnAj
         1aVA==
X-Gm-Message-State: AOJu0YyOB2ipQHn5rzUKrhjH++/N3EVhxCSC2dT8sJQPw4U12haWmQq3
	35WUlLEw0jnjSNZtlRVAQIhgGtfQqWbaOUtEL/3qQkJWGLb/Azzz0NFl
X-Gm-Gg: AfdE7cl0WD8RrSsWvdSumeqbLJQOqeO7cqZhCAZ5vNfEyBtyu+SJigp6tSciN+OfsoU
	ESPBhqqoOsljL+OrYmOMsIvZ9vAPxRYbjskMaHiaLkQ0V+b/VTny38IinFXwQTief2tvZo8UFNL
	VFMDD6QhNC5PM0ebpVtgCLwJNejmMCqdrNSxQAzecRLrZse8IlCKX7wZyjQYY7RWg7FhocAWqjs
	ixQToU8zVQA/L/y3z+qi1IvrnTNbNVId4+RaZV4cZmRlaA1V/IfW6fMZNGaabcjHfHrlO3re4Md
	0c/i5iWuQkYr1jKCQx/O2VcynkNayiWrxOaVIBtWonm2z+/pAoGh+w+oqQPbr5K79ePHpAvGnei
	I55NPx2UFH7EkkZTi3tEQUG5lbKYzKF8N2emT+7QSTb8WEqYx/nO9z+/qBE1GCk8ejX/3XEQDzx
	YPL13FEDqlw8MD+simSjMk/JSY90XEVG89XqhZC0ntl//ognNt/w==
X-Received: by 2002:a05:6a20:a11c:b0:3bf:a698:ce4d with SMTP id adf61e73a8af0-3c110b6e09bmr9547183637.54.1783943934740;
        Mon, 13 Jul 2026 04:58:54 -0700 (PDT)
Received: from primary ([223.181.22.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm63668369c88.13.2026.07.13.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:58:54 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shreeya.patel@collabora.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH] iio: light: ltrf216a: fix runtime PM reference leak in error path
Date: Mon, 13 Jul 2026 07:58:29 +0530
Message-ID: <20260713022829.234370-1-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ltrf216a_get_lux() acquires a runtime PM reference by calling
ltrf216a_set_power_state(data, true). However, if
ltrf216a_read_data() fails, the function returns immediately without
dropping the reference.

This leaves the runtime PM usage count unbalanced, preventing the device
from autosuspending after a failed read.

Fix this by releasing the runtime PM reference before returning from the
error path.

Fixes: 83f0bcd40d5c ("iio: light: Add support for ltrf216a sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 drivers/iio/light/ltrf216a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index 3f34ddc911b4..3ec239eb5831 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -247,8 +247,10 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
 		return ret;
 
 	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
-	if (greendata < 0)
+	if (greendata < 0) {
+		ltrf216a_set_power_state(data, false);
 		return greendata;
+	}
 
 	ltrf216a_set_power_state(data, false);
 

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.53.0

