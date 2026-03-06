Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EFE366DD2
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781466; cv=none; b=jENPW32mfAr2BKMnQ1sqed44i2mlR/pE69AeNHlRx2bKR4uqwTFzuXety2TA2PWWPmr5tsDqyGzCTYsQpKp5Od++VyPu1mXoEpldzo9abcEY3bCiAAJfRSoI1T5ToxAUPxJOmPg2zSLs5rq6rye2beCeLd2Dx0rQcvkhEAJ1w1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781466; c=relaxed/simple;
	bh=Fh0qbI1ajq3bnjSa3lbVuUPdV7Dqmb+F94tP/KqFas4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pRW7KV88wiSaNB80okw3d4BG4YKA8wNLlGw+GMvVqvofmrH5eknGXGt2R2rJfQOcuAWyBOyMU+3eu1vB76Q6O1t634ggyB2uCntYB71/Z8CM2LlnucUTblCJWk9GHMosSUcQwcwJp4LSF9vGJ14zN7F/UHj9554a+K9hE/TUtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqYXoM41; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqYXoM41"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ba895adfeaso7833745eec.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 23:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772781464; x=1773386264; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89vr0ibjLvGlXMkZMP8eAKhnr81FzcNLTu0TR8b9MfQ=;
        b=HqYXoM41fgXR1NTB2mvsLgyrrOupi8+RelDxTe9StzixxY6yV+8Ioy1VDHeghQtwHo
         DvajzsJzDTD0Yuqd7N782xh6TgWLl0BC1Qcc5xYfM8iV0w0+dRl4sdU9+oQTLNmX8HOJ
         Qpu9raVRtDD+rKX2mSR+LZyK+qgWTaI8doI8tG0ZIsClrRSatY9qFAAHyWYwyRETi7ns
         HLrfUDB+c5eAPYwKLUlURTXaHozZboA8THI3vnDaq2Z8a4AePEoc1h8TvCmFwvEWxO24
         iLvARdogC/0oNk2cVWI72DDU3arFO9fdzyISu7zah7VBSCT6x/dURJrDaEH2pTitphqC
         v3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772781464; x=1773386264;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89vr0ibjLvGlXMkZMP8eAKhnr81FzcNLTu0TR8b9MfQ=;
        b=C4gw7Pa+J4f7LUthXN3T9RXXuXDEE2yP+5rN2mX406IA/TZ81JfvoFKqhiTjEJKpBz
         9Euyw3h/l0wNC0p7rumOl9RKimxjBVPKoYNQbowQoHUBPVnEPed3B9uaWkKGcQ8q7WKS
         eTN6hJZxU53zWUl8KoCgw2HVFga5xA62DBe1HZACO4teCPS33cBGdKP56A4jfp2e8N4e
         CKyHvfaxznPaMztQI67UDChIQaXh3ryaN+pd/vBeWzIUN2tRM5uiyNlzLSbcXdiFn2XP
         YjCagVrSPD3ZUUss8syxWZOgPWHGtTqpWneK6cFI09JrFz3YdaLarQb6R7C0PWETiQSl
         zn1g==
X-Forwarded-Encrypted: i=1; AJvYcCVzTDpFdV6Zowfc2Asc3WnEUiwXJ4717lV26p88xt44eQjphVvFWcMulhuf0V94pOxVMuuwwE6T19g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kwmWRgYSDflQlzUlOqwdw08iIZ1x+TUEw8Hs9ZXVTSNk2dxD
	CDCWlgqIMhryCeoz4L6z8rZOoVSeU5E26qhkyWK02E6Mnohqq/wumXjxZ3+v625l
X-Gm-Gg: ATEYQzzgS3Sz/SG/w86xacT58twnhsdTQek/TfYzv8GSFE4LHpznquRhdqTVaMsY1wo
	EDgHOGASrH+AmaDw31IFDwjdRtYshymzcwv3fgxguReu8Dfw/lDt9fMpqYv+zTgQJDbGJT6IR+w
	vEnnNDyzuV6ECnAdWPohiWM9O4qchIMMiQf6VyBtHPAkViwPyQsgSLtZOdkouGiProRxyt7ZGVs
	x9kaiKnkBX584Al5mW6fEB/1ft6kq7DNS/5s8mEutGKmctjoqNnRd0cMZkN6tSge4DY5s/nE2P3
	sNqhfPWaHFEwnbsm+gKc/l2Pi2GFHAhCy9VijWdYlZjuix6voRzx6rJyuCgFuLLYEW3XurLqWn5
	nnKK62mOfJAELZFwUkaT8KRchuZGMez8lAwLAPve5X60/leJGfCMEQqNeldojYrVrn22hWrNDBK
	0rxcet0nF9I/A1xluuLU79LYvRRDU/G5cFRoAoEw==
