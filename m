Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641771;
	b=h98VlsJxGio2PXnYLboLSgk3Jvh0B6aGEUHoBL4+XjNlHcS1t/ZDLeJnyugNZeeCrm4P
	 au72coS+H5UvbUOKSzWvUurZTPtpTISm7+u2j9AMWCYLfqjy5cW7nW0UFTUyd0pv0UV+p
	 z6FaAsuvRYqdl2aySTel4xaSnBzm9w/5l897XBVt583qzayR4YtBreSQuvH8rUPmsaRp+
	 Qe01eQVaKHV+XoZ1mg6qSIcdqU2Iud5FU1qyc0n2SVzxytdOG7fJOadQc6frFcb9XKtDg
	 CSf30wvX2QGFh398ffn3bwHsvN/Ax25HuNCqBnq1Jgiy20uqKWpmgxj+iZhoKzEGfcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lh+xj3j1FkUm0E1b0mYmzquxFERoGGYH5BnvZ8XddII=;
	b=meOQsF3CpuuidX/uwUThWMtFd9lu11y9vYXnXCllxo/a52Fc/kU9lHwX1RO15gb5sUQV
	 iG8ghHaLkiRegquQtNOIvWalmrfVV5Qi2+s7E2zXw/UqHmEUyMsz1TJ3aI2LcGA8BAkL1
	 q5dWfkReZ0b5RtXyeffNf3DpwamcPM7rsVLJRrugtEWScdEEbdiWOeBy5C1EUG7U8VtF6
	 uLRd2m8lGVtAIK1JtNkwV0mCsfnkY+rJevyGD+zuCVMryJ0MLPIPzjM+UHi6rPB2Oz8ax
	 PhRj4JVZx0Ih6Kua9dUI876Bsc12gRz4mjgdnGDwXzL7mju6ron3HlGcPqhNF4SMkTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FApRiqcn;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD02C606A323
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 07:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD02C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FApRiqcn
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so1980035c88.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 23:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794641770; x=1795246570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lh+xj3j1FkUm0E1b0mYmzquxFERoGGYH5BnvZ8XddII=;
        b=FApRiqcnkUypwDNGznoRTPpSH6ZtPuwdDSFzJOKXUHiDsc2Qya62trvl06Kslt4I5r
         Hg3lh0U8e0iqV+ELDp2iH5XspUZIEiW0+xUdAl4lCzF9y6qqcSZeInQXW7NahdzAVtMF
         XLBXLO/AHbQFVIcvRfwsIGmxMkaQSTxu7RCaTIRk9VKTWDa8qyXydNLJyf3hSnLY8HXr
         eHzR/yQ19LDbtWLmrvGdCcITPOX4SzvdtfUox6MRoiaFcb8+wNh6CzvJOmNQQU3BLPH1
         HC2Hj/g/15VX7lj/i4zAb2vXUkSzNlabdf9hf0oUjFuKtTEiuFe1aAa4naKABvu5XT24
         kY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641770; x=1795246570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lh+xj3j1FkUm0E1b0mYmzquxFERoGGYH5BnvZ8XddII=;
        b=WUqa0h3a0ahhaSSREDMCrRMbEQo5HRElIq1lRifLTp64vIkdWZgEGK2/zP2XhdE0gu
         6C/lNHervv4cR7mCRy9WmLfuLI1YW+JHrSQssS/Allo7pswuOKqQmsaMDYJu4BsCQDPH
         JpRnC/lakP6Ozr97PCagSdP0XCppLJPmlC3U9xwk1jqZZF8T669JsKsjIaxs+M32zW32
         2VEBGC2ItFvj0OL2KM0W3HgJiyFwFALp76kTDFATk3iKPeoKsrgdElZ9LBVb1fc1PR7t
         KTu+YUBR/R8WPGSFf+srmEVmRVtTiyIK9OgF7NYN+GAO6zw6tluAN/pYWBDo+taQPUJe
         1a9Q==
X-Forwarded-Encrypted: i=1; AL+hErGxhhFaVpYwf5wsaCo6voKpD1S3qbUrDR951BVAtAE6u2tmzcbZdxT+SrxIY7EetL9tU4eD0ojTqvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/F90olImTP6NodpzzranfhLf5SJ9hc/GF9CQqQdtpnKnMHFjwd
	K1tN4Od6xOiBsG8w4bGxTpaCuvUJCJvBprM7+i9J7cWiWmgCpaBbCFf9
