Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738942010EE
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368387; cv=none; b=nS68OMLpnHKx7e2wi0+zkPTsUeFi6VDbqVSUkVmJ+enk7koriYn4syzYDG3hHocRpm/A/W+PhTdjf1K9ghOD8YLCZcT2iYn0kp8Y2X8/FnTArWwog6MyEAnqTCZjxJ9JJE55Qphg2FUZWLWwzrGaj39D87xURfSnF5CI3OiMRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368387; c=relaxed/simple;
	bh=hovCfJYcEUVlFFFq1ZwFK5AV7uJr5zqOhRta2+uytAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j3adZhze0HftdwlFP3Tb8Z5EJDhVxmtTMr2E4IkcZyPBWXAWCshzI4e/1wYHMOfZfneCwepEyukjJSK06JP5oOIGjcijtD2mY6c2g3dS6dw4pQr0tJaz6R0VxCB8CsBEy7xfw1vGxr4HoxtIAS03smNcj+qHQ7g8JfZLPbEWNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzQMKbwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzQMKbwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8BB1F00893;
	Tue,  2 Jun 2026 02:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368386;
	bh=xPxHBR90KTEunBtPPiggYAWbGhJ765Ut0YRR5/6Cx4E=;
	h=From:To:Cc:Subject:Date;
	b=BzQMKbwHObY4sdRVtc1T7tALMtaSduvV04Ej3/8SszC8xWHm2GAE1lVxMbWQ0K9Dy
	 DtXgX+X+xnm7Fo0AXekzxrel717cNPY7aJVplny7d61HNVY3MYUGGOOlfeFVjQpH6L
	 riX2aAzn/0sGnMHFuE0X0hIzHywFqOuzMK79BcQskm4OuiKFCCOQuxvcx4tbH/aoXz
	 9F86UibUA4jRtQvYthz37MvfT1ehcJiaYmlEf2tJ36bvfLhhkzBRa38C+1flk3eAK2
	 /nyrna6nHcUO0tka9GILCyvW1ukLv9X1ORlwlpl+ogjYyH1N3dVMdq1HOsN0znLTtc
	 peSVbBhRbYn7Q==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>
Subject: [GIT PULL] Counter updates for 7.2
Date: Tue,  2 Jun 2026 11:46:02 +0900
Message-ID: <20260602024614.853294-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=wbg@kernel.org; h=from:subject; bh=hovCfJYcEUVlFFFq1ZwFK5AV7uJr5zqOhRta2+uytAg=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlyzjsmHyuy9XrL4vfc7pZHqJra3b3m6/80q6bxm9bNk vJ0/lnVUcrCIMbFICumyNJrfvbug0uqGj9ezN8GM4eVCWQIAxenAEzkXgDDP9PoCYwHdCXn6jLd 17khd3hK9/lH33yXzVJfP6t0s/OUO1MY/qmxnnhw6ESg2g/eJ7YcbXfsrvzcseVAffn/qb9Vohk k5vEBAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-7.2

for you to fetch changes up to ca815bb87064a8f68b00eaf8872ef0d4a33a5bf7:

  counter: intel-qep: Use devm_mutex_init() (2026-05-28 07:16:46 +0900)

----------------------------------------------------------------
Counter updates for 7.2

Manual mutex lock logic is replaced by lock guards in intel-qep.
Additionally, devm_mutex_init() is now used in ftm-quaddec,
interrupt-cnt, and intel-qep to handle mutex cleanup automatically.

----------------------------------------------------------------
Ilpo Järvinen (1):
      counter: intel-qep: Use devm_mutex_init()

Joao Paulo Menezes Linaris (1):
      counter: intel-qep: Replace manual mutex logic with lock guards

Stepan Ionichev (2):
      counter: ftm-quaddec: use devm_mutex_init()
      counter: interrupt-cnt: use devm_mutex_init()

 drivers/counter/ftm-quaddec.c   |  4 ++-
 drivers/counter/intel-qep.c     | 54 ++++++++++++++++-------------------------
 drivers/counter/interrupt-cnt.c |  4 ++-
 3 files changed, 27 insertions(+), 35 deletions(-)
