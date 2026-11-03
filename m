Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744582;
	b=RJ7pwVJWkbqb2xHSmbXazKzIibWQCW4BfT6TNwC/M/KFmXbqrlIGx74UCd2Nhid1gAV1
	 ZoYTzlKTVsqUWFFRt2hsFqHYkkOnPJDP2VHraGQHUSzh9TdlXG5o+w73tTwhuwp297Iva
	 KGJW4hkCI4oyTq+oBObNYD1u3C8fBCXg+sURqT1ruYRVSzwDjqYF/FnYtFaUhOBZDEJj5
	 SOSfGTwx4z0oa04uuhxn/4r0+z2eDnWBZb3nZQCgXeJC0qRZ4RIWRHU7JMTlCnJuXPDu7
	 f8YaYDlREjeIgz5+sMBHy8HldqI0TvTgxDIU+nHEo5TMpDkRE5010tqe4TK4pv6GAeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vG7YyaR1jfJGT4Zyo7fUKW5YQdRxU04KVZC/8HRXsU0=;
	b=ExOir7NyaAU/XNtazo24tg13fajDOhxw3CRUcQuz5kRMoG4LdXJF5cOSxe1pk4REde6s
	 XUPGa9LlfbpFrZOcXBfn5h5yXmDY0nHNZfJ65Mw0ieAY2gIejxgam7bT+POGVtCDZDJlf
	 Xy2NPw5f5dVzJi+l2Wwq5U0MOuzzdchVVtrHRsCbZPXdV5ZtOQRwTv7bXk4w8iHxw4OBT
	 DcZmz9RxX0czxkIlF56wyQiLZxT0RBdCUe8jlyyp11ppx4nRCVrwF1B1f835W4nhSEU8K
	 3shzWotEru+wCR0eMuKN8sjVX3ulQqVdF8QZXrE3Pap6P01EDL6xNwP4PyUVJVudHPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mWQMoB0K;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C3606A31B
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 22:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 788C3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mWQMoB0K
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2af4c8d00so297339c88.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 14:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793744581; x=1794349381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vG7YyaR1jfJGT4Zyo7fUKW5YQdRxU04KVZC/8HRXsU0=;
        b=mWQMoB0K1VT+Qs08/4w1/EZaMZ962n0okVvivkeH/VyHpZt/S7I3EE2F9vs3758tTr
         dnebJ9MLlplJjZatFyvy+fgG8n/uK3SweCHTHuddXhyKsueRyw0sP9Wx6NeuiO7igq1O
         KckL+SOZCVvgBBgekcNt4p7ygVI2gei2ywWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744581; x=1794349381;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vG7YyaR1jfJGT4Zyo7fUKW5YQdRxU04KVZC/8HRXsU0=;
        b=DkCpwFCgNFhahx69YGnm6A2sA4gVSQcuUR5Da7+2jq/WuOH6g61ki3T70aMtcDtnNy
         TJ2/ityRPAiRcSN1KRTbdWTJbB0rLOOterySi4ptNaSJv+egSTm1h6YQ+9C0pjRIvTrT
         SGszfPW3HRDNbQ0daF5mbmYjMLcwgLqIrMH058efFvRnrGajXRKCbXYCUW3ARUsQZjc+
         7XpSV//mGS7929sPZJmrTG/e8VlhBTMut08jy0aFImPJh32f8NJRk7IWFOxz/51Oi7ad
         QXeAOErP4vgjfdm3eP5Y20z31YF4qX+udaJjggQn0tCtMd/pySwIf+Jd3IuT9/b7T3Zr
         wu9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzSH50OBwfZaXgCM34SJACor5j7Es6nqjHq+wynj0ynEwSfpBx6YfT/wjT65tBzWNAbjxtzDEInx+I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V1f+Qf94GnqPHdKgexfEtWx6ljSPBUtfAxYYziuWOO6IcXEya
	pD1HSnCliXvR6ckGXSjLYaXGXYPIo/fnwJhbE+8iGXRf8tTqoXjkxHXbwQYJabZELQ==
