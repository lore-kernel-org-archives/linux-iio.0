Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374520;
	b=g0P8rpzUrkXvBjdRrzSjvchFiCsw6DgbzbCbhEA2BvXlXtyYyx4gt/8KYUY9hSeY9bBM
	 4m/r3O0xET+jQ7kd+o0VDhS0CJPWO3Sz0HQ2/X6Z7H6i56WUI41s9qGDVJleP0Gsvduh/
	 MsuMKRTjv8B2jErmlVWkb0VGS58XZat6D5L+7KWAdw4l7+elgCFfdnhLqK/OZqPK3JbDC
	 FSvfcoROxlwuIHO99yIyb0ub73opjzmukPLNK3WX340lfz/njr9efT3ZC7yGgId5rHvaS
	 yyQRlHmDInYzfLTwsavNGlYbbq1PwZ0mAsbaIxsZQvouie6J45UAaimz2WS0eSexI6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=73sbTOBTKeNDVIbWsqHqrOHKy267PO+zwpsv2AnOAio=;
	b=4daywgdOzzhLyFS6VYE8aPYADtURvEB6oak/Ol4qNc2JAlxv6cClILFRExZk2HDOwfNr
	 NKJg7IvCI+f67Gey0Sv8JmuwSFEXWRdgCt1YkJYhTaJ+0syFOgXB62/60kBRkPaqjlJeo
	 QsCWyyvIXuIsxlvPX6N5eQShploAVMtI3+0rvKjBF7xuDHobhweXp6jBQ3NsCvnOU3HJS
	 mYLzIShqV2/s2SejzPtL8ZpmsQ7SQORrRhC4cS1JKPcpw+Bnm359AV7WGIxvaNtgJKmNj
	 K/m/jfTQ06IZ5VxuZTZyQYyW57v9RFrYC5uKIzEMZhmu26scVtGSHs7yoQDPdLw51Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=imBWeynG;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FC606A32C
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 19:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02FC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=imBWeynG
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso17947175e9.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 11:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795374518; x=1795979318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=73sbTOBTKeNDVIbWsqHqrOHKy267PO+zwpsv2AnOAio=;
        b=imBWeynG+POI9udwOD/SHv9YDeIv8X0KAHUSoUTVByALVgl4/If+IUmBpPfNHM1+Kq
         sDacnPNicFuOcpl+mEzUhOFwiJGuH+ljFCxYLG/qjx29zAtd7VndewJp8+tuUx6KQq9w
         XL8awbtO5vIktvddL81lnknmie4D88Wqc6YzCsf9LU/hgBBthvjT/f9N5W3jeaI6G43P
         C63la+MoksV14gtEos/ViauIZLD2sY1ix+szq2SUVvbHGTUsT8rBaSmfQM3qw3kvSXUc
         YIyOZpUno/lXMor2w4dx+sM1SCmc+bDxD4irpO0prlt08D4yZ0IFR0CaaLojNm5Wt1mJ
         cKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374518; x=1795979318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73sbTOBTKeNDVIbWsqHqrOHKy267PO+zwpsv2AnOAio=;
        b=i+uVO53Fwe6teBlnCjoAhePW1CJQ5qh1b2td8uw/wFGDgEVIHLKOcD7ypGc48FY/CZ
         4jIZSKglbwFpd8/4upjqpo4rMkKe1M/8dBoaI1sX8F2wJw31tYVaDlvQdOi+Y0bTwlz/
         1lgY2Th1cu118q1q2MImIenrKf3jnYD+Hc5cR61aMDxj88GIO1762V8FxN4dgvbEd4bn
         rlueXfD/sxv0QVEWzsII6MmcR/AFyMIJFwGvQ27wQu18LiWQMdne4GyPRAiwziDE8gIx
         XNVbnjvHrhOVDxz+zLqxeQeQJi+xof0olSA9tMVwLzriq4LH+pAue1xxZB+GkMwc0kIv
         0Juw==
