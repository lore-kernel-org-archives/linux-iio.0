Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660E3C4574
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128853; cv=none; b=AdNr4egZpUvfYbh9srKXShqL3ACvafD+RGDnw1ipZbC9W26MahjRlGd+eDUy1TVWmWrOV7IyrzArDlxAg3GBNnq6EGyn4pcSezyxQlDWZ0GY1ADhuWidrsSGzRta6XcElnDEw1sDwRLRhuJR7CHlr/Zd4YEBBMRp9u/55BGbPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128853; c=relaxed/simple;
	bh=GMowu2iynCcNzROcJEdJQ5/+u+MAHjsvsBWL0ZZIAjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eElH8Gj/+k1NU2TgUkQaMNpaEYKDydjMGLcazlNuh4BxRkLqH45Ad/opA7xj6kySbaZkPFgutWuvJU5iFn5f62H2ybisiqZlphS3AzwOMzvS/bMlw1/ASkX9cTq9KJiQ8hw+na0aKk+p75SbD2+ZR30M/qmYjpPxe+zcVBnsTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oagAlJOM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oagAlJOM"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f6609c657so321215f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128851; x=1787733651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yB6JEi4fc2rxeFHvTUIWmqP9ewveXbrmeQ7lWaASPb0=;
        b=oagAlJOM2trt43X6V7NPpTyjnsgSAb04QXsxgMEcNUjmxl+0GdNO+WHxf/DKUw2Ga+
         INVlv9GYs//1C6Dg0c9V7PlznPTRhx0c4jqKYNZ7h3YUs4rsyf9GNPz3eIfAGDJqJKkP
         UOxpy+BAAsmMSo/vB6ZcOHTMXBjZeNaj5r6hu2BW9e/8/z5B1+s3g0Ox7wC3NP/0neYR
         9lKjVYkUraFA7TLgUh6hWJdh7NLnZvEJEj0s1/pJglKCgpqpnySnNyZAqUiuDk4Zber5
         igm/frWLHG475Wp9+E35DcuhTrw/J/DmRlu1KiKhFwgyRplyszq3KjXL+87O1IOi3DZX
         FnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128851; x=1787733651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yB6JEi4fc2rxeFHvTUIWmqP9ewveXbrmeQ7lWaASPb0=;
        b=mJeW9r0PpvwH7xD3eJ/2OlVC/Aq5B7wefOY8H8cRMTpLKQuvTeGifmA71CkIaWPG+u
         nFUQGR7bwE2BwnyULDJ1NGobf4IaZBG8c28nyvdDYH1K8TEkcg8ZnBhsR/FOexpF8tZK
         6j04wnYVsVa7nA8kFcRsDT7BrMLA02inrfF7xS+Mglxlq8eF88ICT3XqIF9US7YeOlFJ
         RHbfMRJueO961I6CmPydr+o1q1KflgJ8G/qcUEgJlSJMerFcaZv9DgwwaoPI9EVGwgGA
         DPq1x1OoRUDt9im+mAf7gDfBJY39TgmsOLGSUePlDQf6XIefqrnh9f2u6uyD9UrCPDio
         BZEA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/XbkyVKp5i1TOoJsou7tNQXo0t0450ASPAOy8ZTTnVQnAgFACfGm/DuGJ+iFI8MhCEamHRrGjrcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7x6s+lm8KbwaGcYwmu7xHiJ5mpdgULxBjIBndQk753HdN7fq
	gSCVEEdtYgIbG08/Y5Ole5Pea9/RZ3+C1WrLIO3ag+ToHZeENDWYFZb3
X-Gm-Gg: AR+sD12UR2TM6JmiZvC3sTRw9LHnCbXSvnxvynhF4kIY5MeL3jVxVsqxdY5qkG2GGEP
	hTqFE7FnlLfO10EI/YmVRCUEoqdPkFJf+5kJbN6gZu5qDVDEmEiho05MHYR7Qg/SZMxVlYcBGaX
	Ue9M3QF0m+8DfDN7WjMo+z9YR2nWcMFNzy2EEinO1PGgl7toBYJnPZN3GBi29G+GCZ/2aEMpZeq
	WQkxjgXapZxr4UntzgYda2glyWRpbU8h9hPobdLQZ1aBrVgig7OEezqrVKfthKgAzOK8jRT/Trl
	+kb5VOxl6iqV0imSsooy0r6U7KMCU2e8NrHCPK6BucjBUN3mKaUK5wbanzBn5mRZRMRNDIaHoiC
	zyiw4lGjek0XON5+PWYlMoqS4ALLWv+IeL9c5UtCfVzVsiAupImEo2xbtJmf81NmBfhmqrnISJ4
	lqtoWOPTuPpPaanEIWkVdRUhVh/Y+j3T4jD2dKMKCbcUmZVyWXQD1lihpiGwDha+5EjJGBZcY5R
	83h0m+KR6vtOMjr61946vXq0Q==
X-Received: by 2002:a5d:59a7:0:b0:481:44e5:160c with SMTP id ffacd0b85a97d-482b1e8632emr5012255f8f.2.1787128849753;
        Wed, 19 Aug 2026 01:40:49 -0700 (PDT)
Received: from fedora.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c45d1sm3637685f8f.30.2026.08.19.01.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:40:49 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: andriy.shevchenko@intel.com
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
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 5/6] iio: dac: ad5504: strictly separate ACPI and DT probe paths
Date: Wed, 19 Aug 2026 04:40:45 -0400
Message-ID: <20260819084045.16300-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoP7Hr3ahJK87tyP@ashevche-desk.local>
References: <aoP7Hr3ahJK87tyP@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> #define AD5504_VA_ACPI_DEFAULT_mV	(60 * MILLI)
> What does VA stand for?

VA stands for Analog supply Voltage as far as I know, following Analog
Devices datasheet convention. Will rename to AD5504_VREF_ACPI_DEFAULT_mV
to make it self-explanatory in v5.

> It's better to use has_acpi_companion() or is_acpi_device_node().
> I prefer to see the latter as that one unifies the style of checking
> across the drivers and subsystems.

Will switch to is_acpi_device_node(dev_fwnode(dev)) in v5 and add
<linux/acpi.h> accordingly.

> This should be (MICRO / MILLI) instead of MILLI.

Will fix in v5.

Best Regards,
Taha Ed-Dafili
