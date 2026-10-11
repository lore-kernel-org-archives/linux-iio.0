Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB123BF91
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699344; cv=pass; b=lbCaZScRaJCQylA/z4cpbsiU4xEtk1RQ4O8FEfyPNYNd86EfQ3l64kX3wZB25BH9IiLeFet3gifQIFJqmCdgBONxU1Ua/+Xe2AzXlZPQ72o5Ko+L1ZQYv8VKLTygXzdF+4TaPPpFqDpA/vOGjOkYwF6NxRbHl6nc8SBLipA5u8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699344; c=relaxed/simple;
	bh=XrM8GNdz09aTLpj/YWt5QoBx4XJXWOW0t3qeZquGh68=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kU9JWCQ9x4Q5iiXIbF1ifcbrB/b/ufk9FIfGxLvlBVHZ5qDWNnRGuhyLUUEnLiOycTff5RNe2XA3KTDcxpfTf3jE137QOomZXwnZAOOpkmGVVbckRr9iLrzmYbm1KJzYbxu0JRjqJxZMZ+YnzansbUFJdv4tB/ie0ZJSsrzQH9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx0cKMW1; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx0cKMW1"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so545555241.2
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 23:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791699342; cv=none;
        d=google.com; s=arc-20260327;
        b=J1XvhMgb4Os62+FdTacOH/7DNcAcCbz09u5ebBdOaKhVTcGwfvf/yUOhrYYw7c16M9
         /VovBrLC8/T9tlgTQ68qmil/NF57yG2KWCA+rpHa4gyFirb+Zy2mPN7zmDRv39SI+JZJ
         xqQWUvwAvQm8jIG+VNKi0Or3B4z/PtNMZBOMuaoA4R7Yb7VCfceaIzD6bN4/6jDqutjc
         HhKGpuWSWd4ovE6Mi2Czaqa3SvsDMnt9Rz3mE8LD4mPXzscdVPbyyPVRWxxDV8puR5jp
         z8YNAnXaY7Nos7rPRT3Umb1GO6+aHd/zlQ31FcG5ZsPZeH9cFiEkqN9sDz3ZOZh+J21b
         mdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=X8L+iNlTtt3HRZDj3HQaVSJLaMG+O2tpW3fkmUX4Knk=;
        fh=JXEubHZYmWvsM5vtprGoiizEtSEuIKwzeFqjKhZiWKU=;
        b=PAkf4lgKGgMc30fKr0yKhmJd9oRLF6k04G9AqUiJkPq+khsWI/GWladAVxGH7DhiBP
         lwVLjggEv6REhj9VvsReSt8Bd2ABKAYXc51Au63BKHjZE3/txkTmMki42jllZPQsUZ1H
         E14AOhbF4BWM+aw8jlVB1btgNha+GEU0jNCWlLlBk4/DQVghjCNSBPDjR7tJ2EeCTA3H
         3yyPn1HOUQB0XK0lZV3J2oSdtXFmSiwHCxtavta6Fke0KZsdg1P8SGExXl5KG1REeV/m
         8hf79ObsWPQ8SWRwhpe1qOEiNsjfNXplKyYNguyoxb9CuLHK0WerZlPr4sUex6G1Go0Y
         XA7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699342; x=1792304142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8L+iNlTtt3HRZDj3HQaVSJLaMG+O2tpW3fkmUX4Knk=;
        b=Yx0cKMW1CozpDzpNqqD4oNxR1ZlFcrO5YqTTAUPXSKRvR1E1y4mMsMd8q/e3VEX4Hk
         L5UrkkLdCZ8RiCl1DKRZFMSMGEK+WXU410Mn8gFYAUHAenU3HGl1x6/QYkfrPOV1Bbs3
         /fm2wkZXjsjIIk4ZVt5Tgwtl+9bhxluuaohvMpdEPzJK17MZE2CuDBjfV/Df+u0OI8wX
         OQmb3yJylmIEL5RttX1sXEmeXSphHuvxTjB26eFQmls4Eka5UNUqTESC+f4WYriMEqTr
         FuLachD0eu8iUeR5uDOyZfuIM5j/p9ss3dXgi+7ZCkTdFr2xrwCZzWOk2m+xrIbGL8aV
         SgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699342; x=1792304142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X8L+iNlTtt3HRZDj3HQaVSJLaMG+O2tpW3fkmUX4Knk=;
        b=jQWmmqzimHYiAKE2NxM4ps7UFS/vHOL0A5+GTnbAFTVNK5Kn3Hbm9VzD2zhSTk68fp
         fkkfqi2E3fPLQk8+MslYU5SwKYn52UF8+k5mblckVto59RHmtZpGoMrIdjQ2WRo+ahZv
         tZZDtrJlCgS4qVeFr6Ij+Ssqm/Q15bjPOI6o4AIyAkLmOJeUhay7FEM1ekpbVpVAp8fb
         92E/u5F+UVavvtXsfNnOr1TV5mpJ7LJmMDdheZcxqbpwOO42UtflcIxOG2SZpNx6OY8G
         WIHgI3xfE6ACei8ZcaeSXLKEcMEAS5jhAcA9b2cLgjGyYdmNE9i/5V+3JHVgxNqhEsGr
         juIw==
