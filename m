Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C343BD64D
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762528; cv=none; b=gNlNXYyhFmetB8bzuxDHF+yqF9IcgYtfDqtUvf4atRUc5Rag8bagDODFKFbvp0BbOT+z5DMrMpajmenPG+uNdwXR6LyZH+M7EhmmWLVaO8LMSISPl9JyIE3zwwwHznhiyPDJilUxx/P8HQARo+rEaECmrSdvAQbqFHFfqKFb+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762528; c=relaxed/simple;
	bh=ArVbgSqduACOmxfcVTHJQFHzScRMnex7G2M+AqLIu0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eA2M78rOKv3H79ZAvABoonI/xigtzAY54w3gd1Sk7zhgtJEbgu+cryrOmP0pkSDmue8F0P6aZbnFK9ZDFBoYhV7ByNJEVwP6mukWwaKzxnB9d/gJ0MJOE7f5yb4i0JnfOsVoRMM7b/PnJkzY1AokwW0Shu6lT37K0YDIFGSdoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wme4cJXJ; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wme4cJXJ"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8e986b8b1so5221513e87.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762525; x=1791367325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPEyYiVpY7sAQDhgqXyYJbjm/viUGjaJIIaZNqUOais=;
        b=Wme4cJXJu7nMmXXbzE0a1JL020CW0OSQdYGSULCuBMMIi9+lNEUdpNlGT5vqVG/qmw
         OaslFs5bq0BHFEz4SzwhqCsPGPR1B7fBnMYNflwhLZGqCTN4yvGZ/h9bnABETOgis7OZ
         eS9Djpzdq927juL40aZzF/iEwnD3bKb2fh/g0uUm9M+sGTxr4L6FcK0AniMsFchd1XLG
         EouKQ6MoRTrByA/P2tEGVytT/P/P1EYczGTJOzRNsrUz6ZkH7oRjs/b4MjlzBdPhzXXH
         +EqL12NeQCNf7kf8wPc2QZZngTlD7p9hn8CfcDxkAGt1J84f/ByAwTiyDC7/nOxcuLZW
         XYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762525; x=1791367325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPEyYiVpY7sAQDhgqXyYJbjm/viUGjaJIIaZNqUOais=;
        b=Yv2X4w5ECv15mF5IvIESiFfKeCHdmDAExswd4T/eF0Hqba9qp95ln03jbAEnjBvOxf
         68Vd3eyF1kHZWtMOp1QX/R/pxQAD2jXsIQuetFrEqhVdsdStD3wcDbP8GiaGIq+gl8CP
         0qaMNEqDWnhd4W7CW0V/X86mYuUWuLumXHmBzGJNQTGQN9M4kDL0/TO9hj2/knPOOn7L
         +u7rPmwS5O7+SDLpsWV54xqzQ460aRpO0QxICWQyWAmR1ttVcmWpgkL7E4TQvD3FB7e5
         1fJs5FUvO+/FxijpydNZ7huHVtOi2bpZDSZxuzT8crvLCsWaBiaja4me0Aa91rVVu5MG
         HlBA==
X-Gm-Message-State: AFq9FYJQaBTGOFu4quo1A+m9u9ESmuwpzH4cwYJ8mLxRs9HmgDbAKYvQ
	wC7kvT7KKmfYd2Y7WnlaF89p31BA1D+l5uzLrgMMZ81bbz1eMt6gGw8a
X-Gm-Gg: AYBFou1btKsKQwtJgkdCZpfLhdepAuoWFevNPV7D1BgBzSuDU3BdUyeW7q8Cao+yoHQ
	dCCuSz65WTTA4urm1W3ZgWiCuUVChYv783HHmmWgMMmS5zKByfPpFAGLgqtdM55emNl0Myi7lrx
	UgzdF1pDaDgvDW89W97SAvj1Fvj8dIlMT97FgRWhHnYIJWZjGUMeyIJ2AQnWxjll/kGusC0PdDC
	3OiOUR2NU/+pCWVAjPwAxJ1bI8FLSW1VqIo1r1E1DI0gmptVwuRRMjB+M1iWYvET0q1zilfzOWe
	ILJwXxelSEEI1m6I0A5IZFBDX8DaTDwGY8sJtYQkP/yWhi1ed2kg4X6e9q6N+ctIKYBqw3nZjJU
	Oij/MGOPdUbiHOBAqrylL/gAu5umQ+hEzw1SMSdNpvL1hAwq+a0gepaLrIVognLf3YiUSifcIhC
	t9k6KjmTIXVwfN/kCoGlVNC3GmdbMW6ej6QpNSSjZCEl1wG8Y7gvYXhFXqxFzwkjDoyUVXPlCL3
	TuOMho6z/sPcZBW5bXjrC6fQXKFzQcJMvpdomGnZwHk0xJAFf2In9SA+GoqpvHvPT943hrzmT5J
	Tf/y
X-Received: by 2002:a05:6512:3da0:b0:5b8:f3d5:f2fa with SMTP id 2adb3069b0e04-5ba4061343emr433495e87.56.1790762524559;
        Wed, 30 Sep 2026 03:02:04 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba3fbe6c06sm240422e87.22.2026.09.30.03.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:02:03 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v10 0/4] iio: pressure: dps310: hardware FIFO support
Date: Wed, 30 Sep 2026 13:01:54 +0300
Message-ID: <20260930100158.957977-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rest of FIFO series, on iio/togreg which has 1-6 and 10 of v8.

Since v9, from Andy's review:
 - patch 1: include time.h, one continue in drain temperature branch
 - patch 4, new: lockdep_assert_held() next to every __must_hold(),
   including 12 in applied code

Pressure overflow fix is now at v2:
https://lore.kernel.org/linux-iio/20260930085819.886339-1-zoone.rupert@gmail.com/

Retested on DPS310 with BeagleBone Black: buffer enables, flush race,
bad held entry, temperature-only capture. Lockdep asserts tested under
QEMU with PROVE_LOCKING, including a build with a lock left out.

v9: https://lore.kernel.org/linux-iio/20260928211127.641828-1-zoone.rupert@gmail.com/

Rupesh Majhi (4):
  iio: pressure: dps310: read buffered samples from the hardware FIFO
  iio: pressure: dps310: derive the drain interval from the watermark
  iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
  iio: pressure: dps310: assert the lock at runtime too

 drivers/iio/pressure/dps310.c | 449 +++++++++++++++++++++++++++++++++-
 1 file changed, 439 insertions(+), 10 deletions(-)


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.43.0

