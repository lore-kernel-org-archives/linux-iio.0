Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C31F9ECB
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771206902; cv=none; b=CtBReaBTHkFJuDzsHBpnZ87NgBtcd81jYTIW8DELmulpx4u9KsiBs7QbxXl6F7Vose4684KlXmVv6Zmxghdy8Wh2FcQ9f0SdVKotxemS+UZnAvUayNaBhU/zkREeNUGR4j95Us9wBv1QkGC0fR0KrmOi7QJjKJMvf242IxDJ8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771206902; c=relaxed/simple;
	bh=AtkeVHUF/lYUvHs82Nipd25ajUsBlT+4X0Pewe8HsTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7Fa9k3Z0HYGpwVrb89irau8mns/pqWZflIcukmZn2WlfmREsquggfY7ZxnG8NJKY7XV3zaky6luyK3KpCs9dO2gPj29CbzLwcjvw0aeLwXiQhu+kW0v8fOaRPjgvexqQFGNqfzigA2xWzaFdXwZD+ZBka3KLZHgtpzPRcNUBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATrHElGU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATrHElGU"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a297c14bso27551571cf.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 17:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771206899; x=1771811699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6hZl0LUCcfqkVOzwFdHZtri8i6KNb+hmFP1oKEdpX8=;
        b=ATrHElGU0VW/meUsyIuKbbwl0Kv7bWE0rja8+zOvyeNX0nhD31Dhvj2F3c3kIZSSqV
         mc0fVACJLrVITd04TFdLXiJQz9HA6yaSmA0H0MNCVJMifAGoSON5FNxkdfxb2FVQIo3D
         igXbo7gk93qwGpQs/lskhbd0VsWP7Td97V3v3cOzoDQsYi7li3OPYyEWa1gwl/pA730Z
         +VSRS7eUgMMApdDEGghXUxK1/x2htSG+RO555cB954WSQphPCDyIzu8NztVFS51+Id7S
         ZPmGAYixKry28qSeh7mzMuF9D3SXGYiFlwtoqlX/mI7LVFgKWRwSibQGghVq0vieFhRd
         VfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771206899; x=1771811699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6hZl0LUCcfqkVOzwFdHZtri8i6KNb+hmFP1oKEdpX8=;
        b=LYep5Vw9gkpzCXSoVkg+xQjb5m1U3fSoA9LWpGpn94obuo/MAKn/dcxTXDYezPaBru
         9R4TriHOXyouUcNmEVVs9zKGbPjEj6pLhuZhZ5sfpdx8OJ/Uk4JSUKKXNXlTQA9E6cKX
         jUgGLdNMzz39nTstMoFSPDuVeQ7ahZ4vWqPGtKJg5dKOSCbEoCVfwu7FGYDJygAHJJKB
         Y0ax4lgLasQ38+ZOPg06K0fM8hCWDwJb5ldUfj6aBs8qF9e9Yqgn3JevN+NdqjtyNXkr
         GA8M+Q9S6qrvgpGa8GK4ApWCdZQivIbzmCogmgygTjtNcMGA+4D8kjQ+w2b27gCGQ9H6
         Rd+A==
X-Forwarded-Encrypted: i=1; AJvYcCWEjbuGGw3VkP7yTL6BBeGnCpbLwaN95WO/LnhIfFmhibYEgVYy15HkJmkvs4NWYrWXkN+nkzsx92k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JWryBs29OduMsprU7Kf+e0xLojliaoGTbGZRVhPq6Bcg+Ghi
	5W8Fo3OHfzsOd9iQlaznDp1A/NyT+KFt0w013X3mjYSvGNAcFh1wMN42
