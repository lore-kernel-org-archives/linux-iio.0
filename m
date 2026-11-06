Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956812;
	b=Sgt3Y0VZWiwVPW3kPuoGMfqrkI1ixg7FhudOrYjMTIjwJqq7qAoQIMPHqESdF01Cz2GO
	 PlVgkfbvVSuPCGKPKBQbBQwEL/LBedZTiqoAN8u6zjmt0F/VUQQrGUp8CXYItbownOQfJ
	 M2i+NiiEtV5QFJnbpOMSz2JhZR2i+h7D1IzBFeUOlvwL2sFLhm3dxD+34by3MMqcugAl+
	 noQ151oGRusyQIRjI0M96f1wuDNqyzQQyTdShATq/CQSqpcr+H1A5zAeNMYDzB3sc59Gw
	 NcV2+zBv3UvPpSXHwr7zIwI9mEW3wCzaatafHghuga7sokSKDi3TRveOOE9bv1lVgFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BKerVZtCZFwecLdtYHkc8Z2DgusctMkHx27dYOPZMso=;
	b=UhwTjqum9R0vQsj0luOr9F9a20Eh1MLnnFlZjEWHjr2oLgmn56c12HPct5GO2Qt7z706
	 kvsaywpqyp7HSzN2vxdQs0ztMfZi22PZNMhghgNhTMhmQTYX8dfGCKcaKlhApXCFkyibs
	 C7KR7NnD9RJ3sHbolzubw23bqUFSWREdIKH0cH6mTVyybUv1WnjxmNgdTg6QNxF8G860G
	 3Fl2JeJ1uIa4N7VuYNYNn+wCGw8wo6ruurpv3Wq6BMDZY01zLhYl+yAfyujiCre2y4YyT
	 l+u1NwvWo97syDuqD7Ov6TSduFSfu3xTe4u2lrQFuWe034f5MI8IcgXKAlI33MwOwLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YB9MA4lw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56715606EE87
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 09:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56715606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YB9MA4lw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so3247135e9.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 01:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956811; x=1794561611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BKerVZtCZFwecLdtYHkc8Z2DgusctMkHx27dYOPZMso=;
        b=YB9MA4lwBxStiouVrtcdnPQGCzOVF1UehqAaZuv7DxdSERaz23YPJ6PkrQ6A7eVaP5
         IwnwJxuVEDeupExS+TobQjHDN5w2HoGk3KMn3TLst1/zC81sx4oLVPclabeaX6OH8Mxy
         X1a1QPiF1UXmmF9etMn+YLF3ZhhqCcYg8q3lCORpQy/uiZW950/aWuxPkGRPh2nGPo64
         XGyU1NcfwR475BTyWg/SogOWWJ3jJamrMLz43TuzM0u4hLCPz/Knt4ok0UKT+ez/8VWB
         5E4czxvdNEdggWuCLaeolQT1Kq6NvGaAL9OdKEdY0bMcgCoJmmlZseDtkgQeduWYjBIH
         /ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956811; x=1794561611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BKerVZtCZFwecLdtYHkc8Z2DgusctMkHx27dYOPZMso=;
        b=CnVZsWV7ntnmni/SCVMIACV+WbEu/VTz72l/lETpw6Qq99i0q9EjuaW3aVddgY+2pj
         dMoI4AVRheoQ1rOd7/LIEZrw4fuoEs+QIE/HUDogQAX8I59H2/0HSNvFYXdVIxVjglEZ
         nHaMOIdtfTUrqFYGWhBRzT5INECHSW61O4NgM+DTjlgP3Ki/DmRZsEQ0IfUKJgU/CbYJ
         z/zMiYAK+iycVYTNfmk3c1nYrAKRXwRuFk/IZIvr85NT4gnEnOp0kZv8Qml30B2YlWHE
         jV1Tb0ZnRR3xDZA7bBDBnmFoMxnMReRq0J3R9PrsERO8gTJPrYi/3qko51N7ylTf4zGD
         QkCw==
X-Gm-Message-State: APuU4Z8bHGdPrvnuwpie9xDlfM9+5JowoCFNj6MiUL0YO+10eJDYEwS5
	lFYsyw0YHTWnXKqzcRt3bbwyC/9NYHHSuehUbi9TqqXkKth18wg9EeYp
X-Gm-Gg: AYBFou0MFMcyz9DKtnm4lQ7AKXYbzMqnUwbnvXxKOBLkp+wUyXkzjPdaf8O5hkgQz9t
	t8pvJ2075HeI4zQGbDaekKd26rDLEJ53LAGpJM4c69ClYs8To1kZ9TWeddvdkEgNmC2FPAW+AAf
	VSPtGmdrOAXRDUUvAY8h4GFa6WOW24+Pf+PGC9g20PSZIw//Jnl+nn8R/9pxlrvFVp41+BbqMgJ
	1H704xXNXHMQM8bj4irLNP+xCN7aE5lT2X5RZDfp19fTuOsf1Spn2pzTbndE60BpQvTsvXedtiU
	F7fXQs2gEzR/42FjmmyvoaZKhtOMT4VKGFMVBg0UjGvLKBj7FNmZO6k3Nk5EK2lnomPeKasCn5X
	reJhkVY4PjD9a6+TDJNFX1NT2tVrUskWsoe+HZCuuG62qnVaksLnPiy1ws7gAKJzYYbbdjK2YTL
	XzsJrfVKkTVi+Xcod6DduSSe3o4I6HV8qVAvMi++oXEoR+mzP2ZXJrr4lfQq5EVKkYz6wwPxVI2
	vruiZUeQiTsa2OuaWdV5RXnMjGWozg72OvUMwG2z6+vJGkxsoESaMQcIN0SCTB0KEleiFsx2Lgq
	LmWwSZFhrqFpjNkn9zGtANAUtYomlZ7yN2IVah75IF5vUII+W/h41LZPYsjv7TGAwOZG4xQX/4t
	1R4I2R9MG2Q==
X-Received: by 2002:a05:600c:4e8f:b0:4b6:540d:6317 with SMTP id 5b1f17b1804b1-4b6df3fd1cfmr29585725e9.12.1793956810406;
        Fri, 06 Nov 2026 01:20:10 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57203a98fsm108358935e9.4.2026.11.06.01.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:20:09 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iio: light: ltr501: Add LTR-659PS-01 prox sensor support
Date: Fri,  6 Nov 2026 11:19:39 +0200
Message-ID: <20261106091943.35783-1-clamor95@gmail.com>
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

Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
nearly identical to the LTR-559ALS-01, but omits all elements related to
ambient light sensing.

---
Changes in v2:

- set IIO_PROXIMITY channel to scan_index 2 since driver will not handle other
  id properly
- add IIO_CHAN_INFO_SAMP_FREQ for IIO_PROXIMITY channel
- isolate missed ALS register calls
- add commit to use read_avail operation
- convert to use modern chip info match
---

Svyatoslav Ryhel (4):
  iio: light: ltr501: Switch to read_avail() op from manual attribute
    registration
  iio: light: ltr501: Switch to modern match mechanism
  dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
  iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor

 .../bindings/iio/light/liteon,ltr501.yaml     |   1 +
 drivers/iio/light/ltr501.c                    | 383 +++++++++---------
 2 files changed, 184 insertions(+), 200 deletions(-)

-- 
2.53.0

