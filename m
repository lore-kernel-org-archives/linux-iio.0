Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243131;
	b=S8pM+Ht7Q5TmWlq31dzXnqIhNblN2IWgPC+pXjrQWQgwWfhA/yBAnl17hGyezrwFzthB
	 1s0rL9GsbRZb1U4HCsxr/oKEcXOyMoUj7wY8hNOHZjdJNxUMgVFIow+UY0Ou++XjMIR5w
	 GmOE7WFWhyQzYoq4QFu6N0F+JYDb6WDrbzgen/TmPN745cBMuLt37269FAQYmSykTdGun
	 WnSqF8DmsysmQCdINDn1butWHXUws5nHHuKSB3EI3BqYl9nmC1PY62GB6etxeFVYB8yyz
	 mi4FxZlVj303OO1z04EbltZUzIggCmuUQZuuy6JRtmxsu2PYMLvWjjchJYvBPBeKfkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1oVOrNmAbP6cMTYfxlkmY7uJOETX008bTznAwaUK8sM=;
	b=CwWNSYY0yKIb35Ln7nvqIJ09Raq/hpjOy6S+emnN3FhexhBHUi+C34svXcvP1iJaGRAQ
	 nn0GE9g/r6XDiChJo3LmLa8f/kkQ/bDoarSJMn8ZInkjOdEw32xeOW+XtGN3/p+b67Cx5
	 usZ+TYZHaMUGol0ws9rozT3YphF37KU8aSUS9zUpf1/Days7ChWwV1ciXABIq0XDQ+qHE
	 Yd+nZRCm33gIwOCFk+55J0K2GOpqbjqrCQdvWzgYDQ3BuRhR7jRDmT+Lrbk0ix6I4aI+v
	 doMW7E9D9ikefdVPjEeJ67hlJ94cwK+o+tMrCiRa1RKdS6aRmjzanedB52S9okJLyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u49hmJFO;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926260A2616
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E926260A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u49hmJFO
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3b4944abeso299542c88.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243130; x=1794847930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1oVOrNmAbP6cMTYfxlkmY7uJOETX008bTznAwaUK8sM=;
        b=u49hmJFOn9B0OPU9HvxvsauaAchGsbN74uXaEXpzPx+G3roYJ2a1IbOfaUivkL1TTF
         Nt/kBuvqoI3abFNO1KYguKhiTsizz0P2QAx7AvXAnbJ6+ehSfDpWwHzog43iOwF1aCT1
         Dd6SBsRSQe5Ai2UWuzz8EwoaunLM14UfXv9wNQWJC/PXJH7WgUPkNnESdDp1C37JItGV
         F6vVkC1B2bGH+5Ul9JTR8dzrRCw98V9EXJKqgl22+oSh/OFSGeK95q06q+wR2ubM75Su
         EtoExibvXMFfC+zBQR0E3nssfZWxU9JnNX0gv70IFVy+4Z68Q/si1t01n2Mzu9kuAQjD
         98CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243130; x=1794847930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oVOrNmAbP6cMTYfxlkmY7uJOETX008bTznAwaUK8sM=;
        b=IhFFAShASF3ZZIqAaO9EueDFqndQmK1uMMdpgt3pnDpM4OOJw5rcjXx1PlLCHAbzgN
         KDF4vmsC7PO5Qxd0TphxajQAHAtbJPEBe9ObwnIDkkkp4TzhJfTUgEDNjp4ol15A3Rw9
         CPgLjK7IYhcsLhuy8OOE4XGR4Ian6FT52aVQqzOXa6kLWfDZi5lswWh6I7uMkeUzTu5o
         M4t/1esjqmDNeQGIMPdTkmU4o9vILiqxoD1HQtcRMocBzWypTnjQSWeMskUOiMjp0TxC
         UCrIBS76zhABkq6/w2j+5QquV6eaM6Olv0ihyMO1kBO8qiyUtC2wbhJWiLVbA1hYFf9I
         qCLA==
