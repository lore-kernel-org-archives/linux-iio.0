Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552898;
	b=D62iKSkoiSVJtx0IFE7rAm/kfkYLlNuY6d7K4qecr06i6jOr8BCUYUrooHv/ulmlHdhC
	 TMreFU2XcHdnyLVWq1Lzxo6eFQHRCAurQZcLO4YlNabHxJhxU47/8y/mGBZLXcN3O7VGh
	 7ZSkC7UBkUevyoGMnS1tC42uOQPaqdCbbNY8Up1nkuBxmUh8CeXKLmgV7cxFPSKPAH50w
	 41oHsHeUbM5jNMBPMopFViCpojxYhLtKKCgolJ9sQPpJIa74IKJootwYlnJd8FY4Hhse4
	 hQ8k07zpCpLn7w0HTsGn7K+QEmmBuN24KbYWPxcdvVYwR8QqR16i1ddDwHeFRD3GuLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3DhUhcSQvV2ZZs3cPK/rSqn6Ww2SQvg5LbDKPoW2lNk=;
	b=18LBYMzxowv1geat6zADj0+B/gaA6FUrNhOGAdlf4Kmxh9dAvXOIk7ZlyIzp65u5OO7h
	 TmyCz3SHdSZGn/y4L2DTbD9XLuqLG0WGoEB5GnZRzU05UYtAXaecERNP3FbFiu2LGU7py
	 ySTqbJdSofdNlosTWy/N/ut7lLeEl5YPYoGrG9GOogVYyrMENFXWc7Q9BYYvc23JxCZ8+
	 ETQtsxS8L9NGJsI9lybsXEZ63lga6L3xxi4icodIC9k6NLBbmVxgTHFadyTE2M8fipk4A
	 +ejRvK3IeqN1IWISg4Ghfh5qkGbmrcdY1/wFxrSTtOly6h6cSyw4YVocXvMDBZX+wvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UV8FkLQf;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDC606A327
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 20:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BEDC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UV8FkLQf
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15ea896ddc8so8369700c88.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552897; x=1796157697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3DhUhcSQvV2ZZs3cPK/rSqn6Ww2SQvg5LbDKPoW2lNk=;
        b=UV8FkLQf3SQDapCvbv2mLKMjtHyRZzZn8pl9FYH0dyojDc4xtJ3fJB2KQCeqYQwHqJ
         X8MKaRXxo8WtCFfSozQ/wvbKZ2apuy8W0hnG5kkt+6/rvhLeZscSo8tXyQpi8OZ882Ob
         1B2qMGTCKW5JfSTqhXObS2fbW7ztgz9ctwZPraainBGFgmcclun3YBGdo7kAPhjYh/Zt
         lP67ONDgPu0jfWIVeOdHutx/D3lcYO5+vfUiP0KPaZnJgNssCoN8dGOg8xqHmDFGTWNs
         8Xy8hb2gLsiBLJi6NSsu9cz4zqeIFv0aa28QhErTmKzL4y1snaq7b6Ku9z52g0tzIeFM
         7Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552897; x=1796157697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3DhUhcSQvV2ZZs3cPK/rSqn6Ww2SQvg5LbDKPoW2lNk=;
        b=HfU4+haA39S7/vv5htgsnVWQ8GhMxWW2iqXz+Zao6zr9H0zfJyO/V4ZHZHdjy5l7gS
         voNKHpAuNq86u29pK/xZRvc2EKmUPmgon69dfXqlNJ+jhYJg3Q9UYC9MJlxgUUacc+l1
         xLVMWKSHwnMGpdrCbeMDHUAJNC4/3b7/Gy/17qfYAsb26ZcbXk7zUzFzoI+wSh342Nls
         V9o23mj+3fgw23WpCcZWHTVR/R8sAHa47Qbc9a0KrWGM6NyajjcIqrGSiYPTruURXq8c
         Hm64OaB4ucMwjf6oYrnTH8VN4HMMJl3ryNWyZ7sdAEyVuMb7sF9KYQYwdMnzhuNWBlNm
         mdhA==
