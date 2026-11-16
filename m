Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862412;
	b=e5VsdguqOqdCx2DVOUgPm72fsmbwyoGeVQ9M7xO8rhLTq7y+vmX2NSxwtjNd7q2u4HLh
	 LFAnOJuujKKRz1nXS11pv+o8r1ktpeIzJUzT80vXcyZdcMHyPFnRh3maFZcZFHHdxQs5i
	 wPOIgRj0ZHVkre0JZohETlg2ZgMjXKcrwiFbN3/eUKcVHB389l7jR+QkOnT7RPYDirpuC
	 Z7mG5h3bPe/Mls5nvYnk51ugojOk5IjVLGLh16bFVu2no/4df5+3EBYZBfHTbOe1yj4Ds
	 XNbl6NhXsD+M3b4OBC4JmkAXIZVhFdxZJt9BYKkcRGAfeMHqQEZsEnMo69SAARurbhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cvMupzOZtYxKix8i7YVSQn/OkBYaiL8fo+IIInVPVHE=;
	b=hbqrwyx/6FNTyoHY+cTonrA46EosCB6+yMrgiizCz8kZCFmNgfauE5PpzP+r+2R6O7FQ
	 nJmCJWCzLb3sN3uU6xkkJzLLBG981qa38rtBAWkR0VTK25DCJpqxBqKxOlsCrq9B3uFIY
	 tZdydpbXLadRHO/gKlMYajoqLU1lGHV4itjS74BROgV69oF+dfppdQb33tEnjSlsyHXgu
	 JvJLmTgWdtapqdeNSvpgMNik25G3JfSTA8rgusqYi5E/kokIuyM2/+/cLPvVasIDHNNpy
	 THEuqrEsOSQgBOklEhbFAQNIhJSN7657xyIoEHnMVpbLc3g4B2zMw2dd2a/rz27X97Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TkQD9kNY;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A3606A333
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 20:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 984A3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TkQD9kNY
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so4901583c88.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 12:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862411; x=1795467211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cvMupzOZtYxKix8i7YVSQn/OkBYaiL8fo+IIInVPVHE=;
        b=TkQD9kNYr0ubQles2l/V1+jSh7+ys0KC1QAirijznyR5rFoIh55v746WOULNwPqeNx
         n+Fdy05eSychRqgXKCSpZ4iWzs3SwK1AxLvsiL5KWB2nuFv9Gl2XGHHwyWgo1AR6gtT6
         cYw9YopVqdB7zw9FKjWQuTvVgPYHPIZzFjtdGv2XW41pAiHGT4dLumODZ/8dxrhfteul
         DithxtNiWApU8WxvXqWdE2ulwdpMk5E90zbkALdi6SMXn5AX3Qhd2GTmoiUyPAajYhNx
         bw1n3vQmR2FG/IiHCaHlc22311sR8DO+2fZcEk5eirijC11CgxoTfl/3jGumS3LLJz9a
         Ui6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862411; x=1795467211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cvMupzOZtYxKix8i7YVSQn/OkBYaiL8fo+IIInVPVHE=;
        b=Rw4oy1fzIpzM4UcOxMbpSMEG8EXjJJtrqS3q0VjT0I4oDLWIhTAu1hZSJJ/Rx2Vs1v
         M3ayYLgBvvxdZhxXRT5iEtmanATz1iq6qOFvTWlG3OYjlJRNCO3tGmhcoEe/NMl7YR5T
         FMxXozpN4UKoQXspLyvoK4SyO11X0hyOzD86AAyuV5Nqro3ys6nY84DS4iC0GKuRRDlV
         fRl67m+fyBVHGd8v9ZHKEC3qkvVU1j7p7zo/fupLOk6Zjp01CCtIf2yB9XPObr1R6CFG
         FaW7Rpx1yyaDSJi1tgzsXCMFI3iNsedaBTXsKvrK7/M+A2F7AMWP4Qr1i4rLuqkM/JwT
         1vrA==
X-Forwarded-Encrypted: i=1; AL+hErFv7wnPh1MNjPhzbk0htbE6ukASpXXEJzhh7kcE2GlKlAUoW8Sd8otJMQWrKE3nYedguynjvPMhiKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xt9OOvugFSZs9Qdbu1ah3xK74NnhTAHtdH+KRCFlVXdq1eLKE
	5a4eUEIZgIzFMBqzDJ5XqOhUM5Apyqwtw4zJNpngDuhfZvGk0XQWugKq
