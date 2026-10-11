Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93703C10B9
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699365; cv=pass; b=Bg3SDENA80iI07LEoOMPEYOWQrIpeKsXQZzTYeBdA9SnNvJz/iWI7O404i0RJKcI76l3QGR+kS55yZ7rB0n50g28JNh99vl8Qfal3vTiWDyMWm6JXUGLuE2zG52DknRz+QlUhO37i6UEXlie3LKpfEdDyUWW3LGLWJXWa8fWN+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699365; c=relaxed/simple;
	bh=KC3eu+jm7sIsJ7H5aJTfHeeBZbEsbgdbutde6b93XO0=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InXiwSUjV4PkNE3M+c4QuGVCJ2FKUgCBCuRfWdUp6qkEMk+aNHyxQBTqZhI03iYnAUL0JbfLradWNPbejdgXhqoxCU5mdxB5sNIe9y3h4x91JwHHa9e/aytaFds24oxgZ0V05FEOBr4K4phJaOBUo9qsVvQEVA0dGtTJtd0zP/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwHHKkHW; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwHHKkHW"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5e67a6b3633so290875e0c.0
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 23:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791699363; cv=none;
        d=google.com; s=arc-20260327;
        b=QQ1/thgNF8qZozqvSNh+Tnk+bsxDHg2A89iPIRkWQUElglJqJNCQxRYzOSp/xEbuPo
         22riIfrmScxw7PR9DcMyOF36nVPYqxXZcv6Tzk0MAr6CYRPDriK0mfeWJP5x8+UdUeuh
         Icdyhac+TD+IwZFC6LfKYERSecFT2tVFeMb11UOLvtb1wyXb/E+nyPTyc2QYzq54SHxS
         Va3KaTGd+9a03txRpM1BEpId1XWqbvQf8lsPxlpdgmZxiM7eL+RJebWJRM/T0kNeAEo5
         PdPbwLhDcP+njmfO2pT2iBSarHhVnmEHStFodaS0IQiScKQ0myJnzCZCy4CUxGks8FLA
         uySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=sdlsKEFzOLphdwnKgWd3lyNUyk5CQKvc4F8OOL4Kue8=;
        fh=vNeZbkcRuojCjPcO22jHFchURqmdKed4igen1SK3dQc=;
        b=hygxMUh9Ugff6Jln8S8HU2v792ZQwzZkZPR5aajftcMhGescJa2FY26HWIg4inqNay
         Sa0/V4FwarAHwWcydtTMxscO1KMfsvjxpd2d0w/+wU9RoNbpPnS/3UDIDIzo5QkZ1Mgm
         FnlzMYg7MvD/yu3DIpYJNZH1Cx0QhjlRwEZ1K9oslEmQE5nztRRiUzL7SB2uy3p7g3nC
         NkLn7FfntG5o+s8pAzE8zk2i/TxHUp3yTB5sT2+dqnobQN+js+sT/Tpxm7swq2E+N0ny
         /PR+qvPBJqMfe9QXMG3KbeYZpHKY+87uBuDjTEV+YN8X/t1/F+UYsy9QrS7xJLVfHO2N
         53Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699363; x=1792304163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sdlsKEFzOLphdwnKgWd3lyNUyk5CQKvc4F8OOL4Kue8=;
        b=ZwHHKkHWzMIronTAcmX6YL6ZslM1VFJD1XSgMbBXZWSmZUwf60gE7xNoda9qf1Xxs5
         DAK0tHcJk0Y4uiZ2vv35GnZQ3E0My2oDO68vPzbJ27vA3J96ChnhBtfL3QgUAcQg7U0T
         84XkPFOPeKxPWzwwapR/JH48nVvB31U7JCykQkuqB9bkQTX14pFmc5c2T9A2vrHyPPzy
         1Mp4T3YKTdVcLQL2W5sT1n7PsZl2OZXHUXKMFlZjbWlC+WuV71SWyuGgU4NiI2pzpXr8
         aPU+TF4I3C8lWwYQ7Y+NDTqrxwjgBzsZBhiTHrOMCGMZcDheJmdHOCKmZ+ervBDE5xJM
         icCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699363; x=1792304163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdlsKEFzOLphdwnKgWd3lyNUyk5CQKvc4F8OOL4Kue8=;
        b=jBGsRmNVDIpkuk+oqapdWpcqVinPZ0BDHrr36w+iZPK/eVh150cM6WQ6YHDSyyZ3cF
         a2mdU/aTFCMyFwwSY+dFIdaACtveaxN3qVeXkuAfRNcsWaf5rNY153za+ibQt2M67MTL
         XhVwgtN/hCFVSpGg4QdQNdxq6qMr7XqIh41HQZc9/qeCJeffMSuJryl8MASCuFpR1HUN
         NIwArJ7BGfVc/rBhldhgxS/MsdxcmnIgaanZh19W3eui+4x+BVaGMrDTEJiDvZaGSkjF
         zu+D1qcRD05KlD9Hl9zVYDEbOn9a14c2sckzRBeB98SiqqlQAM2uR/vNpxqmurrQ7LiG
         ZFeg==