X-Forwarded-Encrypted: i=1; AL+hErGjbvIf7d36qv87/2W8umDTvV+aGowNUAMM7iYcQwAqjDG06YgFaTcXfMlElKP4CJlCblRPeTLauJQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gPc5fFiCs60a3NtYqbBqsYqm9bKXd9TbU3FPLP8f+vicJ6oZ+
	k8Ty+MnOm6DNdjon3hyHnUiOx6rinscCLsFJNabRpIRCo3VObyLkpbQ7
X-Gm-Gg: AZFdTZevDwqsFym099pmUzRqZ1UBE5VQqp5HdsKjGo9fbFd/o6/+QNGe/f32QUrbhT1
	fBjS0Ondl9OYDQRcbln4Nr4wl29t1Rwg8+xxnvpC3uLz+VQiow8YvFvakxckmf+mbeXOSp84EXv
	M6GQAP31L7YHs6Hj5etnwo5Gt9LA+xm+ODUE+lNfXCp4ezxdpFdOCy2o9jcIqHL7XMrpENTyf0C
	5nseyt9R8CuM/zbH3dRrFLAjG93rJIJ87ONQpXode2tEpKnaTCvtF3RLDuxrequLzkwNgvWnB3a
	slgZkXnsjmMDgkFNLjfG3Y9Ow5jYfM/EELpuvoWWXT5brivPNztyC6+uMX4lNBBFtnuk1K1DYYE
	JXwNmDl7mv/L8wQO9ali/Wx7F89YhRsCJ2CZchaA76PRRXA0wccfYTpQbpVCUJ0+TOAHfLtajY8
	uIiBA/K2uVE0PeHiZSb0fu9wkCdifcAYyT6WKekH+HkU9/rSPLHSRWBho0nvAEMhtp5BO918GLR
	F5UPd/yJDcX0Q+OSJHVBNK46LwfOq/nlTcOU0Q8/ibrwTzPZjAF322he07eF4zUQCItwrF2x9CV
	VmcFeOQbq7Qye/sV9vTw+V+dakf9WSU4xUzf1o8T03EvgoPNj7PdAg==
X-Received: by 2002:a05:701a:cc95:20b0:144:fa57:c617 with SMTP id a92af1059eb24-1b5568f1200mr14664558c88.34.1795552897107;
        Tue, 24 Nov 2026 12:41:37 -0800 (PST)
Received: from omarchy ([122.186.156.30])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm54214420c88.14.2026.11.24.12.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:41:36 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: adc: Use guard(mutex) to manage locks
Date: Wed, 25 Nov 2026 02:10:52 +0530
Message-ID: <20261124204054.85634-1-vaibhav.chahar26@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for reviewing my sloppy v2 of this series and giving feedback

Convert the mcp3564 and palmas_gpadc ADC drivers from manual
mutex_lock()/mutex_unlock() pairs to guard(mutex) to simplify error
handling.

Changes in v3:
- mcp3564: Use of guard(mutex) across all paths. (Dropping __func__
  from dev_dbg() calls will follow in a separate patch.)
- palmas_gpadc: Make helper function palmas_gpadc_read_raw_locked() so
  palmas_gpadc_read_done() always runs before unlocking safely.

Changes in v2: 
- Patch 1 (mcp3564): Wrap switch cases containing guard() in braces,
  add blank lines around guard() calls, and clean up the commit message.
- Patch 2 (palmas_gpadc): New patch converting palmas_gpadc calls to 
  guard(mutex).

Vaibhav Chahar (2):
  iio: adc: mcp3564: Use guard() to manage mutex
  iio: adc: palmas_gpadc: Use guard(mutex) to manage locks

 drivers/iio/adc/mcp3564.c      |  97 +++++++++++++++--------------
 drivers/iio/adc/palmas_gpadc.c | 110 +++++++++++++--------------------
 2 files changed, 96 insertions(+), 111 deletions(-)

-- 
2.56.0

