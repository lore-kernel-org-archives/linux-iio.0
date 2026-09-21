Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AC48425C
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988521; cv=none; b=f7NrGcz5on8jmWxVckn6HMbK7kovPlC/tlaw9G4lPUDCnJEPnWaTXDaiV7uZ8oD+IyasuXT6UBqrR1AAqpNmxktXjN83jfJSrmnKAuXXpI2qnQM3CHCmSgGzYTu8QhFaKM8PV+/+aK7w6oHg0HytSK98Maus6yHGZQQzB9+4Lis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988521; c=relaxed/simple;
	bh=U1zoqHEzQaVfkPpLFBsMt1Td7qlfJLQuz9lR4MKL6Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oycm06p4C2h0U8T6KnrkEMu3fvaZYfqn3H6GGCDX9qYZ4zDdKfDhjQ1Psv14NilWg3CX3n3i6GlDnOybD4eHH0WWxHzRNuJW3itzbpggWDfKClLwqx5ldXmqHAq0Z/cs3lk6C5gfYRjQK/eB4dLT2XKhPOPmQjCrFI3H7ngKacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rai0Z5SP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rai0Z5SP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so23829735e9.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789988515; x=1790593315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8398NpXiVKPAd2ACHhvzXWJuPnh5bd8fgXOc5fmJggw=;
        b=Rai0Z5SPdwnE/WudB9SbaT5qV6f1C/lcWAmyHAezn6vns96xzGBZ2VQ5Q1rgD21I3n
         0DHmv2YZDgrsjlUbYUPTV7QASwzYkHvKB0X8OQ89/+DSnShAdYmzGR+NniEZa5zNyBi/
         NwJmeZT+5o/1DnF2oZCCSu73ivrowH6QpOLQYlflF6YbBd+c8Oqdoriu92j5xYLv0Hxo
         HRPgDcJpL/Zkh9AR11yeW77QcLodYKvR/2aA6Q2wMtoTkbzJ3pI17OU3pug3hFJW+uo4
         J1TG3fRkYGbDBWkWd/oR8kBeNrYBd4iAfjPr1cQQymKVB4sfbQYbV1uUml6KceieDV4i
         C37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988515; x=1790593315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8398NpXiVKPAd2ACHhvzXWJuPnh5bd8fgXOc5fmJggw=;
        b=wPGB48/sNRN2DoFA6J2dKcK+t3Hsek2bHCu7M7c30Z28PVRaq0iif9i6Y8mQTWacks
         nkOfqGAA65TMHJcmYh+o2iCgPs4+MlHgIYfOfOhce3SpR+Sc8Idwr7frhb3HMlIK0ryv
         VFPdvEbwaxJNlfr6GcciBvcHT7XbQulkHpBYHlS+OI6jafGPi5Z31Mym4WUrXNgVdqiP
         fV/vKkmP8TAtEf9iD632zWPopD7UEJ1Sos9e9y/UgFIN9BG+UlYYnXsk/6i49//Tra9D
         O51I80/7mWFYE8EjQs/c/nwgALH9ecJzA5KGHVMSYOe/JTs+5fvOXlJoPOLyoW1rWKBn
         p9vQ==
X-Gm-Message-State: AFuF++laMEBEPwGRWCvSPcIrEVNhGrVmI/Ul6D3drRlW7NUnXhIQRnoa
	SuWXuy7dMVg77hZe/C+UjzwrG8oD1Y2qixzJ1cpm6lZHWCYDVMl1bXZh
X-Gm-Gg: AYBFou3RyYbMu8KpxjRxR7UOuBfKods6eSzkdyiUT7gsdSZyigpgj0hda31GinUOIaj
	MYXdHOlGaqKMibEIc1VeHpot7VPvJnTLcR47CWhrlxJwUurM+wt+KwFXjWVeRGpBTfVNH12zdp5
	+LL4SFz477Coq/9ShKmhmpRRGcfTWfKXKrykroFReFOSBffoLFh3I2RzIx++1KQlbouGGN8GCza
	W7neK64VS17WY1SgbE0m8oMg0NdRS1BXf5FGbxSm3Feu1+O3zurgKv/prFri6vkJvucfee7Wth/
	A1iBmC6kYEF8vkRLSeqTtt7jJugKpR1MAu69WgBFYQz1/e6ay8MmFiVLQXFOCkjXWJ25iZKdW6Z
	/3+dZK+FuQRNFnUcyDabHoEFeH7VLAlTOKhw+ZpmPK7wSOTwaAvkZ69hWbSb3x7T2AA4rOZpdGp
	BPnyRbcJHieHHuoxaHSqsbpc1kZehy5y6j84hp6ypFn72D7pF7vU9vSvmz8dvphdp4nTQggYKz1
	pe3tmBcx3+bnnIr4t7/cEuBsWArWuo0lIINwF8wX7WM2hAYpKQlsSwynFQrADtY+UzM3bOtTdu8
	Y98mD5w=
X-Received: by 2002:a05:600c:a085:b0:49d:25b0:cc60 with SMTP id 5b1f17b1804b1-49fc5747f7bmr150529555e9.29.1789988515344;
        Mon, 21 Sep 2026 04:01:55 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:856:ad4f:1ab5:71b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bc34sm214267425e9.10.2026.09.21.04.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:01:54 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] Drop unwired ADC interrupts for RZ/T2H and RZN2H SoCs
Date: Mon, 21 Sep 2026 12:01:41 +0100
Message-ID: <20260921110144.44425-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series drops unwired ADC interrupts for the RZ/T2H
and RZN2H SoCs.

Cheers,
Prabhakar

Lad Prabhakar (3):
  dt-bindings: iio: adc: renesas,r9a09g077-adc: Drop unwired interrupts
  arm64: dts: renesas: r9a09g077: Drop unwired ADC interrupts
  arm64: dts: renesas: r9a09g087: Drop unwired ADC interrupts

 .../iio/adc/renesas,r9a09g077-adc.yaml         | 10 ++--------
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi     | 18 ++++++------------
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi     | 18 ++++++------------
 3 files changed, 14 insertions(+), 32 deletions(-)

-- 
2.55.0

