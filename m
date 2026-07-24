Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57143CE7D
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908533; cv=none; b=D0HceOOzsY0On9dSCq0oTZzvIMQ1EYjp2u38a5+Kc08jOtnj0NBaSgHpZ+tzyT8gyVskpH5H/xtsMXWQBj79K0YhgoPLa77XTM7c8SDL1qddWl/PqpJ2TF2o/C6Al6zv4spSGbfvIkCo3wbyDusQGGHMk1PuaK78eosUSezpqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908533; c=relaxed/simple;
	bh=13LyG2fhABc676ik9gHXQA/E9NV0US2+ZEqwKc2Ktdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S9IQnKH2ZRPCjT7iSi59nkOrKPHp1PETiadjCBtmExJ/0xwP+9BuRUrb+FIThwVFrRHBWYuXWq9xZCtW9h6y5MxhZmkt42zMpE6/7C6Quxilo0s3yqNBZacLNpKGVquzEwMGjpqK+dyoa4kpALcRaGjKpsfJRUgqEie/niNEvyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ev/aCI6f; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ev/aCI6f"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ee50eb2db4so453594a34.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784908530; x=1785513330; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cyid8Sn56jsXPKcKwRrHqdi3wSKWUNrscCWSRaYha8E=;
        b=Ev/aCI6fOj5ZWdMjBO/n8Ou7AMm5LQ4I/ZURgvP4qHxi7eztozDw+CwPHMdPqvy6dD
         0xAY4GmG4JeULQPDLqkkwcs396TuDMyc8GTNnQr3NGLkAACMgX2gDkcxvSSMANGSX8XF
         uc9oOlIRpnFSVFJtJncmKYSS939PFkOqxQG3q6fzrjvMqOFOseDHX1694iwfUBA3PZ6/
         tYUXweR0oA8FdAz35ays0mrZG5lp5pdhloA5xn2U08YwpjYpRrZKUyCqIp3Nkxw8pOXg
         ToOFkZQ1IqliDkPuK0I+T5ORJoOVtMyY6d8ra+rdPL6fbGUw0EsCKCFzpgUnNVzgPYLY
         mPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908530; x=1785513330;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cyid8Sn56jsXPKcKwRrHqdi3wSKWUNrscCWSRaYha8E=;
        b=Rsw71GPmhmboQUEpGwMaz6e4wNYwRAY138x9M0UtXHNsINkCDlzMVXcHshQ6RgItMV
         owT5h9WHJtjlJi0PenAkTa/UzYtIGTVL+NaZx0SogpKCdq40qq4Lh3cM6Wa+xPlr+OkA
         +ZGzpC5UUXoTAN73fAr0iYN5D/gtr+UDBYvruw8TYoYE9N2h6nKrO67Ra9CXIfakx/bC
         wcHBGoS3CJUlrhYmPLdu9Xh2fOnYJajS0ovnamNrdR1o5ZRF7iI3WbWxYsG822JS4iz7
         LfbuxhRYGMPMkNYclPBh0c4FrV/erPiiCKpLcpJQ+Y0GakCM1+bWADqT60xRBejFUlZp
         vtYA==
X-Forwarded-Encrypted: i=1; AHgh+RoOThq6TQcZvlUE6T4Wm9JMzjhKXuDQOZ6yYVDey1rQej6Whtg/crtnnWyaNL3whE0+SIuVCwpDIFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9z6u2GgsfSUDZTthIQMd1EBQRK2r7jx1EL49CQYX7dGhx9zQW
	p3B7FkCij70sVwWQaJ2RdmVLYAfqkZT6brx3J7oXhkzfru4JdbvYFhqG0P85SVlOUwk=
