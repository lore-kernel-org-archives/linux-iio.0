Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693501;
	b=HD1qnkuawPCV8O9xp2kH6WmZDvVDs+Et7ZfJ4sHvOgQ+1GwGbgb+gJrlaPW9t55qEzWR
	 2sGMpGAzTMKEfcn8nbw7VDIXIifm+jFq5Ri/joILxNfVXVkB3uuTTfPsah5nVbcTIoo+2
	 tHJJESIiZeo4Wo1gK+UA/Xgpdlj026L3chuPO2MoU9aG6LM4iutr2wQySiy/qAeNA9gqy
	 wiUfsHptuezYNhJRfEj6gScPMADZPoM08UeSd/VB2nQ9ewxM/GzXErAk0ZEA2zkR6r9qa
	 yc6cIpPWPxL0YP2WSbBnzawET3bDcKLC2abOnIW0fX04kNKOJVCqO5raalT5M/3MGSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xYSc6o4UCMvbbTqkqVkaayI84J/EIX3dDWkV92RPVPU=;
	b=u1KeadmJ89bT1SNFMjhjn3qaTDwDVrxmCx+XWjFvebAoWe3InGf3SxAemoK+FO0wkN6Z
	 cZ+08fqG87CE7xEt95+AY9OPL1gHDyCdKBd6Qx/ruBY2S57rRytWt5fSqmuDdZc7G7DLC
	 eMxnu4Xe0iRnNnsP/fLhNc/B2dDYR9lLKNiwcyecotl8zfZluagSrHLjm1qRxpnmdV/0l
	 fhtlbCvHwDjUqBjdzhF7eCyOYkVdr85TAPKaxe+NrJOeuSLomc8rxiZyzG02f2pDT6wim
	 YJjD5FF9elgcdtRAiWBhDk/eQ54QLtB+ou41AjFO9AyFD0X55JKNvZwn6LQsWWqxiDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TT9nKMVn;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F6606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 11:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9F6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TT9nKMVn
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso3194382a91.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 03:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795693500; x=1796298300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYSc6o4UCMvbbTqkqVkaayI84J/EIX3dDWkV92RPVPU=;
        b=TT9nKMVnjlGalKy60mqCX4AhaK2/uVGMNv2Q9+zuDWwWAA3ZallXeakZq60KA53PRk
         Eq1ZczfzGzWcE5/pGYHlnRb13FFhw/FBjCBY0u72R9fSR71GuGj9wB456Ua1pUCY9Vac
         GGSw3x3i/IchlVnCJjPdykA3wBro4TSSraLutbIql7I6a55TYcgbWCFmW6ehcAn4IUni
         jJV84wMHEgtNqUH77DM13rLPfZ01AwysgINjaSiKjn18kMw/gQfPV7buzEWBA2IlhEag
         THOEkGQNqUAhkUpNT8SwPbRDteF1qcDHEOfqIQm3Pb4AJI/d0dxQFAGJ42BbNNFV6cKQ
         u6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693500; x=1796298300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYSc6o4UCMvbbTqkqVkaayI84J/EIX3dDWkV92RPVPU=;
        b=p2c0yP9pgSSmfy6XP3uCw71/WWA4bSjz2kJoogoNSiTIf5uoF3SbemFyW0hqCUaCUZ
         d6zV0vYJZqY0ooeW0ogo4oL2uSRFKdguiAj81gbriIX9iyhNAY4VFnafL2R1Ceuwf65E
         xcx+aVjYAoIrxc3BP+G0SfG+HRgaQ5EQtdzrtEEd1FHMRKLicaLaTK+LYxtK+3UHkZJH
         MyAAnLIE+UZaHHf/Ke9He8sgebncA7Vkaiotyk5bgNouyJttgClcaOlo+ktuVvwfTS1R
         z7jvW7Dol6uRZMqKjlzZstwQevrOb6tSQ7F7EMuJUaTCvnCaRlu5TWI/Fre+BYSX7DEa
         zfcw==
