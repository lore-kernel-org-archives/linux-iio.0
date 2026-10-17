Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4C379EE0
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792204772; cv=pass; b=qzAVCwLo1pLSKoeKk+XLpgCnRXE4OfTvuM8uBz0F+f6EEll2XgvGT9nYE5mimlrJH5n6bVb61HW1xpBP6cxEVP7VFYVGZctrXPcKQKDwKUl28NqbPZEZ/pRsOHGg1I0vPwaYzwkq0QP9ssnXMemE6ID9O/Po5gr54TawKPM4NOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792204772; c=relaxed/simple;
	bh=KC3eu+jm7sIsJ7H5aJTfHeeBZbEsbgdbutde6b93XO0=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSMOl0R7TIrS/VD5NjeR6MqF3uVAlbnFtEP6/dpsl4uJ0Pza29MrHnKdXZNRfOxaYFOim593hTjGPOWDWxcPGawnHmWD277PWUhEC/+yUKj63uGCXzwfF5icOKoe3DeNHD3qXY6WynSb1zTjR6bLlrJuO+8F3LgjDP0AhEE4hQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfHTEMST; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfHTEMST"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so1531140241.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 19:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792204768; cv=none;
        d=google.com; s=arc-20260327;
        b=UEEbgFqtOorPvhuYYm7yZnjwVXv8xbVWRHVVyxgxy3Zul+tF6qLWQHnM8vh2tv2sWs
         EjfjvY955tseNmHv3StcYwlNLnx/Vr1HmEsGMPDayLIltcG9JYeowGmJ1aJiZYroQDwP
         Ps3U6DjbTieQW9dgfXNnecZcIS9N+Eks0rYKltobJzxfaP1ONbnSutGtIhKbPKPs/e+Y
         cevKh87X0xyq5aI5Ihk8JwqlsqfqMvU6opj4gXr806CZPeCVKt1Ycztqk2/Oei0wnIYr
         xSYkBR8fvqVIsrUzL5ifF3izlg68aoedhqVaUZKbRP3OfuCR7/ddv09ziforT3B8UhTU
         5m7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=sdlsKEFzOLphdwnKgWd3lyNUyk5CQKvc4F8OOL4Kue8=;
        fh=G0UdmNvkxCLZx9BiCx5o7GCRMLRpnp6aIrqA9adgNWM=;
        b=AoQ0qodOwkNH4WOwMPLJ2FujHq1gBY4yuIOBmjIVEgLu9376TvN/A3m3HK04fsupeR
         Y/2pdSUjq3iOjKFYrav3Z8jEX/knZ+MH1JC4KuOmjZWjBqkz1bEc0hW3JAjcf7TDgPsp
         wZ3w5Gac7exqyhUHwUCmiUCMMhAUkqtH2TyebWO4bodABIfL2/CxOWhDawiV9z6Z7bOi
         O3cLNDPzb9XD0SiLmRsauf19O1ubqxVy2p+BJ8QOm8NT+KX6vIaMK0U8zVDB3sEG+fMk
         MN16BLZ94JtscgqwrhaL5hqX9uKYLenDp4F4p5b2MeSJ85yZAmQx0+2NUpLp7cmLYKNi
         pFdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792204768; x=1792809568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sdlsKEFzOLphdwnKgWd3lyNUyk5CQKvc4F8OOL4Kue8=;
        b=dfHTEMST/tgeW5FfVyWAvUnTAXcgMwmhamnasFCWAwILU2SmBJBXhHHSvGLE+GAPTN
         1dPEg++H2baZtAAJa/TamxmSSxu/sDcCdOhr7EP/nh7oBADIUg+eyD+HH9ROHZTIZmdP
         G4fZQ04IFC0bTbihWhyhAq0B8Alav2cFkYd4TrI92b1ZMU4SACvrEs37qlpYA3aEUO6F
         ETB+eWN/VDwRnFXoZDhiQwQVhiIiU0Z/E8r4hDa7x1Y7wECuB9/Wks0USR8BylBlDqqm
         Rbbem4O/0hQDA3anV9JRQBtK5w9SWGeaKdj3NOnfy0Udyntp2VPZwpwMNeTjcczIpzKO
         9uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792204768; x=1792809568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdlsKEFzOLphdwnKgWd3lyNUyk5CQKvc4F8OOL4Kue8=;
        b=j6ILQUbONoDgxd7HwCooQwVlBnooiT2GEoeSOk7gTwNJqwpJ9XUoePMlJa9aEsCKYL
         6O3goIxC/Gmi/rQDI+AE6CTngwAnUlSTjDQYm/aJLYvITe4DuVOrg4fwBPlJ5QSWG7R9
         x+79sEcqmtwRUHg1B2AwF60ydn/TURyyTHGydPhf0wn6cYvDYUzc9ZyD40r18L0+J3aT
         1ZnLJsHpzPKmvkKatHXpW6y6OXAwtz8VkgtcUdrlCVtTBs+DRO+w4UiHY3hXhz75H0qV
         5AK6WIUCSRSAkGX0JYx9NnikkwxoL6UJ74ZgT+r7rNWcsO4LR1zb6YuYdJfYRIeC/VUB
         Fsgg==
