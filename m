Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069FC9463
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790986697; cv=none; b=ZO82d4tI1pydwV5PTwYHbFp0qecXrWxDCd4XsAdO3W7hVVv/HumqiuGwPczIrI88PovQrYEq7K23EiNCEbFFG95gWbc3bskRt3P5/O4aTm2eoIOGyxVw7ED5a+N7yE4aH4JjZ1ga7goufk4RwF8+sSsWUtwfcv+jKpmEfH+Q0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790986697; c=relaxed/simple;
	bh=RLngXKCYptH5Oe5S4x2wLQFmvcQK8/NtnsyGyPEQp4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7ozrvgH4TFoG3Sf1naRzfA5G8wNp4oeR8Q+1/nGxHYXv/pJG8Oge9H+PyrvDlKlODAV4PSnsIT502aJphkXhM0FXyN63Oq0Ds/3uWZL8CGah3lJ5FSjCjnHc1DLTS2NkR/9abg5hwiMlvTW8X3nfXuXCBPE/YqnmwF9D+Ctg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9TY7CZX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9TY7CZX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so2363515e9.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 17:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790986694; x=1791591494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oZzRzCVHpM9HMQPpqqGziArwwNcQhpJPj9ympsMPsv8=;
        b=n9TY7CZXE1MY/vXsrbliV5LIwhM4diKIEjHNif04ndULqz/6lwDfWZi/zsowYukV8o
         wm4mLZJGxsEoT27F11dn571SX8yozt6g1E88LUUzyS+nLTOm7CQIYGGpU8SNk10HhDkq
         XJfx2pIU57jutemS7zR++qownI3CamS7O7B7NyUG4hxLG9SvGzdmmEHRT0mchFU/84m9
         LKzxQQ2mk5g6I67r8++ytKLgRtm/3RNhAeJnFaFyujKpoJVkU1KUgKEX2GOAHksnrYfi
         RSSNv77TUBg88OVScORo7ueny2/i2WchXy24u2KYzs8/wzzbXnATW81LdkdOZMRrm+cL
         GbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790986694; x=1791591494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oZzRzCVHpM9HMQPpqqGziArwwNcQhpJPj9ympsMPsv8=;
        b=iNoi98OClC5oeSdXw58/9WkVWJmfS2IHtGEbnwXST0X1Ciy9QueofaxIsmFI6GrTor
         rdZDxUx9fVXkVL9hUZekbRfltfF8y0vjbxSrD63gLz6CHsIBgrTtbIeyUV7TBs7Z7TdH
         clrQhG09k/1jxfXGPreKPzdEooL2Ep21druOK+2v/HeVUtQVb3ZCVSNzzxKKtk1IAwAh
         8+rXaL6jrzR/lmBK39dmDPuJm+Eepom2WxfOReZYUjJTeb2sc5MBcOiuaQZWvf+Fm+Lo
         uPMCGnU7Fu9Op+4CUNAx3smiWu8UPiT7ZjvxaSWDqKFHgi7Gpie7nhkmr0Ux6hrP+J7S
         puMg==
X-Gm-Message-State: AFuF++mWq7zSXUOgWXhDKv1VaZfstFF5TdN5+542mbDt5h7dK6tlSb/I
	rrCvBJsUDDmHHofULg/JYcUpfnL82Yan6BFP5knov0CBTRtfRcZlfMZ4bwd2vtIy
X-Gm-Gg: AYBFou19/4MWRJm84MKA7j6AaPxHV/skV/jwdk771lfG5pe/CdG/921ZfsCQyn4Zw1z
	XaOVkoIHJH8jdXq6Xy/WZqqMHj4u1MI1Tsxn60tj/j5MZbqxls6jAEXGPNcHYg23wz1e/sV8Moc
	NS0T6os0Px7BB23Pt2lrGu0DXQrMCyKz5YXA+JKwf3PjxMbAdNSg5b0pbc6c1rwuUG/fYSNW9BZ
	Z5Q4l+AcyrhV6/A7G+W6oaKNjkWNYmmsvvmp4wvhytvGEjc/POvS7Vdw1Qlf8YvSjVCSq/hVP78
	zyi2fCapdRx2EfwU61uYoKp82VK07l8pqhzYC2HpZ1ftDebdiwlEndhk6n28koNJM6eGLPB46Lz
	rMIE/+xQkCCVuY5gZ3xxnogQA5ZwLQuDfByMV1nKRrZHV8PlGxGKSzu4JTxKnLcLQN/nJfCqx7g
	QhoMQ8LfnvhxHD1Ogm2Sy8kjhiGKC5MCWkBenI1EVVzTxQBfomMAUts4MsytvaSYplZEyjDRrrP
	UwS0+ZjllmbzgkwC7T5e5FrEeZEadoeEQ+GNQexJj1nc6IKlMCP98zfC0G2dI2F6/HzKWTv8N4d
	TH3RM2s=
X-Received: by 2002:a05:600c:500d:b0:4a0:1fe2:d4f1 with SMTP id 5b1f17b1804b1-4a027598d25mr70783705e9.28.1790986693975;
        Fri, 02 Oct 2026 17:18:13 -0700 (PDT)
Received: from SegFaultinator.localdomain ([37.142.148.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02752aeb3sm124836705e9.0.2026.10.02.17.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:18:12 -0700 (PDT)
From: Yuval Saar <thefireking@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	maxwell@maxwelld.cc,
	Yuval Saar <thefireking@gmail.com>
Subject: [PATCH v3 0/2] iio: adc: mcp3422: chip info and read_avail()
Date: Sat,  3 Oct 2026 03:16:45 +0300
Message-ID: <20261003001647.1975549-1-thefireking@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919195507.94130-1-thefireking@gmail.com>
References: <20260919195507.94130-1-thefireking@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCP3422 family driver tells the parts apart with integer ids and
a switch in probe, and it exposes the sampling-frequency and scale
lists through custom sysfs show functions.

Move those differences into a per-chip structure, then publish the
lists with read_avail() so the IIO core creates the attributes and
in-kernel consumers can query them.

sampling_frequency_available stays shared by all.
in_voltage_scale_available stays shared by type. Shared by direction
would rename that file to in_scale_available.

No hardware. Each patch compiles. checkpatch --strict is clean, and
the available-list text was checked against the IIO core formatters.

v3:
- Split the chip-info change into its own precursor patch.
- Drop the sample-rate defines that only repeated the numeric value.
- Keep scale's available mask shared by type, so the sysfs name stays
  in_voltage_scale_available.
- Store scales as { integer, nano } pairs.
v2: https://lore.kernel.org/linux-iio/20260921044709.27d59a97@jic23-hlaptop/
v1: https://lore.kernel.org/linux-iio/20260919195507.94130-1-thefireking@gmail.com/

Yuval Saar (2):
  iio: adc: mcp3422: describe parts with chip_info
  iio: adc: mcp3422: use read_avail() for available attributes

 drivers/iio/adc/mcp3422.c | 191 +++++++++++++++++++++++---------------
 1 file changed, 114 insertions(+), 77 deletions(-)


base-commit: 69fa76f0af3414cc189c3b0b807cb59e327ecc00
-- 
2.43.0

