Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288DB3E8C73
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172887; cv=none; b=MFarw9nOdNRMNEsFpfo681DiCIW2O6r0UlexXybg/H5yI1SggrkXfZi5JfqMEkAU6a+tG4qMwuSa7QVqkSxHg0RlwAjJwOOxo6GXpizCuj4MswHNYT9XRVQ6cwZ8vN0BDUu3kd6U5QEiKrVeXcxCLicFHX+hrLhVcCOAjJt7H80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172887; c=relaxed/simple;
	bh=vdc1oRzwcVD4NBxnFGUbR+uqdMDlpG7N+DU74qP3gmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMm6BD6tpUEmE8T/feL4J519GUmjI8O8cRlbBX2PHFvd5nDRT7OINL0rwznQV1SzV9ac7eIx5eNxFHdTDTMfEyFrpqcOx0jVLE/qDLIUrbAPZyLoB1iEJa4fQuLUP5y/Z1ievqpBpLOesqhozOslHzSfWfwtfEjBd3KzNZnaCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3FEG21u; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3FEG21u"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79853c0f5b9so14625727b3.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772172885; x=1772777685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qBmyk3Mq75so5w9Fef059Lp2XnF5B63iji3M7qNerw=;
        b=R3FEG21u/UHAGqEHdDQCfXOhbqe6xBevtLwomgFWttskKzluCosmYPIUJKVxcKWKZA
         OoZ6aPUeJrYJrDH2y5ft/6GcwgJMcIE2fm2dYJqdZ+J7EOXrB9h4gFewk0pYucbLiD95
         nK9mUeUOig2fs17kS9t1zGVhwUIGLuMCvV6GWR/iLSwvbzBFpaYT0YR4ZnvmWG4B9pe4
         UFLvnUrkhBy4YnW2kIx6Dq7sKEhbd/R6IW43kiql5ubGKabMtkaEpoZf4Stc5ko1kh6r
         BvxWyfkbZVhQR2AQu1vXfhKxMiSwYbW8ykxoJu4SuwObr3UUZaw03Dis6ei9qnRAAu07
         yGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172885; x=1772777685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qBmyk3Mq75so5w9Fef059Lp2XnF5B63iji3M7qNerw=;
        b=AlyFO4hnlnUfoE9aDEikVFOQYkrrtPIui99OH2ZiGcxbYNUq9nZBpRQqcAiJDgCSaP
         r9Ef8TK6FYhw9cnENMsMRmvD6/NqY1qv3Bghc1lXy3lcUSdC3kBJ2CfBH7NiehMYIad7
         THgY/seBpI3nb8Owt57MF5/RDTeSqre4k1wyfGMTX3E5E61WPr6ifrFlfDKeaRtRuyTh
         LSgREUQbiiwg5zaje7meBR2eyo8NQkMPDLY+g+PNqWI4/VGeRG1mbimMVkgcRcGcTIdy
         VFHEAxA3CgBhSd4+5ZltU6LiNwQleUWfg/mNrg50V3SNN/iPiKbQGI6W573RhHp2gx4y
         RIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhEIMtFtCaHH8WrOsz2gzMOPO4vobnNNHtvaYCaEVUKJbJPg91LKQl6zSbfH+c0BClVyDKoBhEkBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05HQmkUYdZuJLzYssTBBsthIL+ohPPp7zfJSvG2k/Lf1RivRt
	Uum81wY9Cuk9w3ZmAvtH7Q27icgZO/1JBWdo/sYiUajirNUAvk5FxMhUObw8uf2TC40=
X-Gm-Gg: ATEYQzy7lGXb5AUjozddMAbZP2P48aLWFYM4sg5VHJI9Kc4A9K0Hn0Zm98J/eHG99S/
	wPghDc5Cb9UJv6OKbOMRcIBLej5oJa6KBCj48mQ7/LAB9Hn0hqyL8XOPn8IUptC1ZhfxMRL3MDZ
	WhGmTIb7rXaq4QmwAB+VLrFmUY+pbPMzRBhVDl75F6ibUPXeCoyDLEEwoYjNopmQBv2gYYwELYF
	SQA61GRbutn7xWglg+G0GUpB+r2hQVh5je1g6G/8xK9tBWDpD+lpqGuLK5E2WssYzsOsoW7l1n8
	IRHfNwyPkETFIkZst4hZVIQCU/3p+qcApFqIWGD4rNg0YhCDZoQ5KkhHC37ehihRdxGu3kUpN9t
	T8Yo5utI80LvDpsWv8gK9VhFSxOrByFICtOK5bhT6IE9opwnRuVRPwriB4MWpNBPMNaWm4d281m
	97+mZj6GmGRPcDXSJMxesjBEuSYrPvwe53zsUPsfbfrfpgQslI1twb0gtKBMi6E6QRtDxv9joxc
	lCHtl0lUqWVhZcvoZFZo9+UvpCL5x99F+k=
X-Received: by 2002:a05:690c:906:b0:798:65eb:aff5 with SMTP id 00721157ae682-798854ac23emr17161057b3.8.1772172885125;
        Thu, 26 Feb 2026 22:14:45 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ad0de6sm18149527b3.15.2026.02.26.22.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:14:44 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 0/3] iio: filter: admv8818: Bug fix and other improvements
Date: Fri, 27 Feb 2026 00:14:21 -0600
Message-ID: <20260227061424.1135505-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a missing error code problem with Smatch, transition driver to
use guard(), and resolve all checkpatch warnings.


Ethan Tidmore (3):
  iio: filter: admv8818: Add missing error code
  iio: filter: admv8818: Simplify locking with guard()
  iio: filter: admv8818: Minor cleanups

 drivers/iio/filter/admv8818.c | 69 ++++++++++++-----------------------
 1 file changed, 24 insertions(+), 45 deletions(-)

-- 
2.53.0

