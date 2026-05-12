Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90333A7F69
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625146; cv=none; b=oqHE2UmqmOtR7UHRVdYr5dUAbvF5BBdAL0mekY/p0TB8XgbIqkTblk6Q6QXuHInmQH8THEr3wp7gfdBAZBuG/hdm8qHinhlDP65NSesdb+qUhZxG1OLz1cNRiwMX29RsnnLMkqKmOuRq8PxJs4mmoAR9RxKuVizksmPE/B+W9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625146; c=relaxed/simple;
	bh=Ypvnd0yZE4xn5uhz1eYcWrsIAdyROX4VSJlgjqYpqbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5uw9Ipr916StYcozWpMUyzqiuhllhtC+oisCGDzfspdhJywgpgOCO5y1uxik07w2fINS2PzV2mi/NRwou/gq9NCc2aZfHWm0kH8vfyoytDV43LdoOSIFl3NwSktv04doVePzjLebw7i8BNIMrEaqF3ifoUCLMDVgRn7iJWRkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiOHJVoQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiOHJVoQ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso69646175e9.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778625143; x=1779229943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yma1oPBkehBK4buQzFEzmzdCN8nBmPqJCgl17N+SFiw=;
        b=aiOHJVoQz0SVhd9yM/Kh/PWH34xwauDjW1lP6dvlbIUaMruDFvJIT6XDmnV4cNquyb
         e9A3KLaea0qWB+f3YUAdqfBYTifGPUaBFU2VY0j+aBNVbvpHfn1vWpZJbtpLMc+Q+GFo
         RMIrxhfgXJaVm+tMRvAue1NjOAMNjo4ii11T25+/UyXYqqau6MdFSHmaCV9DTOfiEgzp
         lnq3OAYRZBv6xRkH/ToiB8kd0z+Z9CVWaQKMFUYcJE9bzQz55XeTLMkJsjmpKLHfs1s+
         OWyR9lLL4d+uJ5p0E768k76sPuPZd8QSzo30jj9Edrj9kL0Nq08e6YfQx79CZfmlsyh9
         OPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625143; x=1779229943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yma1oPBkehBK4buQzFEzmzdCN8nBmPqJCgl17N+SFiw=;
        b=R/R77M2UHTfCDJincRSKCY6igkZhjpLhHmIFCvcAtzt+bfx0UtmhWTuJbwndBQJkQ1
         OVlWJ1OzL0EK7mj6OhzQflwsLYw1iPB2nvIfHti4eVsJOSKmgvjfYW0ghnkB2EBw6fv8
         fdZtLwyRhdf9JGvFOnZYif4Hsnr200sjkStUXXAm2mjInNrABhrWoQ785nTu+p6s22ke
         s+d8BDkvQFD2VYDI7Yxh0r11Arl7JTiSCCWSUK30zgEJbGSZIabacK1P87D39vHyp5e5
         0CN34rDW0LAJPD7vif8QhdbLLVKijGzGo7ZysaP+2owt/xJC036eCdP6dyrhNPXqeNtB
         ioFw==
X-Forwarded-Encrypted: i=1; AFNElJ8C1BtTQb2FMNK+PsH3pRE9I7ArWiYVsVHlQeC+9UGE9sKXjvfMi07tCVUnUJzW0E7mFwm6x0NkwbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VaJ15GOOPruQyxQxt0+PkmploW6F2dQW4u31z7MLubQCn3RI
	Ll5cn0rtyH7Xik3y1vWHEzdLG7u20N5S2vpJwsl630oV4kObIfDXdY2Mb04seA==
X-Gm-Gg: Acq92OGX8lkguCYR3NYdwd6irL0x1lMpqeoMTRnkugaOwhJRjNuEuNO9ynC1ta4HWq6
	9V2Y5DCvhbXoVfTvvLzZcyot+iU7HtiU8Yme4Ez40iIsNkvnkHP2Lqef99wUhejp2ak+hSfbTsU
	cxNx0MRQXMj3QtoJctNoacoO2jF07zq213aFG3Y9CmNg+wpZ9cWwOKF3qhxPib2e4Q0EZ/bWO4W
	Rj6MajxmqaXCiUZ9IqHkCw6DQRbbyOiHtNkGyjQNb0PPQM43NiBQpn7XS5MxSQ1P/P4HAEC6tId
	/SPolvQAXsylkKbwFL7Vxi2iyCo/HX4Lh+71iLFkkUSqtgfDTHONNAbOS44oi+cEL6I3bfQkX/9
	fH6OW/5U4E9EXHzKMQO6SAuOnI2/i39WwMnqfZJM94etXurlJg2egT9Vm1YnS7sjBH7ibz+z40p
	FsJK3YGIAb2wg3pwCYNTh1qZkmrkduHVLOu9iD/hUwk64vYecbcz3eans=
X-Received: by 2002:a05:600c:a307:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-48fce99da8cmr566825e9.1.1778625142927;
        Tue, 12 May 2026 15:32:22 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm47377375e9.1.2026.05.12.15.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:32:22 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to default case
Date: Wed, 13 May 2026 00:32:15 +0200
Message-ID: <20260512223215.25596-6-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512223215.25596-1-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the trailing 'return -EINVAL' statements at the end of
tcs3472_read_raw() and tcs3472_write_raw() into explicit default:
cases inside the respective switch statements.

This removes the need for a separate return statement after the switch.

No functional change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/tcs3472.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index f8f70399a4dc..4ba2def244b7 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -291,8 +291,9 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
 				cycle_us);
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
 }
 
 static int tcs3472_write_raw(struct iio_dev *indio_dev,
@@ -344,8 +345,9 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return tcs3472_set_sampling_freq(data, val, val2);
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
 }
 
 /*
-- 
2.54.0

