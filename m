Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A9D4FB9DF
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015472; cv=none; b=F8a3n8Xv5Ojywlqb1VL1KUfhEtKPJ8PQSudBJvKbsqaQOmGApQg3lbBvxHk1rRRbC7gGBTQAxsSuGF5nPBwoML+oVxFoi+6csLebFK7pIVWXqyuU2hXcMCi/5vRVWmt7jE1GV9XV7uGH4rqdynmwlB/sRqhZTIBJJqomSAKIUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015472; c=relaxed/simple;
	bh=aw6CVi2nbRv8fPDaXOaXSEjR9geXXb4sm8diUOqavKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6ysM88P7X6W7ATMmZMwsPLRVH7SkUfyjtPvkCdzz65HsLL77XFSZgWcdDo2Nk3+/OwYM2W8IuGPxEQLi24SnphcbPTKo87t0fI42ru1liZ3ED/4rzuLd09PYsrPWA7U7OqWOjtl58kzIdQcVx3YeyniCCgGqf6+YS63wLOp2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtBfCPQX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtBfCPQX"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so1824831fa.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015468; x=1790620268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4eVGrW6waYffaGCq/np4EMOiip9V2YcfYQGrJdZIZj0=;
        b=VtBfCPQXicF7YIddKqbMJJmuFIHx8IDaDGQQYzTBTj/q3qSjAaUryQmFbuPQUoQirI
         +grW2Izl0BnCrx6Pawqer+zMXP/JxKMG3nNEvFo7fWVykqTbvzkr9iICTud0i8ak0sfZ
         iN/M22Aikm5w2tYVKtErrmUmaxzXkhrK/A1zQuTa2uV06qjya0evpmr/Ld9hjB29pQsT
         SVuOJePjCDGQ+hkOl4JlLrZjzIzySnqziNAmf5LKatbKsdiklafquPPfHYxPw2vWL8mC
         a/KPA3fkAX/J8Q4QOhAnooF9OulCpRFCrNlfC0zK2AOzarU5vScU/UbKeq/g2OYemNj7
         njIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015468; x=1790620268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4eVGrW6waYffaGCq/np4EMOiip9V2YcfYQGrJdZIZj0=;
        b=yt1zTenRzNZ0SOFOXaKD7boQgBnLgmfd4zXxYrzwJyz3dgljscJ64YyS0Z30BQisQ6
         c9uf9+PdMWkHV/5FGEG34oQB+9wFUCY0J4PT2Y+pIIAGQCktLzt9BjPOqHC/SBMKUqvr
         8qk8xIFZQZEPNgKmFvHcbW5wpYE5ty8A8AJ37pJgn9T1P1myCaMpIEPOxZsChKVqU+6h
         BGYbb/oABcRDlcDm/vUfMTpgiXdkwRWXtnpffS3eC8MX8SzcsWdgZCBvRqHJhcPfDoRF
         19jNfPnkB0mmRAmGv8CdpX7tVI1xGtyyssK2Qh6m4TFLZRzmDn+xW1MpqqM+XXKo4oZM
         zRwA==
X-Forwarded-Encrypted: i=1; AKwUvBxWCfM73f65CYXt4FrWymwYc7WMMglyNUkc4eKavNPENYhSJcFZDeIk2JGtVfSa0Pyfm62vWuYZUXc=@vger.kernel.org
X-Gm-Message-State: AFuF++n0IDB9i4yKpMld5CXAC1D4B4vvb/Q2cJMe4eES3Cqp6peVujdG
	8XiH/ADYat8anZDcHGnaxkrk1qgA83vMxPfarKwuT4uofWp117hDyoHaJvPay3la
X-Gm-Gg: AYBFou3lHY1QhOeQtKbk9K5cOD8N+wwSoG+zSTzQ6BBloksw4oi9QuVXU950b6K2cIa
	1wJqXvv7c1rP7fmvJOBjMD6gLsIYaE1bYfIgJBiQSh6B1sPZS9MctEFU4Vf85tAMSijEdlYAC35
	8DDeDOdPEmf6WwI2u0arNqmSwQHm33Xu8rn7yHE1xREEovW8+/8qTdJGOxtwfzrvfkNA8TT9sUI
	Bthlk/UIGyHdpsnthbsf1maOCHahMEA+dyMkrjimjjRHTNNBQB6ROah/ttXt9XEP0/33eehboEV
	uZM/Kp6noVLQWBL4+yV9965d3o+C6rSFowBd/NonPFiCXSR3YkyS0mYn5DJEyEXoR4Dalo3xO/O
	Ie3ygqZQ+SZa4bMqx+L47bgCel/KbDkKXF4A0N/NnCptIE7kk0qZH1niz2c88RSq54XIm381m2V
	8nCYdZf92B46a2I6LUVQJ55IoauHuNQgHZ+jYkGTkzQbbeLHYfYA/LuHLcmsmQadfnXrUNQzDva
	G7Yjg/r6MuMnkIX3yb5Fla/qzLImyIvVwHGsWQSCJn8Wm2J2rpQtNZ32DTjI137maFo2g==
X-Received: by 2002:a05:651c:a332:b0:3a3:61ec:43c0 with SMTP id 38308e7fff4ca-3a624d968c7mr1134591fa.17.1790015467447;
        Mon, 21 Sep 2026 11:31:07 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a6075e3522sm26102611fa.21.2026.09.21.11.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:06 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v7 09/10] iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
Date: Mon, 21 Sep 2026 21:31:06 +0300
Message-ID: <20260921183106.231972-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178992913316.706584.1446996024286841775.b4-review@b4>
References: <20260918122517.377565-1-zoone.rupert@gmail.com> <20260918122517.377565-10-zoone.rupert@gmail.com> <178992913316.706584.1446996024286841775.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 19:32:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> As talked abotu above, I think iio_device_claim_buffer_mode()
> will do the job here as it stops the IIO core transitioning between
> modes until afte this is done with the active_scan_mask.

It does, but patch 10 then warns on it:

  dps310.c:1233:2: warning: releasing mutex 'iio' that was not held
                   [-Wthread-safety-analysis]

clang 23.1.2, CONFIG_WARN_CONTEXT_ANALYSIS=y. There is a
DEFINE_GUARD_COND for direct mode but none for buffer mode, so clang
cannot follow the conditional claim. v8 holds the same lock over the
same span with IIO_DEV_GUARD_CURRENT_MODE() and the mode check that was
already there. If you would rather have the named API, say so and I
will add the buffer mode guard and ACQUIRE macro to the core first.

Rupesh
