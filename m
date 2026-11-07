Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050240;
	b=wcxObYrb2G0t5O9o/2AKXZSJp6Uu34CuuDt9aUNJMrbIX/zeG9DtJLo71dsGHq+l3H/p
	 Gf1SCii4I0UmS2eOw06R15HUrbvDwkHQ0QC6h/Me7JbYHLCOvdbelnNYNE8egGQIbpNHm
	 gOp+QyuF0px07EXarld2Ro3OO2iPRT6a9BuyWtwdNhVFpDlJhtkUBisusOi/seuZJ8vpc
	 zriuG+8O2CXpZj5p6ljMd3sYneBj2hdlFoal1doTm+2trs8sb5TQySEi/wPkITT1i/J+w
	 ipmRVONeqQsshZmtZp3kdztOoceIumN9hp7VOWgHzX2w4aons4Jx+xKmYb5BchlsHNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F+/IfPhG4os6D6vXxpVvbJFaEOwonQLN/tF2+VzMsH4=;
	b=4hAosI8/LuNOLsQmFEFfzDM6jAcFUHaASB+jABATkC62Jnq3F/utCRFC7ZoB3Kens69m
	 3YHnRQSXSppMJqVN9M77mE/KkBC/w1HA3oiTbR4IVZPCE4+lOUGsF7Ujy2M1sh38aaNhb
	 H9iEcIZmNVyJkuwQm78Y4sE+bWeTdiQPrSzK+VyilYoCEabhuh4DNYE8IMwrTu0abqqtY
	 xtX/q7WnNuSPrsmzHvUUhDme+XwQPunoGKVkJXeFtSWnP4n0XVVgAMv4kAVI4fpSBoI4e
	 nSX+wPojlpmgXvZjgGQ8Zabykksh4UacMMUscNMbF/VArgphjPAecP9Jpn67ScG5D9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RUk/JZAd";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E2606A326
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 11:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 287E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RUk/JZAd
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-170135e43c7so2568272c88.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 03:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794050239; x=1794655039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+/IfPhG4os6D6vXxpVvbJFaEOwonQLN/tF2+VzMsH4=;
        b=RUk/JZAdGMZQSXUFKekw43JQ1xkMUp76hSL9vKLpWnel1mRAXbbN4QGp/oHpU5AXZB
         0MCfPvVeZAaZP9oIHK9JZ8oVywCCGkPVzR3sGtGJ8E5ZjxFauXqmYdiZc3rd8AclEvt8
         QzVHwGXgapfIoYEWoM3mvACM1WIkuvS9jAjDBZp1EubGM78cGT8BKc8WbtThEIAOhei+
         8Vjl+tzMHeZe14/XlvNjFzxUg8mJ4F5fNGG5lUOrI2GpMhOr/kmvbcpt/XUj7n6K/ayA
         K9QaXjLhh9V7pzkp3xWn+Qf34TxLL+KpFCyWPqwPPlI1WZjcC2peHR1BiJhbzvvef5Su
         KMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794050239; x=1794655039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+/IfPhG4os6D6vXxpVvbJFaEOwonQLN/tF2+VzMsH4=;
        b=HSNzRNtld/7IgyaryO3LDe3MPTu+MDzGRtPy8hvFk+/n+3Efc7MylWmpi4GnHObo1S
         6wgZy9H99e4VHpsKw0Ho2YlXwhyqBjcqn/WI7JJni1Ks6eTxNLnB6LhICCRde/9sOWeH
         TR8aO8MVrAt3mio9GSg/3Q7yDcqKMebqRaHF0f3ipQdQiSDFNm9iRTNDmvdvWPlCmCqk
         VGfPjIKjP50LwB/3APgDRdBb0G5Ww1tImHS+XuuWPhlzt8lslKARZY38lmx6y+1GAr95
         nyxtWqSCeIGCi/zerse1FPV87eaKekFdO/jwFHAoup3PnF35e6soI5PSMqeRuC10jSI4
         NHQg==
