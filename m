Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F69381EB4
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792204752; cv=pass; b=OJCWVQPqfIXXDJL/TZMzdr1PDQ9JD4c7aaxlrCO+6tyfmBfEp636yrgFnPnqWLOeP6Z4oKOp79ttbKobZz6V9i5Gtcm2qq6pmGXk51RkhOycWZqqx7PzQLLMn50wzlRcmYVqrmWh0yhZ+qTmLOlYXwjyNaI12RRpHn4oqepUQfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792204752; c=relaxed/simple;
	bh=XrM8GNdz09aTLpj/YWt5QoBx4XJXWOW0t3qeZquGh68=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uebEmA7HrtCcUglaxovrDsEZJCgIyQVeDTnt2sklrs6aIq75axg7empxIzMgY0mmF7xPU0QbMJpsVxd/fJs7SKFsFUn4V6cAAILgoGiWx6LVpb7Tie6UTaXD7AaottLlkskhdXOvUIOOrGe3MeJXhyWp9M8IprCYNei0mBs4eVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQtqa+Bx; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQtqa+Bx"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5da7a39e584so195769e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 19:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792204750; cv=none;
        d=google.com; s=arc-20260327;
        b=lxXfjOQZAvEGdFMTjKJ7AgGMR7JhAqIPBjz2eEAYo9B0f3SLx2WbTaT1Grl6EOl+7e
         aKejM7EUhUX5EXjpxE1+Ihi9saczK8tbno0jtsuGzkn4P6EiNZGWhLxd7IZ31i5A93Oi
         Kfcg8jSnvigjQAafJsbzjSrqhQw7hqvGVVbJXOq1ItwlreNG3as6TVB6NZ8TJhGH8eU5
         xREWREM3tuDw0kK3EndEKiqOiUBS2GSI5jMiT8nZZishvgwyHLsDWCA5mqa8xiXNwFH/
         ImxVncT8q0YPJA/q/j8tTRMQtO+0K3Bdpyjr4zguvsDN1P82ufh8MngNpK2L5geKqS4A
         dT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=X8L+iNlTtt3HRZDj3HQaVSJLaMG+O2tpW3fkmUX4Knk=;
        fh=3M2VIZNmBSjrbkEFwprQOcF5t3rlu61l521G2+Gs2YI=;
        b=hhFNs9Nrg+pE2CxnuMIwYSakNIyfB6anEjeanSazxfXXkVMxOASep0i4VoY5+7k03t
         dGnF5yqRWnR6FPl9a3OW4TFG/MZzqspb77dy7Y0hwdBEnZnerX++zzPXfdx/M9HN9dL5
         /6AWnn0M/+y8QXnBBdtKG9y5jP7s4GebBwcf50tlCW7DO3dFLeMusTApOvL+h95+WG2P
         JgAjvmuMKipSoUtC/MUi/B+IFV2RxzN7c6/s90+jlmzS+UgooMlmYEs+ff3SXw5sv8uL
         NIG6cFsC71PqlC/pKUt+wxbvVjg716zoxyUdivaWjar9EpEQLknt69S1H/0xJ2xkutdG
         nhdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792204750; x=1792809550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X8L+iNlTtt3HRZDj3HQaVSJLaMG+O2tpW3fkmUX4Knk=;
        b=SQtqa+Bxlw9myc2CwKJLX4sgLyctPV2TcZBBb8huGIlLrOu7vxDVtPvx9sJggJJS2T
         jdvDpz7U0CDeh0Bd8CqAKwDB9e+CeR+6kuiii7QiQRpuW+ugoLLx8jdFCIQBl8gUW4t2
         /YoD5lxDiMLcOtRCVt7OIVK9Fl5IQQaY3g31DDFZ70qs4jGsXBwf65ZXlHkYB31zmA8Z
         HJQVUekp0rYS+mGOphcFLuWZY4qKOc0pI0yUx+zKndiqKKn5l7yU471y8fYUX8dA08tH
         C97+OMZVZeTh2LNxjl8V5roPRgLsAUO8u71WSd7hDme0Yx8LdGbnhY0H1FRCjiqE7pAw
         1E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792204750; x=1792809550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8L+iNlTtt3HRZDj3HQaVSJLaMG+O2tpW3fkmUX4Knk=;
        b=ejg6wqxEWKFH0sMrOIJlPsFftzYF++iNUTf+PnSgcufJqY0QYYz6F9SOiHsmEsIZh0
         TBh1waxed8/7WRLf9w4N6+n+sYddVtMTpS/SaAa1IhcxS1cf0hhixQprNrC3e6sLzo0F
         Ry9sl7fLHufVbHsUsoiVE87CxAAGEOCaEAYbLodwrKgpbgQOca3077lLU6g6kekZ6x+e
         iq9wzH2hqjKlXp3CkGeUG0Ud+ZskXkmcDWv+Vjv6C0NfCU53vvrJ6R26Ow1MGdH4thWB
         x0yBBWQ5x0jUd9NCw+T2dC3SSZU8Xqm6tFTR1SggVRIK2vY3TAR5qlj7nY3nlk2WIjVB
         V1OA==
