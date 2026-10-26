Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984869;
	b=snIQc5oLO0EqHCn/3Bn0q4yeU8SyonDqPCrjvu9d3Ox6PU2kYKQ6yXiOGL+MRoqurxgg
	 HHp2W16k1lnldfrmKj8V/8H1oQTd9yHduy82Z4lF086aY/E6Sp2Po5JZPMEMECexMexBS
	 JLZhHjzB3usGQidhv0qDMFzlUU/TJglobeGnHRMbG8iMoRZnKXSNdeC3k0fhyQZdy6eIH
	 pban+BV2og/rC9ox/eEsCwCS3ZVl0XuRvFBmcqgPJvvu9iu3ZwYBIbRFjqo56ACu16JlI
	 3fH7HGA9BUER5/ecD31eKtwbcw1Q+Rq1KLCG1jn0sIkLJorkZYYpVAJs5htNPv5oI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984869;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fdaAZ6d0i+//YNwUpxF/TF4FhR0ScfzBY9Iw+82o/rk=;
	b=KRLQg45KGjQXs3w4qwvCrsLhXLvQNBXFNJOB3X44UNuzPSy/chwF76z+JznIMYnwiyCi
	 5jbqwwCWwV/DTpaqAKm+v4DIMpbLT8dItLYv25J142DrIT75e3iu98wrrVFk0puqi4YXk
	 t8uqFUSOqvZbe8RQGTYdTQehNkH1h+dOnAHBlmawSPTe2Oq5Tuod96TjbuOfzsOK5E/Pc
	 1xfr8QLo9nBaRYXSij2AIb/5hZqTde28jYpVQtrb2nqbd+8xz/qWxeU/Vbz2tW33bp9Zh
	 9d0efc7HFFgRJf8kaKtD3NfCJoB60mZAEE0ow9jfE4XlASt7i4g0y/KzkrEalQco5Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNAAnxpL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDD606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNAAnxpL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0CD1F031E4;
	Mon, 26 Oct 2026 03:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984869;
	bh=fdaAZ6d0i+//YNwUpxF/TF4FhR0ScfzBY9Iw+82o/rk=;
	h=From:To:Cc:Subject:Date;
	b=JNAAnxpLNhDx/Cz/N0xbXZGNdyTafP2ec9wX5ebpSd+wPq2ytZZFNCf7cK8zDNcLO
	 SvMXfLiFuc1o7F3ZiZQg0RhBTbV2d/aLju9IZ9Xzr5Vjn/h0ynwhWFn+pGZNsPRNI0
	 G6WhmKKWnP/rwNB9tV0N96BH6NuAjVourVLvKxylyI8Hmt0TvUW4OY66mwdaq5TtIz
	 QjOAY7R2EvzfYj17PBgGqVtjgvxvGGzhljNWhdI1EFc8RmLCLagicYi78OiRjRjV8b
	 obcp5IJVZ9R0iFf23k0LbLiInXZy25FoQmqmfvrt2BqBlmqEKYXugDi83CMSuezik/
	 f8MUHfRlwooJQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3 0/2] iio: fxas210002c: Discard pm_runtime_put_autosuspend() return and related cleanup.
Date: Mon, 26 Oct 2026 03:20:49 +0000
Message-ID: <20261026032051.1004536-1-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

This is broken out from
https://lore.kernel.org/linux-iio/20261021235818.3059519-1-briannorris@chromium.org/
[PATCH v2 00/17] iio: Stop looking at pm_runtime_put_autosuspend() return codes

Understandably Brian has expressed that his series was focused on
just one thing - dropping the return values. Given this highlighted
some other related code improvements, I am going to have little series
expanding on individual patches from Brian's series - tweaking Brian's
patches where I think it makes sense and adding additional patches
for related cleanup.

Note, if I run out of time and we are near the end of the cycle I
may just pick up Brian's more minimal set!

Brian Norris (1):
  iio: gyro: fxas21002c: Discard pm_runtime_put_autosuspend() return
    values

Jonathan Cameron (1):
  iio: gyro: fxs210002c: Use guard(mutex)() for remaining simple cases.

 drivers/iio/gyro/fxas21002c_core.c | 137 +++++++++--------------------
 1 file changed, 44 insertions(+), 93 deletions(-)

-- 
2.56.0