X-Forwarded-Encrypted: i=1; AKwUvBxA3lRT1ZE6Qh0niv1h8+TjQTb2ySj/PCkPvbQPvWv1VqF6mfI/JGKFs9YZyyrA+s7NWvMmbWtVWyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaQvDKIhqGqtb+2udhy/FwwLduqpQEmS1cvydLaTUiOga71qiR
	alxO9Dj0dC5/ftrH1VOPTmKh9If/XhrzHRhtE3TzvZSawyL/fS5Iuizomb/w9TEXEaqNmAWUcmq
	fmclP8pNN2sSwDG9GJqziJiRHIybgPvI=
X-Gm-Gg: AYBFou3bu4UJOEik7lrS1pkv5mrpEIq0Sw8Bbgh6I3/1zz6d57CwbZNILFuqeqTZnjc
	g1D+VFVTYEEcT92uC5uQmgajcfWS2KxjZ9a3fPyNuGH7txE8UPU3yQjHmlxok59hK9kcSHiUvLY
	Yx9eDP6PR97lyCYxzwgDhPBsZKpIaoYjD5iuOftxcuWc089St1062QVMT8vH39k9aotBY6uYd4c
	Kufxe/KNbdztorlmFLCwTtbTrjOb8sl67VIBDvxC46ZJy48U1lnldAOvZKDEeFEwPSphfof+qa6
	MNit6ZYRUaX/88vXhAwzYWcJVIzyWZ7hYKDEY1BmOm13A6kWBch+QTktbK8dj6foIQ==
X-Received: by 2002:a67:f34d:0:b0:7cc:ace:24ad with SMTP id
 ada2fe7eead31-7cc17c72bd9mr1070408137.0.1792204768576; Fri, 16 Oct 2026
 19:39:28 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 21:39:27 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 19:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 16 Oct 2026 19:38:21 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 16 Oct 2026 19:37:43 -0700
From: =?UTF-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
In-Reply-To: <CAF2O-sPfK96Bvqtu-reg+y--nuV35tM57Med9irz_a3RK1xhsw@mail.gmail.com>
References: <CAF2O-sPfK96Bvqtu-reg+y--nuV35tM57Med9irz_a3RK1xhsw@mail.gmail.com>
Date: Fri, 16 Oct 2026 21:39:27 -0500
X-Gm-Features: AclHuK_3LJU8o98OAG69Xz_TNEuPj-B3u8dMNV-r9cFLjr8fkIzbRSp1qOk1GNo
Message-ID: <CAF2O-sNM8HjOOH+sNc+QMTgDpLUKTar_3hXzHPoW+Bi-ve6CyQ@mail.gmail.com>
Subject: [PATCH v2 2/2] iio: accel: adxl345: propagate errors when disabling
 activity events
To: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When disabling an activity or inactivity event in
adxl345_set_act_inact_en(), adxl345_is_act_inact_ac() is called to
verify that the currently configured AC/DC coupling matches the event
being disabled.

adxl345_is_act_inact_ac() returns 1 on a coupling match, 0 on a
coupling mismatch, or a negative errno if regmap_read() fails. Checking
<=3D 0 and unconditionally returning 0 swallows negative regmap errors
and reports a successful write to userspace while leaving the event
enabled in registers.

Store the helper return value in ret and return ret when ret <=3D 0 so
mismatched coupling still returns 0 while negative regmap errors are
propagated.

Fixes: 31f7679bb69a ("iio: accel: adxl345: add coupling detection for
activity/inactivity")
Assisted-by: LLM
Signed-off-by: =E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com>
---
Validation on macOS ARM64 with Apple clang 17:
- Compiled the seven event-write/disable driver functions verbatim with
  the driver header, using a host regmap stub for deterministic read
  failures and register state checks.
- The original code failed all 12 disable regmap-error cases (returning 0
  instead of -EIO, -ETIMEDOUT and -EREMOTEIO); the patch passed all 29
  cases across DC/AC activity and inactivity disable error propagation,
  coupling-mismatch ignore, normal disable, normal enable, enable read
  failure and unsupported direction.
- Verified that failed disable reads exit after the first regmap_read()
  without issuing register writes or altering enabled register bits.
- Used -Wall -Wextra -Werror, AddressSanitizer and UndefinedBehaviorSanitiz=
er.
- Also compiled adxl345_core.o, adxl345_spi.o and adxl345_i2c.o as 64-bit
  x86_64 ELF relocatable objects with clang --target=3Dx86_64-unknown-linux=
-gnu
  against unpacked Debian Linux 6.1 headers plus upstream IIO/regmap header=
s.
- git diff --check and checkpatch.pl --no-tree --no-signoff --strict
  passed with 0 errors, 0 warnings and 0 checks.

This is a host function-chain regression and cross-target object compile,
not an in-kernel Kbuild/KUnit execution or hardware sensor test.

AI assistance: Antigravity identified the error-swallowing check in
adxl345_set_act_inact_en(), drafted this fix, the fault-injection test
and changelog.

The request was to prepare a driver/BSP/kernel contribution related to
an ADXL345 SPI/IIO vibration-monitoring project with reproduction and check=
s.

 drivers/iio/accel/adxl345_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_c=
ore.c
index 5983fc7..8ec1bbc 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -692,8 +692,9 @@ static int adxl345_set_act_inact_en(struct
adxl345_state *st,
 		 * current call attempts to turn off a DC-coupled activity, this
 		 * inconsistency should be detected here.
 		 */
-		if (adxl345_is_act_inact_ac(st, type) <=3D 0)
-			return 0;
+		ret =3D adxl345_is_act_inact_ac(st, type);
+		if (ret <=3D 0)
+			return ret;
 	}

 	/* Start modifying configuration registers */
--=20
2.50.1 (Apple Git-155)
