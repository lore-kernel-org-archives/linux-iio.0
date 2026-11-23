Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442161;
	b=BgCU0izVB5gGlNLZae2I8MIrHNPPkke6ZHbvjqLeksclq5eqyk+8UoJ/Ts4Y8bAntJhE
	 duvl6cJv2g2tiYFYDZVEnDjjdsLEXQOOYQp8h7OJReOnlfP4+XOfV+CKHtiJEQ3rtN4Ih
	 aTGyZpcslcPxJaQfJqx9GD5FNNUUEx5p5GgFym5mMw/1RUKiIv1L8zOXAaJSco6pwcsLu
	 bbf/76TKUCuwMYK1L1Psemf3vyu5uBAGQNEC4OAVXPyROICCM7vhg5PJRtzZe80AWuvUn
	 SIJ51fTeq+AYIgXM2F+0jaGd7yCgvzYwtnTGBo1gcakAoueN6SFu27ewU9ZRB8AWJcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4FZlYJCrrOTZ7/SEb7e0x0CrxaLEX6/kL+T8hZDwyds=;
	b=AnBa9WeiA+vK+yaZmLblAQ6D8/wRKijjFMoRzy+PaBwuMhuCrstgNQUIJI4xHomc7mSn
	 kq1k9h5foRrk5grXFtkBWqy2P+UJRKZZoRj4l1dQc385De4Ip9Z2f/aqdfxjxEILqjgG9
	 362D5hs7AOwhl6UmPk5i4GcXzyE37lyovM1tWyzfpAXlf5rqOkJo7ruBS5OtmBmn0UvM+
	 L+itA1gRpxC3yOQqC+P/H1GBbJOCuqvHCdDlP2QMugAeJrTVyaCUu4dTfOlj/TGQRmrwL
	 7/llv4abM+0PBV0rlrF0W54patr7xRGGmk45bK+OrnlG+4ZHF6H8joUqFy2TDqCduuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b1A6snFt;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A9606A31F
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 13:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 453A9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b1A6snFt
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2761c69fbso2057076c88.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 05:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795442160; x=1796046960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FZlYJCrrOTZ7/SEb7e0x0CrxaLEX6/kL+T8hZDwyds=;
        b=b1A6snFtT/Gqxvse+ACEUnv0h2PjWDwuBDQGoY+HqLz/NmhSYm4Yt1hveHwu6z/WJA
         4Oxo19OBwpdb+is/3/rmDZrzHAzH3f0ApqU95jBpa0yGlXZ0CtzXZ950EKEijg0rIJAv
         BKwCDnAAT3Efiwpxpubl70M/fpB9NfKSi/2+UNIBIArbMe+bqocRZKQ/zxp0O0s3Zc1L
         Wtfq04PeK3vDtivrW3tQTns0ezovjwMCKqXkiXb45VlBSs2kLP2TAgX1v6GIeB8zGaAe
         kViJVRI4LW6ZlDvX/GBKKWVNOCytxkGTP6aOVIGPJaWKq7JJK513qk6398gKmdBdXoaQ
         bJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442160; x=1796046960;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4FZlYJCrrOTZ7/SEb7e0x0CrxaLEX6/kL+T8hZDwyds=;
        b=sxO3HcrmppsegmkCbDy0gZ2IzBr3SFUTVfO8/XhelxHutoFumjJEznvwh+W48b+J5P
         ZbKHIhV3bkKc+YpRktYkREHrL55BK7S51P94uM2abQEWcbT1eQTpAjxx/TV9lq2bcGop
         Z9p8NJgEpsd2advISI4H6duBhp9DwaYeYIazYCKzCREP90cI12SN6c164cbo2OfGndbU
         rlT5ARWRAtEpVDJWxjOHqLXhJz7UIeUhsZMFF+zYs4t88tngga71GltUZId1RQ6U1Wma
         5eP4+5P0NQd33/HFc0T59gp5TMVrjpl7hDkb/rpcJb/JZzvdNDRh9wJQv9SwG4rRTvLh
         YhSg==
X-Forwarded-Encrypted: i=1; AL+hErHZOLGKLdoMDQe689lh+nZCtqG9ggM6pJqECRq1MixabQv3JueiMoU+Ocmz6hAD3PzIUxBpyz7Hn+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WkAx7tOaBKDRKRdh8Gm67qGlSXZcDU2o9h6UHEp/9g9R1C8+M
	DjEDo3x7MZ2rJxLdOZKPhpnFzeo1cPi6yb1ylcQgjONjfy0SycQV8TxC
X-Gm-Gg: AZFdTZfF7h/9nbOPCNp69zv5RzvHbYiJTwLUpqSdGdsMH49UemteuG6CteixQVhwjK7
	jnES2sDSk69wrLPNvCF61iy7zH2SXay4V1GO3FRJ/6K1Db3AzwibQZ00mpKifAPIGxEKoQ7SHmp
	b/Q380hsDVu+Vo4wJIf3mZkncvIc1/cmH2ZBx91y7xTeORgZdp2v/wxn7rWKesqm5Kpnx4K+ah3
	BUrEbE3AnP5t3wEV5pw5XLdhbPxJ32N0CYj9VyDQTQPmGoZTBGfGOx2GFpc1+2o4E9HCP8O2NxQ
	kZD21Q+RbB5RraDcTwbBPGktrfXF2hEY59wYVn/CDo28h5bcWL6L9GjHT0KE0qManV9bHtkcSHJ
	i7LnyDTLuZUSuSM2ZMl88ay6RZZ9eT4MjE9QFW7t7Nqrp/HsTCOzjxb6HrYBVPKjvRx7C6PvsMt
	2leF1C4r4NlE78eQJy4Vt8zWgeA2YFkrdxUxbyeTCFSO3R7/iJP4AAyb3CyN7iTf49g4fO63H9z
	dtwLZsz/nRRhKpZ3nuodxEdcpjMRHiQeYAKEHUZ9Q7D3Hx3aKxrJygFmAaMS23+G/Hs93Vl/Kh2
	US6vDW5fSxvCO6GrNdEUVZQPYKmHunzggJIbHXlJXMD2J7t0SIPkGQ==
X-Received: by 2002:a05:701a:c972:b0:195:c6c2:c6b with SMTP id a92af1059eb24-1b556916d9amr11242647c88.35.1795442159156;
        Mon, 23 Nov 2026 05:55:59 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm29310267c88.5.2026.11.23.05.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:55:58 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux@analog.com,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH 0/3] iio: check register fields used as table indices
Date: Mon, 23 Nov 2026 21:55:51 +0800
Message-Id: <20261123135554.2983499-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These three patches add a check where a driver uses a register field
read from the chip as an index into a lookup table. Each is the same
kind of simple check as the recent rm3100 patch and returns -ERANGE
for a value that the driver never writes.

A few other IIO drivers have the same pattern. I plan to send those
after this series, unless another form is preferred.

Maoyi Xie (3):
  iio: addac: ad74115: check the rate code in ad74115_get_adc_rate()
  iio: imu: bno055: check the hw_xlate lookup in bno055_get_regmask()
  iio: imu: bmi323: check the config fields used as table indices

 drivers/iio/addac/ad74115.c          | 3 +++
 drivers/iio/imu/bmi323/bmi323_core.c | 9 +++++++++
 drivers/iio/imu/bno055/bno055.c      | 5 ++++-
 3 files changed, 16 insertions(+), 1 deletion(-)


base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

