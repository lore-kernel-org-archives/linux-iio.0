Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D135A952
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162823; cv=none; b=fyzNrv5f17PKV2LapWNT2RbsFUjzfb89hWl7f6Kje99mZTFt3LU5CQqsYpx5rQCMZGP6j/u7Aoq50yzoM8s2tWUideA5Z/3kKA6rC9RNRAyLLB5CRfhtav7Qe74moYO+68SZYymXj2GQK+PNt2AddI+KFTJEbn7/w2r4cTqJCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162823; c=relaxed/simple;
	bh=RXfcLfCug7b6b0hoQjF3QuHYIo/sfJvbc/0TFKA7Dm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYD48Dq/kg0T/VFtO1zrWGSx7ujcia8RHf+4VxZkanpWufQId4SwnEGqtSL6Ul9P/MSlj8VxxYDO5gajRKf6qGQs9R+k+krME2UPuJOdWFrvEOi1pof2sbt6RYHbuDxdB1L10SWkpHbE6wlIZU/SvHT+fd7ODQevQLry7pcgUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=l9tFylNX; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="l9tFylNX"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c15849aa2cso6238042eec.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776162814; x=1776767614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaMfn/m7remtrif+yId9t3hIu92WbVw+I82upsfo5Xg=;
        b=l9tFylNXIjCLZxbWfRMw2vZAivb4/cf6Cwff4YNdVFYEVXIksUERc3Emx1+EwlSnkE
         tdIkwszRyTQFT+Y/MKNOJsmYuVqCAwrZzUY/YeiyQq24rjEKSTVqsosG4HMsmK56x6fq
         BeqrUa8cQDL+bS84o/jDnhChVADYqkpKHZMsfvyvB+jy/7cgjWKVM/pqzFCRlJjOxYfr
         Bm/5lEh+dQQj4nc8B7LYz4lcnuCk2D+D/TIb1y4upbyEKEpRSsJIsanivc4MPFZ+a99C
         Rltc0TabOPDeQ/nS9C4CaiAbWyxPoeeps/APnriGKXe6e1jSFrqSTevX+i0LcU8/4FtD
         pIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162814; x=1776767614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qaMfn/m7remtrif+yId9t3hIu92WbVw+I82upsfo5Xg=;
        b=Pkl/l/wE0+SoWkDXEFd7qu1HPrGwUoAutywZ6D4V/NZsk5oHz6FxY/D/YRPaFfTGZq
         1qkquPlx/RN15B6XUvVOb3nOgS1gm5hdAjJ4NTrWymNu0ck++BHxUDh/zeJ4r+ZjSmqq
         lM8aAImP78aN8wLxGg/+oVxbIVeHRlp6FE39DUTpr5wV12tbsSjOts6KQXawuVkAU8qK
         jbubVy/nlOPR30zWbBwrmMDo0kWlSEMrzapKkqmYrc+54celccyfM9pFtlgPaOPngkIL
         dUTLzadUsgaZ6YfrDEjPUs7Il1jK3elLoaG+rl0Vsf53du3Fl18km8mRs4kGMss8Ilfj
         bJzw==
X-Forwarded-Encrypted: i=1; AFNElJ+DlXuNf1h3yngEeJUdByQYgqBzMfIjpzLQg1QirpfQcOggKlQ/v1hOMxVRuvE/WjNPFKfimqgCoOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0lIMINfuEgvQmS67aDul6SLh8Xqh+rlkZAYwq7cl44jzoXx7P
	NRio1CemylpAfcUhJ/aIXYbz4ausO65BrgLk4fFmPM59Xr4UxjEzh1nepbz6pV5e19I=
X-Gm-Gg: AeBDietWXVHMcsUcMEm3Yb8+d3GXGSH5Aefk+vJ0Hzdzldudso3Jd7BxUorhoU7D3m5
	Ezz8J9H8FXlnYbGwRYRPVBROL8WJ8pD/8cUj7SbtCOMo90UOJvDg25tX+5uzY1wAvRLwN2PQo43
	oWez2MOwiUh/5tSM+J7chijvN6b4WGsvQsqjgQEbWIWjFznQn3r90CYoIPvASaGosYnGUG9dtu1
	E1ZC87yaSMk3jUyXqOIopuQds8yXx+56OH/ZI9vaV1g5183FW0YrSRlcrgZ9Ble3gz+qydB5xfZ
	YV3jxb0zxQx65LiYAHkV7NEcUUgFJbIBC1mlKWMN0dqLlhKW/F6MmSVPjRnozw7yHRuXS2bFF9R
	ettZI6WaephFjfoiKT9ZidyyE+prSABsKVcfZpzsP6vJClXTp+C8gu7THA0O3A3E7sL9KyJmm40
	YEj6iRHV+k+2gvvIbTBLwGo02hMEJ90eiTbVu3XJCOaYTt+tpcCz07QGYNGz/y90sJqHNr0dVjm
	LzH6nwxkfupjZkvecCj8OyQbz8UjTucLoskNRSdfsgKrgNkcw==
X-Received: by 2002:a05:7300:5727:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2d586380990mr9041281eec.5.1776162814479;
        Tue, 14 Apr 2026 03:33:34 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d90ae89e49sm8735499eec.31.2026.04.14.03.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:33:33 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Subject: [PATCH v2 0/3] iio: adc: xilinx-ams: refactor alarm handling to table-driven design
Date: Tue, 14 Apr 2026 07:29:16 -0300
Message-ID: <20260414103316.18455-1-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414093018.7153-1-guilherme.bozi@usp.br>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses significant code duplication in alarm handling
logic across the Xilinx AMS IIO driver.

To address this, the series introduces a centralized table-driven
mapping (alarm_map) that replaces multiple switch statements spread
across the driver.

This improves:
- maintainability (single source of truth for mappings)
- readability (removes repeated switch logic)
- extensibility (new alarms require only table updates)

No functional changes are intended.

Series overview:
- Patch 1: fix out-of-bounds channel lookup 
- Patch 2: convert mutex handling to guard(mutex) 
- Patch 3: introduce table-driven alarm mapping

v1 -> v2:
- Fixed Fixes tag format
- Replaced AMS_ALARM_INVALID with AMS_ALARM_NONE
- Changed alarm_map base_offset type

Guilherme Ivo Bozi (3):
  iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event
    handling
  iio: adc: xilinx-ams: use guard(mutex) for automatic locking
  iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach

 drivers/iio/adc/xilinx-ams.c | 190 +++++++++++++----------------------
 1 file changed, 71 insertions(+), 119 deletions(-)

-- 
2.47.3

