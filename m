Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69E497B64
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982443; cv=none; b=R/HjcQDK83fFeAnsAlwqdlp/6q9ggPql+2N4pcBp2pL3k2lAU2sWBgy0mCKF2vyms9NmBVvM0vec+p9bOQZ+m149+tkKSqxc3l4chNQwdLaH0QLGHaUyLoh+q8yMetyxqOHev0hy6K7ahOK07puKbUcIjAMetoqyyLfRFKPhZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982443; c=relaxed/simple;
	bh=RGgoyqq4R7KoPnFF8uisNnEGFVRPpl23zQf4XjNBF4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WoSzZNdN1ZGRPnr/GGFnzCremMWImjzXUY7hvfEU/QIV9Mn/ERdfQyJwztuaUNP0ms6/inK1XnQZ9dvY9ffKdL3F/tgHMd+Wkh9O8bBN95Oahhgqm6Mb9cJGAkKMoVY2NY1hyHY37YO/V8xH7KbIlPBAYZlkgCzPRWQHxdSLsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arzz32pc; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arzz32pc"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so132998eec.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790982439; x=1791587239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WeCGbzmbDMCGHEECOh1TDjR3OoHLvO5PyQaBzCE8Lc=;
        b=arzz32pcwfMXM2R5++aFzaSPf2fSZH9pb2V+jsj+clYGO4eyuevU8LGkIcbMXpxW1H
         vvkIKiaA0/fXNyGb3T+JmAD1A9roMaUUhbVKuSiug1EQfFH071tYhNDdQI5j26AMDrBn
         2TgrDplLUZHJu28zsQtkVE16U+aK6PDCj6nmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790982439; x=1791587239;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2WeCGbzmbDMCGHEECOh1TDjR3OoHLvO5PyQaBzCE8Lc=;
        b=n4TrfFDOi3uuT5v53MXNoIeSviPvnp87pw6I06qnT1/TUkqSNLpbRw6xD44r64Q5oH
         ecPrkUTgGXrLUk4xRn8O6Rec5t5GvWfET/WqFIAdpr+TD8nNMsNcOcdYjkPPVa3hfnW6
         5GIR8f31mS2ya4Mehuhl6sDmjDTF/APCNPaxDBk0UinsE9/ynYxwTy0ZToA2hdxXmirC
         d0Z6OyJFDE3ijemo8bjsLZWRWSJ/GIPHTaqUkqOE05UMlnpi7BQdlUTmpSMA9u6GdviU
         +gSUz1/is/8h7brhVN82+xY7082r9HI+vtr61HalyDRx+i6NUpTQGe8zFR3C4qR6wKkM
         ekUg==
X-Forwarded-Encrypted: i=1; AKwUvBy15aTJ8yyUfXHZaNMjAQMoe91Ieewf/11bB08VyqUaMcYpEHh6IfkG3ut7+uirXGsupVLQ4cKjNoE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcesT0VuyjyO7Wc+WQBUEfj7t858O5XHmL+6iHDoHqJ8PFjEN/
	yL0bMy8k0HU84zRwXA35sDdipwxLBkiSKFWfOttyg9Nyyoe2OtgmDiyCCDvMlIwWEw==
X-Gm-Gg: AYBFou2pir6Glqg+RB7EP5T0lCgkVWVD0/FMLTRslcXHcWr67CKDah5lk/KRLD1EV6l
	Z3D0lUzxRnXIJ0kTSrj4SKYtqnaYDQ7zyyuyNcxhDBWZfiE9H5qm0ReqmPugRjHJ8gatRNAhxo2
	7hAaTjDt+NNCWigz7tU1LWYOK0JB3NQuTlWlq8+bgl9Hmq3FOS0D/LnrN0hrbppGxnVyeIRsNJM
	K3/wS7nfD7hHwYxJ4fvbRdH8Yan/aGvS5h4YEXtEO4XYfpoL0TaGifH3sYVJD/TWxq8b0x4iQp5
	b1eP3LeFm73EyY1RQ+3syAsG/Lqf5QRFR85U2/tXK4iQb5vBf9FFs6upb7j9ZHBfgiTLLPuOa+k
	u2GXiFaiLJLGqCVA1sxMOtqO1bZ5RX3i65DA/mbvJ3qvhnazthJWjf9IS0cqrMMkEWWEuaZngR6
	h6yC2vAED7RC+ztpjJxa7TVKYIhsqtRGKQrn7oSZIb5qUT2vmk6vphXqbioup1M1ghtzfzA5zaw
	jz+F656Bb8T8A3J8aGvGKZS0V2UIqTPtKDeSQ==
X-Received: by 2002:a05:693c:83c3:20b0:33b:f5b7:f494 with SMTP id 5a478bee46e88-34f1509e567mr5123379eec.13.1790982438582;
        Fri, 02 Oct 2026 16:07:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:b0dc:e72e:e96b:3323])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34f14f98527sm8357014eec.16.2026.10.02.16.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 16:07:17 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/5] PM: runtime: Improve autosuspend child to parent propagation
Date: Fri,  2 Oct 2026 16:03:04 -0700
Message-ID: <20261002230714.507921-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


Brian Norris (5):
  PM: runtime: Only queue an idle check for RPM-linked suppliers (part
    2)
  PM: runtime: Convert last_busy to atomic64_t
  PM: runtime: Propagate last_busy from dependent to dependency
  PM: runtime: Add tests for last_busy propagation
  iio: adc: stm32-adc: Drop runtime_idle()

 drivers/base/power/runtime-test.c | 101 ++++++++++++++++++++++++++++++
 drivers/base/power/runtime.c      |  29 ++++++++-
 drivers/iio/adc/stm32-adc-core.c  |   9 +--
 include/linux/pm.h                |   3 +-
 include/linux/pm_runtime.h        |   2 +-
 5 files changed, 132 insertions(+), 12 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

