Received: from outbound11.mail.transip.nl (outbound11.mail.transip.nl [136.144.136.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93D3CA4AB;
	Thu,  4 Jun 2026 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552054; cv=none; b=Ko7a3hU1LGR6Un38OdPr0Dbi1gRpNISbwfP55gadwXxU61skzzkQVZzSMY7JPM7eelAD4yRu0MPRlIlqbhtj9QtYMVSoH2i+ydH2RlVbdsywq5hbK7ySfQAd3I3VLwM9Af/jTfscyqYn/IKgDpqPvkH0nzWwJ5Z9nSYxczoSsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552054; c=relaxed/simple;
	bh=C5ni448VtuIkwwEICqDfUjBPJbXAQkiSFr164C1XyCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfFgcEMGzg0LgaKGXedlrdxCqzJ/+0pFQzUHLSpL5mubS85Hogp2guEFHviUCvmEgp4A4ybvAEzp2GhWjA29B61st+H054J7xsMJgfoDvXei1f/Zei3vM+enuV5PvxMgPHg39+wQDXr29nFI/OydW+KTs1E11273ChlakYWQvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=DjYMI6v0; arc=none smtp.client-ip=136.144.136.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="DjYMI6v0"
Received: from submission1.mail.transip.nl (unknown [10.100.4.70])
	by outbound11.mail.transip.nl (Postfix) with ESMTP id 4gWD9S1HXFzkQQPS;
	Thu,  4 Jun 2026 07:47:24 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission1.mail.transip.nl (Postfix) with ESMTPA id 4gWD9R3TKhzJjhYK;
	Thu,  4 Jun 2026 07:47:23 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	masneyb@onstation.org
Subject: [PATCH 0/1] iio: light: isl29018: cover-glass gain compensation via DT
Date: Thu,  4 Jun 2026 07:47:22 +0200
Message-ID: <20260604054723.2983181-1-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission1.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780552043; h=from:subject:to:cc:date:
 mime-version; bh=uvlpXs05Cgpzb1r5FZDWmc1DpFg8q51UDHKXG3t6x9o=;
 b=DjYMI6v0KZJUIPxVB9IU70E+BFeKijq357a0mfHqPYXrCB59KJCOZdl76tHHBAcQY3NBFn
 lawJvpCxaKZgX90p/BV9eHQsf80apFpdBBOo0QIPKoJ9XBr+yfL5XtTT3kg8D/rJoViP3r
 w4y63vJZhRHcrJAppyzWq+RfvMBqkhCzSqAmS9B7bGx28gJ6HAVPez8e5xS8QWwymjwZb5
 9uKynj9Vq9MA7R/2Uv6KEiktdMSk3GrOCrfh9mURdQphS/hSdWnlZ0Y84gTTns5lLAebTP
 5d8fJKvMMJvpTE7KMazZE5edVrmXoBpcQ1N0BS1DgxkVLdGqIGHA+5Sfiohhrw==
X-Report-Abuse-To: abuse@transip.nl

The ISL29018/ISL29023 is commonly mounted behind a tinted or coated
cover glass on consumer devices (HP TouchPad being one example). In
that configuration the visible-light photodiode reads roughly 1/100th
of actual ambient lux, causing downstream consumers (brightness daemons,
display managers) to permanently classify the environment as near-dark
and pin the backlight at a fraction of its range.

The driver already exposes in_illuminance0_calibscale for runtime
compensation, but that requires udev rules or userspace re-application
after every reboot.  The optical loss is a board-level hardware constant
and belongs in firmware.

This series adds an "isil,cover-comp-gain" DT property that seeds
calibscale at probe time, following the precedent established by
tsl2563.c (amstaos,cover-comp-gain) for the same class of problem.
The default stays 1 so existing systems are unaffected, and userspace
can still override the value through sysfs afterwards.

A follow-up DTS patch enabling this for the HP TouchPad will be sent
separately to the ARM/DTS tree once this driver change is upstream.

Herman van Hazendonk (1):
  iio: light: isl29018: support cover-glass gain compensation via DT

 .../devicetree/bindings/iio/light/isl29018.yaml     | 13 +++++++++++++
 drivers/iio/light/isl29018.c                        |  9 +++++++++
 2 files changed, 22 insertions(+)

-- 
2.43.0