X-Gm-Gg: AZuq6aJwK4G8dAh5ubKWu1tJkAm+SKt9DNCDSSHz+bObEhq91m15y78OjCzsyeqmmar
	qKLm4IRke/lYz6pHdjHuXsXOn/3vGggpoU7KGYSRABVPQUOUWs5GQnGeXTwIh6y4ya7wbWZPKlX
	j8dy3RKz5y16RVB5ma98RF9WxPz5oM8ta7dYzSInGpu33kegB/cOuQn75oJdmW1PpX/yQorqVtC
	Bw/Few19TmtC2nAIYmiCpyoD9Ea9p8f6se1rQpgaLgYC36urpJ9HTxa06gFdVhKmBhvAJK+Ynpc
	LqKyqQu5//9x4sO4YSRnyLnZ21ir1r0ftf4ChovP0PJNtZ0ndTpS5igX/RbPQDTTLAaZ48DoV3P
	Npx2f/Yzn3Hd7BRRZVYtd6xUWzX7UF18yvkxuD70IRLS6uZUWuLhwpSShuczFOacwqkuJBhFaX+
	XZADCYO3CQA8HzdIp/uBf/+m1FfA9VRjx9SkAE6gL6LiKMAvCg3PiT
X-Received: by 2002:ac8:5994:0:b0:501:4e87:70b2 with SMTP id d75a77b69052e-506a8379fe8mr130962531cf.69.1771206898573;
        Sun, 15 Feb 2026 17:54:58 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506849fbb9dsm126926161cf.15.2026.02.15.17.54.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Feb 2026 17:54:58 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v7 0/3] iio: magnetometer: bmc150_magn: cleanup and formatting
Date: Sun, 15 Feb 2026 20:54:51 -0500
Message-ID: <20260216015454.61836-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the bmc150_magn driver in three patches:

1/3: Replace manual mutex lock/unlock with guard()/scoped_guard()
2/3: Replace msleep(5) with fsleep(5 * USEC_PER_MSEC)
3/3: Minor formatting cleanup for initializer lists and indentation

Changes in v7:
- Place cleanup.h include just before delay.h (Andy).
- Use guard() with case-level braces instead of scoped_guard() for the
  IIO_CHAN_INFO_RAW case block in read_raw (Andy).
- Apply case-level braces consistently to all case blocks using guard()
  in write_raw (Andy).
- Use guard() instead of scoped_guard() for suspend, returning
  directly (David).
- Keep samp_freq_table as one entry per line with fixed indent and
  spaces inside braces (David, Andy).

Changes in v6:
- Split fsleep change into its own patch (Andy).
- Use scoped_guard() instead of { guard() } for the IIO_CHAN_INFO_RAW
  case block in read_raw (Andy).
- Use 5 * USEC_PER_MSEC instead of 5000 for fsleep (Andy).
- Restyle bmc150_magn_samp_freq_table to group four entries per line
  with index comments (Andy).
- Remove trailing comma from scan_masks terminator (Andy).

Changes in v5:
- Split into two patches: functional and formatting (Jonathan).
- Use fsleep() instead of usleep_range() (Jonathan).
- Use scoped_guard() for short single-statement scopes (Jonathan).
- Add {} scope for guard() in case blocks (Jonathan).
- Leave trigger_handler unchanged (Jonathan).
- Drop all unnecessary reformatting (Jonathan).

Changes in v4:
- Extend guard() usage to all mutex_lock() instances in the driver.
- Replace msleep(5) with usleep_range(5000, 6000).

Changes in v3:
- Add Reviewed-by tags.

Changes in v2:
- Use guard() for mutex protection in bmc150_magn_data_rdy_trigger_set_state.

base-commit: e7aa57247700733e52a8e2e4dee6a52c2a76de02

Neel Bullywon (3):
  iio: magnetometer: bmc150_magn: use automated cleanup for mutex
  iio: magnetometer: bmc150_magn: replace msleep with fsleep
  iio: magnetometer: bmc150_magn: minor formatting cleanup

 drivers/iio/magnetometer/bmc150_magn.c | 142 ++++++++++---------------
 1 file changed, 59 insertions(+), 83 deletions(-)

-- 
2.44.0

