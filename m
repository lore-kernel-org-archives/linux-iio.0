Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF23FBED8
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105836; cv=none; b=dnQmqyAAAMOcYh/OxQ0y9te1SR+Tid+gvsRIHGHcemF2Iirqp/BvNsdbkIR0ezZp8ey6fHCqOdJ7sJStZKG07BOorH5+PR7gu83QNVCxCxdyqIXeddBojNCKZrYxnv+f97N9QeT2GxMkW9YFgLKkTO6r32zBtLdzzWwGo3/2qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105836; c=relaxed/simple;
	bh=wBnaUtV2m1bn73E0RS+N0clSJ10jlvxxL0XOMrvfdjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FZVgXL+g/JmzoaZH0IqNwzDqCH7UQMSbKoB7b/WN+OGYtG1x1R23lkmcXLsSDXy/e5IccALIBTiXhHRBWUy+4MtIcSP5zGs+mns6VX3GhMlpXyjEZl3KjEldjdV5lcFW8+0U1b+4KAJUNk3b/WpY4INz9yG437rgpZMd6AXCO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpkjxd6m; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpkjxd6m"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so4487293a91.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105834; x=1781710634; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWMGdAxWgvWEGE7uT8Kh2eO2enIROup2WpRiQVG+AjE=;
        b=Fpkjxd6mX6F1SwF7L8Ah1yvdFPARm4r43xhz8gvN1/LieXzRL3DZkZYtnAjn0993Bp
         nUL5q7H80kBi3IDMsuYnQPqk9HgH8+cYe2/KjnWKbGntmaXlibmJsr1kD8XDau8ABQLC
         NxpsKkzrvQ0GBWQEWP7MUVpx+XhUhByoLqtVyG8K8M/PZJ6rvZwNq9beMRmgCbKn75DR
         CxykSqe3j6DU4LWWWx7qXODvquch/U4oSWcZLKDweGagtafnPd/361n/MjPJideMXDxc
         8jbmSeScp5gUv2K47PUbhqtboRBeR9FOS59tYHcs7gSQGl/6XkwNroiVv4NibzSOgF7b
         In5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105834; x=1781710634;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWMGdAxWgvWEGE7uT8Kh2eO2enIROup2WpRiQVG+AjE=;
        b=Bs6DZKrBogUGtkWnAy9n8z7XJQZkradSE6MKk+ZFgoG4RhLUKAkR0ipeAbBRuOWSnv
         Rsjr3jxSE6alk8NWu9tLyaCMu8S00424pweDsyXlgzcwafzXVyLbdyr4a1OUZNQcCh4G
         mLDsR/lAt+iE5dE6jUTOj/+RWpVhda7lmQSdHowCcksRX1p4jixM6k1DdaLuZMO4DL1w
         9Jwt8GIQZgUM7ZS0llV5HGadT3hlBLoaBi5ZJheIeF37jrIHw+KvEbVYZtYx/oTzBtLc
         VovK5l32QsO2FRVL5Jw9BAxwRwIL/7jDyYlUbursvCXYsEW/9zw9mOtHZkrGS8B3G4KH
         erdg==
X-Forwarded-Encrypted: i=1; AFNElJ9L27aNyXKZRiotGEy2fRKUF7vUXVInAYTaQc8e3lfx9APcAXmW4L3q1pZTy/o2huKGqDaXR3puB/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGNbDEImw4znHUDRi+jSP79Tmt+7YIuNGtF3DgPCJZAffjmtp
	AVG981XCbJxSJT/QuX+6pgIyiV/syKbJCDMrQLvAKqcKqc8OQZa58vVY
X-Gm-Gg: Acq92OFtz2GvNCiq/tpVi8GoHAEhByGcvZM3tsUoDkSPr/+trhrCWS8G9CdKlvJtjBF
	mXAo1ZsyW++qMqpVtjNqe03WS89/qCe/I4bHKb0xPSTFWLheeUJ98vYB5JTHV0SH5/kkTvV6s/T
	XdtYno4vO0IyRUtFah53SeV6fqBG3QtamFIuvT8DjeQ2WN2QoXDGW+teQcJGf+NQqK2DO9VNT7p
	zCvV8Yo3waj8SsEwyk0qyO3ZN4q09bvLfO/z/9/YokEOrRvSivz7a+qmBFBj7SrjUfg6QZJjjts
	uovge6vPgXekGvfufBB9uqpkx82QIWWm4H/Pcs7/nzjT64vf2jVXPwp+bhd0xuZTRf1cSG6Tyjm
	TdXO2Elz4A0Ez3KBsxvM/Dfa52oRt6ycnORHMjsphsznfSDI0vWlv43DeU46+OjrekQkGL3ntwL
	Vi78VbUv7tRaJgW1Cjuvp5vrlXfVwW0rUYAxgoH8049ef3H886wb/voPJE9F3OzoyVjCDTaQ==
X-Received: by 2002:a17:90b:5787:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-370f0284a87mr26901004a91.14.1781105834125;
        Wed, 10 Jun 2026 08:37:14 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:13 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH v2 0/7] HID: iio: basic clean up for usage_id
Date: Wed, 10 Jun 2026 21:07:01 +0530
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2EKWoC/42OTQ6CMBCFr0Jm7ZjSYFFX3sOw6M8IQ4SalhIN4
 e4WvICZ1Zd8771ZIFJginAtFgg0c2Q/ZpCHAmynx5aQXWaQQiqRDxX2aSTs2CGzR+tDIDthinp
 38VRbukhrSiEN5JZXoAe/94V78+OYTJ8zW+1mdBwnHz77C3O5ef+vzSUKdK7S6iyFUXV1awfNz
 6P1AzTrun4BwQJOx+AAAAA=
X-Change-ID: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2

Hi all,

This series updates all HID IIO drivers to use 'u32' instead of
bare 'unsigned' for the usage_id parameter.

This matches expected callback API type and improves code clarity,
as HID usage IDs are defined as 32-bit values.

No functional changes are introduced.

Testing:
  - Compiled with W=1 for each patch in the series

---
Changes in v2:
- rectify commit message with input from Jonathan
- added reviewed by tag in all change of series
- Link to v1: https://patch.msgid.link/20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com

---
Sanjay Chitroda (7):
      iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
      iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
      iio: light: hid-sensor-als: use u32 instead of unsigned
      iio: light: hid-sensor-prox: use u32 instead of unsigned
      iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
      iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
      iio: pressure: hid-sensor-press: use u32 instead of unsigned

 drivers/iio/accel/hid-sensor-accel-3d.c       | 6 +++---
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 6 +++---
 drivers/iio/light/hid-sensor-als.c            | 6 +++---
 drivers/iio/light/hid-sensor-prox.c           | 4 ++--
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 6 +++---
 drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
 drivers/iio/pressure/hid-sensor-press.c       | 6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)
---
base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
change-id: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