X-Forwarded-Encrypted: i=1; AL+hErE2Z/1n9u21Gppril3r4K96iTZgSxidcVYZgpR8yHORcqICX6126QepF3hok/igQtG0d9OSZTq8dTY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I5fpHs9ejiDjaCxtGqNg9/eQhRVgi2cHGO4CXeZ4dszezFT/r
	5MDGLug1SLMP2tTsCCO4l8C4Vru7hDRcvCc9yb9/1RzAn3ata1mEv30Z
X-Gm-Gg: AYBFou0pqqgE/O0gtv+Vb8iwe/I7c07bRtkTsrtIOMcuzHkm+RFc9N/n7NDpSh8Xq6C
	CEcpSre974Tqb9A/QRSCI1zBj1IS3LidLqsYNPzg2t/cDYeZ9mbkPkz2cPip3wP7vxD3pu4Y2Rs
	2o7r4x+T9nixiWKzgxVgcyVyyrlzpPbvVp5JRnq41u4nQmJ44GbGFNt1MslCuRP4uXDMJMD5FS7
	1am/oiDXtSmbueaDW042ijUZZQHAsbLY+yemNh8/q9etRNHl7941HXkNgyEAne7Bkr9Oy4h4V8E
	TBl8xT0SWVIQccvWHQeDY9JRZf7sGozqdvbmKKcOMXbaIZOF+yvhcTx2HuFCHoOHECbRVbYsdF8
	SdkulQQ/r0/PBd8yYqX7jcWHhIae6iJJiOCoHoCyBbs+6yJsnAZxYQScXqIyS9+gq6YTOCJuZQS
	hzAoKoTkHCZgofUIQu4TByFMHKpmP4DYFQzK+xC3WnHrSR2mw4fZKfDaHvIYghCsm3JbQKAu9s7
	6v7tiJW7cL2fcivR7DH/8O88PkFjPHCUXzBDH9/86temaFhhotWxm5a8HeEzIN+jwWeIyvuCMQv
	mA/TD35cbwRLJJGDUA9yRZK5XdUq72nH+CUx+sfBhKVGDpRyy15ok7gPG0MuiioS4kET/sRTTop
	2RIS0WaNb2u/Hq+FRm+2FO6NuyGNdST4apwcVjsA9MZgrhDnPUrp06KKVcTWL8TCwP5Wz+mX7fw
	+JYQ6mExA7vsXoJIuuvOuHHT5MbgcM/k2yBHnnVYAgTyiZQ0ls4CqZkOQlo6tRJuSR
X-Received: by 2002:a05:7022:1114:b0:1b2:471f:c4c with SMTP id a92af1059eb24-1b39feabda0mr6979052c88.19.1794243129673;
        Mon, 09 Nov 2026 08:52:09 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890584sm307041c88.3.2026.11.09.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:52:09 -0800 (PST)
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
Subject: [PATCH v2 0/2] iio: proximity: sx9310/sx9360: reject out-of-range hardware gain values
Date: Mon,  9 Nov 2026 22:21:51 +0530
Message-ID: <20261109165200.305266-1-kapoorarnav43@gmail.com>
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

sx9310_write_gain() and sx9360_write_gain() squeeze ilog2() of any
integer into the register field. Values that don't fit wrap around,
and 0 and negative values turn into the maximum code, while the write
reports success. Reject those. One patch per driver, as the Fixes tags
differ.

Changes in v2:
- Keep rounding values between the supported gains down, instead of
  rejecting them, so the ABI doesn't change (Jonathan)
- Only reject values <= 0 and values that don't fit: FIELD_FIT() for
  sx9310 (Jonathan); sx9360 checks against the gain of 8 code, as its
  3-bit field also holds codes 4 to 7, which the driver doesn't support

v1: https://lore.kernel.org/all/20261107111710.442318-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have SX9310 or SX9360 hardware.

Arnav Kapoor (2):
  iio: proximity: sx9310: reject out-of-range hardware gain values
  iio: proximity: sx9360: reject out-of-range hardware gain values

 drivers/iio/proximity/sx9310.c | 7 +++++++
 drivers/iio/proximity/sx9360.c | 7 +++++++
 2 files changed, 14 insertions(+)


base-commit: 340d44bdf9db0f095f99845b5ad8628781d79b6f
-- 
2.53.0