X-Gm-Gg: AYBFou1PRbqq9MCZfa9NWHEoXLtFu0lX75yk9uLxSDe5E3jRYZ+UZCcECpz+sdrwPNo
	dBP/nMfcG9eFLlYXQaJDBFp3ogVtE/qtx+LXBpDwHYPPwoK6wiovsVockLTMHcBtOCStOnFF6S8
	tQgJHCXSs6u7s41LS6CFqY3ZPhX8NyuRdHzA6UDUJiyGj4OLD3CYTbNO7vyCqfErO8cMNqYhM6Y
	N2kU/WbOUncRL+f3XCqOSmp4FUfYuF1uJetVIfLi9S7LKUsde7G9Eu9rEskIyGoHRKIWpIVZyV2
	gIw34VDkjlQMksnn1migV3d1v/XTjcH8qZUakoLPg/y0XwxtP09qpMub9jmTO6GXggG6k3BDY5j
	Jw+F/hZWe3QUrvDo7aDfnmHx2VvOQw5AOpHR4zlc68sxRDmUUkemx42tS3IkCJh24x0YXspt2zA
	0rH3hrJ4hFgm6FmNP/mx6Gy2/aDDXkWRJaBZ6/VyyEK1rwlgyO7qdElut1+YmRe2PnrBgGMvIDq
	6auPJOPfYKGPCuyvCQiYbmQS6vNlRBLy5xgMJ7QUeomO1awzvOsdRIGfzv5fnzkff85jnjYPWzy
	Pn344yd6LdlXNfJ4og0sdneEKEvgmbZ3beRvCqV+z+beBwE14EsEzR5VCSm7aib0s419OP1OyIY
	mYXx5+O7HPGQZ/vG1Kd9eNuaFkLKEJbHvfWqP7Vog2aZ/G5a6lBpY2Ma3PfMHq4RyLHAkeclvjm
	gdt4PSQXiOf2d8XhMaT1qNYtILNgxNCLceVq64Z+DZ9w==
X-Received: by 2002:a05:701b:4354:b0:143:26cf:8615 with SMTP id a92af1059eb24-1b5031111afmr10808448c88.25.1794862410435;
        Mon, 16 Nov 2026 12:53:30 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm15293497c88.4.2026.11.16.12.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:53:29 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 0/6] iio: proximity: sx93xx: fix raw reads, thresholds, hysteresis and gain
Date: Tue, 17 Nov 2026 02:23:08 +0530
Message-ID: <20261116205320.26070-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remaining sx93xx fixes I had, sent as one series and grouped by
driver, as asked by Jonathan.

1: sx_common: a raw read can return on a stale completion (left by an
   interrupted read, or by conversions while another device uses the
   sensor's trigger), and it then turns off the CONVDONE interrupt the
   trigger depends on. The interrupted-read case was reported by
   Sashiko on Zhang Jie's sx9324 resolution patch.
2, 5: sx9324/sx9360 read_thresh() reports code r as r * r / 2, but
   write_thresh() inverts it with int_sqrt(2 * val), so writing back a
   value that was just read lowers odd codes by one; some negative
   values also wrap around instead of being rejected.
3, 6: sx9324/sx9360 write_hysteresis() turns negative values into the
   largest hysteresis.
4: the sx9360 gain encoding fix from the RFC, now a patch on top of
   "iio: proximity: sx9360: reject out-of-range hardware gain
   values" (in iio testing), as suggested by Jonathan. It uses the 
   encoding sx9324 got in 108e4d4de2b5 and that Semtech's own SX9360
   driver uses (codes 1..4 = x1..x8, 0 reserved).

Based on iio testing with the patches applied there since it was last
pushed (sx9324 reserved gain on read, sx9310 proxraw-strength = <0>,
sx9360 out-of-range gain).

Changes to patch 4 since the RFC:
- Rebased on the applied out-of-range gain patch; GAIN_8 becomes 0x4
  and the range check uses ilog2(val) + 1
- Commit message cites the Semtech vendor driver

RFC: https://lore.kernel.org/all/20261107112335.444813-1-kapoorarnav43@gmail.com/

The threshold change was checked against a userspace copy of both
conversions: all 256 codes round-trip, and every write picks the
largest code whose reported threshold doesn't exceed the request.
Compile-tested only (W=1); I don't have SX93xx hardware.

Arnav Kapoor (6):
  iio: proximity: sx_common: fix raw reads while the trigger is in use
  iio: proximity: sx9324: fix proximity threshold writes
  iio: proximity: sx9324: reject negative hysteresis values
  iio: proximity: sx9360: fix hardware gain encoding
  iio: proximity: sx9360: fix proximity threshold writes
  iio: proximity: sx9360: reject negative hysteresis values

 drivers/iio/proximity/sx9324.c    |  9 ++++++++-
 drivers/iio/proximity/sx9360.c    | 29 ++++++++++++++++++++++-------
 drivers/iio/proximity/sx_common.c | 25 +++++++++++++++++++------
 3 files changed, 49 insertions(+), 14 deletions(-)


base-commit: 8fda275449b68a96f0a38a61daa35cc39b0fb9d8
-- 
2.53.0

