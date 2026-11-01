Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793525025;
	b=Bs+7KIv7IV2/mEeavFYmD8id2yaeq4WHYopqMDDvJmJG22GNe3QbTgELinzxMAzNwh6I
	 vZK3e0WMXbpawklDR7mg6k7BDwc+VNmalsqk3KFYD3pQa8c2SnEyckvFC8gGuvEoS9fgt
	 6dwqIpdof/Mpp3ZCu6tEvOC1gQuMX3l9CwRBLDy3g8pKX+0Hi8KPgNTbrJymFWrHwPECl
	 31WGPUapV46SctA0I9+59sCXHG/zldCaloiPDe8o+Sn6d5IfGdXMWPOWd5eeybU7+LmCD
	 vzasmu166EEdCIwPoQbzccN2f8m/Z0YMdh4r/PWoV2fOjbK6dBP4fP/Xh8wLoRUQiwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793525025;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=71JQCGpn1mJWrRV3XHq1yw0fBtDVlykSsHEtsfaSReM=;
	b=a7UCdpqFiFMRYkzw+0mNfRJJsQI4mRMgfgq9ADjObhyefOHmrXCTZjg39zZa6/h70EIW
	 ahQIfoP9tyNBv09AoXzgU/2k2T/LII9xmkGcM+U+ndDZKHlWP31QRTPCLaJ5YHSQYRt66
	 xfE9zkTbi0licB1JQvwrmc8hssHVRfIdlG2aV/939Qhk2C2fLXXmRo/AcIupqahCh1Mmw
	 IK4dLr7IgQTO4DIBep1if9UUBURauoApAVFx2AedTJXmMmVKcPF/bEJ3n3dYP0wsGdkVq
	 Dq2ArOaKguleEvuxuV7FX7yzkV64VIm1WUCa6+8EUvp1XT1Y9LvA/Z1rxs2eoKtA2vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bqSKMgWv;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8C7606A324;
	Sun,  1 Nov 2026 09:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D8C7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bqSKMgWv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bqSKMgWvxy/RqAXe2sj0PDteF1lpnhvzEK9uA8h+oQIMSF26R2CCXY4tmsdWM3oHZgfU6r7TQvxV0
	 09b347rlQISD5s0P3+yJYJA0sDew2EcexNUlugSxD8wCDQr5hMOk3Lqji2XqbzDni3y5bTVgoEIMEb
	 ffqVHZghQ0rqHAMU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96ae7050fa9d-84804;
	Sun, 01 Nov 2026 17:23:31 +0800 (CST)
X-RM-TRANSID:2ee96ae7050fa9d-84804
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[112.22.250.195])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae705103df-a5b26;
	Sun, 01 Nov 2026 17:23:31 +0800 (CST)
X-RM-TRANSID:2ee66ae705103df-a5b26
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org,
	linusw@kernel.org,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v2 0/2] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Sun,  1 Nov 2026 17:23:25 +0800
Message-ID: <20261101092327.197-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261101000404.41fe1028@jic23-hlaptop>
References: <20261101000404.41fe1028@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thanks for the review comments on the first version.

This is a rework of the runtime PM refcount fix for the mpu3050 data
ready trigger, following the review feedback:

- Patch 1 is a new precursor patch that splits the enable and disable
  paths out of mpu3050_drdy_trigger_set_state() into a pair of
  separate helpers. It is a pure code move with no functional change.
- Patch 2 then applies the fix on top of the refactor, so the error
  label now only lives inside mpu3050_drdy_trigger_enable(), and it
  uses pm_runtime_resume_and_get() instead of pm_runtime_get_sync(),
  which keeps the usage counter balanced even when the resume fails.

laixiangwu (2):
  iio: gyro: mpu3050: Split data ready trigger enable/disable into
    helpers
  iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable
    path

 drivers/iio/gyro/mpu3050-core.c | 182 +++++++++++++++++++-------------
 1 file changed, 108 insertions(+), 74 deletions(-)




