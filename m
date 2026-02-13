Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B127EFEE
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002354; cv=none; b=g+gQGt7V0XWkLwX+mw5F+92JeimgdTXNjc17q4/rQlCTkkWo2NKptkKpBBlHyW4hF08/R/H5CxEVpYEiL96JRRMLw2seNCUbRimV2YKmVGHB3VUWUE5SJPsA0ZL4GjCQ6rfSCEzNbjwg4+XHReJM9kun2497lzdAJ7iJUgpRJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002354; c=relaxed/simple;
	bh=IYGeX6DGry9FC/d4pSSuK9P0vd3gE/XtnL6hAhRpe8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ/8onj6jjJWp8NKAiSLY/PrhExv+OiGkLcQAGFwPxyVgLxvYI4+TKVVg0bkq8n7NGkptn3AXTAPjBknj7e/Hm7M5WKwVL3AqZb6U4ND21n7sp6gdpHz7ZED8fhqJXh0gwnK9yT/4U8dGaL8zBcpmEhEKnmS2D2uruXI/tKsmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiyTulUP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiyTulUP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43767807da6so717215f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771002352; x=1771607152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYGeX6DGry9FC/d4pSSuK9P0vd3gE/XtnL6hAhRpe8M=;
        b=EiyTulUPkjOi8gY1tFD8M8PrHwNnxntNK0Hfx4/9m0TC08vaoGAuMh5XvmVxImrtsX
         13aJEcHEXGIWr97HBt2FqCUFABvgQ8/UyWG686PWGCuAgPU3x/BZ3zx1sOdcw/JqRulm
         qQY3szK2QPyocxAR2HuV4ad+WGLWbVsPCAzgwnJ6ghojnTwCJbRUBfGfBz6qCMd1Po+6
         Y3hizFCJhfKWjidsZYIvcVoI36UT+V2+7gMiuk4BcMhVLzFqhi+rRqaDa8RZ5FqkfoPK
         h77LQ/RqeY2+oAKDqOFx6+mnJFpnQHOGkhkNgW8pAxHOAXYAMp+PV1S/goulcLszYvhZ
         sEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771002352; x=1771607152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IYGeX6DGry9FC/d4pSSuK9P0vd3gE/XtnL6hAhRpe8M=;
        b=XtnLW3KAJqGygDWmSYa5v+howapLLQs047YfjMKhOmAyl+Q5liXPwUj2s4zExT2J7l
         dsgimCrHYZjHsa6goabwHrvp/NiydlVsRWoa82tg1kV2HZco08GcoAtHyzTp0aOMVjkg
         Kp+02otCc54OB7q/+TV6f0cGnqrbj99j39Ro8dXovNTgFjqkP1dkMeEVweydAmLfZvOU
         3XYr8PdJl4agLem49elH5+hlC1nLgHJItcpr94i7sACXjGouDzJx6d0G4iubEQ/JSAbV
         rABLJfcMKINr8T8iBlOvLBjsgyr+/DF4T84FwkU124EdNk1QcrkV9JHHyijD9rBxklzj
         zDhw==
X-Forwarded-Encrypted: i=1; AJvYcCWbHPfypXgHrRdUe6VVJQ1W+NoKfQXM4+yqa1TZpBtsVqTJYJwZb0MuCvHcTaIffIMWS4HMDl9Q1UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySnBtxxqyk25ug5Dypr0hzh3jT21xzW1T49oJJ5BFCttog5cof
	cLOauokPX5D/se0cuprFraBrrSW4q92xQWvXsiu9jt4erJWwRclBpvCT
X-Gm-Gg: AZuq6aLieeR+ZqWh6f/IMfdVA9XvShrKU61sCEJ9i68didB0j+MZr/Q1LV2RQCZ+fVU
	j8esbeXegZlWFodBdWkl55iNyM0/hh/OHz24BrHB6j2vdjiDyuon9l0aRUvlufOSLICMYGrezS0
	XIgy2w2gp2KTM4oa39szSrBzMcJt12H6APYSo5OsryHDj4uDPvOaPUxdf12scpAtpD5FWdbPGq4
	70Gr8WO2sMFWYHm99v9swMRh/9Gbz8bKBjZfJgHuemXuims24G3zkxWy5pf1QYU28T5uTe7WNX+
	QCKIky0cXRUtKGtSuvS/WnEUoZKGoKg/+y4DqMLQEDpHfrLe9ue6SfsaMQ+PxyzcfsbqFgUTosx
	IaCsbYGj99OM/dtKUGHMdaKqR12TWxre7bYUQqMGaCf987gCnIecpgBjQ/1Ei4bkEm7ETqxRc2Z
	IGBldBnOz8jyMzmgnwTRXvNAQWFRxJOsaGbAlsMm56F9EveZVa9/Kk7Kzw3u+ZgFLtsGhoB216d
	gM=
X-Received: by 2002:adf:ce90:0:b0:437:7088:4150 with SMTP id ffacd0b85a97d-437978c0a14mr4182508f8f.10.1771002352200;
        Fri, 13 Feb 2026 09:05:52 -0800 (PST)
Received: from db07.UM6P.local ([196.200.180.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc85csm6682432f8f.22.2026.02.13.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 09:05:51 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: krzk@kernel.org
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mentees@lists.linuxfoundation.org,
	me@brighamcampbell.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Fri, 13 Feb 2026 18:05:48 +0100
Message-ID: <20260213170548.28569-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213-curvy-voracious-yak-cc13ec@quoll>
References: <20260213-curvy-voracious-yak-cc13ec@quoll>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Krzysztof,

Thank you for the detailed review and for pointing me toward the standard
DAC schema.

I'll update the bindings in v2 to address your comments, and I will also
ensure I check the common schemas more thoroughly for future patches.

Best regards,
Taha
