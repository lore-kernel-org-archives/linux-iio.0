Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528729;
	b=G2w0s3q1Pev/50Yr0Nye5nwlKUxiC2nZbkbCsowkvlK1hGfD7gneJudd1664uASGnsZK
	 tiJax3h1RUdv8QR+6YITY4B1DPnvuxAx3B2r9BdFFTGU49Ia8FLITuKlWam+2+816KEcm
	 NsX+PQp6m1H6rflk0ZMtrz5vsxYbcJlzl9PQxvlANOZr8b0HVKnTBZa5odf3jFoL7lq5e
	 hDNDazubz+nbCEoTcwdopfP7o+0kILYuhZMM0E0DldMdEVTqhub+C5/siHi0WeQRcb8Q9
	 ZLmfM/BtdNzF4xUA/r+rzBsnQ+FTCPehX1qASgDpzwyBBFmuBvDFbcoN9jaf8XgDqhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=paoWbKvqLK3NcbGaFUKJSTzcpwiwtIw5MyG4/oJgE9E=;
	b=gWKC6clnfHlAAYhKAjUESnek6FBTlmxGMlcygLJ3PSD8LVkdwnSYtmzAbeeCn9jeDzae
	 IQX9E1fz7jbRiTskthNlHh5Ljl9JFChCfzuEZ3uM+e2eyQ/8pVdFNd39DBn9yjZ3bYu6K
	 8/rWT2GaosCUZ5XScBkYMCQE9fyrbGjhnzBcKbQCkOp2wJ5MAlyGJi3lEmmmh8z4VPQf2
	 E95EYO81pfy+rni1YX+8zf8i2ZnudBdl6/lASKnWe/tm48KXZBdm1MbUlHz7AXVolo4G6
	 S/j0HT7swcNu0DP9/TgFCl6gVXWznhucv8xtvWMTRaHyGrpXyjK+k7FTO9mfTNkk9zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkQZ+XJN;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA5606A324
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 10:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90CA5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkQZ+XJN
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so2106580c88.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 02:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793528728; x=1794133528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=paoWbKvqLK3NcbGaFUKJSTzcpwiwtIw5MyG4/oJgE9E=;
        b=PkQZ+XJNbnFgVlIDTRSgVWtEJWIYgUuYr996WYpbTC04fo+/qKtNRMvi44xHQJ9/6D
         P5XqmOJvq8Lb3QV8R+LLJm8W5KYnS7jrkIlHy+S1tLmCMBbktNcUxvz+EfJSUd2xLS8W
         sl2+LYM6Gv6lSw47at6Hw7PIV5t26I4p7gO8oDaBOkgyRPjfEBbbkFvEdDpL8e0kl+FH
         v6k1VdQIIQQuqLwqW9K29sO9CAyckMwfJ0Jk9FHv2Th8o6u1+0G6uvPv2PTGgUv1dcrU
         ho7nre1YGo59y1tGRehJ/PCO6GGkD6rlOx/XDfh67cfzYFeW5ybFUpp0vi+8Uorpb03a
         iWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528728; x=1794133528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=paoWbKvqLK3NcbGaFUKJSTzcpwiwtIw5MyG4/oJgE9E=;
        b=xgZDoyxXBoskmxA6MaRiey2Ia6onjsahakV909Iv3rfrRSQADnBk2ntX3kJJpkqBC/
         o5CBrMx3+5gsJQ6VZ0almMt3nmkCpb2ScJrls5YKlUeV7rt4iJBdVsY/tx1s8yXuFMMj
         xcmV0+WAJXC3q++Tf9s7U6MN+MRZrgj1mkmy85DIob3rZIlMCdEDpQZe6xUIcY9BHH2d
         uTBgIv8mEw8hp+IomRSPxjH33GsY4DVNRDqzxw+XBd99dFMS9GqXxgd0FeXRrSEdpl9d
         vpW5P9bK2JAQgDoAYWO0P/qTvkuQ8TK5ELXggz0/tqdOx6w+XJzRu1YrcS2JdPC9DEQD
         C+rw==
X-Forwarded-Encrypted: i=1; AKwUvBxvWNmTMxnie8JW2vSxRDkR/hP5YP2f9zGVyX75KXi11Z/78l8ywJIVapmgt3XsM5ET2dKkPmOzRCk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKE4SEn00dj7+Zt6FJtK6c5vi9HBZIn9DDgvH5b7CKlDeoIT91x
	o66w9H5KQZu5MUluNB/BQ2KJFN9bZO10beXizWR56Lie0Bp8FbFmre0p
