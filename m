Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190962882B7
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785597; cv=none; b=jYqythHwH7z+2h0FoG8/nm4Wbpptyb3YaPaPpxNtJQzBvIrT7evyG2/PVfexPJEU0gfm/FoUpgqfuez9NSBe3GBQBnQcmRHVMs3mgaygJa0Emf2Ce7irMUYgIpxV65ZyV+spNO27GnBa9ehRuFKfeQeqygQ6z2+I91GaaLkqIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785597; c=relaxed/simple;
	bh=+01pEnYZzCPJ+GoTR0CqnFb8zM7721yqq5M+QY16g5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uD6rJdgYFEnbxvu2Al/SWycJlk8iAfOCZSBo/ZeJSVbEv9wb4z4lyCVc0qQIE/dp2RBQ4XdqM/cQigNW93xMnfgK4IXYk+sWHN78xThvse0nwALvmIPUZExCGMxYYAIKwyZU+2gh5DbDqYfYR/Y+hM3+cZLIjrtDxG1OEFFQ0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=YfZTbtSd; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="YfZTbtSd"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139edc6bfc0so7469128c88.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 19:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782785594; x=1783390394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRbKdYL62vHrkIRE0LVNTTXM5CXJCmLaqocrjjB/7AU=;
        b=YfZTbtSdgQ6msqlOGc4S/v3fJIJ53m6UrWgKwZ9UvpIh/svzkPrjFzsUkxRzEvhocC
         uqME4MPakdViaY7UVTLkfhPCc/xCT2MY85bl7Q4YazI0hBBJ0sdn9ZDJKAHQabarH/cu
         l7vw+SS6ERibIrL5FqUo6SBsLtwl3M4T0k680ZAy9inEL7Yw0ei6bIwymt3miKF/YBAY
         ch3QtzWGEes2i5A7YJx/UWi7QgrNRf8dlbfeJk9/YYtTL9xb5u4f4Ftjl9N/SXsNEI4q
         fnrbsbXTtYokIbOtbzDOgAb16k3beu4xxM9grgGSWWnJvfQe3UPp22nt3VNMZhCl6ACT
         PJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782785594; x=1783390394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRbKdYL62vHrkIRE0LVNTTXM5CXJCmLaqocrjjB/7AU=;
        b=tYNqxcNF+hh8neJFjPYXOzmmrAnwZ678ky7BuUSOv889qqkm9DfDHyxywGEYMS1zS9
         oodgyVUE7X4F/QBANZprmXlpVV1xPJUAiI+T2hMVdMVop/sBddCOrdyBPungaCeiDzJD
         ZzEdAcYoit4fp/ye4PM+99vDmAxlFqtd3zN3rw3R8BFW3x9BJkSVNo00E0KBBN/XZqNf
         4W3Gp4h227aAfrjJrPtLerNdbJsyFDN5JzpseFw5jNOzkCFP74yFD830brrP2G4lmiOq
         Bj2MZLbR5BklDUNpdTehzC8X9tg5L7b9FnKc8U/TAASny+RgF4ydvqytYXRb/nXGyCXl
         uang==
X-Forwarded-Encrypted: i=1; AHgh+Rr+g1dYjIH4cDBrdeRlWPF95NAbS8FooGFWxdRGInHv6B3JIevkgXWuFrESFhr08VdqXRFFd6dUdsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJpDdXu9BIDRhUUnTo6rrmKFsjcKKZfSfxAmTonkoeAaBQVRT
	2nf+riNbEuStqwrZAVi92qjbGRjxV6SpPINPMcQu4e83mhs2stT4uVz3XFhCKLni/Pk=
X-Gm-Gg: AfdE7ckNdhZ5HtG7yng0DF8WWJIzxQv8FNwwNY5Meb6+uKmG/lYeS9f2pYErf3g35Q/
	4PnmG9lzEpeh6dgr62bSRRzhtWg4PVzS3VXNbC9wYEh+qXACojsy/7PSJ8Xu15jD25DbPmn5pfZ
	F0WTdVrjAbimkobiONFXsXSZhKnx9OrMlsJ6Y8AAjKQbjvJtXllCTV8U2uHHhza0oTrnLq8UI5J
	HvCIyvkL12HGjEtmOtpDkhZje7PsplzEvmax6h3jLBkNHuYLYUrU0roLGw0rQV42X0ayyz3vY03
	tAH0z6f8PLavh24SrGB8aby1HjUhYgtFaSTffDNLQo5mdx/+q75C1XCd4H7Q+AfTwWEl2fxplNg
	eJFaO8QBI8N/6lKvEilqxFol312TsH64Aji0QCZ5RgscQf+pyAVfeDiwPH2b5zQXe8GJdgVIvLj
	WYmBt0s29zjlcuUwGNZMK3SXgPXA/oRnm/nBJj
X-Received: by 2002:a05:7300:1496:b0:30c:ab4f:46c6 with SMTP id 5a478bee46e88-30ee14174camr1348319eec.44.1782785594027;
        Mon, 29 Jun 2026 19:13:14 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:865b:5eb9:80c:c4c8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30ee32519aesm2310913eec.27.2026.06.29.19.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 19:13:13 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v1 0/1] iio: dac: m62332: Fix regulator reference count imbalance
Date: Mon, 29 Jun 2026 23:13:08 -0300
Message-ID: <20260630021309.36636-1-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m62332_set_value() enables the Vcc regulator on every write of a non-zero
value and disables it on every write of zero, without tracking the
channel's current state, so a non-zero-to-non-zero change leaks an enable
and leaves the reference-counted regulator on. This gates enable/disable
on the stored per-channel value so the regulator is enabled exactly while
a channel is active.

This is an independent bug fix, based on mainline rather than on the
in-flight header-cleanup series for this driver
(https://lore.kernel.org/r/20260628034811.152946-1-erick.henrique.rodrigues@usp.br).
The two touch the same function and so will conflict; the fix is
deliberately based on mainline so it backports cleanly to stable. Happy to
reorder behind the cleanup, or rebase either on the other, whichever you
prefer.

Erick Henrique (1):
  iio: dac: m62332: Fix regulator reference count imbalance

 drivers/iio/dac/m62332.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.51.0