X-Gm-Gg: AYBFou39XjfJmF+AzTNqcOonIppdOf4dt5QESPIjnBobv1Put3OyiW2Sw1PLQc5XR81
	PeUKutZShu1AoKbI8HElv3ml8FdKcLpse1HIg3kBqCnRkCx8w+pqap0Ne70KH+rl1C77b6pl3o0
	CmvK1ks7LcUQPlpUG+1bHWU4fZGOA/ITQMMvyt5zAubzzWFj8930sbIphC9LhtqSGmHxId04G9h
	MEGSpm2LlJ14jCV/hRv0n9KykgmRT9rm6HATlPRz4QMYVA2SJncMnXDrYHKToag8DcMha6XPKkD
	gUuBbwjRaGSMSHWSVOAJgQBF1nqEkNyi8o2of83wZPCrW3bQlR+deAdk7abRVOzOTaWQqDE/9yS
	ivijOk6rid4wHvwwNOjnn9VQFzIrzVktgvWCc7yHnyxOiTEGUu8OZnlZbLCAsyMZXUdzfo9lWbU
	BQ0mFfQNhktD0sR+C+cCbwXpU3AhyTXzilXitql8Cgc6nS5yJBEnNRT/Oz8StUXqLgOLqNAI3qv
	AVU3n/bvGLX2YlpcF5VBfHTnViNDarQ1Qhb/B8NHTAY/kqcSrzE9WW8k1CUp+DVo82R/cs2tj5F
	+tzK04bfcUH65mrX8XTtcR+q8e8IZDyddAo5cIAFkwiJRR2lJji9h2P7BC7jXigr50f9
X-Received: by 2002:a05:7022:b0c4:b0:144:eb46:c3f with SMTP id a92af1059eb24-1ac560219bamr19881274c88.2.1793744580537;
        Tue, 03 Nov 2026 14:23:00 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245b86fbesm1926506c88.1.2026.11.03.14.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:22:59 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 0/5] PM: runtime: Improve autosuspend child to parent propagation
Date: Tue,  3 Nov 2026 14:14:38 -0800
Message-ID: <20261103221717.3840215-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v1:
  https://lore.kernel.org/all/20261002230714.507921-1-briannorris@chromium.org/
  [PATCH 0/5] PM: runtime: Improve autosuspend child to parent propagation

See patch 3 for the primary change here.

In short: today, children can resume/suspend without extending the
autosuspend expiration of their parent. For parents where their activity
is largely driven by their children, this makes it easy to experience
"premature" suspend.

Many .runtime_idle() implementations seem to try to work around this
problem, and one in particular (stm32-adc) documented their problems
heavily in c537d3457542 ("iio: adc: stm32-adc: fix runtime autosuspend
delay when slow polling").

This is an attempt to improve the PM core, as suggested in review for that
change:
https://lore.kernel.org/all/CAPDyKFp=KTf8=zGBSzPYqhjnZpY8xwvjCeM1e-WTKT1QLSxaDA@mail.gmail.com/

This will make it easier to simplify many other drivers too, as a
significant use of .runtime_idle() is to simply extend a parent's
last_busy timestamp, as a proxy for "last activity performed by a
child".

The changes:

1) Preparatory fix, noticed while making the following changes

2) Because the last_busy mathematics get a little more complex, I have
   to change last_busy to use an atomic64_t type

3) Propagate last_busy from dependent devices (children, consumers) to
   their dependencies (parent, suppliers)

4) Add KUnit tests

5) Remove the pm_runtime_mark_last_busy() workaround from the stm32-adc
   driver

To follow on with #5: I believe almost every other .runtime_idle()
implementation in the tree can be removed after patch 3. (There are a
handful of drivers that should just use autosuspend. And perhaps 2 or 3
other drivers that do other non-trivial work with .runtime_idle(). But
most are redundant.) I may work on that next, if this works out.

- Brian

Changes in v2:
 * Update comments to explain when/why rpm_propagate_last_busy()
   performs the update
 * Minor kunit test improvements

Brian Norris (5):
  PM: runtime: Only queue an idle check for RPM-linked suppliers (part
    2)
  PM: runtime: Convert last_busy to atomic64_t
  PM: runtime: Propagate last_busy from dependent to dependency
  PM: runtime: Add tests for last_busy propagation
  iio: adc: stm32-adc: Drop runtime_idle()

 drivers/base/power/runtime-test.c | 99 +++++++++++++++++++++++++++++++
 drivers/base/power/runtime.c      | 30 +++++++++-
 drivers/iio/adc/stm32-adc-core.c  |  9 +--
 include/linux/pm.h                |  3 +-
 include/linux/pm_runtime.h        |  3 +-
 5 files changed, 132 insertions(+), 12 deletions(-)

-- 
2.56.0.398.g882cbad275-goog

