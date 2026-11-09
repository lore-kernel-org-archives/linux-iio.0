Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794224346;
	b=xKG5FM2iWuh6rpr2VL9PXMyTW7mw0Hz0GMBAlvz9zTKldMTaeAZvWb2UXje2gTTzqQAO
	 MQpNhJzIFTplhxqOfm++0ICsJsBXLQdtvHv0EmgPUW+2JxeuB460D7l8ZyPoiZkdAzcAB
	 im6lg7HM+ejFEqiIjcYNWukLC1te3dn1NjByg6XW3Kp5SSUN7M7k3IvH7R6RcijrNRuDl
	 +e9PEA1x8ii2dqM6DDfWY9YV2t0GQMg7s7Xw8zdel2NVCHY5K4RNb8wmkgNfuoW/meQPZ
	 2f7maxGK1welSMQd5nNiFiEbS4MU67A1hw6yD7fbs2z9QVunBiIu4Xw+QdJj5I42u+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224346;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tL97Sx3NDDJXyLk5A2MZkuVoSGbryHAMgtK72h3ULF0=;
	b=d1IuDynBM0Te1kGIILPMRGb20yUbGNouEaP2KbL5jTQJsWwhItHvYgOOyIsmODHmS1p5
	 dL+ip5omYtYbppVvVXpyqnDeP2A3S6Jvh1bhOhuHweF6uoNIAju6v4lT0hermXaB7IniF
	 q/i1FMVcEaxpWsgeNKjhzG0zGOk7Q7m8LVW60DmQEbhMvXSAGLBV7AajZoGZ+EfcqzlUL
	 7h3Bd1X7r7dx2iJwXVDui1GKyzy4zwqKLj9xiAV+tUtRYc+31ljlLID5nXlqG+aeKzRJg
	 t5lths5th5kK7dQy4YmeWhE0BQGSHvmxpBn+KriCAu5YbECBvAoNSuitepmpY+12D6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heW7vAx5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C8606A321;
	Mon,  9 Nov 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heW7vAx5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794224345;
	b=mDULSZ15ISZP2Q/G7lJf+iazrT7okuRXzW80NVDag7jwPx/mIGRpPvmME2QAil/eja04
	 L0tDGePI9s7Ch1s20Ijoz6dbfpU79KXAr9yiTGNQ55sNVu3MMY7RVMBzb3vdCgRTjPw3V
	 B48q+GJXDs4CUEpHOQ+Yz/SqR3Ob8cHyn2g2Jg/G3rjNeObuKnwfczZiNUgd3tpr1GZnl
	 iZVXhY3mEDWXkIqnsQQdtJl7+S1G1N8FFCi4vhwX0XSmeQwqvNO1BFLNb6y8pNoDbyg3I
	 1PTRocOc80uCjMLw1WlE6AqQjoLLg5K89vWKcPIzqVsmm5RTkEQ9yo6eLX7L/0dHc9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794224345;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tL97Sx3NDDJXyLk5A2MZkuVoSGbryHAMgtK72h3ULF0=;
	b=0gyGR1cDdSp6xMtHPVAPAmIZdDVyNiR/fSj/HERGAObeTTCXYJksRg9FHmPFSbWUQHf6
	 FiP5Q4802OkcpncJwTUaEeU1OP+Qgk2QwOJ4WPSwzMwyol25o6Su9g/bljgoSIna3nyDR
	 GE0R6jLiXrp6HXQYhGqG1l3K9TF90lvQtLWXzLf6Le3Bsg+5UMedrAFIlNNlvopVLUM1Y
	 Grr7D8b2FS9n0WKMNAEzdvVZ7sb/imMoVL59YM48mpePLNsyLD0FEqh0YzBLuczlmuRVb
	 AVQc4gOry8sqnNii4N3HaJk/qRVKj8jYQRNuBiwoqMU0MR4TNtr1+8vbdM6lVSZOr0g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A7B11F008A3;
	Mon,  9 Nov 2026 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224345;
	bh=tL97Sx3NDDJXyLk5A2MZkuVoSGbryHAMgtK72h3ULF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=heW7vAx5wZxhSWzIidKKoqF+Cwx05i80YhJ47450hmBnKCG1XajHH024OyHmYWLSu
	 bfd3CsFxajRFIMFCQk5x1UJAecBngbWP5R+aKtW/rWevq9cnIMeLGv5UV8HTdl/2hn
	 Maw5dVjesA2LEnJ9OMGFwdxLpHnKFkX2KCrkMaMBYEl84gD+BGzy3grkUyRjAZOkQA
	 FVqnbcDfA5YIj6QrMdqWhgpSAYnTKRCBU6Lg4mKQdm1khXP01yO9vTvPQPaYxbDIeG
	 73eHLaIHbFiBLbXvIWhpX3myR1f18XEopAhhCOxDGLsU5i8dgzcbeh711Tt06YA34W
	 f1V5sOKAYGv+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B346E48425;
	Mon,  9 Nov 2026 11:39:04 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 11:39:03 +0000
Subject: [PATCH 2/2] iio: light: adux1020: extract the FIFO byte count with
 FIELD_GET()
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-adux1020-measure-fixes-v1-2-fe1ba63f28bc@gmail.com>
References: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
In-Reply-To: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794224343; l=1221;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=XsuW70+va29sa1QD4DljbLTZAicup6mt3PPzvSsELWA=;
 b=MJsbFtOFSHMT74bZQ616PxNSEXPCHJ0tPpLBe58Yv6A/JDUNhapnFPjXmA4zGP4VgGD35jLQ6
 /sl6iNXwG4WCbOf62Lj+f2Tps8hrv5nlPmnrUKDfkshsGhbp2OFwCCo
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

adux1020_measure() masks INT_STATUS with ADUX1020_FIFO_STATUS_MASK but
does not shift the result down, so it compares 256 times the FIFO byte
count against the packet size. A count of 1 would thus be treated as a
complete 2-byte proximity packet.

This does not happen on a correctly working device, because the FIFO
only stores complete packets and the driver always reads complete
packets, so the count is always a multiple of the packet size. Still,
use FIELD_GET() so the comparison matches the datasheet's polling
procedure and does not depend on that.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/iio/light/adux1020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index cccd509dd18a..dd5230c6dceb 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -331,7 +331,7 @@ static int adux1020_measure(struct adux1020_data *data,
 		if (ret < 0)
 			return ret;
 
-		status &= ADUX1020_FIFO_STATUS_MASK;
+		status = FIELD_GET(ADUX1020_FIFO_STATUS_MASK, status);
 		if (status >= adux1020_modes[mode].bytes)
 			break;
 		msleep(20);

-- 
2.56.0


