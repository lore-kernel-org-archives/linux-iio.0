Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05769398911
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778423727; cv=none; b=hP52Li0HU+t7OoCZ1y2G90p8H7h1hudCes6t7UZv9ot8G0eJ4FSrYz6i9K4pWk7+PhaYXBmo1GmlaZWNbkMeney/+vl+OtyRmHGYacItec3X4rruoKt6r8gBuh3AAO7+NqvPnFqg+mPM0oiQMRyOT9VqjU2KAF0wvuhsTLyvcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778423727; c=relaxed/simple;
	bh=LPW3CzMkyX8aVmQ8QJLkI8mInFYE7ZNck9q754Wwt3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EhGgIZo6eC8vgzkNy0HDSl7GufQcDB9XpwEvmaPFjyyyNtSb+pIG5gVIq87v0LQMar2hav0TabE+QlDtNIlFaXzja1GFS6eWwb55oDcp2LhZ2Lt69jlGexUa2xLKgKxU+Ladw0pH71KQXoyUnLcAZORA0O0aKXgYbK55Xks7JHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V14+9wHi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V14+9wHi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48e69e60063so1767865e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778423724; x=1779028524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2yG1YyL8PiPgfTbiFmJl/y0RSGwOWd+rEhPWgtBZe0=;
        b=V14+9wHiQBJqRhqAg7by4910K7WPuxpGe13W8eWMgjnf0oKonwcxA0UjgT6TpiPm6f
         o1QtgUpss0xQ+amOiHnGzHxEhJu/6WiMYk3dajmDlkN5osRt2uVbHTgKKHqCDs2qg9E1
         oeK3EFwkzDvVPwhev8TBAe5nhazQeKfAmpGaEym7GEllOpRPjUuLom1t9nxN0Fs0OU10
         g+H3qEGVNxeYYihjDPWtwJUX2QLRsuWp3Qh35D3StK7sqsVJX9++10vcnonu+8Zw/SFh
         8Bv0yQuZt/gppby9/w38p6Un9pKvRBkiBcnbXiQO/c4UbRwSmCuVThu39wk/3PEXlYVa
         1iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778423724; x=1779028524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2yG1YyL8PiPgfTbiFmJl/y0RSGwOWd+rEhPWgtBZe0=;
        b=C0IPTOr1olGFPwODr8Hv7geD7kVNOvAPVV9xnlSu9vxCe0/fYnZZI9DoWA6dzet7QG
         klgqkB0ziqW5CC/orcAsbxJB0uJywlFjpHjFRCd+4AgE8VKUQSDVfAGul7oNycsB8Ao4
         R08Y5oon7XE1UV+v6RfnI03SFkLGgE0RV807aelOa9k5r8TbVorPIAwASRjxYQrK7lsj
         kP0DJDoMCYJFiNTR/onnZCoQ4DANIKxph5gGvfP5m3rCtmA/5tW5ANIFwuD+JPvT781p
         Km3iNwXVlEQQj6zoUnVzd/ELjXWLKscnHn1ERW7izkeZtMI/3EZHeV+FirauZ6oVPq6V
         Mang==
X-Forwarded-Encrypted: i=1; AFNElJ8u8ojs6j2/OX2PKftCLBjlToy4Fc4s/kBLm6erySIeo8XVVW3XChaxfBgKpFeQZOk/bgbRmmSvRxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiOkLsHaBiKt9vpENobhW67HFMJS/I2chDz7otkHTwdapqx4I
	IXQGXx4DrlrejZQRbK3oVJksjAYJC/yr1T/cE61u7wjm6J/bW/Dub2nU
X-Gm-Gg: Acq92OGu8HZ/4/9HAuHjrkj1IjK8oOHDdHeUY2PBE78bfycTOYPfTuTwTzloaYr4DIG
	8gOGsLaXv9sbwH1EIBaGEmsmqP4Z5vhwD8nNtS8TDnm3B68dX9cLJiSLv4bRQYO+muKBYpJ0cx6
	C6MY/PqSgYY5C/5yG9MlNXgVuRW1LJ6E80RumUrGWKzVW8Yo3LWoyBqF+sPOcMohdZkw0moB3zh
	D1iplkMsYomnXsxIVTYIzAir8QWwMn8vtY/vK4UnNDjmrvqdj4kUFuzEkoBZQWQW+cuUB/Ii4lN
	nzfJXDy+BgRO7hjycRQaNqDSlbMYGJopC9BVde02XyHBknTpCERyANZFXlLdSTgjm46Yf7a44ne
	OX8td8UdCYujPUKyMEPMNWbvG/cB5pT2uOQIym0tWZtb8Q02k1WC9TrrXwfkiWjfNYG2TTNObd1
	iW8hTxsoTO/0b8w2Crte5sjFFek9nW+8iVt4o1h5kO6obr
X-Received: by 2002:a05:600c:3508:b0:488:ac4b:59d1 with SMTP id 5b1f17b1804b1-48e532b5cd4mr146889045e9.8.1778423724020;
        Sun, 10 May 2026 07:35:24 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e70410310sm130155835e9.12.2026.05.10.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 07:35:23 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: magnetometer: ak8975: replace usleep_range() with fsleep()
Date: Sun, 10 May 2026 12:19:44 +0500
Message-Id: <20260510071944.56700-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "minimum 500us here" wait after power-up has no specific upper
bound. fsleep(500) expands to the same usleep_range(500, 1000)
internally.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b648b0afa..a88b19fc1 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -456,7 +456,7 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	 * and the minimum wait time before mode setting is 100us, in
 	 * total 300us. Add some margin and say minimum 500us here.
 	 */
-	usleep_range(500, 1000);
+	fsleep(500);
 	return 0;
 }
 
-- 
2.43.0

