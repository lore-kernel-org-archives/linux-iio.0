Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9673B2FE5;
	Mon, 11 May 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493849; cv=none; b=qIcgx2jnkqrGg2YX+Gp4yytxkZEavYjaGIEbzCGXCv+v4DMq22oreLhpyFYAUxFNQxFhK1RduqEf43YvaVFuRoJOkJIfybRRAl2qBAIkQ1SQT//x9Gud+VbuSnENFGwrdi1BSrAbCUomHqszKqrSWdWuLPhuEWgdLyMuzCIh+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493849; c=relaxed/simple;
	bh=nb4kCBCHyrfIFcgNEo3rbjwW9n+s6utiA5PwbihLkAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/ypCMek8+mXIyuwhsU8clzlHm5MxtOiHengjJ5H810hzqOC/eUdurizeIzYG+8vQjYRZPjKMKJIIgGF3229Dh/bCqq51tz05bRU9SWvC3MuM7pulLzs5TYB5ExnAc9PoB7S2pWYJftAZmgoX5m9dRx9dllFo9GzW+Mkom544jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbCwdWyc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbCwdWyc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 582E5C2BD05;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778493848;
	bh=nb4kCBCHyrfIFcgNEo3rbjwW9n+s6utiA5PwbihLkAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AbCwdWycKrxJRzCdcXypPh1c9rgqL+GpBGTmS0f0hJKvJIlZFgaDvLysRkdTj1qe1
	 7Uahryk3ZWi78YzQVsoCSFczbXwTX4cffLo2PiHxcjFHW3a6SKGaPx7RgXrsJBiuzo
	 +4tlUUDz4wv7A7DvPE5CEnAOrb16fhG8BR7kJxfb4GA7dYhyQI4lwRJA3IJaEaJqsM
	 Rqk5oPSKa7urlh2zkCNE3TyoS/h4ubGlCFpzPpIBLzrRb4+1afuM/3sD2dCbRTOpkh
	 k5nlS2v45Tdx+MkyjsIYDvcIi9zFLmPrjcukb09Ymjq+zVIieQn2t74gbYWiBDO/2a
	 Bj8Jfraa6S47A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50510CD37B5;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 11 May 2026 12:04:10 +0200
Subject: [PATCH 5/7] iio: light: opt3001: localize for loop iterator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-opt3001-cleanup-v1-5-f7879dc3455c@gmail.com>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
In-Reply-To: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778493846; l=965;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=u/HUKTzIcOfpvygcTLqBLKYbkfqnk+THD3TcTD43zww=;
 b=V7B5NHXs7MXVYQtshZ/EhhLkFp17pi8ropfMt6deX/iiH4b0+lfgOE2fYaPw5+ae7vzoouYJG
 cPbn7gWmtnyBMVWAXKQr2lX6hrT8R7q5KRpOVvg44Z0S2qo9pX0fcpJ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Localize loop iterator to tighten scope and fix checkpatch.pl error.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index bdff785bcfa9744cd25d32c5d00d62a11dd9d866..3719757f6ed7784cbf2e4aa659e5c69a39b0cce2 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -228,8 +228,7 @@ static const struct opt3001_scale opt3002_scales[] = {
 static int opt3001_find_scale(const struct opt3001 *opt, int val,
 		int val2, u8 *exponent)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
+	for (int i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
 		const struct opt3001_scale *scale = &(*opt->chip_info->scales)[i];
 		/*
 		 * Compare the integer and micro parts to determine value scale.

-- 
2.47.3


