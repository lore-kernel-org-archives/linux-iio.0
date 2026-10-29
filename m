Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311600;
	b=xZQuUk2WdT9uz4pyKhrZH9aKlxY7ZslDdxXvB5dho6/x4mZW1EKmzvxCmGTIBtnAVk9k
	 P+2+nXzQclUKatP2B5e3rhyGr5opi4OIABzKgvCoa7OPZWF3BSFr8eLf/vZiMnSqisUZQ
	 +CDazLbsAIPu4upV4WHpo7zXXdiFworitzzDsQZlgFwbIL9flJMdVbzLTrbltA74wGkLJ
	 3hhvhlCJPetD7N+X36iBS3mAPIz1oA5g7HarnOJsUNIGDy+Ed2MOpJn5d1PoWB6XlDft5
	 Jz04c/qE/ooyn1ln+6HjftvpUybZZ+nbXWtZQV6KQ0V3+Crs1092O9qNvRsw/nz/Z6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pRlEJMcyxoH1Sz7G/BmKQvoLUKOX5CmF/zOk36T3m/c=;
	b=ZYjAF1wA6wXf6m3lKO7mLhxD6MhxcpTm4jOOrF8FPx3yOTGXSw+E6Jf43eOpzhxLdGyj
	 Ppgxs1yJu7SWLi6LZ/S1t3wYOuo9OkkgIxcv75k6LPNYnW39nsygJRfjQlusGp4zMgLFg
	 arzck9b0t3otO8kkKzaBqUFSmK7chcZXZZOziGIKB6R0RnzSppG/z5P9U5mflM9kJBtyC
	 KB+SQIs0AU6JQZmDWcciW+a9WQEPc6/E8U/GbrYfQpohqJSGLJfV7m33g4xZr8fEqsovm
	 EOJqv/WJHijpdY3amuuNGtQjHvWqrngfOAJ001KPo9UMVxKNvtl5BZmRCK6wLpDu+IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0uqDyA+B;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD55606A31C
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 22:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD55606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0uqDyA+B
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d0so1196671fa.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311599; x=1793916399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pRlEJMcyxoH1Sz7G/BmKQvoLUKOX5CmF/zOk36T3m/c=;
        b=0uqDyA+BWerg10l+57wmNs+lI/xBwVdnTCi+ekyMsTTN8mSdtf3VjtlcJLkQBAUFgr
         75xkaRAMMcTvdJpvirT/xnvZHoB27fd3l3y+agHSPw8UmCcfbfqAlyIzTFjNjvBzBm6w
         zgwebkCs7h/KkTgWBSMKI+C4FJPdyq9k3t3CEOF9y44mijPF6WLwjOvhguVQvm4bFRwl
         8/Rye1+vLV/HyB8qr5GGHzktYVv+cFJDf0qQNYZ178UzQN3vqDF9Zlb2nCqmvsE92qzJ
         YUtcYwGfNLgIw7rvH0rubF4g9haF8qZlqDX/z1+pEHNZgKQWv1Y5BEU9KSCOvp89v2QC
         RxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311599; x=1793916399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRlEJMcyxoH1Sz7G/BmKQvoLUKOX5CmF/zOk36T3m/c=;
        b=SvoursYxoQXI5JNAhF65UF+MDtc5QZUhgngg9PqyMPLKzFtBUxMSMtCv3Qs9Skj/XM
         g5w7ijtUdfVPn18sbLy9OyrdrvOHjsjCVMx0JUT7E3YdnwYa4+9/gC2TZAm0NKqXSlCE
         WiEgLO2p7RLhyKn22Vx6DTlKaTwGxCRxfKItehN8iW54yqyb8CeKjnIM+rF2fqAiV14H
         Wvl4N5KdDhizOis4XwkxM4mz3hTk3KETJxoEsAuAMxlTB7oz+oOpczTy9Af71ba599m6
         h+T6Jx0JG1oeyOcOz0xKU3znV0kJoWLN8UmWLjv5AfxcVfzvR40iMOpEH7ImZZ7l26xy
         DLUQ==
