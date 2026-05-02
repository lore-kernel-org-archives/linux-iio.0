Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427A2798F8
	for <linux-iio@vger.kernel.org>; Sat,  2 May 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777765459; cv=none; b=iAuIkZVs5NQFworEoT6NAGAxxCD0ewoXYWYBaqRm5mEo+usAqeo/DrffN0nYjOdD1G2WnLnBFqJwOUP6YhDsG8qMsqMG1I4G/tFpAYprD2njZBD8e9pi3Uk0AYhBTV6PKBPxKzngaxQSXNY5sfJfCqYJGqDseOuK8H64DKP8Jss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777765459; c=relaxed/simple;
	bh=QO/vYKppxX4gUu/4OjlaCFyDHBCAindOTNJlmvfKXos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkTmqv07TjRFgatPvdV0mSnqCw07PMu+kRFQgw0De2xCanukp0jh91U0IZJfZzB7pH+QSLUfvofXR07b+kxdlRO89HFyS/gzMmjGteT6mD+Zn/Gq5xokSVuClbHNOZ2jheGVBpKxQeH2DMUbcTwoXcmMiSNXt6sclOHiD9MtUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=fQ6Bdqeo; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="fQ6Bdqeo"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56d933b555cso912233e0c.0
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2026 16:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777765454; x=1778370254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ulID+9Mq+ZtW/p9DWKJDHeAzc1xbWPH8oFisrdrmDrQ=;
        b=fQ6BdqeozC2w/rGAjt4TzrRFqMvb2Ogmi1BwAQjr51aWhmLNRMfoS1D0Xomu3kBs6X
         KCQhwkR90qq8y/btGzIf8e3AD1imL4mOXeVDAVE+Nn7oSe2hnCPOSSN01WfBPXUn5fg9
         PsbfzjttGzZsPEx9TaJepbCEmgTOv8cqygkPNu7M6VzlMagP7wt0Jalbs67XadoODitr
         fN1Y42aHbJIJ0s5rqZavNmHrm3vif+7YrcAex6aLSzja8+SJ3uPDI28B+6iXjxGh9JE4
         Vee4tFpHFHardQij6iVia/rAEVrWlETmM6Q9/BKItJcGm4qzoQ+OedhtCv6uQwUaQmbP
         W18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777765454; x=1778370254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulID+9Mq+ZtW/p9DWKJDHeAzc1xbWPH8oFisrdrmDrQ=;
        b=KSzEZntuSc+0AGY0I5IV/3Vn48rmI8PzC+ADi0RZDrXzE4fN1PTwWUtCdFtkDdRoAN
         UjR/ZzrvVh1+arVf1jSPt/d0IPMjWRl1XLfkGdfFdHMQ82UOhDk9FigUcyrMETbLEQqr
         crHjFuucvRT1atISUaFwf6Vf+hlWwrsTpd1xzkzv3mHFKvqb8TCQQnzh/WXg/tXw61qB
         OsPwmaAdC5JjL/P05/Hd5bkdA5N8V4QFrKZLqQpa6DEVl4wzFRTa7/diSzK/kD3jKN3B
         crIC04CBTs8NViOdYrSzHl0Np4yRfF/XTIVkfCNTEexsgBS3rFKTg/tIRC05hMfU2+w6
         VbeA==
X-Forwarded-Encrypted: i=1; AFNElJ+g5qTIXaXJvZ1LLAnD0uh+KvlpG2kzzUro4EtFAJGaLDLvtUKqmLHo/lvxiceAlV2k1V0U7YV7MuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuI5virNCGJZVwwG6OvC2YZW3Ifup0fRarFib2ByX5CSUtlZp
	PdgMQ82XC4Lp3gmGhM/abH2n34AVRld7/VHjsXhndcEXe1wc+jbPjavm/DuXrKF40H8X8gaCULM
	53doUGxjHKg==
X-Gm-Gg: AeBDietMo7IgfGsEwxRJRcbOPlAGnfuq6+o3AcHBoLST0Q0BIrdJod9/LLBZ/vVqJaH
	OSodE9n8moyakUWCn+G4QIYfj9MlE8p+bfqX0Flckj3SI0FNIT8y/OPPGZdYxCI+uvesylJGNWa
	kR+JKuqzHVxKmNGEGig7NfpsAjR1J1BW11TZ9gm+XWDc2kEd/+2zY8TOlui56DkRrzS2kuCTVc3
	JnF99ftk0ZISUACOf4K17PVQCiwHhdCeUDvhHF6wlFaMe/x9nP0gMtByHbn21Vzuo49W1x6+/I2
	2XXDt/bmiUpOkwBeesTWYyorzB3Cz0BLLs/NpFA2y9X4AdbI6CczEg1RmdaqRhYI7X+WY/U+Ofz
	OhbfRpgAXS1d9lTtoBpZ1HPui/d1A6yC9j/o3K3LnkBeiR9XC8dGj3x+GFnC2TyBzT1SVlXh7De
	wqk+ncA7pvgx0FPfCVUGSxBo4fVDwrr6fSNBmi
X-Received: by 2002:a05:6122:4204:b0:56c:db8b:504e with SMTP id 71dfb90a1353d-5750c6ae9a0mr1938795e0c.13.1777765453748;
        Sat, 02 May 2026 16:44:13 -0700 (PDT)
Received: from gigagabriel-PC ([177.33.85.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5749f7e9f72sm3752167e0c.3.2026.05.02.16.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 16:44:13 -0700 (PDT)
From: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: ricardo.kojo@ime.usp.br,
	elliancarlos@gmail.com,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] iio: light: veml6030: Generalize hw_init and cleanup naming
Date: Sat,  2 May 2026 20:41:02 -0300
Message-ID: <20260502234348.131563-1-gabrielblo@ime.usp.br>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset refactors the veml6030 driver to improve support for device
variations and future-proof the codebase. The primary focus is to
deduplicate the hardware initialization logic and move away from wildcard
naming conventions.

The first patch removes the 'x' wildcard from the main chip structure,
renaming it to 'veml6030_chip_desc'. The second patch introduces a
configuration structure to handle device-specific values, allowing
veml6030 and veml6035 to share a single initialization path.

Changes in v2:
- Renamed 'struct veml603x_chip' to 'struct veml6030_chip_desc' to
avoid wildcard naming as requested.
- Refactored initialization logic to use a configuration descriptor,
removing the redundant veml6035_hw_init().

Gabriel Braga Lagrotaria (2):
  iio: light: veml6030: Remove 'x' wildcard usages in file
  iio: light: veml6030: Generalize hw_init for veml6030 and veml6035

 drivers/iio/light/veml6030.c | 102 +++++++++++++++--------------------
 1 file changed, 42 insertions(+), 60 deletions(-)

-- 
2.54.0

