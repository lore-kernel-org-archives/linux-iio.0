Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE34539795
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987429; cv=none; b=VulmK6VpMp+ChOoCzNe0EDW+ugciC1iMnLNK5f0pfGtwr3KBVEAFDdF0RL/nN55TTe718+Ru2Z8NOjGI2cSfXr30jw/orByCLCgEX9w5Y0iBUxG0hqqKKfT2Y33lk8Dg/pdgD7+zwvqmnm5CzPvmCPCfCaE/Re1kX91gCtT3GxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987429; c=relaxed/simple;
	bh=qZvHyApaLSyIV/u8hAf+LBvoGKwMloq5Pf6iUipRYLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmhU6U5GGDecP3ejDAx3XkhiBaoAogSTXCwaAF4Fzw1jIflA/5/JXWnU3KNX23RfL0p0L0aqrE8bPxq0BtjhVrk44pISaPiNnMeom3+c8H3mjvgaNBWeDdDYx+ErLVSSNVyWxTOaUbSV0JNetKjfLfKk5rofPivXGDdownKaqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxNQNDoq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxNQNDoq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b060ec084so2754824f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791987426; x=1792592226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LE5QCyk/kuk4y0k9VpD3QxwfCrYmBzMze00/pe2mg5M=;
        b=pxNQNDoqcict5o9gxIZUc74J+AGfTP9r+kvXgu85B+rX5mR89CqgayPWjeB7VT9vgn
         QkWyd1plEvI1TnDi5co43uX7tm9bcFCIiDD2IxGldJ9rih4zQbHcONzBme3Ur4Ikpfgs
         pV+ASILVgZIX5HkVAIstePXtSWeEmKN3MsyG9I+Rddxa3sfSP/yyi+3CeyN7UO8KaKjr
         z1Dj+J7ngsR6eu1GlSQ3S9Ez4Xd0Ey9plE5RYN+eb7ZC3akbmb6ytkF0q29HI2xG/Rvw
         SkRIio/a2Ea9zJkyeICXydjZT0nqcXhEHV5jdMxslcm01kFBJHU8iip2b4PgREWaGo+V
         uQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987426; x=1792592226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LE5QCyk/kuk4y0k9VpD3QxwfCrYmBzMze00/pe2mg5M=;
        b=thke2zfXh7mYCtxbDk2Y5qwvVguCMadCwegiF4FCzCxLuW3qnoPKkcx9hVucQVvWIx
         woG0uOdF+Ko8jvQDaLj8G0t291p5ucUqdHhuDTyxD+Xs9JbFjutkLfmc14xUQvA7b9aT
         1Y7AQ2r/F6F43GXUbroLBtAnbKz+xCPFXmPBnpdDiWoKFmfbZe3K2+nYNRPIRRlRKh+E
         Gom2dIbvnrrU55ZIK3eF0FZVusi39oKuuJoHFjXnunKfMDpDeJNeu58HHKxBhvTJJEK5
         lQ+qU+bzPfB16puh+LSqjOi/XqeExQEddwnE1/mToPcXML2XgMweQdt7MHVgzjyJQ/Rw
         bPog==
X-Forwarded-Encrypted: i=1; AKwUvByQoFaw1Q6x811J6Gnutb1rBJNY4SlRDiRmOKbX0zQOukJs9tmnTTOnSSyBC1nQAtXhkx1EcVRPrIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJr4amE4Upa1zDNHBQj80ZC7o/TlhSczv+/Daj9G4J3rhflZpb
	O6tl98PKo8tlhNtZgpRX9N78NU2zCUsd0LLngcaKJkwUjhXZtIrq64B6HtMxpt5hfIk=
X-Gm-Gg: AYBFou3ToBiwJ6d2kgKew79It9Zrsc15WnVZDv4VimNhNwutLO2Hw3S+trknlivheA4
	PPR3eF+gC0jZzfQOtSom+NmZcbk/C2vU6aY0hqUFG4J9uNRUROHF5aZWiqz/WZxPbKeWylmzkEf
	tsU4xe+UmOWpJRPoY7qoUI8rLqZEn+Rz0hTz7GodAWLyQS/ji5Hd6x6LFl6REu3k03q7TGRA7vW
	17PHmDjXYbOL3XKRiQK3MWnEZ6pm3yMFAoJsKVoM5ThmV89w9xoJK9GC4M/qGY461Nk+azcvohO
	74OQ8aocFWAARkNU/bu7vmhnQL6N3Tfp/t9qJh3Qs846kLg/m+H8E4MizPW1NBtACE3b0nDCSkY
	MdX9gyECCsxURcp7u0E7BtRVnPXUlXVnMqqmhMn2PiVVVtB29yJ5JpHG4tchMPj7Qf3M3/BkccI
	/XgnpNuGMIBKk0jLAwA3/z5CFxkCIZkMXzkbZOjphuti9YhuO3HEJWNWUlxoB9a8gx+BY=
X-Received: by 2002:a5d:6f09:0:b0:48c:5304:5e4f with SMTP id ffacd0b85a97d-48dbaade750mr28722326f8f.15.1791987426244;
        Wed, 14 Oct 2026 07:17:06 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d20:6232:49ca:4be9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaabc3sm12364370f8f.16.2026.10.14.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:17:05 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and precision, add I2C ID table, report saturation
Date: Wed, 14 Oct 2026 16:16:46 +0200
Message-ID: <20261014141650.259929-1-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Remes <jan.remes@mycroftmind.com>

This series fixes several issues found while using the TSL2591 in
company products (Raspberry Pi CM5) and when testing (x86_64 laptops
with MCP2221 USB-I2C bridge).

The original field report found that the illumination value has always
been 0.0 (caused by division by zero on ARM).

Patch 1 fixes divisions by zero in the lux calculation, which occur with
LOW gain and short integration times, or in darkness when CH0 = 0.

Patch 2 adds an i2c_device_id table so the driver can be probed on systems
without CONFIG_OF.

Patch 3 makes the driver return an error instead of a bogus value when the
sensor is saturated.

Patch 4 improves the formula for calculating lux values to make the
returned value more accurate.

Patches 3 and 4 change existing behavior, I am OK with splitting the
series into two, if that makes things better.

AI assistance: Claude Code (Claude Opus 5.5) was used for research on
sensor behavior, datasheets and Adafruit library, to compare results
produced by old and new formula, to draft some code for patches 1 and 4.
I reviewed all of it and tested it on x86_64.

Changes in v2 (thanks to Andy Shevchenko for review):
- Patch 2: Use C99 initializers
- Patch 4: Keep variables in reversed xmas tree order
- Link to v1: https://lore.kernel.org/r/20261013143943.436816-1-ciakval@gmail.com/

Jan Remes (4):
  iio: light: tsl2591: don't divide by zero
  iio: light: tsl2591: add I2C device ID table
  iio: light: tsl2591: report saturation
  iio: light: tsl2591: improve lux calculation precision

 drivers/iio/light/tsl2591.c | 58 +++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 16 deletions(-)


base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
-- 
2.53.0

