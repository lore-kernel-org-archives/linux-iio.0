Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D73E123E;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697226; cv=none; b=WfTC6mMQlqpg1KOx4ZJgukv5GVtM1sy1dBcTW9CSKNWgLALy9vLZzcoWIm0efFNuTBg84dcLKAamFgByoIxPhwvBnqUQWdO1ugDjZV4NawSYGCwLvikueYWdFCA+B+X91kFBII6bhFGRbQGfnHrwL21Mgd2JqvxkRf7C0ZD8X8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697226; c=relaxed/simple;
	bh=IPkVeA+IgQkAnOarSY2Gh6Pi86M2VA4Euc5JsqsdIpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUyCGMy33u9gIYUX5VGxevHdRe3qFUAJjN9zzexdN/NSw4FHQqmml7SfAllaGxAbQUMhNaC2JCQc75Zxuc2hdMIOn2ZmvP6bci2tfzma4XJoDaj/iAMNfPJQjSg5GbkG+whED4iwbXeP6CaASGTypNFtOnuG5FecUU1H/iyzmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbUfE+3A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbUfE+3A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA125C2BCF5;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779697226;
	bh=IPkVeA+IgQkAnOarSY2Gh6Pi86M2VA4Euc5JsqsdIpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AbUfE+3AZ5OGoYuwTLzbI7B8B8mowiaUm86oqOrMSbyIfcIlCOMlOcQcC+WZ0IeWw
	 dtCoJhJApNVAVTzvY/rZnMufw56Pl5nn03iB0oXj3Yj0syGqD3a2ttcBGveoU888cX
	 OFb1jvq2zaVc2WyAZggHq/2BHF4RB3T51lC0srILn7V7TCOnh++K322rNW7iZP0938
	 8PVJU7E35LrmdankeMEuQQyxorNqMiuMGLU8Ayw2uPva/rkpAt+Pr8HZsyILclbZ7p
	 M2e8KkxZevApHac12Hv38IbSh24hsKaXxnotmHJOXOhIyufprVlKvlODaRibRejfEr
	 9fEfgiZB7EXhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E035DCD5BD2;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 25 May 2026 10:20:18 +0200
Subject: [PATCH v4 4/8] iio: light: opt3001: localize for loop iterator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-opt3001-cleanup-v4-4-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779697227; l=1002;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=tpQWvMzLOXdTHcX1LxcT0aRdkJtE7TOkAhwdw+eYL50=;
 b=rEJWopHXR047UG34D8sbIWbnoJGBfBE/ybb2YquNqHemTOhR8qwO94kxt9HrGdlXb0WGVFETB
 ijMwIe4G+LKC8GjxhA35IhGnJclOY0x8lh5AFn6jH063r1a7km5vNz3
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
index 532929e8fa8b4172eadc696e927315017a07dac1..777a54753b0c84dbee40980101019450fcd06af1 100644
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