X-Received: by 2002:a05:7300:cd90:b0:2be:2b16:b99f with SMTP id 5a478bee46e88-2be4de928fcmr419987eec.13.1772781464272;
        Thu, 05 Mar 2026 23:17:44 -0800 (PST)
Received: from [192.168.1.187] ([76.50.196.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96f25bsm545713eec.28.2026.03.05.23.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:17:42 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
Subject: [PATCH v2 0/4] correct macro issues
Date: Thu, 05 Mar 2026 23:16:57 -0800
Message-Id: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NPQ+CMBRF/wp5szV9BQtx0rg4OrgZhkc/oIlQ0
 xKiIfx3K5ObjvfenHtmiCY4E2GfzRDM5KLzQwpik4HqaGgNczplEFxIjjlnpMcyR8mUD8GokfW
 kgo+skRXHpiCDDUKCH8FY91yPb3A5Xk9nqFPduTj68Fp1E67jr+cJGWc7klZzqqiUdGh7cvet8
 v1H9BeeONQWTSEsfuH1sixvQj4iWAIBAAA=
X-Change-ID: 20260130-adt7316-correct-macros-b6801b4ae1b1
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Harris <michaelharriscode@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772781459; l=1853;
 i=michaelharriscode@gmail.com; s=20260130; h=from:subject:message-id;
 bh=Fh0qbI1ajq3bnjSa3lbVuUPdV7Dqmb+F94tP/KqFas4=;
 b=bLF4VJL2k9NZhl/Et4g24Kw/ijyppHV+Zvz0gQWWsgYPZRSIg3VsOzW/b6nX+7plHyvwMrQL2
 e5spsYum3BxCsZoniEr9xpgTkBdn0KPmcATyEkQ83ygDtuizCmfj7pN
X-Developer-Key: i=michaelharriscode@gmail.com; a=ed25519;
 pk=td/zQD3XANAhdG3Kf3mSetXiynk1Ql0eM4s0+eks5DU=

This patch series fixes various issues with the macros definitions, such
as:
- Config macro names that don't indicate which config it's for
- Magic numbers
- Mask values being before the mask itself

Additionally, some macros are outright removed due to having better
modern standards:
- Offset/shift macros are replaced with the use of FIELD_GET(),
  FIELD_PREP(), or FIELD_FIT()
- Macros used for custom sign manipulation are replaced with
  sign_extend32()

---
Changes in v2:
- Delete "remove unused macros" patch
- Add a patch that fixes manual temperature calculation and deletes the
  associated macros
- Add a patch that removes offset/shift macros
- Add a patch that adds the associated config to
  macro names and adjusts ordering so that mask values are below the
  mask itself
- Use GENMASK_U32() and BIT_U32() instead of GENMASK() and BIT(), to
  prevent sysfs_emit() from expecting unsigned long (thanks to David
  Laight for this suggestion)
- Corrected macros that were incorrectly using BIT() or GENMASK()
- Change the cover letter description to better fit all the new patches
- Link to v1: https://lore.kernel.org/r/20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com

---
Michael Harris (4):
      staging: iio: adt7316: refactor temperature calculation logic
      staging: iio: adt7316: remove shift/offset macros
      staging: iio: adt7316: add config names to registers and reorder
      staging: iio: adt7316: convert magic numbers to BIT_U32() or GENMASK_U32()

 drivers/staging/iio/addac/adt7316.c | 384 +++++++++++++++++++-----------------
 1 file changed, 203 insertions(+), 181 deletions(-)
---
base-commit: 5d2905f2c6acdd1c553f9b022dee730ab2cced71
change-id: 20260130-adt7316-correct-macros-b6801b4ae1b1

Best regards,
-- 
Michael Harris <michaelharriscode@gmail.com>

