Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCF37DEBB;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357343; cv=none; b=KJEKp/Dt20Qi1klHrcn3ma2Wsbs7abZF/aU5jJkmdXg7sF+rQzZZx/YxTG2pAZjHVbG9S9GnCmDlgKBtRPvvjkUdV/UAk+i9klwG+yg7mhZ/dJTnPX6DSkWCBNYst5jilONMMF+OJxn1qeFjMwEgimzWPk+VbLC95wdKX579dqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357343; c=relaxed/simple;
	bh=zXF9JhxmxCFqBjgpvDElVmn2gwo7C6M0hFU6cRioKoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tTlSSrAobeAGoG+iuwtVd0fu7TlKTU1BREdOXolC7EIUWCp6rrFPJX9XtRJlkS2rxdQJNrIp0cIGfwliWLX7H2909O0uAlYsnsZNAzWOQAFenuiqH0ck9A3t0+9o4fBdFgpw2q6lnBPt31EXgDCcffR9F1NpHc6bjj8HehN+x70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCbjbBUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCbjbBUS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 182BEC2BCC9;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779357343;
	bh=zXF9JhxmxCFqBjgpvDElVmn2gwo7C6M0hFU6cRioKoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TCbjbBUSxf2xWEXXEj2Lr+4I190zgEPorTN8LtTDUyLgnMBFBtwhS1QA8iJBjAsKS
	 eopULLIXS5c7tng63o1bR5udWIM7BLnQdWBEyjHjgm4FrPnvCI8dSVpAfPNgBpEm2p
	 Ft2RjY/OJ0boZad7syWC4NnfATulEtI7Sii8NGVXarjgnkvMBw9wLT7IzxnRMzuDzz
	 NuTHyaTxyOncNU/6GZ/e2LYt7tNsFf1djcesMmFHENbhVZV9BaPguR69MV+TA8C2jx
	 3lBiZuEgjr9K9M1zLqsKob0ap0nOHnr78vH8F7GB89YawgK/552JfveHuSiqsnGVUr
	 YczIFOFeswlVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F328CD5BAC;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 21 May 2026 11:55:41 +0200
Subject: [PATCH v3 4/7] iio: light: opt3001: localize for loop iterator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-opt3001-cleanup-v3-4-820169dec8c3@gmail.com>
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
In-Reply-To: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779357341; l=1002;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=eLTKqoKDL5j3IrIvcKrS7OVJxPKTQ2BcNKIWwEDWqrM=;
 b=QWZ8vEr/3nMo2lOUxB/k2sj9ks2No4kxon1dIlh8v6sdYu7+kEpgXorwoR3V5H8NNBbm67Shj
 CwMgYlJs3uPACyk6KsGohUELvtoxsFh58IaYPTR8z0bKkUl92M/59rl
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Localize loop iterator to tighten scope and improve code style
per checkpatch.pl report.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 09843c31516b4dcfb37e6f5e32c30aa75a03d4cf..22a73c1afa74988dabf9db10c3b55bd07529fb20 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -226,8 +226,7 @@ static const struct opt3001_scale opt3002_scales[] = {
 static int opt3001_find_scale(const struct opt3001 *opt, int val, int val2,
 			      u8 *exponent)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
+	for (unsigned int i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
 		const struct opt3001_scale *scale = &(*opt->chip_info->scales)[i];
 		/*
 		 * Compare the integer and micro parts to determine value scale.

-- 
2.47.3


