Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFE48CD49
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730093; cv=none; b=XzGniGWAWQ3fNp4GHBbOpogv6dowmLE16kGBtLin06X5+zh3wTtjFIdVFFggEcumcV7EBzjkJUEWgEdk74pQFKHZdIDEhFwmr/r9ctqKrDTsF4m6BZoH4+lZ5o4LZiGfrBr/bDw/Q5xj0Eh2afM+cg8jK3NZvsxLpMHwGdAd56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730093; c=relaxed/simple;
	bh=kMgTpZFq7u5Mzq2u6SsEFzNK60Jy27f8eDeuQkZcDUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AdTyN1FYgMvGisZRkWSC4GpAHcAZqhHIwQi+KOcYjOTo8loqfenw6S2Jtz7AbT3cZSU7j0zVSvSU1ZcPNCMyYr8KTOCK+gERN7KWw8NCP5j1L6d4sv1Fwb0vXOwYqMJc43qDaYAocIBnJcrAmLe6P+iUUFHbp/Jt5Qx0JTsDVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0cuAJnR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0cuAJnR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1535577a91.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786730091; x=1787334891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pehI8bbVaub01Lzsw57p/i91GxlgKin3+Qkja70UH9w=;
        b=p0cuAJnR68HsGf2yx+msJU7nrqgWVfXRdS50q3rYHwDegxAFUAa9LGkWNN18w7X4j/
         i3iu/Txv4ZkOo+Tri0Rxk44whOoMpwYna9LTLdR4BcFLpRTDkXNhZGo5quLXSh4Gb4Xo
         OpWN7sH5iJuaXRpwMZLaNm33qQugaCVmARjjfvqJHNeg+ONe0A28z1GrfE00oCPkRjo7
         NqB4JHISdXclm489Ly3dtOYprpKwW5K6wq87mgUkefDk6RpgKM2Awa9F19ptLsd4jZ1u
         Tic92p5cWWMaxWw/20zNHdIUZyBmlnR3MJ/d18fo3Qx02xV4d9q5uTt/gGpquK45QoKX
         2mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730091; x=1787334891;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pehI8bbVaub01Lzsw57p/i91GxlgKin3+Qkja70UH9w=;
        b=ABIGzurfk32grTygKR+c3LkRxIWbLjrU8w6kmaPhZ6GLq+gGnG/dqH959uWz6VGILx
         V7mS9P5H+nePr5TTuz/cTd0MPnPCIUwRSVf3EbGt8cfKw+0jLMGinECH7ANm8k+OX1Oa
         428q4UwHctLcRA29tqWpzVSCZuPNZP/LxSO1TGxNBrLnrdJzvpHshUf8CzFswzcciCiv
         d74Sl5SBP1pw/7hcwiRmRgVXP2NsYFtzyVnhsRvMxatByLvG9nE0YC9xRdG0mr9e33IW
         8urjRPe2vjYMpp/wC1GrWWtzmSely3iSnrQ5CYO0GyTV2XXqD/OeE2GyuB2UdMMIA1Kx
         lmqA==
X-Forwarded-Encrypted: i=1; AHgh+RpXbi0xFTaRvT1CuWcFO6bG8rbd1ggflc9eeQNwJUSIBIQyfKQ1oelfRg3ubgoKEIdc4GOgJmiX51A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylksJycsmOtEWFcX/XZE2/xWRqrzppipVXBKN8SrYaTckIESXc
	xcTHWKmGJxhxIY3cp2DQQN8qPSDYY5o5V7VZf/X1YuWLYYfPFXiFUW4=
X-Gm-Gg: AR+sD11EU+GRjDDSjTv7qKHQwwy2KOsFbZv16MyYwXoqE+6mgOidFqPrpDBTSJTD9gM
	QSS2RBLkC+qqgGXWWTc6KlfcyF31I3xAh2sXTHZ7xBs4ed7b789TDFigSxmnfGooCkfCExhCZJj
	zzCDzUyviBXyIvFBpziaSAvpN5rv+4YPpuxr/EM4M/ZbEVZO+yD9QJjd5bZWXFDv9vgXVgx0hqc
	jCCHh8GWnakv4uXLzvIEaq15vroFCoIFJdY/ESalOUhOLbjb/orP6YO7HE69YzcskdopeMj4Tx0
	NKwz5mrsAnjiW78NbgMVFttBz8fxpybdN5E0QI9BTt6zSz0LUpHmnVuFvMkIULW7DVsmeEfOM1+
	pqzATnP7504xgjAM5RQKk7g+OQVntn0IkquGodaG6rXeif9kASehCNBXuxIjtOCXpSRHznl8wT3
	/TpDqxwEOHTLmUfKPJTlBk6aqxkwYTbByG4z+U7R9NBqeWIaZKCxswYkQm6cs94IP3H8r2qJ9Vw
	BVSP1IEnDoKEsJ1GgsBsrJKbC+uzGe8p08KCtBB
X-Received: by 2002:a17:90b:2541:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-3933e5d2332mr8447176a91.11.1786730091422;
        Fri, 14 Aug 2026 10:54:51 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee70sm11128710c88.11.2026.08.14.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:54:51 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 0/2] add support for Aosong AM2320
Date: Fri, 14 Aug 2026 14:50:18 -0300
Message-ID: <cover.1786725567.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
communication protocol and measurement conversions.

This patch series adds am2320 to the i2c_device_id table, creates
of_device_id table and adds both am2315 and am2320 to
trivial-devices.yml dt bindings.

v3:
- Added "aosong,am2315" and "aosong,am2320" to trivial-devices.yml.
- Added of_device_id table.
- Replaced using a constant for driver's name with chip_info struct.
- Separated code changes and dt-bindings changes in two commits.

v2: Link [2]
 - Generalized KConfig description text.

v1: Link [1]

[1] https://lore.kernel.org/all/20260805183733.1000550-1-nico.antinori.7@gmail.com/T/#u
[2] https://lore.kernel.org/all/20260810183337.451812-1-nico.antinori.7@gmail.com/T/#u

Nicolás Antinori (2):
  dt-bindings: trivial-devices: add Aosong AM2315 and AM2320 chips
  iio: humidity: am2315: add support for am2320

 .../devicetree/bindings/trivial-devices.yaml  |  2 ++
 drivers/iio/humidity/Kconfig                  |  8 +++--
 drivers/iio/humidity/am2315.c                 | 34 ++++++++++++++++---
 3 files changed, 36 insertions(+), 8 deletions(-)

--
2.47.3

