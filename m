Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA336F90E
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066335; cv=none; b=OSTw7jLwbBsGx5g67q/ciqJI+BphcC+6kPpNQ+7J0zgzTmFMcDcCaK7IUK1FYAoaTPKnOlZJ6etzlddiLTvbpz9UK5M6OlxLrmhhRrHbyFRkK3FEdbMm1+SA/9irzkn5HZrHGt4XZSNsm1nkeynxn2mPHDwW2ylvv1Kc5tr0rDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066335; c=relaxed/simple;
	bh=o8Ej2moWtxJ/U8fJVoCsPDsrcgZIFSbjo/BMmcEUEts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9o08TiHfDq9zWxw+Xt2lTHdjKMSjXxHKyPPOHnwfEen255uqvzsb7x6/bVZjivUOgjLzdAOpClwohhjWlzVnrFjN5qefYDvJL9sahy++eb8iIWLYv3n7eDo4K/L9JdnOMJzrse5VM2PS171FXueu7egkIwE5EuGXVhmMrX8Jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVYOWmlW; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVYOWmlW"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-137335bc3caso8007360c88.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 21:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781066334; x=1781671134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vythKnw9qWdaQEpb+F5HQ/TToiAE9RP8yXVf7yWFllA=;
        b=GVYOWmlW+faCzOYHJXeHOE12r87Z7z/lQP62UUyxnoCLCeS0seq8GPP1XYwAILPVVf
         +4nbOvSpTLnLN1H9ObVrW/RsoLWHyeDQqzn1xrcRb96zIEq2UErcpk0axSEFriRpgFmL
         CBUZsI1Dtvbbq3lRewl8LmoS+wEk3sUrRj2JrFYV4SsVwTO2jJxIJZffLhG0O4RDDSd8
         66GcGP5Dp7PKA30UI97/4NOxkSLLorhPiDbzMAHa9CNbGJQsEKHlS+71Ug2/sgtlpc3H
         lVytkOqa7H1Drbac/+AsxaCI6Bu6W/lGdoO+iS1zKRkfYNAilVoHmW/XELtPQn6EhcZz
         7q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066334; x=1781671134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vythKnw9qWdaQEpb+F5HQ/TToiAE9RP8yXVf7yWFllA=;
        b=I+g6cPAsIGS3QTuUWAaOIO7Ovgx81i4SQ8YZPIJcJ/IHKNrDuE8W29FJy8NfMMrk32
         pdwoewGuuwi1/a3JzZgxfmDmJ8s9a2EUMCM2v6z1h3uVezMca8ZzOASYhXSJy3lKyNdn
         STD3MT5UVbm3PN6X5iVPmvqnsz1e3zVejLV+EGcjyrxHA0OKya2G7gF2ltC8S6O6vLum
         dsWMgPxlwKN9OwTEfn1WvmwkpOkzcM89G0CZFW+0vB2NOpKC+lzK19zDarKx4upougcX
         35LIAoYguuGb70YQ/qzr48pb4XfnkOwKOV6abTo+ogRfP0povBCsP0gjtK9N0RCJW3aC
         DuXw==
X-Forwarded-Encrypted: i=1; AFNElJ8gwsD1n096xjDiZ++NBQI2A/CHRGlo1ggmZa7Jl5tX69/uiwjn+3+ppU36Bo2aC5JOciKjHcAuQNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZFKDcD0veD1DVcwCVLm0/lgknUgmzOm1HRKbMqI1pVTKZLAV
	G4M7HGs+fHiykB2KDMMxLtQR1SgBcTYc8+DOgAF4MjZixW0hRdchWClU
X-Gm-Gg: Acq92OHadR4ZuMSP0SkulQSrzL6qPWOFlw0bIQKC5nDFHDS1YHzuItV0gfBJBwT0HLk
	sMAw2793W0dOt3vmNYNFXNTfn/HJi7eWQNLqRAiwodYddQpi9dae/1Uox/38dZZ4GBAPhcvvoSB
	rSygJ3Opu9zwIdVjp+ELK5TpZDdoWA8IwMn2e57IPWHeUb7YBYHEKCBSajIPgBft1hZqRz9HK65
	22xM5WvxloFTFMDYO/Ldi+6qyjOEcfM6ZnyusaJcc1cAuakkxc1VEDV1BisXUxy2F+uhpCjoHiL
	8UfQ0Gs2GvVWpfi4Q77vnt1HcrSIE9sQNDOHisyhAOI5t5gdZdRvq6tpPBAf1zzJNgE43RFN2YG
	laOQoc6hDNTBWVP0QDmd3p3UA1yKdR7fVXaKOFoX6RtR0uNpssrWYe377KKhThnm0tE2hAPopwc
	nwZpw49modOj0nTF/uMl9abTF6X9zgyCiCA0MBCsamsiYZcmM9RYU6vLz+tsKu9ZX5Ig==
X-Received: by 2002:a05:7301:9f0f:b0:303:f295:4db2 with SMTP id 5a478bee46e88-3077ae8e8femr15369710eec.0.1781066333761;
        Tue, 09 Jun 2026 21:38:53 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8708sm25693676eec.15.2026.06.09.21.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:38:53 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v5 0/2] iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
Date: Wed, 10 Jun 2026 04:38:36 +0000
Message-Id: <20260610043838.90708-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
 - Remove the extra blank line in bmc150_magn_get_odr()
   that was inadvertently retained in v4

v4:
 - Split include sorting into a separate prerequisite patch

v3:
 - Add missing include <linux/bitfield.h>

v2:
 - Use FIELD_PREP() and FIELD_GET() helpers as suggested by
   Jonathan Cameron
 - Simplify bmc150_magn_set_odr() by returning directly from
   the matching table entry

Hungyu Lin (2):
  iio: magnetometer: bmc150: sort includes
  iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers

 drivers/iio/magnetometer/bmc150_magn.c | 49 ++++++++++++--------------
 1 file changed, 23 insertions(+), 26 deletions(-)

-- 
2.34.1

