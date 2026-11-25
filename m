Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795594185;
	b=zPG+0ih28b4uZTSVjSsjkdP3cgXU3WrJZFQIQ/vuYt1DXJnjfleDUIvvp3x+DcqhL7FX
	 s0XWTTwyhyMdlcrVOzxGX64EsO7VVJL6r1uYw2RJ/iAw6bB0HqqQlnxWkUll0KIDmgJHN
	 BfwiB4FWtQVD1AM77/YhhvMPfnkrNBkSrAwSElPkt0lSGSq4DNbToT9/Q7JG+Jzx9YCC0
	 sE5Wy1DvNqWT3TGLYsBPW2/nG5bWhPSGL2jm+QoS4A66MOHnvBoSYG3PnypqjRlF/OBz9
	 OGkLnTtXIAWeTdjETPBnYx6Fnx38oTnGwA82ES/hc3BGNMnIIMHM4LP15juukNF5Z9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594185;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Z8nhMcOEmFb6L+CgkAbvXuh2iYwQe8I4JVQrmmp60QM=;
	b=3/Dky5ryFVqvOowSuOrS/lnHW94sSkyVCZIunyUeREuamVoDQWTN00RZOTEuizzxLbcF
	 gdvD4xUCDkl/JUWLISK9OgT75sv5yne1v5ueZAKqfh3yboCak+0ztB0112Rp0UHHc2+PU
	 Q9MOESYQjGAkM+KQGq9EjQkv8NXTBitdvwSi4E48fUMXrY3PtCS6IH4T1cMjmgfryUBWo
	 6Jx/YQ44uuBdMu5JaEUIdy33g2SUonZDEywztj+GtVo7K+8OYQFbiw6CNPwd4YGMX9Y+r
	 Khy9zBIqRGsjFmDgM598FjOehrwEfKGvOv6wGdPwbJ6w47l12cLNjtRbN5K7rSA1guA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwixjiLR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71725606A336;
	Wed, 25 Nov 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwixjiLR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795594185;
	b=JM64CYDZ17tfthhJaBqepgd1IUE0V7wLHSbLHSpL4uZbsELTqRH9sX4fwFsNkT6qf5bZ
	 Kzoj0P8SmpMo5SHhPwwjHBZaTS/vE+6ZykmMUyX6Yuj3XMXlT60OgUt4fGf0wcULNKmyo
	 lxXZd53T9EO+FwiDQxaSGpk5ksaG6a9ZjaQBAkXIJlX6hsWnSf1jzbmjS0D4nWe9fxsOP
	 430bBnFAIgmATHyoXZTJ4VOHtwTyfsD+eMrw4JBSJgiJgoYY76dLgLggweDosFohLjVhq
	 jUW53X3n9yGrBvl+37bBYaHR+0I9mjb4mbubC14YuxS+3JggBuJ696yZTVDXkhySy0g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795594185;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Z8nhMcOEmFb6L+CgkAbvXuh2iYwQe8I4JVQrmmp60QM=;
	b=KQPALW0JyzwrSQKkzY9I3H0R05cw7dH1KJVsJ9xA8sCP56lgRccBNZzb1uQs3unI2C1Z
	 Hu0RUQJ5Yv8LcZN6vagzdJK26LDGfJdM47buAi7/zZVyo5OMQZRps0WVr0Oz84CNdso4c
	 d6fiSJWscbi93x+aEnMCVggHolue/fRIHfg7rW4AXMTscJ5B+H+251jmQEn7x8S8vx1X+
	 At826rcf0+WOfH66lhMQBJgUdIjhK+PZtD6h8iFzQpSoFyvSYfMFsLPe+8Rrl9w+9vCWF
	 90A9MB7usiVOy2gdUx3m9UvjTfBwCkGuovXjxkf5GE9/zCDPjDiseI7WdmDaQugdMCg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 96D121F000C0;
	Wed, 25 Nov 2026 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795594185;
	bh=Z8nhMcOEmFb6L+CgkAbvXuh2iYwQe8I4JVQrmmp60QM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=dwixjiLR4DecAj6LVJvuSNnV7NHjDeAlvNoymE0Ig/fahAZunwKchOPQWc7u4lngz
	 pI4GhQrHT+5OKEHlXP6PNHG3BSX1sy/kg+r1PomraPw6o9OB/OW8qs3RpLEWOEGErk
	 xOwHFz7JShMtxdRZ0CYRaqemf2QRWYHSaI08B2FYdWv5yZrsLu3WCrH5tz7ta3+eZX
	 Wel0Z0dJ7iSuDlYcXlC7NBiBDtyVIZlRnt9lftND5sLVIgosExOM81UGsKCb/m1e8M
	 lKU4g8HD7W2mJdSy/Sq5UMy3qvDDBIFat+2vDBId7ic3eXuxXHRMgDh7asozMUEWC1
	 NFPIq8ecq8BWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E6E794CDA6;
	Wed, 25 Nov 2026 08:09:33 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] regmap: handle values wider than val_bits
 consistently
