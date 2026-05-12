Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE738E8A9;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=RTZDjP9Rqc1Pl9eIHnzWIwFZHEUW02YnRs51k+Cg0bGTuHKw4GsrHnz0l6pLvLUAswou7IOOwR6f+KRJj0mtwbJBDTkkmDpbaS5dIc/APS8jAqnwrLDNbuinWgeuO/W5IR721Zn6wCmQSTRI0STlSZ3JJRsjsERMwrAJ2mQtofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=B7gGNBYNYgDZb5ePCf9Qtb2Yz2VINvwRgOMpEaSaHVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmpjLEHfIsEiJ2vq96/2o6MFN8+IHQURsoJ7iW8Z4a6g0GXoCsdvpTZwEIzl3UwZzcH57kak2M+0wsPBVakSrfA1ao74rRlk0d/M45ZvlJdwxb4M/n8Dm7JMqfQY/MLrZ0cZ8h6wSzpx/rfcTrTMIaZq4vrfb3xOCNdV/WURC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjep0qqw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjep0qqw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41B8FC2BCFD;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583473;
	bh=B7gGNBYNYgDZb5ePCf9Qtb2Yz2VINvwRgOMpEaSaHVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kjep0qqwIMHvaXlLXZKXymC2wNRJ0mZFVOHDAdBI79VJIlvMle3Ux4BRQqiSLr1Uk
	 VHfutKCUIVvYH0ShsqH938/UaBPMi3xOawzL32OJ7JBVSoXX9qODhttppleXwjxndX
	 afKh5MKR2YWzL/YNI2M6LYIHZY4RcQCn/ognVKCPe/iT9E82HYY/Gcy3QayfNLnux3
	 Fak5JRxoGjGt7v7ZIJJpQr0bIM4r5sfjyZnb7FS+tNoP0Zs6YIh2CgNcCKqW81Kz1x
	 OKgN2gR/feOvS60As5JOxFfBDq+2PCisT/s0FQty4Pjlrb//L/oXQYS+QndXC3ZR/C
	 duYRqVovaMGtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A82FCD4851;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 12 May 2026 12:57:26 +0200
Subject: [PATCH v2 06/10] iio: light: opt3001: localize for loop iterator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-opt3001-cleanup-v2-6-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=1002;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=AsyGssNVmON9RQX/C6khFPg58cqD0NGGocT4co0wy1s=;
 b=nthaInSsVtNIjCRF2FMDgEAjZvToY06ZDGOssNu6LjIgq1pmnstb8y9TxPk9zfDQD/tiYbmT9
 f5iToYop3QICm1hcKzsoh6GqjgMbnLC40+c2t24KsmCqvpRQm1e25MI
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
index ad729152bb9266a35919e3abe576e792dbc08730..8eaa2cb6b5b044afdc405f19cd2499abb7e4d7a3 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -227,8 +227,7 @@ static const struct opt3001_scale opt3002_scales[] = {
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


