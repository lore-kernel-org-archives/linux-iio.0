Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D7344D83;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493848; cv=none; b=Eyz0wZ8ue450k7Vz/TgXmtJIlSSicf3R9DPM/3hUytqMpQgc/3xn9bo7LevYmnwCCbK5xJCJ4M1HSzVR7YAm4uARYO4t1cV/yAl1E2jvveMH6jz8hqdoMUSRpjYWubeJ9XWrBxRfcboMIt+Y+IihO5N6S07lcZCe/b6mwgPeAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493848; c=relaxed/simple;
	bh=Q1rBnzssda7tdLwjVM6yNMHp5lDEFrPzQPGj06IIvNE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WD9ndKBoBy4vMzPIW9tsm8AQuAoE9lZ8V8LnlX5QYnGrD4mGpPZP1L33/G3ERiKolewtnldO9K2OsD5akJl1LT7ZmAWxor7zRb0yPVbV77pbOlOcMkKvjAs/9QCv1CMVqsmPC/N1u568A9O3ww8seNJNl19qpoRz2CWN2KDnVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt1zCHrx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt1zCHrx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E313BC2BCB0;
	Mon, 11 May 2026 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778493847;
	bh=Q1rBnzssda7tdLwjVM6yNMHp5lDEFrPzQPGj06IIvNE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Zt1zCHrxHC9hOI5LDDm3nM82IJx2zVOY+4pQdFEnEasKiMeYcf3SHPfTXUfrDh7Y5
	 dk9XKqyZ3FlxnCGZX6ktgIhAztjelOFp23w/DrOudRqXXEiTwHN92aF96jQUxP6AdO
	 uPdziuhtWwNYrb0iZdKEed9kmZyLW8h0fEaWEn+ITtod9Qek3VrgpkxfUlWPvN7iMr
	 06+cbwcJuoJ0wRzFDVM/3hD8/8qv87ehxV6vYhpaHCqpTU72/80JeqlkOqkhV6NdC5
	 XmO/Uhx19Tu8KbYJURrZqGQYMLOPdHu8U2mLl9GxPwmJYz+KF/cODy393rQces90Tx
	 DQSG78KAGWKwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29DDCD37B5;
	Mon, 11 May 2026 10:04:07 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH 0/7] iio: light: opt3001: driver cleanup
Date: Mon, 11 May 2026 12:04:05 +0200
Message-Id: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWpAWoC/x3MQQqAIBBA0avErBtwtIK6SrQQm2ogVLQiiO6et
 HyL/x/InIQzDNUDiS/JEnwB1RW4zfqVUeZi0Ep3qiXCEA+jFKHb2fozoqOGaGZqTK+hVDHxIvd
 /HKf3/QBeb772YQAAAA==
X-Change-ID: 20260511-opt3001-cleanup-c1411de14392
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778493846; l=1156;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=Q1rBnzssda7tdLwjVM6yNMHp5lDEFrPzQPGj06IIvNE=;
 b=/+p4LeIyG0DDi3UZU1Qms2lGU+xW0Tyo4EOnNspDbQDu1duMoRwvwwkq/mNBdoLE1YCokXAab
 kSRylgBkEXBAF+hEHA48ZCl/2twrtqzRv9LrsJY7/ksnJTnjHRnst0Z
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

This series deals with cleaning up the TI OPT3001 sensor driver,
moving it to more modern kernel practices and improving the code style.

Changes include:
- moving the driver to use devm_* functions
- IWYU cleanups
- removal of unnecessary macros and comments
- using dev_err_probe() in probe and probe path functions
- checkpatch.pl warning cleanups

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (7):
      iio: light: opt3001: make headers conform to iwyu
      iio: light: opt3001: use macros from bits.h header
      iio: light: opt3001: prefer dev_err_probe()
      iio: light: opt3001: move driver to guard(mutex)() use
      iio: light: opt3001: localize for loop iterator
      iio: light: opt3001: remove unnecessary comments
      iio: light: opt3001: switch driver to managed resources

 drivers/iio/light/opt3001.c | 208 +++++++++++++++++++-------------------------
 1 file changed, 88 insertions(+), 120 deletions(-)
---
base-commit: 74d173f29572951629d1e0b7456b424006e51b87
change-id: 20260511-opt3001-cleanup-c1411de14392

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


