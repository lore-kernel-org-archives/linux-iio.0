Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853E40F8E3
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576010; cv=none; b=a73DiIVs21WjC9+4m0i4sZM31grf5BFb0UJWzAQGwkdVYuxgUsrpTGwD39q8sE3Hl/JSaLVPllroMVZbApRloUdTQ2fIdK7LCggH1btAXN2VKxjJTdbhsAnEjpwkIypub8DCvEJAN3DfEVqysULfEjFmBB+28sfJnUkpKRYWHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576010; c=relaxed/simple;
	bh=64QUfkom7uEDtMysnLju2Qx/2dTkYRXbK2UFz41Lis0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o2uFMxY9jBfgutnIawBWxgNuCUyv6bDhRzL+Bzd4KdLFNqXerde+VKYq7lOU+2Q64VMHE5n7saZgIiovU7hqLROKZwiQaLZQI17MWkhCIjKtXzGByzMH0EOxwm+i6oUZIu8iE9WZ/9PcGT5LCsDIr0jLeb7kLwi3qsnYYgLz4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5R4ZBro; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5R4ZBro"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-362ddc1de56so817134a91.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576008; x=1778180808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGccq0i8plqZ3vgrYDR9wktiKmoj73x4kCmEfkgOkik=;
        b=d5R4ZBroV13CXHbdaM/lY6Y62Xwv1knenagfBOw82jj7RgpfIVJbl9qXoj6bY90Ccl
         j5EBD7lbMpi/AT+MmT5i+0zrKatYG1+34DHVJZ6OPIjnuHMou2HwQYWgjJcIT6GkjxSf
         S104fxfK3JBhXIg7ADv7ynKW+mgbSICdHqQCZK7RXBeAyqOx1JOchwpfj+Ferv6Ox3uW
         Q7T3NE+aqMqOb3XPq5yyDMvfSj9rQZLq87U7Bv282LAZSY7R/o0q5jdzkztHu2tyZwcF
         3pqM/V6AfKbWDccr21x7d2N/67mc4RiTn3ADGE7bAht9tSN94RL2H50BZvbWKpyJgGKP
         qyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576008; x=1778180808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGccq0i8plqZ3vgrYDR9wktiKmoj73x4kCmEfkgOkik=;
        b=mcPytywzF+sBVuS9rrgHpJGAtuJSJDVSItIYsPcGKSD1bz1hIi1IuCN2hNk+/O9fAi
         9zAjq/y7NjtZAe0+Qbmh+aZBemooHKWObGC6O3k8zhc1Ln/QqlMi6JSSNViuNs9qmnqy
         yx43Vwy4N4qFAGmJgGLjQhVraK+V6X6/OKYk3RcsIUxhYSTFCdFGdHjdD0tLxMD+zeOO
         XlJbiRiOyVZhEPqj7ECfLS2VS2R/pM6t+oQDH0J4wzTtMGZGBxR9lhe26q7NhH/NAGnl
         +tSM8VT8DpRl2Eh3ce6Zz7jXtLuSo2VZ8uMq6z2SY73+qKikPkDU274xq1wLz67UA7Jl
         rifQ==
X-Forwarded-Encrypted: i=1; AFNElJ/E05M5+zDkmmfvfaul86lwDqA1jHkR5jO784gYfEEbzUGm6whz/oDGRRThp/khoJh1HNxPML1oZ0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqa5ohAgITkF6F/rut2TXZfClKWDZj6fOIJViiudQ3zKHtTJIP
	lC6IGdiNJ1R6avWz88VB5zR7mrtQ57g1/q5VdSGU7HxAKAoX51cCD7nW
X-Gm-Gg: AeBDiety7FLhk/OzSZfvDZEhyv9VTr0oyxK40C8KFg7FPMRtcIXSbAS1hssa+HB4zaq
	XnXyjnNZOAYXxywn1taUY5X2BYbyNpXtUSa/i7Mp8B/AwzcaP+gG1VKdt5Kk9D+5aFyg4G9P6jj
	xwpzZ52YfeCjmg+EieBf5qUmpa9I0l1dKKGDrjdgVjlgUI17aOt+G7XfXv+h13VgeDc2DkPrgGN
	7uqmva9UtoCtit5EJ76W7CPJm0woeIkQCezsPqbIdqHNnF+Y0VET5rRtoWmS5kABzEX+GRcQicT
	tY4/ScB5TJSREVtSzVi5VL8rPpypaF9G+JTEMN8iah0YIti60l/g/Q44MGws1QoTBAZ0TJuOWpR
	VmZ+9oQKuzHElKpDH5CCEqpEMWtSSThXpanTOc3Arava0k3ph/yAYNyv6WpGOCiGXPVR1cnT7dC
	MtkcIpMg/hojsXIlRblWO1PjRpUqpZ7gEI9tudnyrzsSpVOSbEACs7rzSxbfw=
X-Received: by 2002:a17:90b:3f8b:b0:364:7467:53e5 with SMTP id 98e67ed59e1d1-364c2f149a0mr4490831a91.2.1777576008104;
        Thu, 30 Apr 2026 12:06:48 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16067sm3332185ad.40.2026.04.30.12.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:06:47 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	lars@metafoo.de,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] MAINTAINERS: update iio adi entry and drop redundant entry
Date: Fri,  1 May 2026 00:36:37 +0530
Message-Id: <20260430190642.3434650-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi all,

Following suggestion from Jonathan and ack from Nuno, prepare change
to add linux@analog.com list to has always valid coverage for INC IIO
drivers and drop redundant entry and make sure same has been catch by
the wildcard paths under ANALOG DEVICES INC IIO DRIVERS.

Around 40 entries are redundant which is covered by wildcard, to easy
the review process split entry in multiple
MAINTAINERS: iio: adi: consolidate entries changes;
based on mutual understanding we can fix/squash entries.

Changes in v4:
- Use ANALOG DEVICES INC IIO entry to catch all entry of drivers where
  there is no explicit maintainer then drop that redundant entry
- Prepare series of change(s) as suggseted by Jonathan
- v3 link -> https://lore.kernel.org/all/20260421165856.2245598-1-sanjayembedded@gmail.com/
Changes in v3:
- Following input from Nuno and confirmation from Jonathan,
  replacing domain specific maintainer with mailing list.
- v1 link -> https://lore.kernel.org/all/20260418211336.1800221-1-sanjayembedded@gmail.com/

Thanks,
Sanjay Chitroda

Sanjay Chitroda (5):
  MAINTAINERS: Update Analog Devices IIO drivers entry
  MAINTAINERS: iio: adi: consolidate entries
  MAINTAINERS: iio: adi: consolidate entries
  MAINTAINERS: iio: adi: consolidate entries
  MAINTAINERS: iio: adi: consolidate entries

 MAINTAINERS | 386 +---------------------------------------------------
 1 file changed, 4 insertions(+), 382 deletions(-)


base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
-- 
2.34.1

