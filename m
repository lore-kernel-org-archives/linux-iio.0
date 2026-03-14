Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1F31716A
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508013; cv=none; b=mZ0NsG9iPl3ZZ9u+TnfjQKHsuLUc3I1XxDVLziSmGpE1lVQLye5q8EL5WxdIiFzRLt6pHjIUDIN0AB/6zdTXg18/323f+6nltFucVZcBtGtphLdPEUkrBf25uTGK2WMvUSJsMML2Ssmy+19SDyl8CoBvmKlNboMAagm5eOXemHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508013; c=relaxed/simple;
	bh=t0qnLmmT+rU/wbh54ROxtKhP0rgu5jO91amy92nisNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8nqFL7x7W385X9ucJrCRN5mb+TnPozRrSgPoqPTn1M0o8vc04NGrtWnke+vWKq9u//c/8mhUatbYfsHf+1L7mwD3FKvKlVaOlSEcgQbc0Ee93YyLGJb5lL8IUpqK1kbEnmnIZNcif5B38s1MCLyHXIqDrCeMUdnNA4ERbzZRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNb6DY7L; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNb6DY7L"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1365767a12.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508011; x=1774112811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIjsSYZv2dnX/t0vzXl87KzE1YBg6RqtsQz/BB9ZtE4=;
        b=WNb6DY7LYCOi6oQAP4AMgFfE+/rfJHGoUkQeWQsX61cSNMI9+D69gNY93oSM+/KmZi
         5kimxEC91cOuuc+AfogzRsUmT+cTywCa7QfEvy11tKusnLhnCDXxh56KrQOYI3umTNcp
         elvf8toejs2FqmJpWLtP+6HmD8469Zq8PpaWN8g+oeFsywxFj0vLH+LwhKT8Jukk6tdI
         ZfbjTxg1RR81A1IfJA3q3h0vYM81ZzaMmhn2J6kRwe1B031kxTXQB3OI+K5VjCcb5y2p
         VQGi2ulNafQhrwhnK1P/zvuYTU7gS57EfGflG6nTMH4rnXMbHTKg2DtNt3PWulwW45bW
         X9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508011; x=1774112811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIjsSYZv2dnX/t0vzXl87KzE1YBg6RqtsQz/BB9ZtE4=;
        b=cCYZvuQtUOJtkYln23HkbuJjRpF02+65n7d5rPs9VAzIDvvAe1xh9zVQp1LZJ592JK
         8C8ZUywRH4kmZ2Lu1oDXXgaaV75Qe2vtDZRKqrYIKYFol+kQZaOfuz+UR46EvI+h2YQc
         8IJVS2Uj751HceqRmFek6aj1ynqyEMuxc09Y6ou+kmzRCyjlGjtM5oMK1AxqT1XBdmCJ
         E9nH4Ov8fnbt+FahWsB9w5N9huDDZj3qysCWnBWmYBZKbqcENP07L6xnUDTG1wBIQCHw
         ue448rdBcfAEMGlSs893foIbqcoMir0aMy261rdjaODMfpXZ6UXNRsPb0FZACBacJAZU
         Ri1g==
X-Gm-Message-State: AOJu0YyDtmhce9JvSOORbkBXlKmOHkm7NEUJUvvFe3P9YeBS1euDm5wg
	hoUsecLNJ+0fetkqCI88lZDv81GBmqkXjeZxsc3Gf6KHFNe1AG2YZWyF
X-Gm-Gg: ATEYQzxLJrj5CGiBabhLi+o98OLUnVBd9I7EHC83KHXLpaK95M24mTryCxDdZi1gOaS
	zhp7UxapEO2hNsFj7ey2e2oaNmiAXC3iTTvybzh/LU0Wcz9XNK5wjzVcFlWf2vDpC4WsNbUlw4F
	gykSVt38LEbc+av0rsxtGX2CVb+oByvIHzn4BDLZ0XWdY9zvb06hqvj2jrc0YHn7padaf66Tf5t
	2tL+ph1gUg6ATs8/Uha10VVzlOyLL16bz84ljp0U/c/wC4BQ4KRCfDsy8vEWFCf7Vz/H7W2K6Ek
	z238w6SjhKiDwUmpaILQoplZU0vpYujucqEG1OshTPsNrHblSTngw7qWjSFYOA1sb5NDQeu2O5F
	e0yiSyjhkFe3nXEcwqzoDO/r7HBMKzHZ69qng6WyJsC56SYOOyc9wvRqz3XGq50sWBAvA7BbjL6
	mxicaB7Xl2yNMqWVnSpu1+R5wYuPxFX5BycMfqEJ+gQwc5AspmNngYuxBrIpIxNfpV6ymtxL7x7
	l+PGDrRC5wesvjZ47WtA7Scr6Y=
X-Received: by 2002:a17:90b:39c5:b0:35b:8d89:71a2 with SMTP id 98e67ed59e1d1-35b8d8980b7mr1739625a91.33.1773508011221;
        Sat, 14 Mar 2026 10:06:51 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:06:50 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v4 0/8] iio: accel: convert to guard(mutex)
Date: Sat, 14 Mar 2026 22:36:01 +0530
Message-ID: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts manual mutex_lock/mutex_unlock pairs to
guard(mutex) in two ADXL accelerometer drivers. Each conversion
also simplifies error handling by removing goto labels and
returning directly on error paths.

v4 : Sort Headers alphabetically

Link to v3: https://lore.kernel.org/all/20260312081942.23858-1-
rajveer.chaudhari.linux@gmail.com/

Rajveer Chaudhari (8):
  iio: accel: bmc150: sort headers alphabetically
  iio: accel: bmc150: convert to guard(mutex)
  iio: accel: mma8452: sort headers alphabetically
  iio: accel: mma8452: convert to guard(mutex)
  iio: accel: mma9551: sort headers alphabetically
  iio: accel: mma9551: convert to guard(mutex)
  iio: accel: sca3000: sort headers alphabetically
  iio: accel: sca3000: convert to guard(mutex)

 drivers/iio/accel/bmc150-accel-core.c |  38 +++----
 drivers/iio/accel/mma8452.c           |  38 +++----
 drivers/iio/accel/mma9551.c           |  19 ++--
 drivers/iio/accel/sca3000.c           | 157 ++++++++++++--------------
 4 files changed, 115 insertions(+), 137 deletions(-)

-- 
2.53.0

