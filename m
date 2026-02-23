Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640C37996D
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883845; cv=none; b=QlCum0BneKYQ1S0FaQgo5YTuWDgMDfcpFN7oMJdIeviNso6da5x6v5146GNVnqoamurbd4ewT5EGCB++SVXAENzRQPiGcsJfOxAXS1fLycr9jJV7HSLbZVpnrJgDKhB4aRw1pvQRpuxnwhry9XIxBFOSnk6kPZ3vSMDKY+QT0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883845; c=relaxed/simple;
	bh=PFgKxE6kd0+0Gn8FzSRLyAHBvf9/IgdDl2hwNLrsxQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3h90gBmA8PUbD4X+awf6sJ6PLLBukSgUYFzmxVDBwZMfvG3TVEME/gtx8UPo7ztQJv98VU39dL83wYwnDu3vTetl7Aau7QsZRdJVEsLPvB36kjYMv4f5fcJolHSKVEkyj0Rlk8gCxisvC8Z5Lwq7lbnAYivEsnKux6Ot6kaGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecsRMJoV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecsRMJoV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-354a7b089bbso2725644a91.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 13:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771883843; x=1772488643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc+2JM9mzVfHLoEtVQbn4jvvZEFjVrivm9/PyMFwuiQ=;
        b=ecsRMJoVnOExPmMwpanxhR0tz0/aEEwyi/4Ynipd9rzZKaFCrWSI/fVdJs0kYn4ydU
         oGRNjVDQ8208sNJQOo0HuHpyTLQZN4Yt6p0oBOJdx3nQsSMShT6BoiD+zDGUS1Mg+CjF
         E9OX8axZwE9jSmwNfLQqtgLqoLSVG7+r+T80xAWT8EsXgYxsnfr82+HypGvszEivnwDw
         tHS2s+mPQBMJGXAJ4Ls9wFSL3aFNL8/N/tX3TEeiFlvlyPbbAuFdUGAsztxZ+F6rsvmT
         bR4BzRexqFVrUTxZVhKOPVPkcEUwLf95biQQrBmEolwjfkEvYuWBmL8nTyWd8NPz7z2Y
         kuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883843; x=1772488643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mc+2JM9mzVfHLoEtVQbn4jvvZEFjVrivm9/PyMFwuiQ=;
        b=ZZ6vlM5C7k7SvVo2S9etIPkcq/biNy0FG+HECWNQAV1TCfMexCOYNqBNojbo0qFXri
         JonT0jnjqtv3dqp7DGKsa9p47Naq+eAmOBWCkERlva30g+Hmsq4EHA9JXgPhyWLAl02S
         Bfrz6fFn5YYdVe/6GnUEL977ZOOjcJJsn7zJMC1nDQ3IIyUAGk5y6bWmMgEHza15y/uh
         0cT+KTiGTX9IOfJxWpza/gKsURa82iMJacjhdSLFrU+SAw80sixL5v9kuTTsAZTR/Bj1
         HPHzI11Y85svEv/xnaxo7hHoux5bFmtzRr1bpXEB9Y5fE3d5oSpgWxR/TM31YTiKttK2
         lSqg==
X-Forwarded-Encrypted: i=1; AJvYcCVdg0iYbX/JQbg3Xs9N6kNxo8G+NnaAuasbqEv/dZQ4lWXh9DzQhIUsO08QlnY6EfKwYmXFVD+rRAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdqTrapL9i1P34U5MbmO2r/kFC8DBgg1kv/o6/mb1JsEsLNW7
	JcUwFEJZXlq0wYYeOuLD4d2Clt2YeE91MqRCD1UlK1M+Fwccl/wyH4rY
X-Gm-Gg: ATEYQzzsxn4MRLPuucAJdrzNnqRW+xdK0jcPw0RZi26KUurIo8nLgmY/XU/+UhBXuVt
	DgW/YuYPGkx2mMmYW19R8yGCjBFRj2qxhNGJPBwAAeid6LaSkrXB1ZUteNor5637M/1KMifECx9
	CzOSvUbq31FS4EKDVoUPFFMYEQi0Iv14eGKuEdzs3PVViovuSo0gl1GqnjO7OTdK3Xk1KwriPq/
	L6mHBMX87HTSxp8zwAtOoUiMX5whHZH2Kjrx3ChNZgvBZ/NrJoU/HE3NiI/8bCLuj6i172I2KXE
	KMZtwQ9Z78U5UdIcdtIMH8jRWoEgWAxyLzVyULaamXDlU1hiqOmAZudyCOv7xdLHSgI3oo8MRKy
	U3G62VVOnJH2Uu4SP/8v2BgVe0U2DjFlP9g+bEQNmUkjOFYJLa0qjf5GLKQbXRvc5g3VR6cyk6b
	Z51Jfd+lK4wtHGYLYygiU0Qg==
X-Received: by 2002:a17:90b:4d90:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-358ae8c2d4dmr8551876a91.23.1771883843464;
        Mon, 23 Feb 2026 13:57:23 -0800 (PST)
Received: from arch ([2409:40c2:5428:afe:6feb:bc4:5ef7:1700])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358dc0092d1sm352772a91.5.2026.02.23.13.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:57:23 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 2/3] iio: frequency: ad9523: avoid multiple line dereferences for pdata
Date: Tue, 24 Feb 2026 03:26:35 +0530
Message-ID: <20260223215636.18606-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223215636.18606-1-rougueprince47@gmail.com>
References: <20260223215636.18606-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform data pointer dereferences for pll1_charge_pump_current_nA
and pll2_charge_pump_current_nA were split across multiple lines.
Bring the dereference chains onto a single line.

This resolves the following checkpatch.pl warnings:
WARNING: Avoid multiple line dereference - prefer 'pdata->pll1_charge_pump_current_nA'
WARNING: Avoid multiple line dereference - prefer 'pdata->pll2_charge_pump_current_nA'

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/frequency/ad9523.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 5725ab62e0fd..6daa2ea354a8 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -797,8 +797,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = ad9523_write(indio_dev, AD9523_PLL1_CHARGE_PUMP_CTRL,
-		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll1_charge_pump_current_nA) |
+		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->pll1_charge_pump_current_nA) |
 		AD9523_PLL1_CHARGE_PUMP_MODE_NORMAL |
 		AD9523_PLL1_BACKLASH_PW_MIN);
 	if (ret < 0)
@@ -842,8 +841,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	 */
 
 	ret = ad9523_write(indio_dev, AD9523_PLL2_CHARGE_PUMP,
-		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll2_charge_pump_current_nA));
+		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->pll2_charge_pump_current_nA));
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