X-Forwarded-Encrypted: i=1; AL+hErFjUzh68v43xeeTq142yvajml4AhXwlzJ6/aGh/dRH0ngD4RICHJ7JhqTE8OG34z2IdRfAAKhHTBxI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NAwxyaL0kitqWv+fWh5dSgZotgk1GcHJd2jsto4Uy28DvbXOU
	6sY1gSQVMug7VPAe6Wt2Pxr2vd6PBqVCdZ6JmS9KQ8G7VMG10DNRIjAQ2NsC//Q/R3k=
X-Gm-Gg: AZFdTZfZlvcjtGOAQXMB4wCIcWm3HDfwmmw9ASodiMGEyei5wg2/KaxAVi7ktUukY7g
	U7kJvODQptYHnWqmX4i+K43VkmoGn0wiAJFwKVXJtYcG63kWcQHqTMaM/ioXaI3ABQLiODGcpc0
	gZE8A7AHrN8W9ZkLxSJvu9xIEbdmdLGnlqxzsx680oOEWmYunJilSs6gBiprwha6HRjS+kvhuG4
	g76kawDk1NuyG201T3RFgKQGIrUrdbJtIhDKABv4dzyYEHw7IbqxdajYM4xJEAsrNPksTrvQG0q
	YgxApBpNg6mRPDKKRv0rmsNM6hnDHFL/xFZd0SpnfeAr+9ZXg7gFTEJcyA0fAlrDC2sSpxAJcWe
	x+KZYgg4Q1UFgb7e2Zt7XtwlhfeMcPLXOiiv+/E735S7RPoR/6OP2wu/KesXvHJCQmhfJZNGu9B
	2qAI7/InqrbQ1c1qCvMzM7Z67iOeKNEbmAGX+/QCmgYHrdOq898qeH4bVDSJxiYrRb86tzY8ozd
	K56sHH2vHVYKET4gS+UOB3gxAyOuFoxRsXkVsdjad5of+PDYvMaKJpXou6FFipjcrwNcHabdCXl
	w6WcfRtw/NGmQkhufDpxflhiXtlm1MVgwVfbrukd9uw9iPVH58G07+Ff5/6wTT2i3jTrsN0yTRx
	IiUNcV+FsK4A=
X-Received: by 2002:a05:600c:1d03:b0:4bb:6118:4f57 with SMTP id 5b1f17b1804b1-4bb888130cfmr226843875e9.18.1795374518011;
        Sun, 22 Nov 2026 11:08:38 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895f7bc1sm103080395e9.3.2026.11.22.11.08.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 11:08:37 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: magnetometer: mmc5633: Binding, supply and mount matrix
Date: Sun, 22 Nov 2026 20:08:33 +0100
Message-ID: <20261122190836.66111-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
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

The MMC5603 and MMC5633 are listed in trivial-devices.yaml, but boards
need to describe their supply and orientation. Patch 1 gives them a
binding of their own. These bindings are also used by PebbleOS, which
is where the need came from.

Patches 2 and 3 add the matching support to the driver. I have no board
running Linux with these sensors, so they are only compile tested (W=1);
feel free to take only patch 1 if you prefer.

Changes in v2:
- Cover the MMC5633 too, including its I3C connection (Jonathan)
- Add supply and mount matrix support to the driver (Jonathan)
- Drop the mention of the missing I/O supply (Jonathan)

v1: https://lore.kernel.org/all/20261122093412.71604-1-gerard@teslabs.com/

Gerard Marull-Paretas (3):
  dt-bindings: iio: magnetometer: Add MEMSIC MMC5603 and MMC5633
  iio: magnetometer: mmc5633: Enable the VDD supply
  iio: magnetometer: mmc5633: Add mount matrix support

 .../iio/magnetometer/memsic,mmc5633.yaml      | 61 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 --
 drivers/iio/magnetometer/mmc5633.c            | 28 +++++++++
 3 files changed, 89 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml


base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.45.2

