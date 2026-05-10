Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578C2F8E8E
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778399231; cv=none; b=rdrr3pKzR54M5ItO8epgE3e+nD/G2PNDelelWUqE2lIxz+uCuEm6DOWbsSwQStBXb/wM8mIAu4ykliA6cgjC6zSBA1qk7WFVmOSRsa41k/CeVgRpAt7hYad4hw+Rpd35yadde2vir+Z38bvvQpAKZPA/WeXjc966P412QZGUHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778399231; c=relaxed/simple;
	bh=o93q5z/oklQESNTkD/mXMflAorn01/PTg9PdtNT8Jno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzD+ggoqhkOkHGvdVXuZDC8RcGZI9HZQcJWzlPYzQBG9xnIiWr8Zf7kPfkaXnbyDF5R5ZyDweH6Cghg224aWZYegAjNHFsW0JlvVkcxueRQArfehjlUsunGDRk+/kbHf88oQ9dcc67vN7A2IdyYBlJIQMt5qGr+7zFCnExVrY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgt4L0Mf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgt4L0Mf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ac04e13dso3151335e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 00:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778399228; x=1779004028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o93q5z/oklQESNTkD/mXMflAorn01/PTg9PdtNT8Jno=;
        b=mgt4L0MfHCluuvNkqJ65/+59128OXBxcz8PzQDkTa3tEbrvVqla8zxhoBERgqAsiLr
         ZLy69nAta8psrdihccaWXF/zf+v9thR8qwN8hKQYuJYjhNsWBXk+8FHDPRhnYV9128Pw
         3e0knQBIaQywfCXdlArLW9U58SQZJJADUby7cOp4tAKVWN5N4Tz3WiWprAVRIDig3gZr
         83mPc785k0s5Z77N5qYrXmxg0FmbTv/0L7egXKw3vISqbP3MrRfNulnhZVYefCVXuLLE
         ZcYDJUAKbLcXIbT4IuDvbmmEmMYlkcCL+SUfIdg/q8Ytfgv/u/HitXCuh4kJuKEaRqNM
         hx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778399228; x=1779004028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o93q5z/oklQESNTkD/mXMflAorn01/PTg9PdtNT8Jno=;
        b=dCvVnMwTZigpl/CqxHIJlPjQ3WZmr0a8pKANo2P5o1kWVhd/cJAAwEqr73UXTNqSlU
         HuG2n1tzWdCBL7RremHkut1XNtPxiUv3osqKRNgNtHtspE2iIiCqd+ay0x5Izs50wQ8c
         TxTIkbs964RO434CTg2PxbB9+qtUXbKs2uSdQdP4N5aFkGBAYy1PDOImknisBmm1fqFL
         Xsv5cCU3WMTOeNX44/hvK0wx2ZLcPK3xyF4b4n5Ul4jEBm2TR/ciKVyQF2hoeQwvx9A0
         3bzHWl6yCmOsuVP+BXJbpN17n5UFgCM/uTA1c2EOcuq3gFXhPulMX6xJbE5wy1AaWc/+
         A+rg==
X-Forwarded-Encrypted: i=1; AFNElJ+4+eDLbTWmjPvFIFd5wUAk9YM3GSkuWjHsM6DXqFm9jL/5OA/LWgtuVoL9BrLpIrlVxJFbz5TpNp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/lnbBA81FipPRVeJQWvVGBEVJQAM1Zx1C/jC1JwOiUb4TvIZ7
	XJq+NpFuYAp4pUEH3f8Kp92XdBFRHg4WEnwg7OFD7dKhm9MkSajU4uTR
X-Gm-Gg: Acq92OF2/gZYBBVXt9TNGrn4aCsVuAuglBV6sysBALeSZPVaoZiOZrf4XdT3w7M+Tsd
	mcyp10Lz2pWkI4ckV2bFfN6em+MfygdExbFZy9HDLwObroRY5gH1CoX9dWDa8qxoQyPi8q6UX9Z
	K9sqYO1/iaTZkl7pmWbr9ObCMcPH8zIy9Lq4P7RIx6nFVIzq9ARzVRIbCxZt/3cPoUSS8S5Tkbe
	LGVFMmJ8ZGGDrR+BuiswRr4d00fgjTUNitM8YrnfLQezgUDLehy1rdfFS1FLXeG5LdJqix/HYA2
	lPfd924R06zPbkMwmjB6IQ+aIUUye5JaTf87dq4JY8Ru6mPLPTE5IjzWrbQrZh0hM1H2SC4Y0NE
	iWHZ2e2yEaLU3g9bGCaIP6F0dnZ6ZUfKBUMtNYMGT7dt2DiOUnK4nNlypMQ+RiJSVPNsCutkuNl
	TokGhBv6N+8EPtFYpJ7JsaHhvnZuBYqWTnuZkI0Q5Ugb3UTHLEXlkSug==
X-Received: by 2002:a05:600c:4745:b0:489:1c1f:35e5 with SMTP id 5b1f17b1804b1-48e530c97f4mr136648275e9.6.1778399227821;
        Sun, 10 May 2026 00:47:07 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm16981737f8f.18.2026.05.10.00.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 00:47:07 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andy@kernel.org
Cc: giorgitchankvetadze1997@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	m32285159@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH 3/3] iio: chemical: scd30: make command lookup table const
Date: Sun, 10 May 2026 05:31:36 +0500
Message-Id: <20260510003136.35026-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260509111634.21700-1-sozdayvek@gmail.com>
References: <20260509111634.21700-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 10 May 2026, Andy Shevchenko wrote:
> > scd30_i2c_cmd_lookup_tbl[] holds the fixed CMD_* opcodes and is only
> > ever read in scd30_i2c_command() (via put_unaligned_be16 of the looked
> > up entry). Marking it const matches how it is used and lets the table
> > land in .rodata.
>
> I believe the above is the suggestion on the correction of the commit message?
> Please, make it clear!

Sorry for the ambiguity -- that paragraph was just my own reasoning
for the Reviewed-by tag (i.e. what I checked and why I think the
change is correct), not a proposed rewording of the commit message.
Giorgi's commit message already reads fine; no changes requested
from me.

Stepan
