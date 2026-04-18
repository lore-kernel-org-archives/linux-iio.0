Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27019992C
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523669; cv=none; b=GyW69vO/biGIl5eq6coP1BxnphLBZywFJ98ASSMKYzUQ5wtX1U1QhLM2D3UCLzGqC78gcIcbsjdmAtD8TEwvvdFzoNvxiuTd9sznlQjvDItcqyBPYkbVoVnj0mfTg7mMlok2xPBtlKU0xAVyM9HgAdZ8LHLS8UQUEJxLGcGQs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523669; c=relaxed/simple;
	bh=eM+cPPhTbWP6d8hZZnG0IroQxUq2NWVkL9wVoSPJ1mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJyf8FuDCeBjqcsFTc4s4klAfXazkVk64fQ+ZV0DYlJO8cN9msQkLiImzXvshy84bxZDAih5YAZQ8vJ+16AMB6kJpVWLRgFihXtuzZX3+3SoT0OwCMh7INFq9jhhaWC7/s9b+dfQ74QimTOsfAbfhLfCRSA8poCSSFgOGK5YBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHPAOyQm; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHPAOyQm"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso13083301fa.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776523665; x=1777128465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWVfW/QUZR75njEVm2LPlYmg1wiyoY5+XXkPVMcr87c=;
        b=QHPAOyQmZAEx2oF5yYq1ftmp1Zua+DPzbyNlCF5DUFan0XjnafYesqP8laCeiTuN+N
         5Uj2RA/gxuScCcH4QQFc+4i+bECZz/NYzhvf5Nz9cpt3270zW+g8t6swsNTMCnioQvjK
         61rTlBLkvn5Df90QnrMaltkht7zjqwjgXWpb4S0uusNShbU3iS2e4g7IkInf6ITyTvdT
         SyTrTsTUt/d7MfsZ59bTzN5XD8FS8k9IgbFAfPeJoDXMOO8cY8uhm884EC5V35cLqShR
         k/IadaRklbeX6VVbz6xaKtJGvwkgmSUUocCLU4/Sgm8n3IkC46Zhc4WORBas0kbn0UBb
         q9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776523665; x=1777128465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWVfW/QUZR75njEVm2LPlYmg1wiyoY5+XXkPVMcr87c=;
        b=BXCxFuIpOSaI7vbRO7zlrSVB8NOYxvmcCOsqxiO33OTpUQ4f1s0yrBeYQ97vOhzEeY
         Fh7AdjO2LVrd0tF+rphpR1F2MO+WWJgpFk1uNix7141mkfgVMoyNSp2A8YIBQih37lSp
         rmft4TVdqE3+Ke/QySR8fRfgfW6cxRDfvqt5H4BOomu9WVBaerYVvGkkmN5Axih3vVIj
         XeuLVE+k3Lp6NUIVQFn31Dy6UUKtFoMFOzPGyynZeGOw/35lnJozmr7WSmKm5qqbioHO
         mcTAETgvjSQOUYl2QNVDwi05LrBNRGHXmy3whadGsYpLCTMsChrDU4M5PuM2yCW6GanI
         7kVw==
X-Gm-Message-State: AOJu0YwGlGKbQ1aheg+CVAuUjy03gjAv47Au514NT+EvqxtF9bDblgJW
	ZUOMRH4Af+ttIoES9IQcbEClx0yHjmi/RWiw5r5OoBBd+oX16/PCjpj7
X-Gm-Gg: AeBDiesEvnvnHbooiMPKW87SQoE8YAJovovv6BSfON1pL1ikfi+s2DAbzLpDtXwu60Z
	rqy6PvAZME8sWPXaHk1ZP8UWp/WRcgObe6ITmXTVpwlwLVdbOjNOM2Tnm5s+r4GIc86LPs6Z/Jg
	vXSSSp77/vPvomWOUMyYUbCtty5/pWqt7Bcw/uQp7/ylfSWTd0D9kL2H1VC6JoLN88IV1Lv28vH
	xA0PPy0hCmUH0oC6AciIy+crPR8Q1DvsJ3Bz4Tveb4a8lnEl1BqRwfz9kXzxong8TuyypFbBqqH
	wQv49rinUIPSeX1cRoyzmRg/TcwUrDmklBOYPIlqBeke1q9WL36vlDTvJMe0j4H6HttzauD+ztK
	Id7xJz3jTFikKpbb/Yhea8STwT+6K1jHhbQMJk5yphPKCqNIY4UQ7qBPw5i5xP0QaoU3hm5AsbY
	ooL/k9XLhS48RF46PLWGtR8ro=
X-Received: by 2002:a05:651c:3259:b0:38e:7bf9:9835 with SMTP id 38308e7fff4ca-38ec7b09049mr22619261fa.25.1776523664375;
        Sat, 18 Apr 2026 07:47:44 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51easm10901001fa.6.2026.04.18.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:47:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Update APDS990x ALS to support device trees
Date: Sat, 18 Apr 2026 17:47:11 +0300
Message-ID: <20260418144716.132936-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Avago APDS9900/9901 ALS/Proximity sensor in schema and modernize
its driver to support OF bindings.

Svyatoslav Ryhel (5):
  dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity
    sensor
  misc: apds990x: Use more device managed approach in the probe
  misc: apds990x: Drop Vled supply
  misc: apds990x: Convert to use OF bindings
  misc: apds990x: Drop IRQF_TRIGGER_LOW trigger

 .../bindings/iio/light/avago,apds9900.yaml    |  83 ++++++++
 drivers/misc/apds990x.c                       | 197 +++++++++---------
 include/linux/platform_data/apds990x.h        |  65 ------
 3 files changed, 187 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml
 delete mode 100644 include/linux/platform_data/apds990x.h

-- 
2.51.0