X-Forwarded-Encrypted: i=1; AKwUvByoS/jG/2ygo/35X8fQ+0QHBA89Ou9OjqlKJuCUBQbardB7AASzKDIs/KL4r1ui0UKDDpxA2fViZWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gNyO70niCyaiR5zDIuYg9eHNVhd9jkcETOrjzdvMi0V1mMWEB
	A4YeuWgdfszyUedQpKm5ip11k/ZDfiAuhD8h4pZp+WZEbJEzruuS28oZ
X-Gm-Gg: AYBFou1eE/GKmEPQfMoD63JCXtSKGfvMBZkWx6PY4BIaAU2dY11Cclw3iwnFzcJFIOI
	V3VUSmUh0iPzF/E92jabTTuAxLB/04nSyH6iR9xjtuizJfKxraHmC4hXTfKlb2NsiY1bBDby7pr
	IXBU7OUvg7jlfovevRotDXjdzD6SWiliAkxzOPUyTyPIH2FrS5WvbT7gUjad9P4N9bkf+BGUSPQ
	+WxN7cPilrSu/Ai99fBJNnlgi1E8i8ctFLQHvDLbSor8sJxBlyR4DDOKVtTsfiSY1nvfTuyYyAw
	cBTr6w1iAJV7XKuBWmj4at8CQMY0kLBYTNjpbq+pVHYmisjHBKHujQ0oJIr4ZL+6bRqc9iYFMVv
	J3hx7ULWH5Lc2pDexhAYDReI198QrXrWe5N5au9YTlVaPd0s7RSmCNVtkTkDy8eq8GgIYERWRCg
	cm8IHWODYqvDZUEf9uKsff9rGH46hi+k6VHtu2KTlfK9/JCCeFu0/edgGjmGKkcxJKhtU6dGm+6
	G7pl2J2Fwmo5c97PK0vLmiy+CNhbc0Ac/QXe3y4HXCndEbMHLryi46DV2lfd+zUr0yNm/Ws7Omm
	Wfo2/FLBe/O4eMVQWfaIkwo0RyvyEi4XGf8Gr+IIdJuG2dmeC3SiXJ7I4Q9ghDB1vmnCWscjQUN
	Kekg2QyxJfn246BhE+rf+1XR8ug04rcrzNYsjLXM+LrD2j42+4Ns9dHWXCrPHIJ1dNsJsJ6pVmD
	lxMvC+tM5Sx/KeHbma+BBcHIlSCvRqtK2UodNXH7xfIA==
X-Received: by 2002:a05:7022:ea8c:b0:154:e9d2:d741 with SMTP id a92af1059eb24-1b25d3058c6mr6660822c88.8.1794050238640;
        Sat, 07 Nov 2026 03:17:18 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fd0000sm13284120eec.21.2026.11.07.03.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:17:18 -0800 (PST)
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
Subject: [PATCH 0/2] iio: proximity: sx9310/sx9360: reject unsupported hardware gain values
Date: Sat,  7 Nov 2026 16:47:02 +0530
Message-ID: <20261107111710.442318-1-kapoorarnav43@gmail.com>
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

sx9310_write_gain() and sx9360_write_gain() accept any integer and
squeeze ilog2() of it into the register field. Values other than the
advertised 1, 2, 4 and 8 are silently rounded, wrapped or (for 0 and
negative values) turned into the maximum code, and the write reports
success. sx9324 already rejects such values; this does the same for the
other two. One patch per driver, as the Fixes tags differ.

Compile-tested only (W=1); I don't have SX9310 or SX9360 hardware.

Arnav Kapoor (2):
  iio: proximity: sx9310: reject unsupported hardware gain values
  iio: proximity: sx9360: reject unsupported hardware gain values

 drivers/iio/proximity/sx9310.c | 3 +++
 drivers/iio/proximity/sx9360.c | 3 +++
 2 files changed, 6 insertions(+)


base-commit: 340d44bdf9db0f095f99845b5ad8628781d79b6f
-- 
2.53.0

