Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA083B5319
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421010; cv=none; b=AV5g1Rc6XfPjNQUPNk59DtQOz4Q2vlZwGafFe6Yo5gYP7cEKksVgP6Jx5ulNAOrPdRdySeM4kas+aIRZOP+nOaCA+fMpC4qfxWKP3M7FArgbWJmOmJd4LMNefhTGE7As0ez/S8fZCuR0si3qxR0N6CSlZPNlW2Occ9o74RnRhDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421010; c=relaxed/simple;
	bh=x3q2K6rFVuDHnvRRFG1SEzl1f16pub+k3/xWTnkG7uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sL4VHHalyTbUeLYk1qKBF1UDFfUj3HW4mqaypQL7Khtw/Y18BBqjKQjX+lJdAerw1ki+y5jnS4r/p+g3+WN/990B7HMitheFHvtwIAzCUzep6zLiOmBB5YuJN3QJyG9uVHuNWhRQra6pHyRFTAXup6LtDCT3BK9RUWKuuJuE/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rV40YsWi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV40YsWi"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b97f9587e6eso79305066b.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776421007; x=1777025807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlBwsGyamHM/um7fXumZZuvnYtFUYtBDit6QKB0s+qE=;
        b=rV40YsWiK2+PNCboTlM3ZuFIlSe6IsnuwoFxMeMWj7cBM8kf8mnwWazmv0/i3A4PQy
         Sd7Iszu3/H08F6nbyXN5Z7g12JM5r/WI3Qet18yuPnkF1dXoA8bFnXIvDSEB2BX0JuRw
         xzsJ11YVCjhPaA4qyMD82faPzmpgo3z37SKOLmXI8AZZouz0FRBY4E95ztbfkxc3WhB/
         MJJgBeHVXK8jxM5sZOhZI4iUauKLas5WIaGff4SuWcpe+yX3yHaIk5cvgXu89q+LoKim
         AKi1JfCB5EZfGsUEXztZv6GXchcT6iO7D85fZxjYsfG9kKvWMUEgLSol4qDrHQ6Du5sh
         /2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776421007; x=1777025807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlBwsGyamHM/um7fXumZZuvnYtFUYtBDit6QKB0s+qE=;
        b=hKr3JxzuG9nilpYwcvu9Z2sW0kjMh2DBW8UA7eFqWDYcNF4JwpWMwVapS6o+U4bd81
         i3vd26PMYl39tbXwxUjtKuBUADQYQ1aXDSs1pyOUSAX4rqjHJBz4m2vKNHw1JXRa7Z8V
         k/l4UqlfsymncJR/5+rbmHR0PlFiSaiDMCmWaExsc5S62nII8JU+VFwQmMhPUNZ/2tK1
         nuIDzvqfqs5NtJ5IwQDLbvJegMkY7JgejVrd5B2AlIzJo1wteIM0FffciEfboL4p1FoM
         o1jZVQQyjXTlDPE+ov5XN3OrDy1JSmSvatZ5yDCiDiXHtlzWgTBScPHoaGET/M06/5cI
         ygbg==
X-Forwarded-Encrypted: i=1; AFNElJ9PpHRF2vm0vshLu+h0aneujQFzjBDmDGUn4viqCopb+Ry8Cw3bjvSifbd1I3SrOCtNtZ7imH23Rxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTEOhL9AP2WqWr8Zyg6rOXDt27g4FWUR83Lw8m8PuD2xJ2UbT
	XGOAjdrcd7ouj9pxT0Uzj+jtfuTpu4tdQkToYrYrifqnzyuI7kUTgCcD
X-Gm-Gg: AeBDiesKTYP/Q6dww/IRGXG1ReFBIVb/uerKLEmqx7VggFL1Y79rCmT8ToLAbbIjs03
	k9YoHP+MrQ0TjOPePN8WzBbEiO+6h0rHICkuo8TL4jQgdkebz9gLiB/mrsvjRQebRxj1yKikfOg
	tCnaEjO46YAaQqrNtp1MxA7MJi2T82prZRS+L56EyiPQn7yxStuChp+V/kmoK+O2SIhFhRSfl47
	EUhpP2rVwGNuyZ/yfpYr+gAp+mqxM6rFtbwKvOr1FeuRSi0v4sBoRrQTpbW21KeIrSou1knxXRY
	uqGeOC2zbH55LI1W0rAvD1svuwXbHdJzQ69+O8VLCAJv8OcS5st8JLMV5s1XZrwe91pcqmy5bAC
	9CCT9xCZtOBrfZWidviP/UEfsU6dc1jEJ+LyfR9PQFt9mwHY5pmBsji4iLMXaGNr6Vnm9X0W8S3
	eh8XlKlOshMS+4OnQIJBhOiB6qTxHGdP9wFSFAWuwjHCH1Kv8E0fj2vZubvFiIj/4x1+YQTSM3P
	l6ouT8pwDaREDCVfc8HlCq+NmakjBscM8+h8j5eVmHtzidfml3fY7wDnYgLtetDCxDK126smm2r
	OHodphho031bDEiTBj97FNNjHwTOkrl1VPQrrlaB1ApyvSQNjJAHpHHiZ50oqF9vkJdx25/SNM0
	ugIX8NW4g4yyg/lh8RidYWzZxyTq+1XwArk940KcchUzXLNrC1tUNTAxbsukZ8kW/4KAHrY5fTs
	rBd2Ecz0Q=
X-Received: by 2002:a17:907:97ca:b0:b9f:9e7a:bcd2 with SMTP id a640c23a62f3a-ba41a632e8cmr119328966b.38.1776421006917;
        Fri, 17 Apr 2026 03:16:46 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (125.133.90.34.bc.googleusercontent.com. [34.90.133.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455926c61sm38937066b.63.2026.04.17.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:16:46 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v6 0/2] iio: frequency: ad9832: cleanups
Date: Fri, 17 Apr 2026 10:16:21 +0000
Message-ID: <20260417101623.1281-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series cleans up issues in the AD9832 driver, including proxy
header removal and bit math simplification.

v2:
 - PATCH 1: removed redundant bits.h include as it is implied in
   bitops.h
 - PATCH 2: changed ull to u64 type
v3:
 - PATCH 2: remove rogue vim typo
v4:
 - PATCH 1: removed slab.h based on IWYU recommendation, header
   reordering
v5:
 - PATCH 1: commit message stylistic changes
v6:
 - PATCH 1: add additional headers per kernel.h removal, commit message
   edit
 - PATCH 2: commit message edit

Joshua Crofts (2):
  iio: frequency: ad9832: remove kernel.h proxy header
  iio: frequency: ad9832: simplify bitwise math

 drivers/staging/iio/frequency/ad9832.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.47.3

