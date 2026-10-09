Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7802A48CD55
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588382; cv=none; b=gKMAJo7CvjOj1BFqDpPOBdV9DJHu2JjI0crBVBDShbXCVQ1A3TCas9IlZvLVMfVLHYnvYwk3iz6DCtNx25qZhGPD/WrZgZNBbWv+o1ms7Ompq1Wx0qFcY2G2NO0oH0SjVe7ND7DTKl+VOiTmCpejetd4LvdTf9uTCz0R73vtbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588382; c=relaxed/simple;
	bh=V5O8dJGvVTHLXZ79IY3HVKNJHoLUT5+l5KbQEv9k3cQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P1MMO1jfBe9aZnCrvYoicM7+Rfp8xqHzcEaA3s9whHuB2iWgDHZ6h7b+8x0EsqWhUNNlgPf4imbTVqeZ2xaAHYiSDnW33SpvdS1lMj3AWTRpO8rNP1JzzcRVpcmYPoUEv2Aj/tcTJ+tEV3xpFuj+gnQTwStxkfiyVLRWfljFdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cBZzdgLt; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cBZzdgLt"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8253bc5a613so233746a34.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 16:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791588378; x=1792193178; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NszE5JWc8g05JKm5j8AkIMR178Aewhhb4qePMLYWK8g=;
        b=cBZzdgLtrX386sodsiaUUI4v7KHRDIGmkBu1KOxdblm8e4tXEFmDhkxqiDLFc/Wmc6
         LQyqoixFbVt9czaVJXflhJuTH71aQzd5SaPu2iqdLJ89DM7gQtH5ObzRLsiErfkx6g8e
         oPNNCyJrqhUNozlrBhAbxKAQC5eDZyA6KAxO03S5pgi07UweVEaDpA1gJRSl8f+u7R7D
         3MmkwZHD0gfyTNWd2o3CZgD+TGkjtzNz/N3ISC1G77n23da7xUZB9ZHweLmSdbF61q5K
         hXPQ7vzi1RrPl7kCzRG6IwJwGXQKyK+JiUkliwBVybKvFszzw4/rMn8xZXUq7e0hmhF7
         RPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791588378; x=1792193178;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NszE5JWc8g05JKm5j8AkIMR178Aewhhb4qePMLYWK8g=;
        b=ZQD+sAgrgCg5OcbRodPxzj02LphVdOht7VcyKMlhWEhER9G5VJvjMzi1q8YO06u7VJ
         2ShqzOTABevLjo8+nNy1vBs2oyany++C8YKrRAS0yy3Vq1eGJ/FUP3jMxl4V50aztTXp
         OvQ0RIVuqXEUa+isv1Tcf+HY97QP5S0wlJSeN6Q4/alh5tXq0aYEGuSttvJD0WtEZqIA
         IXdNC1Pn7oLneYWFR+wocXg+m+JlrX3ao6CE/Sw8l9EnrRUV3NTn83xXuQPdPsuX04hs
         J2qvdDAi7DxEJIhdeKsZ9izjQ0bXUFABq4PK5T99Wn9xiVJpvHOK39/UILo/nh0p156f
         zAcQ==
X-Gm-Message-State: AFuF++n4b0rbjGC0AEoktpaQ2p63MKL3sLA5XccmyEl/B8hFyjg9LEAL
	OfZwdEjYWtAxYnX5KFRqnQdNLGy1IxC+99ZnaggY46GTIF017bsPQCT/oFQtnAGlhLE=