X-Forwarded-Encrypted: i=1; AKwUvBxnCDnJhXMTy62N6T6T3qYHmd5o/3koTZAgvGiJ00w9cyaxi598WeCMUvalKmPl8eWMj9BH8YRnw/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqzqs4jA3Q/Aap2tvgY1bl+JaDd/KboIqDl17IRirDiXxhznHL
	o7bM9JYuu6EZsz0TjEbTzQNpVoUN/cnPB7TpgyuG9qOVYy9qM5cEyw9PZDkTrnIXzeErKN1H2tD
	Cvhf1oA/5ldKBVuV9qWYgB8GSf+lnldE=
X-Gm-Gg: AYBFou1e0WagMQvaa/wdblYSsFhzNicPq2v6CPrIjzoV04mo/s6T9Nvi7CHHs7Z7iVJ
	YmIBhc5UH5i2RJZ3J+XLmXYdFlSfPQkXFbOdKAra93ax+CT8rj+3JPWq9FOYvis93suio3waBSi
	x/oCBqyHeRZXWV6Onz6RALS8lzPOLyPN1MQR5pPM/9lz7QOspq8+6kXLo4ZMmrxw/A9pz9C53PM
	GLdag1vlueUiVDKv33BdGe3uboPnjFKz326fdUpe6izAq6dqqVGzNGG0EUMNq9zbk5rpurKvl9W
	39vLwkavnKVSmnkcawA+PY1Ol5BKlaiinTvHj9aV48/I8EMvKEhO8KY=
X-Received: by 2002:a05:6102:358d:b0:7cc:32da:56e with SMTP id
 ada2fe7eead31-7cc369a49bemr321993137.19.1792204750392; Fri, 16 Oct 2026
 19:39:10 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 19:39:08 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 19:39:00 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 16 Oct 2026 19:38:19 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 16 Oct 2026 19:37:42 -0700
From: =?UTF-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
In-Reply-To: <CAF2O-sPfK96Bvqtu-reg+y--nuV35tM57Med9irz_a3RK1xhsw@mail.gmail.com>
References: <CAF2O-sPfK96Bvqtu-reg+y--nuV35tM57Med9irz_a3RK1xhsw@mail.gmail.com>
Date: Fri, 16 Oct 2026 19:39:08 -0700
X-Gm-Features: AclHuK_IN0yhhB4sCeARlYxYXPd7McL71ZiCetTEMjL3AdHkwlcwOj_W8gMlVrY
Message-ID: <CAF2O-sO3OJH1sNnm0TkDXkEwWPKM21+s0_iNgU-VAmF+kMWtLw@mail.gmail.com>
Subject: [PATCH v2 1/2] iio: accel: adxl345: propagate errors when reading
 event configuration
To: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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