X-Gm-Gg: AYBFou3AKaqqKC0eRQYqHO8Wm5qloYqdDKD4p7lRtaAt2o6Y+IqtfF0ZfuuXFnX7Jv3
	ucyvaMpjc9zGlDYeHfrPOxux1AwioQyUqs7WPHqa4LQvx3yIgQOjf4sEuDKWk8QxzOsItq/EbLh
	SYqlBQ7Gl+3Ifku5sgUxVTLzfdtk34lWYeFX3wuqgl5plf/raiUSz9ofD8eG2h8YmYyG7TKfufl
	LKqMx0ezxDwtK8TGxhIsm2IMijRCG1e+n73NcHXmfwlNS68N86EbyBNF8/zXERh0ivjRUDb4qn8
	VDzHP7Dkyhps6WeZi3167ZgFEQUeQ/Q9F6iJaU2cKVisnHGVhI/Hb9fWLDy7wC9QZetnUeDAkAZ
	UXW8pskhZxl83uNT6Hup3/ReSDiu3n7D6tnR/TCHz+jOCWviPm5ZlnxxnLfsiO+djpNH2vFO+Cv
	ivLguriwv/Bwq6257xe8dd5RtDafstq0edJaS0GdivunARzEqKwgo+uRsK/ndUq0XJNSwrPv+cc
	HJsfrjdrqwOD9yv7wSso+nWy+JOXCm7H25ZJppDrbjOBr3WHTHv3uuKDJaJq13mqRKxsc6uay0u
	btjEqqhiRs11sJA9Q5JIErRSFuplC48PzOtuwqWW/EseIfMxBNKoXGO/cXES8r8wW9G/kvEwwy5
	KpcZgOgFt+fJt+DXt6QgXqMNUNQM7AbXwHQQzwbla/ma/PE3lDSyTdDE3pKg4/iUdoKsIzfxKG6
	Fc3MW+pu31uRawOTkHuKdUNDzdYUckBH1d5U9ALSmKrd6oq8rqtK41wy0kPNmTtOxo
X-Received: by 2002:a05:7022:29c:20b0:15a:9834:73f2 with SMTP id a92af1059eb24-1ac5c5554eemr10126918c88.38.1793528727415;
        Sun, 01 Nov 2026 02:25:27 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b106edc7f8sm6767163c88.9.2026.11.01.02.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:25:26 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v4 0/3] iio: proximity: sx93xx: keep the IRQ balanced across suspend and resume
Date: Sun,  1 Nov 2026 15:55:01 +0530
Message-ID: <20261101102518.22757-1-kapoorarnav43@gmail.com>
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

sx9310, sx9324 and sx9360 disable the interrupt in suspend before
anything that can fail, and don't enable it again when suspend or resume
fails. One patch per driver, as the Fixes tags differ.

Changes in v4:
- Enable the interrupt first in resume, so resume mirrors suspend
  (Jonathan). This also drops the sx9310_wake_up() helper from v3.
- Drop the IRQ 0 wording from the commit messages (Jonathan)
- Drop Joshua's Reviewed-by, as resume changed

v3: https://lore.kernel.org/all/20261028220444.70121-1-kapoorarnav43@gmail.com/
v2: https://lore.kernel.org/all/20261026112342.65917-1-kapoorarnav43@gmail.com/
v1:
https://lore.kernel.org/all/20261026100322.16720-1-kapoorarnav43@gmail.com/
https://lore.kernel.org/all/20261026100408.16874-1-kapoorarnav43@gmail.com/
https://lore.kernel.org/all/20261026100450.17023-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have the hardware and haven't
reproduced a failing suspend.

Arnav Kapoor (3):
  iio: proximity: sx9310: keep the IRQ balanced across suspend and
    resume
  iio: proximity: sx9324: keep the IRQ balanced across suspend and
    resume
  iio: proximity: sx9360: keep the IRQ balanced across suspend and
    resume

 drivers/iio/proximity/sx9310.c | 32 ++++++++++++++++++--------------
 drivers/iio/proximity/sx9324.c | 28 ++++++++++++++++------------
 drivers/iio/proximity/sx9360.c | 30 +++++++++++++++++-------------
 3 files changed, 51 insertions(+), 39 deletions(-)


base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