X-Forwarded-Encrypted: i=1; AL+hErHfR+sJRzBVZ6UukWE+TvxZvfe1RAZS+gSmQpkLZ/eyVxGnOa06VwNlyDB0aIDWs1+en6Gbn8Oi4NE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/D7rjMzrMZXYxq234oMulZcdVu9FTUisTpEXLSYYVJBTqUaOQQ
	a36X6FS+6P7V4pClX6gGUJaFtj6s52stSAb6lWyO/+0tdB5Klt8gGyXa
X-Gm-Gg: AZFdTZcElCUumnU4BbOClr/cCjWC/m5YUgzIsc4ach4zB+tc91ASQS6EP6mvDcPOdbW
	042FOsfCC7xfCuG+7z5hroC07la2/Ig0uQMvmRC5rf4cR0q/1dj4SZ9DsKZi9xg5T8ipmRz7hPR
	FlukgkKDXUijBWVxat4M/oT2cE8SNZ7rsicN5ZXxRuJDksah993l8oEjzOG+ljkmWQhFo/oadXm
	VTpTLyKlMj+dnelpPeJOalRn+L/9/smsGmG8xcMxLd6dzVf1tvIn4OfK50zbTigtCWhSIdW9Qda
	lV5OAxTz9Rwz1hzAbPEH3YgqFelNiVFWL/2xIBgcr5pso1waR6XCdP0ntALa6TmTdjZnU6afddr
	vK0JIMZpQiTa7vSekHKGsyC6RLxoO2wmzdmKIUyckrKeqYn8jLMHUxxmx5PkJFzPCPnibAVINJG
	+Rb4jUI0O+yv3kTkMTaUsjuTJNtf0tSJXdcZvacs8i93mwigz6ytDs7FL+56QRDSGeInNpQ7k4K
	LLyxEwoldVGDAZ14fWbmEjozI+jCOLj/QCvBpBFNIVXd7O2690zCSt5FEZe6ureVwXyilsY+2Dy
	M34NTY7WJ989tpMjPnegNn8QWY1FLQ7l
X-Received: by 2002:a17:90b:1802:b0:3b4:1359:45e8 with SMTP id 98e67ed59e1d1-3b41c92c55emr19529457a91.44.1795693500463;
        Thu, 26 Nov 2026 03:45:00 -0800 (PST)
Received: from omarchy ([14.139.177.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm32962809a91.2.2026.11.26.03.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:45:00 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Subject: [PATCH v4 0/2] iio: adc: Use guard(mutex) to manage locks
Date: Thu, 26 Nov 2026 17:14:31 +0530
Message-ID: <20261126114433.20674-1-vaibhav.chahar26@gmail.com>
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

Convert mcp3564 and palmas_gpadc to use guard(mutex) instead of manual
mutex_lock() and mutex_unlock() calls to simplify error handling paths.

Changes in v4:
- mcp3564: Drop blank lines before `if (ret)` checks and add blank lines
  after `guard(mutex)` in `mcp3564_read_raw()` to improve readibility.
- palmas_gpadc: Move `palmas_gpadc_read_done()` inside
  `palmas_gpadc_read_raw_locked()` and drop unused `ret` from
  `palmas_gpadc_read_raw()`, moved conditional check inside
  `case IIO_EV_INFO_VALUE:`.

Changes in v3:
- mcp3564: Use of guard(mutex) across all paths. (Dropping __func__
  from dev_dbg() calls will follow in a separate patch.)
- palmas_gpadc: Make helper function palmas_gpadc_read_raw_locked() so
  palmas_gpadc_read_done() always runs before unlocking safely.

Changes in v2:
- Patch 1 (mcp3564): Wrap switch cases containing guard() in braces,
  add blank lines around guard() calls, and clean up the commit message.
- Patch 2 (palmas_gpadc): New patch converting palmas_gpadc calls to
  guard(mutex).

Vaibhav Chahar (2):
  iio: adc: mcp3564: Use guard() to manage mutex
  iio: adc: palmas_gpadc: Use guard(mutex) to manage locks

 drivers/iio/adc/mcp3564.c      | 103 ++++++++++++++-------------
 drivers/iio/adc/palmas_gpadc.c | 126 ++++++++++++++-------------------
 2 files changed, 107 insertions(+), 122 deletions(-)

--
2.56.0

