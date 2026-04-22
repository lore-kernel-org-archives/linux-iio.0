Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78673CFF64
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856936; cv=none; b=T4sn9kGaDbDzXPyx0EJsLJy83q6a8CunbVyp1O41jNLWqesKH6h2Vr7Q1QFfhXVA4fMzpN/3Lno6VyIxXC+zZPrrmrkPSlxj6Xm2OpU73/X0paDaQXwOdNWjSalhx+O0SoYaKOtQ1BWMBVeVvSBWb7pq2pcNBLUG6YkFK4LaJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856936; c=relaxed/simple;
	bh=W/TyMF6kDuhcPgPOZy6BALUPv/1OZTqBilE8vPJ2UQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt0WKGkd5cDszyG08wpOG7J/09mXdBmKidtmz0oW/1kWu33Jy44nkXJ6Tbp/La6QmZvrBGnu9ALBNDBDZPHwzOqNG2lrECJ3exYE5f2nyRFLAd72wj1/5Hi8iNopH1JO8flQPYe5e7Nlyot7K7qg7rbXqCkSO2Wv8jzViwAZGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npt+YUx0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npt+YUx0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-671d60ef9c6so6888003a12.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776856933; x=1777461733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7Q7xJWAyn5qQh4ASS/XmE2oxFwyglfCuD3i27PptR0=;
        b=npt+YUx0LhCsWGMoAki1dBg+PZuX3IYNGjIcrlWMJISgrlYkajWQTbDFc2eTPNHTJX
         kf7oPO+bIkpbxR/4UP3PKOL0z8yfmdk5UaopJQ9uvvsuGMLlKm4et+pjoFqvQgVKfj5z
         ZoR2j21dOGhcJALqj4WSBkd5P7IQaqJ/r7WvM/c7vycIq73HU5ohz8TLyQGMCaX+iaVq
         Vr/d50WEhlnmTPmCm5dYGL0wSGo//GKg9y8DVFrxNpraBzlZti7SSeNZtNWk2WzLg/e+
         uCw7GN2Erozqrcts7vnnTZ1mick357eh1oXKMUiQpOVr8fIb8e9MSdfUmv4+LMhBSSSt
         WOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856933; x=1777461733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7Q7xJWAyn5qQh4ASS/XmE2oxFwyglfCuD3i27PptR0=;
        b=c5kuOMrNK9iBqScKy5YdWptyghi1Pt7yKCcB0PVqV7sp5RYj8h+rZFtpkh+7zhcZ3v
         kRjSDhDG0XFjiuEJc8D0HWxZiLvD0kMsFck5+6t758YZ6H318PWyO+WhhFXUPrQs7ouz
         jl2BGaTep+9IRYkQyP0KtBSvfi7vFjN+K5jXhPfmNV89IuPasoGflbUCZhVnL3gL6G1M
         aRF2lEAizPiQe6k+M/BP9Ak6S8pYPSmO0GtS4i0Sg/SakEwwyje+J4HbUPrUVYEJpv2m
         aB4GjcVTtGrQ/ES3bMzEFWY0WYGhPG45BZKwpv+D4Tcb/CfeIT92Bkk/vhiWgSZodluX
         u6vw==
X-Forwarded-Encrypted: i=1; AFNElJ+6FJcTRZn7gR557D1mXIVHxHh7AYFn6n8ADYNhE60HLpEGtKSfccGdUYqCTU0Srgysa8JhK/LUdJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUEL8MzBK/iIx8PST0LNRD1nrUhO1oaQ07aglbtsPE086VHxp
	/YiXoNOV01chWbmJ45uWqv0Y15UeHLsKnmvZ/8DlLcQYcmnh+0qd/Ivc
X-Gm-Gg: AeBDiev6bKitgEaA2oeFaGqzy7MNXb8aBVefc6ZljWG7Lom5dUgQWvOhR2bQqzZ/yO2
	52el+AAcTGHVvVV4f3z94KUVhxvxWolkrAcCXGB415hPt5CrkJ+m184u6HXS2MytfH/rUUyJbpH
	1XgQQzwl0ojtyI2/MQNkAqNrMXnRoNpOa7AilMnJsGUuWmJ0DrP4kzI2VeZOUM32GoJx87+joSq
	AmhFWW892ExKW+MZTs85rW8qUAQANKLUBAf/KrYfray6nFHuiXqQeOPefRJ9lK3Ewc7mDJPFbqr
	c7JA7MBeN3NRmnuN1Vwp2zNTmW3wphIh226zafHCtRbz0udU97CwudLyxdXppgXfwIWZhEOi5Th
	ccaQ6YFx4jMgedf3YX8seA+Cc2tBkNM57OnwMRlAlM4GxQUqW5Uh8ySOzdnJsZ6Bn+T2IHamiqm
	c2dQO5WI7E4NxylrG3qJfmbLsWSpB2IB+mPCB4+8kMoVU6QX+iBwO9UUN/tMlF6cUy59jAiXKBa
	E3HZi1vQGcYCtzApRr8usccOmTKzfWk98SsptxnLHR1tuAsyjvyU29V2ky55Br07eFAnaL97bzL
	prXF6Mldk3jmuQkvBu0+aDZsFRpRkNqHU+RguwcVvHH1khOX+FdP6Ty7Qx8nbHQmwEE9CtfKDqR
	zdefFaS12FP82sZOcLK0bH4O3+sXEyJR47KrGks1kp4klxY/00YO35G8YdKRO4BS0nrZ2FBin5p
	/A31ohYWI=
X-Received: by 2002:a17:907:c28a:b0:b9c:aba8:87c6 with SMTP id a640c23a62f3a-ba41afe6d47mr1250605566b.37.1776856933068;
        Wed, 22 Apr 2026 04:22:13 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (25.236.141.34.bc.googleusercontent.com. [34.141.236.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba6366452c6sm395156866b.11.2026.04.22.04.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:22:12 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] iio: magnetometer: ak8975: replace usleep_range() with fsleep()
Date: Wed, 22 Apr 2026 11:22:04 +0000
Message-ID: <20260422112207.1313-4-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422112207.1313-1-joshua.crofts1@gmail.com>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace usleep_range() calls with fsleep(), passing the minimum value
required by the sensor for hardware delays.

fsleep() automatically selects the optimal sleep mechanism, simplifying
driver code and time management.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 2c2ed2063f8..ccd71bfc8e1 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -461,7 +461,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	 * and the minimum wait time before mode setting is 100us, in
 	 * total 300us. Add some margin and say minimum 500us here.
 	 */
-	usleep_range(500, 1000);
+	fsleep(500);
+
 	return 0;
 }
 
@@ -551,7 +552,7 @@ static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
 
 	data->cntl_cache = regval;
 	/* After mode change wait at least 100us */
-	usleep_range(100, 500);
+	fsleep(100);
 
 	return 0;
 }
-- 
2.47.3