X-Gm-Gg: AYBFou31RflmlJuivMqPP67H7evs6y3Kv0adsGH+K/bgJwlrLVvgl7gLdKZCdyuDPNs
	07ye5wjpIevVm5wP02fgus5wsYdX23qKsHGbDOKNEkQBg5j1+cPc39LxVbypYCtX4gOndtBqWLA
	d+HWv/gcKz1a036DZh3XPajRwxr2x6zMNjM1oKRSMtanc//pJywyAo2ffjnfiQ/aSl4PsNyNYac
	f3FbVqDiAj9UYn6gI9cn543GWj7TvjLu5CWJAq9RtxrgUMBTQryC0B1Mw8ZrqiiUrzsl+U394W9
	SCF0ouSZUfrUomagwJlkB47+90P5Bn10nB/4U97l7ng7MCum5B6OTKL5XKKB7rzbKEfqogBYbmH
	zWAo3QDKilsLdfRSgYZUm2CpW7m11pnMyJ0j50bVMoAuFnNp9iBIrZIbOlMdCwYlkuQypDTSeKE
	NY26biPOANDy3CJ0O1LfLnxtbHHVh0CLQlmjD/CPZfj34gPe2VrjaGtyWeV+U78iZ3LGvi1KoEZ
	KM=
X-Received: by 2002:a05:6830:3892:b0:822:6f0d:d04d with SMTP id 46e09a7af769-83095a32c5bmr2862182a34.16.1791588378320;
        Fri, 09 Oct 2026 16:26:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83038f82468sm3293817a34.11.2026.10.09.16.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:26:15 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] iio: adc: ti-ads112c14: add gpio support
Date: Fri, 09 Oct 2026 18:25:50 -0500
Message-Id: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBCFr0JmbQ0zoggr72FYtGWAMUpJi0RCu
 LsFL+Dq5Xt5PwsE9sIBymQBz5MEcX0EOiRgO923rKSODJTSJS3orESc0rVVo0QJiGQxU+0QXSx
 yYzKbpxkixP7guZHPvn2vfhze5sF23Aa3RCdhdH7ezyfccv/8TKhQkSZDeGXTnPTN6PkpxvPRu
 hdU67p+AeVkziHXAAAA
X-Change-ID: 20260925-iio-adc-ti-ads112c14-gpio-197bb4c70411
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=V5O8dJGvVTHLXZ79IY3HVKNJHoLUT5+l5KbQEv9k3cQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqyXgDfeWsuBRQjv+CT9pO6s6OEFyD676vZm2ga
 GSJXkFPbrGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasl4AwAKCRDCzCAB/wGP
 wGdZB/0WnAcqSkRS2vhMq+W0Jowrz141X8ZHRI7AtfaLaNZm0BmDq7zZx4o7jDMMen2Xz7t2XEx
 yWzLGWlkVf66Uo6v+smNKp4xQ2fyrOyvHf2TT2FpAZcgvnjLRgUI/4gH0r3zDs2G2m+a4L6e/Lo
 PXl2hGW91KM7HUi9+x42I2tUS5U+GaO/yPP4fA+ykst6UpYUv8jnYYcmqOk5WoO94SJVuyo0kPb
 KZZlr4mKt2XxTWbWdqTJG3JJH26wGo2m86YNMTHA9FIzqd51bwESDw3+TlEAnQvnsIGgOJ4cveW
 g5mNPraa1GVb80IW0/7L1yw3FGBa/48CVOpy+8DqhsJ2LAzU
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add GPIO controller support to the TI ADS112C14 driver. The first patch
is a small cleanup to make the GPIO register field macros usable with a
GPIO offset. The second patch adds the GPIO support.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v2:
- Split out GPIO register field macro changes into a separate patch.
- Make ads112c14_reserve_ain_pin() return ain and use it in assignments.
- Shorten names of GPIO reservation helper and mask.
- Set reserved bits directly in struct instead of copying from probe.
- Use non-atomic bit ops.
- Drop unneeded bitmap_fill() in init_valid_mask().
- Add GPIOLIB dependency.
- Link to v1: https://patch.msgid.link/20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com

---
David Lechner (TI) (2):
      iio: adc: ti-ads112c14: parameterize GPIO register field macros
      iio: adc: ti-ads112c14: add gpio support

 drivers/iio/adc/Kconfig        |   2 +-
 drivers/iio/adc/ti-ads112c14.c | 191 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 171 insertions(+), 22 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20260925-iio-adc-ti-ads112c14-gpio-197bb4c70411

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