X-Forwarded-Encrypted: i=1; AKwUvBxTe0dtNwzngtUkTebh66MmJgYyePWWzxN+DnyZxwaRnylaoLZr6v/50WWqgTALTUs9N/h59LoLzP4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhvjvYV21aZRNPVhZKQu9yJ+VGj/GJVAe6DaXehSwPP3Lk3y07
	OmXtUDDp9G0XQ9o+O2o2R3Vv2Hs++TXOeO1YXjLA/dL+m51xMAb10wuOuAUGuZm+ITsNsfjlJJL
	FJ7kO3yMhFAIfOBzFcXzPI7zAm3nyoDY=
X-Gm-Gg: AYBFou1i1B/MRdxLhLG5Wyyg7TB8nMrVGS7VqD9Hxc39MbuFnO5hibeSUcH5mCHaRHp
	TSl1nCCkLsuJzamkUD83lfifucwedr1m5M2n3+EptODH05xEEkAbMECjzKTg7H5IOSLpxrlU8xf
	K97h4SJmE5UxxLJ2RSGxzpCD0P2KfMg+FY8twI8RMROzi2AhjU3l05anFlnxM19efvuVJA+vb3d
	0q+PFHPpsU05m9jfMZISqIjIh+Cj8Jw77G7816tH1V9VBVNt+zjChmWmVLaBRh8PGk0rgBGBAos
	0+OZKEGRqCtYC1r+CSAA605hXVxdCvgnFPlSRQzp3xsW3Pc116O8Uw==
X-Received: by 2002:a05:6102:508c:b0:7c0:18e9:ba46 with SMTP id
 ada2fe7eead31-7cb372dc755mr1811107137.15.1791699362772; Sat, 10 Oct 2026
 23:16:02 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 10 Oct 2026 23:16:01 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 11 Oct 2026 02:15:53 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Sat, 10 Oct 2026 23:15:03 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Sun, 11 Oct 2026 02:07:30 -0400
From: =?UTF-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
In-Reply-To: <CAF2O-sO1YuVQWLoNT4mRN2+mzFOG-WdQ5Nt80s1k+7PP8QUtFQ@mail.gmail.com>
References: <CAF2O-sO1YuVQWLoNT4mRN2+mzFOG-WdQ5Nt80s1k+7PP8QUtFQ@mail.gmail.com>
Date: Sat, 10 Oct 2026 23:16:01 -0700
X-Gm-Features: AclHuK_DsW304sqSeQ8iznGSxkMUxK49dZwUz8k-8Bh5_Iz-Vw4uiU5beDk6WEc
Message-ID: <CAF2O-sPXRLQ8AkYuZOtNjnWWLK5Zzw3fu1155S+qjN213kJ_qQ@mail.gmail.com>
Subject: [PATCH 2/2] iio: accel: adxl345: propagate errors when disabling
 activity events
To: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lothar Rubusch <l.rubusch@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
