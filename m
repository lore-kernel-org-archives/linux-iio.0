Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452785;
	b=euHYXfxRyY6YaVTTgSt7PqB2jKYo9eYjnwRHLeUcC3bhodprJGdT0oPrcE/CFgQoq9+j
	 GoDbE9OQG+lwOT3cnrMG1zZ7xiqxc2Ev8qBaxNCiWtZOeW7uk3iabw0iJ3nlGNU8m129R
	 XX0zuqfnC0DhDrz+nk4WSUN7nBLXlk+HUJtpN/oeNT4d+mRU5bz8mP4Bqt5yWRmZFhGzN
	 Li2NUJuWb4yShQm935H1j3CwcGsSo/V2zmH2IeNHBsw8JyYl2HtcUnlIYpXLo4bVMrZe1
	 L/uMvHTAIbtBylwYX7wlVb/bi/4jxEYP0EW9sNJzcD485oNHNDrkxANSKrJwXNjPHjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ROav2NeqSbzB5BYixiJ/XiL62TG6L02nYYk25SHoeS0=;
	b=p3yGO5o0wtHtzN/yXTO1UoAEdMGbRibK8fe41gPz0Zh3sT8+HW35tz3dShj/5y1cleyr
	 O73cCk3MWGia/Fl9VcL/nBD7JbM3s3vfpnkYvtjh+ABQ9zH9FYPEpS7lP6MQR6y1+0X2M
	 C93T8/CTJbkXqYLFokjNjudi57DHIOCGMqLRhXB/thmVVfen6qp23c9hLhQ+uQmWE/UQW
	 FS7yw9akl9PgqIH5zv1SV81de/7N23tMAsQDAoeroOCtalxclj1Jy4zFW+E5JTQjshuf4
	 Tw5cRz+ZeCjGgFJREojMhG/GQyYnWSl0U+Ha/6LePyhPFbnii6jMNyTzpNSJQcCtacA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hKmpdOlL;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB42606A327
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 16:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB42606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hKmpdOlL
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3282db206d3so10489757eec.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452784; x=1796057584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROav2NeqSbzB5BYixiJ/XiL62TG6L02nYYk25SHoeS0=;
        b=hKmpdOlLdUmdZb23Y8BQJiCwpaasGgN0pAC254aazMxKHwQFlQtXWbu7qC4zxbvh1z
         2jV8b+rqhrl2XpTm3k+0eK3Pyz3cQ3ObP/Q4E+luVllIkxZeztg/DUEwWsJPs956Qnuq
         RLVEXxX4Ec/BDu2gBV7V7mNQzg1dzT2/4Baf0xGCKMg5kf2m41k8L9+nVAhhQEFz8Wxk
         jWwr+PS9Odn1EtMAv4obpHXAirDB1pKrGfI9l/rJfSKoPaVcdO18s3B9QaStPLO3Il9K
         wrU12Sh9QNEu1I15iX2mtnHOWLfUH67YIR84/nKDk4ucaXWCfxqxSBZsL9DwRg+ymDgv
         ds1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452784; x=1796057584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROav2NeqSbzB5BYixiJ/XiL62TG6L02nYYk25SHoeS0=;
        b=c0rTI9NJLPAfi2gvPNq88zWoerLFqkLip48kxnQ9ozyMbmIjcXFcASsxhZmfNFPebW
         VHiBLahuue1Hw+eUO70ELYlKXFdzxAuukZ6HHmTrkAFgh2N32nhemDJL5oXyRo/bxkIZ
         B4qHJ0qVK1P1T3766mrhCr6CwODqlBKzPlS1TeJajWwxRHX9DHANY6Lpowm05osJjrRb
         U0DgjOeXw2ahoWb8RxiAAxgco03di9XHjkcq1HgTYHKDLAdLsrOKuHR5PRyv2XuE0NdP
         /MOhQZso7VNaMk3qMCGql4rEAZc9TWMxIBkXb3JT1k6F4qWpKoMqbqvOAFr3sgNG8MeA
         HEwg==
X-Forwarded-Encrypted: i=1; AL+hErGtF8oywGo789LwbAID/aoCkBaVPiq5RRDm+GhFL09vHc0ARi8sQ+qVhVtRDklgCwUQYz2TkmO00YU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3LASTmfN3QDaQSiusyikap/DSJzseYPMmayhEKoucRMsAN25m
	MicUuiqJRofc+xzghE//UUbLkjyMVtCJQZG+SAcFqGLrrBU7V1ScrioE
