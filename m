Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB577211A28
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920425; cv=none; b=MLwpRhJdhEMjoUg5HDRa6bCD/VkodgXIuNSwzFSv5G8zF/JuFgRvOID/7qtIm31vEE4uNM0gK8RiLwcOcEDYQKPsQQTz7ujXXw8ZG3mWA0ILuGQt7/gf4P0mDl8NQjIKItCEtHeq4vNeXlhCXfwXj5YoZfGh3k2Fpg1BfcUY/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920425; c=relaxed/simple;
	bh=uVa+/wT3KNLi8Q8FvKRnSsnebspAdMUzmu8d9BvGiTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMvon+701cVvAwlXy4ssmFGvqytMgfYH2Y+SkjmvaQyxSf4m2loByMILLGXUj7YxWE9kJiIcaS0lEeINsLxFX0GkBxijUv65KauSsAuMkOtM5wJ5pE33ITl0aApAO7vJNQKOzDZplXpkT+qWRt6ioNvI17DNC1ZPzPyaYGhgNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywr+ulJD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywr+ulJD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43621bf67ceso107283f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 10:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770920421; x=1771525221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8E3QEIEUXqaGRqVfLNoA5ttIhLZ1wRahVarTW2/Waqg=;
        b=Ywr+ulJDq1lCI17n1lzkNvhPrf/eRQg9rbnIxaz61F51boA1l3EdrljY+0J4Q24Rnn
         LY/7y9ChFWLW6d6PdeLEwtsGjcQYtlQkh/9w5yje0fBYQiweecLlpQ61ppiU9rbfyTgE
         K6xVzsrmMhgepB9tkX16zGm9zCwcmwv/aJd2Hd/3R0+bTpmfpgb2bg/K/Tj50bs2RrgT
         ih4qpqbxaMHFwQgNKQN7zw5e+XjZCQf5r70obj71zVLbl1Erxgsw4rw07kY6+sGk0lel
         fnPcSr0EzWWAz04MvW6mWU+qLFILX/+Lf5W8cu8Aac4FIm99v+QQmMrzRP8vgit89vkD
         gY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770920421; x=1771525221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E3QEIEUXqaGRqVfLNoA5ttIhLZ1wRahVarTW2/Waqg=;
        b=kkdSIvbe/Mx1QP2zsHoPN+vC4qQEcp8G62yIcbymex3Ae8kDjdq638TC5lkdLf9RiJ
         2Ptn82jd6aY3hDzKLbrI8v5GLAq9SWfu7r/SjFwcYcKrcsdFE/obZ7ELKaE2B+B+EGIn
         exx/wOc8c7vgjAbzhgTID8njPO9bzI51Fp1zNZ4KPjtzYn9dslLxGSKDE8bZdpep5BK0
         btt9NzpwSc3aiwWFdciQWPwMgsgIg9XrCjqmsoZdL5UM1fPzADa7UW7SrDsvBVrdAXoa
         tkayREBdEi90qS2ngEuCLTfyUpk/+xozyLznk9DpfFZyfKKhuvm33ZUgo5kSDdwMITp5
         f9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXk/7gGuaYkpJ7K+txYLXIIYIQ103JhTOGYjAoP/Bcyynmm0C8LMyNpD/iicQGD4ikPYyyj0g1MUzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyferK4nE54vrZKa+DsJ9UEdD7LIC4pKFarWs7EHT/bCniysbL/
	HnlilhnxH4JHHVR8FkN9qVwg1rOUwjOI/DCS0EnmsUP4mMVUbNJQYnUa
X-Gm-Gg: AZuq6aLs4EBvr2NEc1c/HU6vu5Z1wlCcbVvN17hD1XoA+mhqS5BW049poeK/Ql99BvV
	kDFNT66CaD6YztTi7p7Oq2ePLLVFPNUyKbco3dZ8B/u56r3NuPVICVRk8hI5XZ1syGQldsUD0Jw
	4RD0lasHjKObnJGdSXy0Q7pY4crz+Cnt1Hdof/kxqjl8/sTxPUEidfWF/A58EJa+pOI2ZkVwXQ9
	rYxckSHKqnMO4gxAnUvJ0dA1VZXCYFHLWFZgunhhHDzxtryee94hFHjU9UIkald2HXfn8X+ReBu
	YT/EmSsj8v+tfUiO+TsTidkumzQfGSPpuk4j/tUYspQU0o4w4C7YkJMUpyujTz2FaNRbSzmWvUt
	tvEWl70r6uJq2uoyb0MV9ZPh9PrgYV1+RijT7B+u5my05fK2aAS0/IxhTH7vpDbRZvJJQmZSEBF
	rDcCRqGj4TIKLaGn7Mrb3un81INKQFmb0X//Wa7wDDvAZtMYcouU0ystCC/I5pJJRs
X-Received: by 2002:a05:6000:26c2:b0:437:7770:d058 with SMTP id ffacd0b85a97d-4378acd7296mr6978525f8f.63.1770920420975;
        Thu, 12 Feb 2026 10:20:20 -0800 (PST)
Received: from db07.UM6P.local ([196.200.180.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc2b0sm13239933f8f.21.2026.02.12.10.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:20:20 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mentees@lists.linuxfoundation.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v1 0/2] iio: dac: ad5504: fix voltage scaling and add missing bindings
Date: Thu, 12 Feb 2026 19:19:53 +0100
Message-ID: <20260212181955.42724-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the voltage scale calculation for the AD5504 DAC and
updates the devicetree bindings to support the necessary hardware
configuration.

Previously, the driver calculated the scale based on the VCC supply
voltage.

However, as confirmed by the datasheet (Rev. B) and discussion on
the mailing list [1], the AD5504 has an integrated precision reference,
and the output range is determined strictly by the state of the
R_SEL pin (0-30V or 0-60V).

To address this:
1. Patch 1 adds `adi,output-range-volts` (and GPIO equivalents) to the
   bindings to describe the hardware state of the R_SEL pin, along with
   other missing properties (vlogic, clear, ldac).
2. Patch 2 updates the driver to use this property for scale calculation,
   falling back to the 60V range if unspecified, while retaining the VCC
   regulator enable for power.

Link: https://lore.kernel.org/linux-iio/20260210121032.4630-1-0rayn.dev@gmail.com/ [1]

Taha Ed-Dafili (2):
  dt-bindings: iio: dac: ad5504: add output-range and missing gpios
  iio: dac: ad5504: use adi,output-range-volts for scale calculation

 Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml | 20 ++++++++++++++++++++
 drivers/iio/dac/ad5504.c                                  | 15 ++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

Taha Ed-Dafili (2):
  dt-bindings: iio: dac: ad5504: add output-range and missing gpios
  iio: dac: ad5504: use adi,output-range-volts for scale calculation

 .../bindings/iio/dac/adi,ad5504.yaml          | 38 +++++++++++++++++++
 drivers/iio/dac/ad5504.c                      | 26 ++++++++-----
 2 files changed, 54 insertions(+), 10 deletions(-)

-- 
2.47.3

