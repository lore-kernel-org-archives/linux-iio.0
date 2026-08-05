Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1630D411
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897869; cv=none; b=pNx/E2QBCo0dbhr1tMaUrYILIitwuUivQbmu6yBZBnSflFUjzDOZHcF9HqEnjsAzFMJZi6YhRda6skEtWo2AfMYBBjvCQZKgUCKpasx9DMSCJtmBq97+aXb4sWFLYd/uO5bk8ZOA9m9NAd2tyMnBc24THsL2Ssf14Mcu73eECxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897869; c=relaxed/simple;
	bh=iLZyhcCcTEYXRlfDgj3/k9vv2VDKmACXB22WpK/1RWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTJ3K4OaPCtlXFXeH/cZFwk7ub81AKWPdu/joTOv5Iee12mhhOUzuqzJb4U97I2q8nGjnJxOwSfR11PRfz/Vx2hN3xPoJXQW9J/C5NIyn8fkiuxsJJkN7LEejaKMoUjRUS4wzvYxL1R6e6zFZKcol6dImaG11HeUmjZ2TV1mfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJmZVWVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJmZVWVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998AE1F000E9;
	Wed,  5 Aug 2026 02:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785897867;
	bh=qLyfd3RlW7a0hC3oIqffHxN+zmq/I7ZyhROv6M9q8rc=;
	h=From:To:Cc:Subject:Date;
	b=KJmZVWVdocbcVQoWQWBGzPaCscgdAPxTQrVVE0PJ9w0Lv5MvdTKDY8VoVP8HL7zhA
	 Kj5o3LPYaIf05W3MNHIjKhhIeKO3liwi5KmX2GGXTcAZrN6YKaLbdm71wWtHk0SEMl
	 DpZB0VhtxhNhI76o2KCv7Bihkn6OiHyECQtuKxuuMR6Q8hiI52a6P7tuGsDCJeq/iN
	 8jgUX2xwl6sSaYVU9v565rBlCKvo8ZgmRAYDqB+J/TVXdZskBiG/vYGImB/9fOWPMG
	 bIitjJVU5HLFSCoUryUaUbnskasNzsvftJtfs7v56pnrwtu2ow3H/qzkZ+o/yMfCiS
	 vnait7iUDgn1A==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>
Subject: [GIT PULL] Counter updates for 7.3
Date: Wed,  5 Aug 2026 11:44:18 +0900
Message-ID: <20260805024420.1501279-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=wbg@kernel.org; h=from:subject; bh=iLZyhcCcTEYXRlfDgj3/k9vv2VDKmACXB22WpK/1RWA=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlFiwulGzbGsl54wLtIJ3/n2X+a0yL+iz5SL0/+a7I++ ZDQ/rt7O0pZGMS4GGTFFFl6zc/efXBJVePHi/nbYOawMoEMYeDiFICJHNnFyNDC3emruFZuY2Ls smc+VksXbd1Weqj7drr5l9vXJH/U1OUz/GS0umR7KYq73nfdA92tIexz2+buzNzxvfTNF9fKH3p NGbwA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-7.3

for you to fetch changes up to 353b2e09f44a91e64c6b8117df46b6999c52e465:

  counter: ti-eqep: Remove redundant dev_err_probe() (2026-08-02 21:47:31 +0900)

----------------------------------------------------------------
Counter updates for 7.3

Remove superfluous dev_err() and dev_err_probe() calls from
stm32-timer-cnt, ti-eqep, and ti-ecap-capture now that
devm_request_irq() and devm_request_threaded_irq() automatically
log error messages on failure.

----------------------------------------------------------------
Pan Chuang (3):
      counter: stm32-timer-cnt: Remove redundant dev_err()
      counter: ti-ecap-capture: Remove redundant dev_err_probe()
      counter: ti-eqep: Remove redundant dev_err_probe()

 drivers/counter/stm32-timer-cnt.c | 10 ++--------
 drivers/counter/ti-ecap-capture.c |  2 +-
 drivers/counter/ti-eqep.c         |  2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)