X-Gm-Gg: AYBFou3g0bq7ge6nuE7zB1JXtW4bo8FrURknFXwkzPai5Vgiu6KuS7qzBJIjtg2S/lH
	pdN/28xIdgikbFf52hzDaJS+pI5S/a0TBtBSBPVZeiyLSofflACCJgrvoOHYCQXjjb6Gl2rIzdz
	yN3KtqKQnXBjleOfi3k5yKm6KOIu98tzdG7mJigNBCkOWOd3u6/H7X+hbNXK+RYL3mLxCTdiY7u
	+FqqUukKhzgFyQX7kycBwjzZQ/t/Zkc/SLp57EJ3xBRlFWw/cZnuuh/etyEM6KKD3bgaz7oOA6R
	i3THSTXFbm5xQRHTyCV9hVaLTKV5RjnZCr+QV/SpxCaKkP8yjGyD83a8BA4XEo+VYJ/tm/NI8TN
	OlhsP+JnIcYRyNc7hFHt3Kn5f/Cy4fByEH+oVDk23FPb4j6+G9TR1ugsizfmbydQYXti2zo+dZJ
	LYhtsKA9Zn2nC0O87YdHz/iqcVaq9Yxre2YYtx2ahH3KFUQXKdsF8wIlyrC2twT3LJ5qI4jPCvK
	c/OEjs4b40sQ3suDREVOjf52Ogxg0MzF03vBGjy1wKAQQQKdrHF7h1KnbSnVgNqYywd+a96/E7/
	KxgsW5DFvHj8LW8ks8M2jSS+SuKvjxqZt2VCwiQac40c6e2jdE1Nv49IO8Ll3ulfyY2/dyOqDFE
	BYkP9u2ALsFsiOK3K25V8rXZus6FB55Xknue+hOIpOxXvdRPTH6TMGTi2+jLQSQc+yQP5cMSOwx
	RhnV/uvi2LU2J6vHqgUPC87B8N7iGu8rBWWAT8/7NJPA==
X-Received: by 2002:a05:7022:286:20b0:14f:8d59:edcc with SMTP id a92af1059eb24-1b5030d4057mr4772322c88.12.1794641769764;
        Fri, 13 Nov 2026 23:36:09 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d990sm16082635c88.4.2026.11.13.23.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:36:09 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v5 0/3] iio: proximity: sx93xx: keep the IRQ balanced across suspend and resume
Date: Sat, 14 Nov 2026 13:05:54 +0530
Message-ID: <20261114073601.23404-1-kapoorarnav43@gmail.com>
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

sx9310, sx9324 and sx9360 disable the interrupt in suspend before
anything that can fail, and don't enable it again when suspend or resume
fails. One patch per driver, as the Fixes tags differ.

Changes in v5:
- Disable the interrupt with disable_irq() before taking the mutex,
  and enable it again if suspend fails. v4 called disable_irq_nosync()
  at the end of suspend, so a threaded handler woken during the
  register writes could run after suspend returned. Found by Sashiko.
- Move the register accesses into a *_sleep() helper per driver so the
  mutex is released before the interrupt is re-enabled on failure
- Rebase on fixes-togreg

v4: https://lore.kernel.org/all/20261101102518.22757-1-kapoorarnav43@gmail.com/
v3: https://lore.kernel.org/all/20261028220444.70121-1-kapoorarnav43@gmail.com/
v2: https://lore.kernel.org/all/20261026112342.65917-1-kapoorarnav43@gmail.com/
v1:
https://lore.kernel.org/all/20261026100322.16720-1-kapoorarnav43@gmail.com/
https://lore.kernel.org/all/20261026100408.16874-1-kapoorarnav43@gmail.com/
https://lore.kernel.org/all/20261026100450.17023-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have the hardware and haven't
reproduced a failing suspend.

Arnav Kapoor (3):
  iio: proximity: sx9310: keep the IRQ balanced across suspend and
    resume
  iio: proximity: sx9324: keep the IRQ balanced across suspend and
    resume
  iio: proximity: sx9360: keep the IRQ balanced across suspend and
    resume

 drivers/iio/proximity/sx9310.c | 54 ++++++++++++++++++++++------------
 drivers/iio/proximity/sx9324.c | 43 ++++++++++++++++++---------
 drivers/iio/proximity/sx9360.c | 45 ++++++++++++++++++----------
 3 files changed, 94 insertions(+), 48 deletions(-)


base-commit: a6d9114f68c4b5507b2d945bd6d1e37415f913c5
-- 
2.53.0

