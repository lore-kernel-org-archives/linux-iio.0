Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A8379C57
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262464; cv=none; b=tg1fe8JLECOXaoCpCX4yFxMIrZAGbZ1kn4cipR0mPJtP2JytXNbbJjZbQT3PBFNMNQ4sCEvKUFhNOqm87A2ZCx59xdYZJ1kTlSrwFdvfuMYFSuJHGRtS3qgZCTNk1ADlUnWjam6kKaJvDz+G7tUoFP+3RpktvUN+00OuI5GlbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262464; c=relaxed/simple;
	bh=qVycqab8o99a4AOAEjqzdnDrRkhD68okwCNeq/5OvEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pz+6aPKt4d50JvU/iAlUUY1oTScm3h8wS3UnUu7Glb3r1LQxv+VloxL4xiqzICDVca6tLcROP0uFgOEAMcY+6IeiGDxI9MfWy0UONzSTcl1n+gjQEv40YbF02jR6uK5eqw1BrydGXWDLZ8fVs9if+wfDVGAky4KIpXLoYhY7wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce4UpE+a; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce4UpE+a"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35127e848feso192898eec.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 21:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791262462; x=1791867262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMPAnis30QiFUw04IvU/bFrNZBajtnwIlCR6CxFY28Y=;
        b=Ce4UpE+aEFz7l3oF31blwuKo+me40AV8/Ntxw3WRZGwJsxLTCGcqeIKKxY7I/at3DN
         nCisFlLqy+lwwd94HMWpgywzgtuJBgWyHVEqGoOmY8ix3x9S6Rn7GBsWOoq1OIQOfXiR
         ipah4W6VSyMa9FRyWMoFWYHf7qYotg8oFJ8dDKuRYMCxPM0QFBlTNnbvzGf4ENQ00h8j
         pietv5QJAYeaA25V5WIuHJUcMvXrRyu+Qkh92X6vpGFRM2HB/qWxhodjn9Na7I+xsS7j
         kn675ptmC+d4piphCbHyXvS+vDvrCuk5bf0r2sHS08lUr9bfcXd+nyR7BBNfqZV4EsSo
         Z/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262462; x=1791867262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMPAnis30QiFUw04IvU/bFrNZBajtnwIlCR6CxFY28Y=;
        b=tAfyzS+mNMykfU+a6zWMCTfpAlvFtAo/fX0NPSwSRK+GMLwA9qONnphseGiPp1a0tf
         GzcgUrKlAdLutR1ZWS/rDpZWACEUfI1qsdH4qfhSNTOceOvwHi4uUJ0EraY5+2NF0DR/
         D2L7AljYl2qni/+THSupR5CSNKnK/SsuLGFvtm0vLRbWm70CvQU3flM0PE9L/q//bz/s
         MEhCFwhOy5JE0qBmWntCw/3GvMZWT6I+jq/Ze5Wev79z2C2ck/eUeUrRPDFeV88kgI1X
         99tG6kVJ+OZBz8bHxW3ARUI8oJpA5bQAj9rDYtt1NltbfWoB0eoziBo8izL1MHQTL90e
         h8RA==
X-Forwarded-Encrypted: i=1; AKwUvByB+ORK4Mq9ORK2glPmig8HBobdZ1Gh0FTc9oTltHyCMVWUYh1LFhexXJ2tOTDjSjXQsB4SsxfnFX4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwYX4t02q2XdTL9Mxyb9z8rqE5MaE/tCAgVhafQXiEP+UALI3J
	87md7bB4I5RurdteTcP1S/HuCh/SsQ+m5SsvVYTSAG/w+viF3TNhslKm
X-Gm-Gg: AYBFou0w4mE/nje1eIv/6svowHH3ahmJ0dYe0SAjh9InjqZ95yIxgoHAlDnGB+ASedX
	nxCcrdAt2TulMC7Avdk6jq4B6PjvrVZS4KpBvTM+ZBlbxE0LevwsicdqtDM7+YaxczcYXOEVhko
	HbWGUhKC7PzdV6LGzKuhxbjSatiStlmCCcoNbbmOIUXS0WEEPZIFsHdVrO9rWrn/0vhMzMcUq1/
	eUCg1KFr7HqKN6iIrGqje+FGJiDu01zTDFcpJFhInkKoYtbmZfQpmVYQJnsG/TamJtIgO1ok1Gf
	/MskKRUAhRa8BEUCUY5Sf2EYtE+lY1krA8/FJwiy4vrp8kjpKgCARzUGf5x1vy5m4VTAWjk2Jnz
	GYNbXSSuMZJLQAYfNhSnBphcqtVj4YnIcUiYmq6yDEc5XELcDGkhcLMBkrNew3uEXvWuLhJfhGJ
	bNGNJ2RTWNDue4OORMbNwfR8c1W0gd3YfgOt65uzaxh8JGiSXQpi2Nnx6AK3fGI4x3jvQd7Y2S9
	4i/OJgcwnch20EiyD2NiMmMIzaEZPtwg/dso/JG9KU1GgUkYJIgiUj27R4RLjB8FQ4m2iWx/95/
	AFyHNWUZm7XeYR6Ep0mrdg4vPbvx
X-Received: by 2002:a05:693c:880e:10b0:34e:7f9a:c722 with SMTP id 5a478bee46e88-3514e2e649cmr183008eec.34.1791262461760;
        Mon, 05 Oct 2026 21:54:21 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146b3b5aesm5539737eec.29.2026.10.05.21.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 21:54:21 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 0/2] iio: imu: inv_icm42600: fix kernel-doc warnings
Date: Tue,  6 Oct 2026 10:24:02 +0530
Message-ID: <20261006045413.14320-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the kernel-doc warnings in the inv_icm42600 driver. With this series,
scripts/kernel-doc -Wall reports no warnings for
drivers/iio/imu/inv_icm42600/. Comment-only changes.

Changes in v2:
- Add patch 2 for the remaining kernel-doc -Wall warnings in the
  driver (Andy)
- Collect Andy's Reviewed-by on patch 1
- Use the Assisted-by format from coding-assistants.rst (Andy)

v1: https://lore.kernel.org/all/20261003055339.143977-1-kapoorarnav43@gmail.com/

Arnav Kapoor (2):
  iio: imu: inv_icm42600: drop stale vdd_supply kernel-doc
  iio: imu: inv_icm42600: fix kernel-doc Return: sections

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        | 1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 4 ++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.53.0