X-Gm-Gg: AR+sD12udAjFaNMyibuX1FpyNLV4Fxb+L1T4+3Uas5JWc9Uz4QkJE14kSYwLi/HrCTJ
	8zBkHFyY2orfsNRm7OxcV4NyBmazAemwJFvsdEgdhVqkLG7lLj0o1Mii429ASLxyt9pLBNbqbTO
	BnGSLphnaonwOIXufCz9+WZpVP6CAUMbgxL/krpod6ZL1Zdmae7Wm9FOessexSd+Ayj9JqR45i5
	aSyMu4kvvZRwpsDAk7RNCyoV82uk8pYPCUaNCpdQOTq17NC9t/Xueb0RgWfEOiCETSRfNCPtslw
	6zt4J+KNhx5g9czKIn519xuDtOoyNrIcQWNl/TUXzSzub8uPwsSykIy4+sxxstyngUbMsTC3yGv
	7CBzUrdCRM4uXY9+tg9Zmp/8Y3ogrTfjl/uF6KZZgKi0iSrr6Nie44kn358fiXgUpU3cjx+Yad5
	j1YMyHkQ==
X-Received: by 2002:a05:6830:6ac2:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7ee43a1fd18mr5020745a34.1.1784908530278;
        Fri, 24 Jul 2026 08:55:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a03eba8sm6160911a34.17.2026.07.24.08.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:55:29 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] iio: adc: ti-ads112c14: buffered read support
Date: Fri, 24 Jul 2026 10:55:05 -0500
Message-Id: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5VPS07DQAy9SuQ1JvFQ+ltxD9TFfJzWiGTAM4moq
 twdN+UCrKxnv59vUFiFCxybGyjPUiSPBtxTA/HixzOjJMPgOrftdrRBkYw+RaxioxC5aMsw9T0
 rJ1T2CTfEr4mi71J8ATP6Uu7lZw15Pz1wmcIHx3p3/mMof0+WXh80CL4wxjwMUo+N6UurPGS7t
 lagtVllPMPd7SKlZr2uH8y0iv9TdibssOctUzzsyO33b8FfPyUoP1s8nJZl+QUn548YJQEAAA=
 =
X-Change-ID: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=13LyG2fhABc676ik9gHXQA/E9NV0US2+ZEqwKc2Ktdw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqY4rdXRbdKzNgomIgovXbFNdymyFhGfuPuhlkD
 8mdiNayEguJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamOK3QAKCRDCzCAB/wGP
 wIbvB/0QB/yBDjrxGutCracP7xpq0YRUfV5Xo3dXSMlou5axFeLam75mgi2nAWRIkeu4xxGODpV
 AQ6WCFlXi4xn1U95F1nnJI8LeVhl/4wrKDemWMpHV94CxG+rIpSBSW9xPtlF6eqc5f2QtLirhJp
 RTlJvqxMO46YCQwTju0Rc7WoFbi4DXWShRxlN9PX0i+IgyKfReQp2dt6IfjHdvfSWFfsAOOPXD7
 UtMukXtg067WW0rHN+aADcOOLWJYRRIYauCeFX00RhQOit+2DCYmd2Twl1EDEbAqJswqYsaDj2B
 M/MFPa40pGqf04WiGBlCeYF2/0wCG8An4hdRFAqxPxjO7VR8
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This is the next phase of ti-ads112c14 support after [1].

Some design decision notes:
* This just includes support for software triggers using the single-shot
  mode for now. We will follow up later with DRDY interrupt support and
  a new trigger to allow using the continuous mode.
* We wanted to enable CRC checking for data integrity, so it is just
  always enabled. This way, the buffer layout is always the same. I
  don't think we have an existing control for toggling CRC checking
  anyway.

[1]: https://lore.kernel.org/linux-iio/20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com/

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v2:
- Dropped debugfs patch that was applied.
- Adjusted for tweaks made to [1] when it was applied.
- Made some clarifications in the last patch (commit message and comments).
- Refactored the index tracking (`i` variable) in the last patch.
- Link to v1: https://patch.msgid.link/20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com

---
David Lechner (TI) (2):
      iio: adc: ti-ads112c14: add support for I2C CRC8
      iio: adc: ti-ads112c14: add support for buffered read

 drivers/iio/adc/Kconfig        |   1 -
 drivers/iio/adc/ti-ads112c14.c | 255 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 243 insertions(+), 13 deletions(-)
---
base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470
change-id: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

