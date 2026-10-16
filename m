Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF53EE1EE
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151185; cv=none; b=fzTfOo7tK3gsHgNbXkblV+Wk1XKsgzUWEU5UXx3G7UAZlOcow554kxGZ/+4z9uBtLbOTDiMXdugSX3RDrJPjkQn/9liIsMANco9y+bqqGr7ql3vJe6k1h52daLOH2YEowglYk33hRpUtIUxsBBxDh6YpO3olUHUakm2i21SQXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151185; c=relaxed/simple;
	bh=XfgWy3OdAosQabJUNE32QEs/auUSjFc3Dhf5jJyET4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5JyP8o286sOkoDlUmKNNKcv5obqJEVtP/J4KmHlvyXW0QGUq91jrt2UoRNxl2GiX1olptBNbgA4q1zYXSf1+ePUwZ/GG2v/dB+x0HoRIzSlnAzkGsIyffBTskR5k5sCYd0ln2FNehT6vpxPU1dCR/o/7o9V1Da2JVxgf0wz4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHKSsPx+; arc=none smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHKSsPx+"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so2239486eec.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792151182; x=1792755982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2GBgJDeRRDTohR0y6CO9y/p1qH+zLQzeNlu49sshfs=;
        b=VHKSsPx+Eptqu6e0tD/px2AF39I2pXNl8E9L7pZDMpeDFXOmp+KuY6Pxu4XLSzZiDC
         I0YBlgsVZPtb6l4CLryEJ4U3UaCTqpISy7rJAQnriQjOQSZYEdgGNYmd11VFU0/bDTQt
         6KvkZWzm8v24VHhg/pkMUaIhjFrBviWqlgWaELaJZHRuLljWaRpVt9oz7dwrmP++Qhy3
         MjMrA2gHeFAyPfQNTpIUteO1V6jIATuXLZzWZ1EN1p0whVPHZWwP14j5gd5OhV6u026t
         u/WCjHDYyB1twVaDzucYkIgwBiiYT6lr1+WRdgMGvMGtKGX9jsfkzti8IXVMIQJ0rVbZ
         u81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151182; x=1792755982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2GBgJDeRRDTohR0y6CO9y/p1qH+zLQzeNlu49sshfs=;
        b=ctc3yXJl9Codr3xRsAzkWpaH9EP9PgphBljwEscIXq9QCQCwtNS4uTPIQho9omn+wU
         /p3j+v2t/dzNpZqyOy1hRiAO9wN0b5QE0uuOP+1an2fdlzIzFbe5fUROdb6/3fcJm6J4
         Rl9vRNAKQHgDQ3Pgtb9dxd/TiDVXAylWUqjp+iQN6t68VFOyhZCU0hLeFnu44CwsOLA5
         IbCL8ebmgxHaT3aJI8xCsEctXVDl5QCq4mrpAHPieblWwjKDOe2FuM6z0SVO2WBIpGLI
         0fYv/o7/PHHWxXyMtXSSeJKRCz1/7/qJeoNdXeMkl1nzrbvJeQWKA+bX03Fa/ukPkJxH
         EMiA==
X-Forwarded-Encrypted: i=1; AKwUvBw5MGny3GQ0ecVfGtTBI5pl1leNpxqyHM6AMwaJ8RcwAvhEIfugid1Fq7QmWoRKZNYyJd2uer+xnfA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJqSp8hmh4ytvl9kSoDG6QiK77cVz5+AeGQ3Su3pme82fOBAFI
	tIFleeLyZFAyAbX13ZhH7woE7cgKdcQY27ttyDRrGKeEk7FP8SSImU9HlQe37iZK
X-Gm-Gg: AYBFou206CxXZWWAKuMVE3/mCJINW2+PAx2PwtPt3t4S1sDsDsDgodp4Y22CcHA7Htw
	nnoYZbsD9L249uMdkUaNM+++R65jnAYi/Suvl1IT0doqFmTIT+73VO+1vyfoJJaslQU9jfSJo8T
	LmJLlMtcAx2fwUzazq+uzHD45X1Sdp0Q2PRr+mjF0SAmEqw0mmnBrHdYL2tYKHRwJZtU2SD/fDT
	y/G5RO9UuU09Hkk22zkz4ms3M93B+A20lLw1SpiD4SIze8HUe1zC4/AEyCghXP2+aERt/aUOpDG
	T3ONy+2O5ph7pIqcE72pF48dResuiWyoBUEFJ0hiQSSOqgAx80KAen1roHpqflw9YJwQ7c6EbRe
	4CZtNUK6Nn4XpBPvhaz7zUC4XFCyYctv6+nytHo2eJ/pbGVx0QyMXTnvCmVMLAXX72CJzZWbW0+
	Ds2LoZS+b8okleYrFOWQROoLI/sYE21NVioBGsoSHERsDIetoutpQVvobOtiyzOIigpkyK
X-Received: by 2002:a05:7300:fd03:b0:351:4866:255c with SMTP id 5a478bee46e88-3537e058277mr38968653eec.32.1792151181599;
        Fri, 16 Oct 2026 04:46:21 -0700 (PDT)
Received: from fedora ([117.134.210.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b63e1sm7330259eec.8.2026.10.16.04.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:46:21 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH 0/2] iio: accel: adis16209: add missing SPI and OF matching table
Date: Fri, 16 Oct 2026 16:45:25 +0500
Message-ID: <20261016114527.128364-1-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced old manual matching via MODULE_ALIAS to modern SPI matching
table.  Also added missing OF match table for DT based probe. Compatible
adi,adis16209 is already enumerated in
Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml

Shehryar Ahmad (2):
  iio: accel: adis16209: add SPI device ID table
  iio: accel: adis16209: Add OF device ID table

 drivers/iio/accel/adis16209.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.56.0

