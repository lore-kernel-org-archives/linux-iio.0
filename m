Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D72C1584
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405337; cv=none; b=AVIvNYhnNNIyE+ufEOFY7bqrH7Q3L4ZOy3R74RCgJW08xzloax8ZTZfmoF6wJG9YUZet7BP5SxsvCaoarmLPGGA29iZWXmF0omVpD9sPLOv7hWbOLxr7yOufbienoAjKKLGhBUwu04ml4PHnMXORXQAnsGCCOhbbFbzk1hlZP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405337; c=relaxed/simple;
	bh=8qx/XKxWog1P5nWj59/e89o2n/LZJld80MrP89wH3MA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OW6cuYJIijjtWk+58D5co/XrdkAeM9u5+BrzW0SUmJGF8G1tFyYx/TRiI34rzLmJQBLwjoF8TWgE3d0Y1sN8LO3z9OTlK+4AvphBjRUwVGWvtKmQVpcndA4Wb8BCaY9/Sq3SjBXTR6bQuGQwmM4cWit2LDZFfKEiOmObNLSJ5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ5SliI9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ5SliI9"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66e6d960ff5so2110114a12.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405334; x=1776010134; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EP0ISSwcohEHN0y056AsDzemMTXanCaG3q2UXolPhgY=;
        b=BZ5SliI9uOM0aFCwDC1utJsJbc+cAQg8fiXw/pTUDG6u9rAsvex4foDiVbcKG75re1
         /OdY75RwJ8XvpNDnG6NeQsfeDy7+HyJUod8yOqtEBfcyTqBamNjZy2QhDZQY7APDeGZk
         JmlSKuFFwQFTvcDfeZuAf8LGUGKkNW8z4bgIg2B1Fx8lDMrVKLTIpvBhqPiiO7PFAHzX
         wKrvakRC5TvEZqDqShr8N+XLIjoGRUS+xtiPtudp1CexUOe8DEwqwQCHPS803WC49tS1
         3YH8d78mWXIQLEjH9XitxyQRClQhUGniA+Ql+C+rKTkPUJGW+LoC+3KWwrJYBl7b6hSF
         oFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405334; x=1776010134;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP0ISSwcohEHN0y056AsDzemMTXanCaG3q2UXolPhgY=;
        b=o/IMdoG/oGGvMdJlhxoZPnKSvjPMIaizY1r4P4EPkc7Cn13rBOCC5o2tFVZeSM707u
         ZIoaBdngwUwU5hXDsXP7GzzCsjuKYi1p4Hl4h7VXqpMcWKVcU1J8XM+6wqurcZG5dMHE
         TCTP8nFQEHPx2/KUGBbuqcbiAJzrTKQPKODbvzyvi0kGozldgTxwIG9QxR5byhoqGwi9
         OEkd1jDxjE37GqP77x0FBYHJaz4446/q3kbOQ+tpYmZCfNAphIT9YQQS/iPfbQydvwUt
         7bjYKInDpZXYqZuJd+upb/p86aYWKMNZphm3r+Vu4msS8S/mhHIH48I5TCIcAXyVQIrG
         nu8A==
X-Gm-Message-State: AOJu0YzNGIHQARexIeaMw0107lUDLHy3xJHQ5gHoKmHBHPiVarv9+55L
	2bJDkA7OW2CpWNMGMobawsldRg+yOObvNTWT9pc6V6o4F30Rg7yOFhW1yfUkfSTv
X-Gm-Gg: AeBDieuLMmKYkFRmwEfya5tHVB9+jYV6YKbHw5wVgN6z9bojKd4AgVdRV2U6U8AnVDv
	4R5Kv8XhWecWIOHS0dzVXXDI+M4XdQs5KrViSfbGMHdlw11Ey15ZpeQ0tMEcArlK6hVkpsgU4ti
	IdqZCxLrfqdvMbLndR61iLA1aN7xNVpJElCw0M1kApJuKEA6EmVccrS3fvElKcysnuMEIc2Pf8h
	1n8O15ehtwgCgfNzMefTsiUbEigCJkvxYZ+SUBehb3NCt/i8LOO6dd2yh1oRusesPEdyVe6z/q9
	CwsrA3ixLjddfblgkjmuNK26U0ul6rAhTpFWk2AkFybSzd2I6QckGXXX4fl7eYolA777cg8Wimi
	652/LKloOXbCZRXXoWl0zeHBEeRBYw0botYZp2o4UAqg/EDos6+Q2w8HmJc03TcZKOGxXCNBSQS
	BXXnM8we4nLAnTdMqilUXuidxh8RSOhyYP9XIQ
X-Received: by 2002:a05:6402:13cf:b0:66e:aca0:ed90 with SMTP id 4fb4d7f45d1cf-66eaca0ee07mr1569137a12.1.1775405333518;
        Sun, 05 Apr 2026 09:08:53 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02f389absm3195890a12.13.2026.04.05.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:08:53 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v2 0/6] iio: light: vcnl4000: drop enum ID table and use
 device-managed register
Date: Sun, 05 Apr 2026 19:08:37 +0300
Message-Id: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQqDMBBFryKz7pRJKhK66j2KC4kZHdBEEhtaJ
 Hdv6gG6fA/++wckF8UluDcHRJclSfAV9KUBOw9+cihjZdCkO2pJYbZ+aYkIxxg2dP61IumboU6
 xZTZQh1t0LO8z+uwrz5L2ED/nR1Y/+zeXFRIyj5oUkzWteUzrIMvVhhX6UsoXo9s0F7QAAAA=
X-Change-ID: 20260401-vcnl4000-drop-enum-0238061fcff8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

This patch series drops the enum ID table for device enumeration and
instead adds pointers to chip ID structs directly. Necessary
information about the device is then taken from i2c_get_match_data()
call. This removes the association between enum ID table and struct
table and allows for easier addition and removal of new devices.

Along with that, an iio_device_register() call is replaced with its
device-managed counterpart, to ensure that device is unregistered
automatically.

No functional changes are intended.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Changes in v2:
- Moved device tree table entries into one line.
- Moved power state function in probe into a device-managed action.
- Replaced call to pm_runtime_set_active() and pm_runtime_enable() with
  its device-managed counterpart.
- Removed vcnl4000_remove function(), as all the clean up is done by
  device-managed functions.
- Link to v1: https://lore.kernel.org/r/20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com

---
Erikas Bitovtas (6):
      iio: light: vcnl4000: validate device by prod ID instead of table ID
      iio: light: vcnl4000: move device tree entries into one line
      iio: light: vcnl4000: drop enum id table in favor of chip structs
      iio: light: vcnl4000: move power state function into device-managed action
      iio: light: vcnl4000: make pm_runtime_enable() device-managed
      iio: light: vcnl4000: register an IIO device with a device-managed function

 drivers/iio/light/vcnl4000.c | 274 +++++++++++++++++++------------------------
 1 file changed, 120 insertions(+), 154 deletions(-)
---
base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
change-id: 20260401-vcnl4000-drop-enum-0238061fcff8

Best regards,
--  
Erikas Bitovtas <xerikasxx@gmail.com>

