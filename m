Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415253;
	b=XuWo/Y73xtxhdW3iS9TITaRIQ7c8WDj2cRLZK2DhzuKXkA/2sRZFERX9QFcA/Zw1wJ7X
	 kN5on9Rtks0FcCbn6ilIvsDrxwyjDgZWa+iEbjxXNR4QL+fwjcvWFcawD/MxpA3Btqhsa
	 /xAMZhkYeGxBtEZEjut+oidyutwMOXi+J9/IXoZamR5JCsyPwNhkI/obG+DOI7hMvy7Fh
	 TogSG3T6K5MVuxet2vbOZ0rbBD4Sy/z4B4K0l7812OIlkDUiEp7tw0Ocmy6qAq/SnUrQk
	 vW08MQyLyyAPDVZN8QRZxw5puJuO6cuou8rFNRkDDC04msgYD4AH4KUX5nB/KYR+CEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ru6Wop6zD4SlcoFBcvjI3pjN1oteV3A3iUcGiS7Riek=;
	b=YzKitChsrnpjzQts+XJWFENd2JRdJUYjhjFEiAhCEQ55/fDsqTOxzNpeEI3q9fcLM1nX
	 zTNZ3ZJueX3UEi81Rn0xafqkCp8WM4w1rgwxNxri7yPLb7XPtMjsogmBTdurxaxwppZUs
	 LLVsh+r2USSpX3tLJcqx26Vb52RA75u5CTX5SB6lcRXsDiV3EHK7DWEQwNFQ3gjDxyC5Q
	 C3q6iFnwPlT1BnYYpYEnel8xBr70ITVnY/EDw8IRhD8TzZfC/8BX+w6wcuBQGVC6nT5A0
	 jKm3/GZwf4HpaX+PthFQR5tCsxFzCRfQg6RNEk9gydTcwozpfIWVroLwlRd8EzD2Qew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vh6+wCs4;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832D606A89F
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 16:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1832D606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vh6+wCs4
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so3639191eec.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415251; x=1795020051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ru6Wop6zD4SlcoFBcvjI3pjN1oteV3A3iUcGiS7Riek=;
        b=Vh6+wCs4y17+XhlOELZAK9/7BUqo9m9pKcWAWOT2fd48lOkHy4u9qQFmjzT72OTCfL
         SA4642JaeLj05/jZr8BDvmZI35qddEw100h/rplpj1r9m9Lf460vqL4e1HyJn8E1yx+1
         I1KMJlVDC0Ci6oHbWKU5ajfWPAUjAuaWp1m9Fv9AVzszXLolfYJPK+ECxRqbyprieR8c
         vpEav7vKmSWWIMYA1S1jHLyda22Pezqhiennthcpw0B6ywEcO+UjzqSnAqesbxUgAzdz
         7k02c2pfBwMK4YY/iWg2fDoyBcKAWcGuvi/dHerg0V7/5QDXYQLL3j7MREuU3WA4tVAo
         vrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415251; x=1795020051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ru6Wop6zD4SlcoFBcvjI3pjN1oteV3A3iUcGiS7Riek=;
        b=jTDwgNgNc8mbxx1a5Hrw+WjxwROqBv1BekWA6HrEKapRhaztiz6Pk9jS3hbNTMduCi
         X+j5na9rPSzeT2d1jLPTK4/5EPB0TgGo3zpDKJYbUYfaxKz9lVQkfF8lf+h2zW7BmbWl
         EBOunUVePQpoxUa9V+m4dYu0lGmpheV6k7Kxy5EoX398UGLpAVJJv+Sm5iEsO1IUTJdY
         vpatzNY1rs6S1xA0h+va2LnBm28GOIvfK/hhSTfJPztzXnDJA19+VAXRxPTwpqMwBYt6
         GIhpyIJ7i/W+kjTppvsZxYEWqOh6eRlmL06ms+qbP5FZ/NSlCzLfBdgFzRHxFe22D11/
         9eVw==
X-Forwarded-Encrypted: i=1; AL+hErG5rWXtWZtigMuP4Nu0EOYdwVaf7au0hiPt84mGMhIprJsotGTeCTsMLkAeVNgoswgUjRBkCBfCmjQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vv1klvvB5UVxxsOoxWDTSpCr3u3mkN+MIvkGi/h5cIYDGRYX3
	REZTWfGjI/VGED/PKFXhkSM1YnuxFt+LO4dy2DaYtkYUPtfeqDNFa4yY
X-Gm-Gg: AYBFou2hPdEjC+ZWCf4I8e8qpxQL7y5OyfQp83yxKMrL+IbEvJtGuxb4Dh0NxHQt1fD
	JDhvCGzOa0cFLhyRJVk3kp+/aTx75yp0eXHlXQvyiweN+EH+zKuIDIpKwSyNgYDRFZsHv4BbyOu
	VzKhk+feSBsJ9c+XwhsYvB8dI/NY8qZM7Rpd4RSUsVBqYNCZ9z6Fg+SlaH1MTjqTE6Hgb01Bbnt
	kJtFQH2lTwc5daq1fCaMbNq9iaFDO4gSmLutlm15hoY/2cxt2pIkvIvhQ4/eLcIDX8DAM+s4+AN
	DrbKOzCDwapp7SVbYwMXGJn2atm9cJAFfNplXY69v+6yC5m1xeov+yhQGNq6b52C8GNERhhmey4
	8aSeT82Cb6T6JKUK/aOpFeDTaiY/t0tIdUTA+YO8jwsdQNoxSO89vo9JRpynKm4HXM2nSK1eAcH
	MewL1mbCznaRtz2m0eS50Aj3GhGB1It3z9J70aIvImhLBvEfhv+KOaem7kwOg7xhtwF6LR3SNJT
	D4b8BPSgGU63skB3HKz7yN1LZghT4UYHBo+z2e+eYJxVmBLJeaNd/T7iDBEUS1ZnXLm70E1G40u
	ayhhCg0viXLfb+vrxkrwJqyngevFvkq8L7OPb2FTIGM0n0V6YQb2P58HdPiOmc/X+rgB5mgEGPh
	fuRmgSAG2y8h3Co6xfzaQ3NoHxqBlBIVIvc8MRtMCtaycaxWYQG0x7eeW2B1KRnUowTCjusXLTU
	7xrLXT/QFVljfb8up1uS3QL10wDHHj5Kms8D/oaP4tGw==
X-Received: by 2002:a05:7301:5f87:b0:377:678:2309 with SMTP id 5a478bee46e88-37706782738mr1963858eec.15.1794415251216;
        Wed, 11 Nov 2026 08:40:51 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm19158013eec.24.2026.11.11.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:40:50 -0800 (PST)
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
Subject: [PATCH v3 0/2] iio: proximity: sx9310/sx9360: reject out-of-range hardware gain values
Date: Wed, 11 Nov 2026 22:10:35 +0530
Message-ID: <20261111164041.341776-1-kapoorarnav43@gmail.com>
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

Changes in v3:
- Return -ERANGE instead of -EINVAL (Andy)

Changes in v2:
- Keep rounding values between the supported gains down, instead of
  rejecting them, so the ABI doesn't change (Jonathan)
- Only reject values <= 0 and values that don't fit: FIELD_FIT() for
  sx9310 (Jonathan); sx9360 checks against the gain of 8 code, as its
  3-bit field also holds codes 4 to 7, which the driver doesn't support

v2: https://lore.kernel.org/all/20261109165200.305266-1-kapoorarnav43@gmail.com/
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

