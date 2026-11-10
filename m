Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325380;
	b=svFwBxuoq3M0GLERATXFDRJVR5+f6WV1YC8UysIAXK3JoFi7sPutTiYj145daJvIpejz
	 x/16uqbTREMm16zIFlFBXCQxcGK705Lw5L+jbHDAVG6Hk/QE/FRBz02X9t5WQVeJhe0bh
	 F5WzLzNY2bRhU7pbwRBYaHiXdGy4g8zLw7ze/hdqLPu/vXkKRrC+X6SlUtk1/thsqLvFq
	 YMlv41YIbxYirvYe0Lx/9qsyiGvOGnzM3ADflbnkJfP7eC7qYeFyrV83sVvTRba9lD9/s
	 PPua9u7BLCB0o9WRBIxJpWRGissoU4UtgiDs2etaCoj9xAnArBCSIU8on1+QWRH9Wvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4jRjHl81EF7Up+etusJDBfF6O2vx8cD/qRLceIcvSnE=;
	b=g48HEzEDj060HHOSwwteXt2hxh9dQDN4JC5cZQf+X2Yzm1mHW7DaOmHzABpNeAC8qtdR
	 RBm+yL7RNEzuFa5ZY7q/8lcGSrkjuR4roK+J592M/Eru+WX/h3k137ULeQuOWCRdumarM
	 kXKIfXPfw0txr9chkJYWdrJ0zqMz/HdyJhMBz5DlC2CdXqTsWQb+Oor1+J75HmbGH3UAz
	 XnmKi+qXov1/EkedDzq6pCR5ozd9xt8PDIcRR/W/BJ6znm6Eew+HTHTdNVbLXpx2QOnJE
	 CMHr8JE/hDlOAv22FbWDK79gfZnioHJKeHek/cbuNIuRVZpFDYrns5r70w80t87WxGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l5AEAHyv;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C8606D74E
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 15:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04C8606D74E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l5AEAHyv
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3acd239776cso15948201fa.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325378; x=1794930178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4jRjHl81EF7Up+etusJDBfF6O2vx8cD/qRLceIcvSnE=;
        b=l5AEAHyv8z+xulJVwemyoKO1nMLJoW+0E/Ca3zvhcOYCWcwLTpnla9Us4ZMoYZhRwt
         7D/Bt7S60gk5MjmfbWwFBma7zl4e+M+3SeYfldkBWxgY+g9v6lgfKF+FfeyoxMsIp17i
         IX+nH54etlVjQl5/and1ir8fTJVCeTVV5MXnQRsjxDf5vW+iKaIqR4uAhRhOWKChdmX+
         Iyntsj6tex8XP0yk5L1n1DblWV7pVcDQ2YEjjhsTrv/VibzeLYiZg1MFsZMMNJXSi3qF
         nA3wkyWxZBeQtkT+OBHdxH3R5nFzWx+LojB6FzA/xmcP0V4jUdPA7Ka8EqIdYoevtyho
         xE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325378; x=1794930178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jRjHl81EF7Up+etusJDBfF6O2vx8cD/qRLceIcvSnE=;
        b=ZcX4V6rlCCfK/7oidWKca42rRV+2gW+unFI+hs0uw/J5Q/Gy280r6nYRCL7vJ79a6F
         20zcV1gvbcxgJWQfHPIh7mBUN7AsaDtS+US7kg/gQ8zwkG31OUfgb3ntLSV44BdN9BMf
         c1Wyr9RTSYebPAEvCyzAH9B/JMg6BgrHVkPB+rSrnjyqTSofEUpDJVtvo36HOT+Q7plZ
         jX2rmIDy6jXz3DfcAdZ6LTct59quurKszhZQFsaYyYT20Rc1ZkmeAb/8/S+ATjr6Tyq4
         4msbU6xu86ppD6RrC6QT9oBn9LJJ9N25t5iJLf9LYjvRy5tSl4+mkIhjcwmqt0Hgwk+a
         ffDw==
