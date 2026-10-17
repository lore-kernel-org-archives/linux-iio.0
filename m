Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4137DEBE
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792204727; cv=pass; b=LJXQBSHriRMKID8MMzn9K5D6oKMk5JIyQFNUWc7OwEqrCWTmOAcLfEnu9JBzFicETDvFpNIjiNfsQzcFsNy+OWBgERa8eRgBiqiFUumNUBxy14E18AKRXdfNtHDHGIVV3GGLLQynaET38CVFvUdi6D8ezScuxXdg/yiss4vQxpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792204727; c=relaxed/simple;
	bh=nOUZa7mPXb64B5PFhied2Fd9elX3CDzEuQcuQ/9SsVU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QLWRBzlWbhDaWMb3f1eEmofoCOX0cCzfIAX3GE1Jf6IRscNpsz3liTI80wq9aZV09mn41D5Glv8dQ36rWY7YV2AJG8xNW6uhJkbBYAj7lsfVb4GOL7BDjDkbibvS3r7wrFxWzrwUsXjaqtDL+/gZWY5Bk4H/fomfCzh6ShzN910=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDhQ22FO; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDhQ22FO"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c337cd6614so256914137.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 19:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792204725; cv=none;
        d=google.com; s=arc-20260327;
        b=CbmllL6lgdQpcKm9hfbIpDKJbdMijC07z8rwqYVQuE7sSy2xi+/vaHh1WeGOysc1hk
         cXv7BSWdGWO1YyV+Is6nYmUdSM76HJhrHfIowYdqu4oGZRu4inogdGQOY+JQJUpnSQS6
         TS8QyVVYGaGEdgtRhnreG9q8SbdD6EgW8JC7Ufo4LEjLIJ7OviZ/0dD3fag2lQfwTmg8
         T8qwVF0eFkRRog5YyE7jIQ6H9/MmnVQKpwjjdMaju0U0JGyMMsOOxVbLF+6tX+rRAXIw
         gaQPC/NS/bxEYcPr1Ue5zkzzo2HSFBSFtXVStCJSCc1BWT36Xm3ZyINrlTk5M0jOCY/l
         IGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=F+cVJX57n5iK3Mle6VsDiyzgCu683wJpJbVw4JqE5DA=;
        fh=ZRVIvcWq8Kq5oN8+koexvFApf7jUnAFYN87vrwydPmg=;
        b=YHI4o+CFOo5jpsEZSRRlFEvF6T7+Csd/f6u6TG2Zldg5E2Wsqb2IJfb5M/utcd+LdI
         hqEXoTKSteACQNTuZNCAy5NZF8IWasBc1HDkUOt9qPILFDd+Mh/PA4EFtAf8rj6qIOAN
         W9VGUPkCk4aOu1AvZ7PABP3xZk1kihGO8Ica6eYNcM/iBk5ugQszTVwBxPWVxw9cchQn
         /BamtU5CJBT3IUUjE+a331DL7EfyoZnoJVw0OExBXkUVXgLs5PFndkkSZk+gmW9ERGAV
         se0/DDZbPGVtDH1v1iXeJsBWFASON0fz5F3EWnW+0eqUAJUBJIgvMmNr5QX2+jmQKcT3
         VEMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792204725; x=1792809525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+cVJX57n5iK3Mle6VsDiyzgCu683wJpJbVw4JqE5DA=;
        b=TDhQ22FOpGglWO+4nvqHrnedJkB3n+BmoR2WUGm0MBNz2dVPxrpCzBftnr4nG+yCa4
         jR4EldbYdrcseIecVBdWaBGYH9jnyNoSbmi4AZ07Xi3nAmpXH0g7GkHOkZ9Hlz5JV1aZ
         /xXwmeTcVw5ylXmC0Q5iKX/92LADKnHrC/qHedI8BGePsZiq+r+Ah0s1DHUP4Th2cFwC
         RMNP4CK9C9TR6gEXVSjN3hl/oyI9MV/fo3oZIzwqblErtB0Tv1DWFO9TS09onQ6W2+ci
         lmn5/79M8hhkDRmtbqnQPpTFNq+sQT0PVYZFJ0w7/6XZZDmWWVHJgsXx36zgT/S+7yRL
         JoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792204725; x=1792809525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F+cVJX57n5iK3Mle6VsDiyzgCu683wJpJbVw4JqE5DA=;
        b=Zf12ep6xkC7z3/bol81xrEl/73hrll7W9MbJofFS7GJnI8kKcXcrT//eQgOAEV6Vsd
         UlClexA+hPkJVwxIXmitV/QnZKs808XpfxVMnm7Ytf5Y1Byu5RsAmx3r1mc6/Ymb9Z1r
         P7uU0+zzTV7FdZVmC+PRQTqWWDKlD9CdImJ9TQib/E+veRuGn7/5JGgsnQ2ddnDaC+6o
         X8qou3wzOcVyQXbFBqzmf5tsqKWNZPlh/C4L+ol1tDYoTBy0JbLNy5RQsDiYIOG7ws3A
         izHlHkFkMYs6Xb0I7urc0DqbenC1WMM15PjCkox5az3UH4D519cJragauLci+oBoyFWS
         f+wA==
