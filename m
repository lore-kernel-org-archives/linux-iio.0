Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68929A9C9
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694773; cv=none; b=SZL5/6TIa+9ub7bi+SnMwlU2lpSkEHOqxUGaOGBSmB0nHeiOKAPidFiHds07aug2G8JO/lDv6CFE5OW64Wv1CSLC97Wg6Zce2lV9r90w0sqhZ59sxi3TTtDbgzEOqt6RBRNWMhdFwAHJxXzoFBuviA3ADQo3vbjGfyqN9oF6m+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694773; c=relaxed/simple;
	bh=BdDrI6giDaid5DIqw4t3WZQKah8PsUxMwW2NN14GGNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vox9Yxr1Q2UV9cLVnZ1OwrnIQjoPZGqg59xpLx4gUkH4DPgiX/IJfRU0sV4OwKRERDM1WmQ9cUsNLR3EL6Kv96KMTotEFMynlbDQV7pbpr5C9IC5wa4OF2K3CA52xRq7AdjXttDGUeEofwwRgWSK5qz5ZsNv3XBWo0UoZwk6zoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrFEg5YS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrFEg5YS"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb49f63238so181958485a.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771694771; x=1772299571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMnqG34gLcv/1lkIYAnha5Ku6wD9Svu7hJwMHG4lOsg=;
        b=CrFEg5YS6yi9T5xPX9+0tVbcn2MMyh1oNRiH2HI0JwMIM4z76KEa3e3ycdCx4zUph6
         0VM1UStzCGlKznFxT3Q9kKGdGKftWwCmslnt7t0awocXJDC9nnmCAl3paO19vW4i6liX
         KaBcEj2qz2+0JBJqGpjemAn1Ihw5t320jjJ4e24i22JKXUYmeUfUiU3SXzq0ONHakvWK
         ExiETgm4oqWFv5cqXGUC1611n/7VXX5/7WVgT+KlG3sC9nyaP0hoOpOSjN7Kz272/xct
         JbFRBtqw+gBhlkzZL+8ODqa5sph7WWGNNjyNqm8Kx9WqhDpDjj74Z7zRVFQfe0BqJqbS
         eEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771694771; x=1772299571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMnqG34gLcv/1lkIYAnha5Ku6wD9Svu7hJwMHG4lOsg=;
        b=AxTZI18Vh/1pA74Xlm/dw436+w0HpYQoij6l7jPvVjWvPO1xDv4nQE1a/d/eUlRnYS
         +fJBs6wRrAG+Q8nzR1dsFObpCMz0ef4joJkShejwqenYOSocqwMhC2+Em6yufOkQX09E
         R1Txb4z6OpDt7T01zbtpRMJbUIumJ+BlhwhjjuVqv7Nt6sZIF52W2lr6bY8XU3UPZJC9
         smjCdQreoOsfRbtdzgV4V8BVDVn9FGPMx0ZaMydVCwj04FBfY2CgJzAnWcyY/yVPwmS8
         4nrNEzOIZ2J4pY0+AMgPjdvjOvK1qi75rDbucI8cmbd23GwqdPMIDLkSMy6/1EgGILWJ
         1Tsg==
X-Gm-Message-State: AOJu0Yz0WxXKYLf8el2H7Mr5/o+6GCHdK0wAWouUdwElWYGs85y7dX2A
	+0FpSLDeZln7BlhQ7j4+wqbyJFMOMDZKxg4ktETKnL/2sFEOZ0E57S+Q
X-Gm-Gg: AZuq6aIFR7HNFOB15U4+aC0xr/LucOxFoE5rX3TJKnQ6iWAmELsEKKS7LZ6ODFK30XC
	p2e0fm5LnJLABBzjxm+OP7IMYUmAzUlV8RdMxcOHmwZjKAncYqX4WnO/B5zC9OcemE1hMD5dxKe
	dpCv8drObjsXM+eQS7I+Nev3tKr2ZxWpnJ5proTxWpqNX4Q0in6j6279pbmPv7N1+Xo/wyKhnB0
	3sVcHX/GII1CtI6c+wYQ961qFy5eDFLHTmt13MCoBNl0zd3250OrYoVOP1DCCg0twQ+anS8m0+7
	pdfjpwtS3tLUMNDg3GAjOa9UbOAbMovXeiybbdeYGkzwcl3R3q9vfk+4sJMwBRLU56I1uvr10Qi
	pzjcIgdr6Hi8R6x9az9ya83kyeJCbqooEjeYACohqrEw2NatEmzOSQ26maJ3UMakWwv45233ggk
	BLxF91Pe+fPJr8xdiOXSZ2kKR03fSYAjRxk1pc218LmRg3w1l7kZSZMzHQsp9vbtgD3dKf1AkHp
	p++vu/j+aeioHOYz3NboM9qwFET0JRT
X-Received: by 2002:a05:620a:4691:b0:8b1:1585:225d with SMTP id af79cd13be357-8cb8caa16femr381828385a.82.1771694770741;
        Sat, 21 Feb 2026 09:26:10 -0800 (PST)
Received: from Mac.home (bras-base-ktnron0818w-grc-05-142-198-109-43.dsl.bell.ca. [142.198.109.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d108c41sm231416885a.42.2026.02.21.09.26.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Feb 2026 09:26:09 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH 1/2] iio: pressure: mpl115: add system suspend/resume support
Date: Sat, 21 Feb 2026 12:26:00 -0500
Message-ID: <20260221172601.77818-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently only implements runtime PM callbacks to control
the shutdown GPIO, but lacks system suspend/resume support. This means
the device may remain powered during system sleep, wasting energy.

Add system sleep PM ops using pm_runtime_force_suspend() and
pm_runtime_force_resume() to properly synchronize the runtime PM state
across system suspend/resume cycles. This ensures the shutdown GPIO is
asserted during system sleep when the device has a shutdown GPIO
configured.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/pressure/mpl115.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 830a5065c008..29794ce53bc6 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -244,8 +244,10 @@ static int mpl115_runtime_resume(struct device *dev)
 	return 0;
 }
 
-EXPORT_NS_RUNTIME_DEV_PM_OPS(mpl115_dev_pm_ops, mpl115_runtime_suspend,
-			  mpl115_runtime_resume, NULL, IIO_MPL115);
+EXPORT_NS_GPL_DEV_PM_OPS(mpl115_dev_pm_ops, IIO_MPL115) = {
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(mpl115_runtime_suspend, mpl115_runtime_resume, NULL)
+};
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
 MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");
-- 
2.44.0