X-Gm-Gg: AZFdTZcFCqC0V2pKLumKa6x/X6+gF8ZohyL7EYrhma++GgWqwLoYn32jYzunJI5aVpN
	ZdE96JlT4WvGXb5gJckzSj99W70hvcO6oi4guXVvgtJFLeMYH2mT96U4rJam8938JlD442cKPnY
	VsCA/+5biiY5B9733VjXIfTI+Sk8m7a6c+as+S6sy1K04mZ7OwXpes1EYaPywrHrnTtzHxXv/2l
	EssXKAXuHi6C5KtOSortOu54ouc/hbijwvFrnATStsF5y5wUTkvqemsmnoJI1vE/dIHyRLsw2r5
	Rp/aiq/Zlj/Yb/gayGt4GIpruOqXMiLpbSszKE5NLPen6F+irB18oEQfkY2IvpYdhfQPI6GA9BC
	Wp1/Za+pXJeUX9NevLzu36v1sy8WhjDT+L6DFQDNpMSFwqtxCP7TJBCTOxzepUIIRE69s3vnr27
	UixezD9VcvVsivFDKHF9ocWH1dzI8AtFP2oLSvrZLS45RSxXky7dBe1fjPWMKJ0AUMS0zCgapKi
	nTCTfnb4Fp4NvOyYoNg/B056R8Oba1uqI9rSHSQas8r40TwPlHINdHDKDHmKx1gkStwNMJCCHzL
	K84VBaw0u/ZzIJWe4jDOJyM1qb9LlP//eknW3pYUw6C5S6g2Gu3xJhhjwGJyPuzN4H5Wi9VhhR+
	VeNFYciEIG5eVGuqlsw0gbx4q4Vz3c+Bl1Mh5WJr2f6IdHbvoZT4qvFsoh2SzkJdnzHhmf5X3v3
	xjkIwFRgDpLITGX0iJ+Rjw/EAha0RxzefjL/h+A08U5A==
X-Received: by 2002:a05:7301:6582:b0:374:e25e:a533 with SMTP id 5a478bee46e88-38570154017mr23142542eec.35.1795452783837;
        Mon, 23 Nov 2026 08:53:03 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm47196668eec.5.2026.11.23.08.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:53:03 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 0/5] iio: proximity: hx9023s: fix sampling frequency, resume and event value handling
Date: Mon, 23 Nov 2026 22:22:46 +0530
Message-ID: <20261123165255.239490-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Five fixes for the HX9023S capacitive proximity driver.

1: writing 67108864 (or any value for which val * 10^6 + val2 is a
   multiple of 2^32) to sampling_frequency divides by zero: div_u64()
   takes a u32 divisor. The check added in a318cfc08537 only catches 0.
2: reading sampling_frequency indexes the 32-entry period table with
   the PRF_CFG register value unchecked; the configuration file loaded
   by hx9023s_bin_load() can put any 8-bit value there.
3: resume re-enables the chip interrupts only when the trigger is
   enabled, so threshold events stop after the first suspend.
4: out-of-range threshold values are masked into the 10-bit field
   instead of being rejected (-32 becomes the largest threshold).
5: same for the 4-bit debounce fields (16 becomes 0).

Patch 2 assumes the whole PRF_CFG register is the period index, as the
driver already does; I don't have the datasheet to check whether it has
other fields.

Applies to both fixes-togreg and testing.
Compile-tested only (W=1 for every patch, checkpatch --strict clean); I
don't have HX9023S hardware. The divisor wrap in 1 was checked with a
userspace copy of the expression.

Arnav Kapoor (5):
  iio: proximity: hx9023s: fix division by zero in set_samp_freq
  iio: proximity: hx9023s: check the sampling frequency index
  iio: proximity: hx9023s: re-enable interrupts on resume for events
  iio: proximity: hx9023s: reject out-of-range threshold values
  iio: proximity: hx9023s: reject out-of-range debounce values

 drivers/iio/proximity/hx9023s.c | 35 ++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)


base-commit: 793d80b04b6c4f7f896c273567f94eccd0fac54d
-- 
2.53.0