X-Forwarded-Encrypted: i=1; AKwUvBybG7vCCcw8Mlb5AKiQtATFapHjbwOkxiK9aGSRb+jWegvP88K3EoR458hB1QsvmPUF5Y7QCDUA3QE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKH2ZLYuf6bpdymBIT81xcN0UUJIZYf8Q2AtzUYAPQOVtWK7fy8
	5SMTWu08+BQazt7+tdbo1A7FxGmJ3eBgiOTwZ80scoGx6IoN9B1RkSZ4CJqFj63c6KAOJdXhpdS
	xJ8vcdSVSqv+3bO8v+Hhw/WoeKiJ3sBw=
X-Gm-Gg: AYBFou3cfocYO3mIQSRkNGOdwJPW7amRK01FoUhJbdYGxDNTanV+QGcpyP06KajDqDw
	wHhjGjQdSxe1Dyf2uEMuMei9G586+Z6FbIvhkdtSX86esROQk6DtKDnUwUPYM4taheeUHeDVwJS
	CxH2j1iNH/Oghm0/6+J1GvWAMGO8ELaH+iO56UN7XAxC6YzCH8AbJp89AEJ3pJCmxxzAD+hvuNe
	kd9yDJPPU5/yoAQ0ScmNO7d9W5BOq7S38spvel/5ejBUhLV9d0i9vd1E7I48DIkZBs4ClFdokX1
	Jmqm2c3Qy88NR3cg4o5XXPI5kp/uiXoPvY5aZXEodry+mYe2BGgjz/A=
X-Received: by 2002:a05:6102:e13:b0:7c3:3f26:8785 with SMTP id
 ada2fe7eead31-7cc36911894mr511447137.7.1792204725618; Fri, 16 Oct 2026
 19:38:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 19:38:45 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 21:37:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
Date: Fri, 16 Oct 2026 19:38:45 -0700
X-Gm-Features: AclHuK8YKaodonu_D7Dy53BTPfOy_XVt1iqiprjUi0LnQxRlVx4_q3w6CmNizuQ
Message-ID: <CAF2O-sPfK96Bvqtu-reg+y--nuV35tM57Med9irz_a3RK1xhsw@mail.gmail.com>
Subject: [PATCH v2 0/2] iio: accel: adxl345: propagate event regmap errors
To: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This two-patch series fixes regmap error propagation in the ADXL345
activity/inactivity event configuration paths:

1. Propagate negative regmap read errors from adxl345_is_act_inact_en()
   in adxl345_read_mag_config() instead of converting them to 1 via !!.
2. Preserve negative errors from adxl345_is_act_inact_ac() when
   disabling activity/inactivity events in adxl345_set_act_inact_en().

Changes in v2:
- Resend with a [PATCH v2 0/2] cover letter, preserving patch line
  lengths and whitespace to address the v1 formatting report
  (thanks to Joshua Crofts).
- No code changes from v1.

Assisted-by: LLM
Signed-off-by: =E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com>
---
=E8=B5=B5=E6=96=87=E5=BC=BA (2):
  iio: accel: adxl345: propagate errors when reading event configuration
  iio: accel: adxl345: propagate errors when disabling activity events

 drivers/iio/accel/adxl345_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)


base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
--=20
2.50.1 (Apple Git-155)
