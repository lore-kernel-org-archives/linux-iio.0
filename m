Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DD366073
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878702; cv=none; b=IyLJwI53C0xgDB94HsZXIHTPeY3kwGJfeC26FTuYp2kgu8ULDBaMk7kUkS4J4S/y9px9SkRBLqUIedBHE2+UxNLWrqk7TsOJgIcDnmYGS5G16g5LDVwcQKHTWk4ycEiF8MzW3oFyhkPYepd84prWjv4c9WkAcsXA9Ze+9w0ii4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878702; c=relaxed/simple;
	bh=EDEYITHLk+KBhib0vXKBizDuXqqMsr4ntCcgZd2rk1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+IHOfx7pUzzt619tP/Bc6aLHwEReyguh5BpbphLGV2ndWJ7CnD6f4IBK2Izd7HO8/r0lyNOEUN6DTXdNow/2JNbvByYM/sYuRcWMKqRTyES5R/VI65UKZ4mERwBNNqjh2dptgq+y3E51H1c66LoXpTlmXxcgpie/aBOPo3rbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3WszjzM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3WszjzM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae88e16485so5610605ad.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772878700; x=1773483500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxG+FZn+bR6NrZAQzrMOLNblwabArWh7Lsf3IX2YTv0=;
        b=k3WszjzMaZ1DV9O2lNwdjmgGDBh0VNg23WoUQoiZtGbVH2l+CgRjSmaaVPwHFKeydw
         wt90KDIIAWov5hf2az9h61cL+jFyIp01EpwqDkOTpP2XXkc9R1dczX2+cABQkS7meByW
         ihOiIM7AjxYU5ll6fDER+47YNjNk8bPP2wuoWAwFJ7j/ek0l3B2w84IjtYlCDUaiBH4B
         /Zlgx4JRYCS4IaGuJiymri1WmaDpjr/IhDb+i8q8uSXOdiE6AHRB34frmRH7NSlxXcMd
         4Xa3PbDu9dGTHIkwAl7h0ypF5sFiYtd2YET34yKpvUUYX4qbz5VZ4U6Qnylff7lbaqYx
         E70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772878700; x=1773483500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HxG+FZn+bR6NrZAQzrMOLNblwabArWh7Lsf3IX2YTv0=;
        b=v2+U4w/GJwMXYXgLrSyQER0DM/5u77rKjZqAkHqweUlAQYVODy1t82C+Cy3Ilur8Ba
         +IGztHnM16zc9uodHQkW9Mt2AYbUjmt8BM7QKiWyz/bPx0zG1sykNvkJUvR9sxeJU3KF
         A6TDT4TisutIM314rfddfThUV+i//mCC/5tMy/sCy796R4zRuJGwoFsPWeQoDmkZhct+
         U6REZcJhBYCsBi4hv0fNuseyIiZiFflrjyeE5BiYPonRPRbE7Yo7Dm7DK9WHaP7k1m5c
         EOLWo6FOjxK4H4QI/++Ug6VCxT243iysNxXF1TvJD1XpvWgcR4mYSZelKJrHhXvbeMwS
         UEiA==
X-Gm-Message-State: AOJu0YzhONSD5QI58EKhdgtwoC2Z84rRXBmoJH//meKsgx3uMB0aoe6X
	NnVb7eJXNk6Ot5ftHHqbW/IUS+sGuHVI288Swuz2iWU++MxexPRYCP1m
X-Gm-Gg: ATEYQzzI8dmv97smga8ArkcnoDS84tXjd6JgxZYmW1SX4oAxBUhaM8pNTPfjDiv79ZZ
	8ik/sE4giyyEKS3IIN8Rm8+0z3gaKfNOfkx8lRQWpBKQ1abi9rzLlz4HRjXFXiZ3PfKgEYFINWj
	hdffvkJaDkXgkQ/+Qte3V2WhIzr4hEteme2Oz3T8hugUSYx+mqiEA54Zd6sGPJrSdfzpAc0wHKF
	N9DTgj4oV7mbWeXKkFijeHeorqNFTY2dSF9DFE7UT8U5Gc8rL8BNsDY/SezWs1Muo3GXwbTDQvW
	0HRc6CJOBINCLPMWvLOxq03skjha6M1gSg6QsNToa1RcODNYM/8o2YFRH2Ltcsn0Ye7d1bJI0OP
	cqMV//uKbkuGGEYLQeiAgLvTzSAXCm9U9o3DUCToCCqkff+PKrKe6yDV6bjOq5z5OSzpwMCwM7u
	3UQK+XeE4cdusw9HsP4rFJWUkqXZUOiiNj+Cu7Wz7YpjPa/jJI9qaZBAnPs6foG88T6lZpUtBXG
	mTQiHS0aG4DAe1RNILh0oHh
X-Received: by 2002:a17:902:ce83:b0:2ae:45bd:9b39 with SMTP id d9443c01a7336-2ae82416b18mr51351775ad.12.1772878699749;
        Sat, 07 Mar 2026 02:18:19 -0800 (PST)
Received: from fedora ([103.215.156.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7864dsm48381265ad.49.2026.03.07.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:18:19 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v3 0/3] iio: accel: convert to guard(mutex)
Date: Sat,  7 Mar 2026 15:47:55 +0530
Message-ID: <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts manual mutex_lock/mutex_unlock pairs to
guard(mutex) in three ADXL accelerometer drivers. Each conversion
also simplifies error handling by removing goto labels and
returning directly where possible.

v3: Remove remaining goto labels completely as requested by David Lechner.
    Return directly from functions where ret variable is not needed.
v2: Split into one patch per driver as requested by David Lechner.
    Ensured each conversion also simplifies code flow.

Rajveer Chaudhari (3):
  iio: accel: adxl313: convert to guard(mutex)
  iio: accel: adxl355: convert to guard(mutex)
  iio: accel: adxl372: convert to guard(mutex)

 drivers/iio/accel/adxl313_core.c | 15 ++----
 drivers/iio/accel/adxl355_core.c | 81 ++++++++++++++------------------
 drivers/iio/accel/adxl372.c      | 16 +++----
 3 files changed, 45 insertions(+), 67 deletions(-)

-- 
2.53.0