Date: Wed, 25 Nov 2026 08:09:29 +0000
Message-Id: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0K6dkynVTCuvIdhUcoIo/ylLY2Gc
 HcLHsDlS973vkV4ckxeXLNFOIrseRwSqEMmbGuGhoDrxEJJlSNiAY6a3kzwmgcOEE0HFQcP+an
 QWp5JXnQl0nZy9OD33r2XP/Zz9SQbtthmtOzD6D77ccTN+/cRERAM2loqmWuFxS1Z3B3t2ItyX
 dcvrvesyMwAAAA=
X-Change-ID: 20261117-regmap-kunit-val-bits-6473305e083b
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-sound@vger.kernel.org, Neo Chang <YLCHANG2@nuvoton.com>, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795594173; l=1960;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=niRjLc5BPtItCfeqEJ3V75a61ksSwRctBYQr3XvGWXM=;
 b=Du8pd/IZETKlBvTPHNlt422/qO1bNIozP3bj2PlLrjcfGyjp7C+mSS5hhzM4WEUHj6GsEmT5r
 5q4H77EIz3lADGuiNvX/6xzcLVrsTGE+wtSnKZ92F8zj7Hwc+DerlBi
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com

regmap_write() takes an unsigned int, and what happens to the bits above
val_bits currently depends on the bus and on the cache type. As agreed
on the RFC, mask them in the core, before the cache is updated.

Patch 1 prepares nau8360, which sets val_bits = 16 but writes 32-bit
values to its DSP registers, so it would break with the masking.
Patch 2 adds the masking.
Patch 3 adds the KUnit tests from the RFC, which now pass.

I searched for other drivers whose reg_write() handles more bits than
val_bits and found no other clear case, but the search cannot be
exhaustive. Implementations of reg_update_bits() do not go through
_regmap_write() and are not changed.

The regmap KUnit tests pass on arm64 QEMU. The nau8360 change is only
compile tested.

I prepared these patches with the help of an AI coding assistant, and
reviewed and tested them myself.

---
Changes in v2:
- No longer an RFC.
- New patch masking the values in the regmap core (Andy, Mark).
- New patch preparing nau8360.
- Use be16_to_cpup()/le16_to_cpup() instead of casts in the tests (Andy,
  Mark).
- Rebased on regmap for-7.5.
- Link to v1: https://patch.msgid.link/20261117-regmap-kunit-val-bits-v1-1-a1cd02063217@gmail.com

---
Raffaele Tranfaglia (3):
      ASoC: codecs: nau8360: set val_bits to the widest register size
      regmap: mask values to val_bits on write
      regmap: kunit: add tests for values wider than val_bits

 drivers/base/regmap/internal.h     |  1 +
 drivers/base/regmap/regmap-kunit.c | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap.c       | 14 ++++++++-
 sound/soc/codecs/nau8360.c         |  3 +-
 sound/soc/codecs/nau8360.h         |  3 +-
 5 files changed, 77 insertions(+), 4 deletions(-)
---
base-commit: 573c689219af87f6d5a4bbf809c174e7f28a23a1
change-id: 20261117-regmap-kunit-val-bits-6473305e083b

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