X-Forwarded-Encrypted: i=1; AKwUvBxGmBl+pInDqaQOkqDZbxaZ0UGLsiWQw0nQRp2n3SHipooElwHxfXYq9QqsyqcIyCNWVIdHlk0G7HE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI72tf50spM8QJyi1gxVZjuzhQCLF1QoDalnBwZ/yGzCINGG8GR
	M+HH27MPp6nDmWA+Mzsa/vGupUQKhhcXxkAaa7fDHyWaJMCNIrkaYIV2cMicAvItWPgM4ZtQYPn
	3SImXb36+qetAw5iEepFGY0H8SlOTP9o=
X-Gm-Gg: AYBFou18V9VRIHU0crNmaMFsdbmwTB2l6EXzezMICl1W/6uamzVq3/p7sD1z44UdbGW
	tAHAaEBAaVb3EuFvZJD2kXPA3zQeT87wbykLDvIAC9jHCM0jldPr4toNlSfJzhVEcsjVkmm8uGx
	bYzAt7eOwuG8AVSlz8VMdAbluFQRMfHecgmpAnL/UBRqOCIuJtIk0OQ0gsfkzebWeWlDcxqpaMl
	uscRJ2kNq8ihl+b2LAOoqaxf8pK7KPMIhqzZmygl1hokkdm0+CF17SdFa6BCbAJ4ofV+pJ0ajd0
	1YfnE65/ZJXk23I5OQsaaFkpjpn11mRkt8BJHqTy3+57ArjcW2ADZQ==
X-Received: by 2002:a05:6102:14aa:b0:7a1:84bd:7f50 with SMTP id
 ada2fe7eead31-7cb39713ccbmr2025006137.1.1791699341706; Sat, 10 Oct 2026
 23:15:41 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 11 Oct 2026 02:15:41 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 11 Oct 2026 02:15:02 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Sun, 11 Oct 2026 02:07:29 -0400
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Sat, 10 Oct 2026 23:06:45 -0700
From: =?UTF-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
Date: Sun, 11 Oct 2026 02:15:41 -0400
X-Gm-Features: AclHuK8AMx45cLdSTsGLQ9rt89HLUljIGqTqKX2kSBVQqAMXvnHaMVhCGjVg3xg
Message-ID: <CAF2O-sO1YuVQWLoNT4mRN2+mzFOG-WdQ5Nt80s1k+7PP8QUtFQ@mail.gmail.com>
Subject: [PATCH 1/2] iio: accel: adxl345: propagate errors when reading event configuration
To: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lothar Rubusch <l.rubusch@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

adxl345_is_act_inact_en() returns either a boolean state or a negative
regmap error. Applying !! in adxl345_read_mag_config() converts every
negative error to 1, so a failed register read is reported to userspace
as an enabled activity or inactivity event.

Return the helper result directly. Its successful paths already return
0 or 1, and the IIO event attribute read path propagates negative errors.
This also covers the adaptive magnitude events using the same helper.

Fixes: 66a1af6d8a63 ("iio: accel: adxl345: add activity event feature")
Assisted-by: LLM
Signed-off-by: =E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com>
---
Validation on macOS ARM64 with Apple clang 17:
- Compiled the three relevant driver functions verbatim with the driver
  header, using a host regmap stub for deterministic read failures.
- The original code failed 36 error cases; the patch passed all 53 cases.
- Covered activity/inactivity and DC/AC coupling, each of three regmap
  reads failing with -EIO, -ETIMEDOUT and -EREMOTEIO, enabled/disabled
  states, mismatched coupling and an unsupported direction.
- Checked read order, early exit and unchanged register state.
- Used -Wall -Wextra -Werror, AddressSanitizer and UndefinedBehaviorSanitiz=
er.
- git diff --check and checkpatch.pl --no-tree --no-signoff --strict
  on the code diff passed with no errors, warnings or checks.
- The full patch draft also passed checkpatch with no errors, warnings
  or checks after fetching the introducing commit for Fixes validation.

Also compiled adxl345_core.o, adxl345_spi.o and adxl345_i2c.o as
x86_64 ELF relocatable objects using clang and unpacked Debian Linux 6.1
headers supplemented by upstream IIO/regmap headers. This checks syntax
and types; it is not a full Kbuild/modpost build.

No in-kernel KUnit execution or hardware sensor test was performed.
The checkout is sparse; --no-tree disables checkpatch's tree layout
check. Initial draft checks used --no-signoff before human review.
The final signed email also passed checkpatch without --no-signoff.

AI assistance: Codex reviewed the event-read path, identified the errno
conversion, drafted this two-line fix, the reproducer and changelog.
The request was to prepare a driver/BSP/kernel contribution related to an
ADXL345 SPI/IIO vibration-monitoring project, with reproduction and checks.

 drivers/iio/accel/adxl345_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_c=
ore.c
index 6c9080d..5983fc7 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -1176,9 +1176,9 @@ static int adxl345_read_mag_config(struct
adxl345_state *st,
 {
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
-		return !!adxl345_is_act_inact_en(st, type_act);
+		return adxl345_is_act_inact_en(st, type_act);
 	case IIO_EV_DIR_FALLING:
-		return !!adxl345_is_act_inact_en(st, type_inact);
+		return adxl345_is_act_inact_en(st, type_inact);
 	default:
 		return -EINVAL;
 	}

base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
--=20
2.50.1 (Apple Git-155)