X-Forwarded-Encrypted: i=1; AL+hErFUyk1gxiRB1c8vua3CldmH9+XudIP2CB2p8HN0PofjlMZdP33bXtqHC0HhIyaM/+ThmM0jhNEwCp4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MqCgi2YO5xibl3nv8eJOT5b0M69qisO+02Pl7PM3/delXZ0oW
	hjXBu6Cq2jUYgV18AyHoIMek/emjS4GPmI1naSLWR6TUzzNWFyhw6x4WUBsG8tIz
X-Gm-Gg: AYBFou2Uj6IxqbxFBgv53b5tF3ZbM9GYtXAhKMRV+XgNWul8Z8qGw/WZ0bAb5OpgeQV
	l3l3KkwutnHj8rcS3O3yhbeBjdp1gX1fPdyk4Sya4ZckVcxhx5WMAGX20SsCCDMQsJNrsDZbLkQ
	HXNyBaz3WWhE4h4WLljHeo8yNccwR9/7V0udaz3be8PHdDT8QJOhnblH1k5NUNnXHAL3dx1lByr
	CnSZWvo7X8pqBZhO5QfOyVsIqD0ixQltxRjBRMefPl51bEcNRF4V6ES7DPFY1M2UY9lYYqoigSG
	DDM/J01SPIOVVPKcdwSOjYvjrnXvZJ8Wp24KExwiFEFzu4TIwTKqobMsObX0DJSi6D0NzzThakL
	l4CMeBfrrGGCQ7vsSnZOWwjA83JT9MGJ1RWeOIpZVpDVz0ow3blYzYwSmPnY9SEFnLV2DInsV/y
	yLn7xbOomHxsNn7fV04la+6UPvUFgshK8spYoVGiuM9ajzrWG9SWUoiQG+gcOV984urm3IzJBt4
	rk2eiZCvfdCKkQ6nFyXmomGDOMeMLwOFBfyyTV31fL9PdYC/BeAaPR+2j+yZcfMtpYJ98S/xg+0
	OyDgoBU2Fz5F29NSxwePh4KB7Re8bSBQpwDrpfWD/9Bo4X1qLpCe9PoPSRWtxmd75mDuXcJ7cqP
	LmYOJ6U9k9f+HZT1I8E38sTSB+1B02hFgkBbEog==
X-Received: by 2002:a2e:a9a5:0:b0:3a7:6d4a:1c9f with SMTP id 38308e7fff4ca-3ae0963162bmr6483001fa.15.1794325377875;
        Tue, 10 Nov 2026 07:42:57 -0800 (PST)
Received: from yantra.. (nekmmqt3kfwnocz4ivv-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:453b:19fe:80e1:2b9b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae0923d583sm5751481fa.21.2026.11.10.07.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:42:57 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 0/2] iio: pressure: dps310: data-ready trigger
Date: Tue, 10 Nov 2026 17:42:52 +0200
Message-ID: <20261110154254.39092-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
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

DPS310 can raise an interrupt on SDO for each new result. Document it
and use it for a data-ready trigger, so triggered captures follow the
measurements and are stamped with the interrupt time.

Tested on a DPS310 breakout (0x77) on a BeagleBone Black with SDO to a
GPIO, level-low and falling-edge: one scan per pressure result at 1 and
8 Hz, gaps steady to 0.15 ms where the handler timestamp moved 1-2 ms.
Without an interrupt nothing changes. Not tested: active high, which
needs SDO strapped low (0x76), and ZTS8032.

If the chip stalls, the case the timeout reset is for, the trigger stops
firing until the buffer is disabled and a read resets the chip.

Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Rupesh Majhi (2):
  dt-bindings: iio: pressure: infineon,dps310: Add interrupts
  iio: pressure: dps310: add a data-ready trigger

 .../iio/pressure/infineon,dps310.yaml         |  10 ++
 drivers/iio/pressure/dps310.c                 | 129 +++++++++++++++++-
 2 files changed, 135 insertions(+), 4 deletions(-)


base-commit: b70566610b48ba49dec636019da4d696db64b085
-- 
2.43.0