X-Gm-Message-State: AFq9FYIVYoxR7VYAFSTeyPEyU+W+ZZHd+Cl+COqZY3qDiPRWCdt4+Ce2
	LH6P8IYQVG9GvOGe+Ijeg5AbOhy9NjPA4GU+/PNe+PxOLhzETb5sdfMs
X-Gm-Gg: AYBFou0BssUoN8eDuqix7191OGIZoHOS13qND+YZPTz4WAhmjr1ZqcOAXOs9Him9iRk
	ggHp1mqbBACNto7Ie/v7sc7SJnlL9W7f5uJTpx51smtw9H+vX2h8tJ2pmRvReVBBk1yJNE2JW4N
	qp+GIfGabdWCu/SS+vC2UXHDuMlJmmCFwuUtDTnM5SMK20RGq1vQEvHDBvsNUkBc7RBMp7+A8Vq
	C8rbrysyzrX4LO7wDGJ1yCAmMNNKUynCl9aaXdyp+/2nW37U4w1h+VqIJX9JYsVSxImB+Ks8rW+
	8NWjoJ8uC2o0tPY/c4RxnyP+eo34mpbyNSh4t6sk4VJNoVorIommVwiXc0fheOWLTW14vvfzA57
	/kP1MrY5pFbN4iyyq+uwrgH2y9zOba1vmjFbEXYXVNfvb4BCe2A2RPrAOAeWf66BFefDngyFqRv
	JYWoQpDOZBQDSolwkKyOvpAKIeGAGK5M2vgvp0TQSP73AjrbXlAFf0TTa/BEM+uuSHieY2YhJ0E
	xe/Hu6lTKXqAkyOX83qFP49fuWt4UtT/e5Xezx9L2GEoJwFVZVi3ZEI/oTi28YPbmJ4UE5KN8yK
	ig3DMt+RwrkfQtylO77+cp/mgvIdXiCGp/lwvNhYOrkTb91f69+x7ew3zrcOucx+0Od5u+d9IAl
	KzrOdJ30B/NDVgHjdZ72TQOevdxbbbPUN2uYhQg==
X-Received: by 2002:a05:6512:6193:b0:5bf:b237:8161 with SMTP id 2adb3069b0e04-5bfd95632b1mr85554e87.10.1793311598452;
        Thu, 29 Oct 2026 15:06:38 -0700 (PDT)
Received: from yantra.. (nekmmqtmquaao4qwdoc-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:6842:e549:8c95:f73c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfd9c507adsm9605e87.65.2026.10.29.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:06:37 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 0/3] iio: pressure: dps310: fix input checks and resets
Date: Fri, 30 Oct 2026 00:06:32 +0200
Message-ID: <20261029220635.18816-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Sashiko flagged these as pre-existing in its review of the FIFO series
v8 [1]. All three reproduce on a DPS310 on a BeagleBone Black:

- 0 or 0.5 written to a rate or ratio is accepted. Ratio 0 puts a
  reserved value in the register: pressure reads fail with -ERANGE,
  temperature reads 974 C.
- A warm reboot during a FIFO capture leaves FIFO_EN set. After it,
  every raw read times out until the driver is unbound.
- The reset after a read timeout silently puts the rate and ratio back
  to their defaults.

Patch 2 fixes a commit that is only in iio testing so far.

Paulius, patch 2 also resets the ZTS8032 at probe, the same reset that
remove already does. A Tested-by would be welcome if you have time.

Based on iio testing. Reproduced and fixed with help from an LLM coding
assistant.

[1] https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com

Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Rupesh Majhi (3):
  iio: pressure: dps310: reject a zero rate or oversampling ratio
  iio: pressure: dps310: reset the chip at probe
  iio: pressure: dps310: keep the user's settings across a timeout reset

 drivers/iio/pressure/dps310.c | 38 ++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)


base-commit: 7d80b4b383bc53b48abd3a30ca4a91cdab568bfa
-- 
2.43.0

