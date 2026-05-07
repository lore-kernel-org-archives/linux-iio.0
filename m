Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18317402B9B;
	Thu,  7 May 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164570; cv=none; b=i9qihjz3Y7hqlXT5jiZ3zoSR9Fo4TC4M7zmui+3VHO72EtamscNWU0kLZPL9v1NTCS6mwW+gkqUznBZHHDlnPHRJp64Qmh4fgc1qQkfts26Bg6MnxIpYLykwLOIWpGUr4e4eB6mF9z0E17iOluUgqYGJ77VOcEEnX3jxe9HVVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164570; c=relaxed/simple;
	bh=Dd/KxItWicMwbCV2zwSOzcxMY1WSyk6AKUH/IWkhgmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyLNVbrSMs5wEOs+EMR4gD1769oa2VcV61RIiIw62FAQVlCCmUNReyjyM7ip+3Z8ouc239RTxY4jG1HSGK7CB9RZqP5NeVC5OdNDN1GcFuleiAkuMEspTV5t+islJnxT0IOsaryjCbsi8l82n6jp/BWgsDilIYKc66hzqYSvJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzjslhkk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzjslhkk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB9EBC2BCFB;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164570;
	bh=Dd/KxItWicMwbCV2zwSOzcxMY1WSyk6AKUH/IWkhgmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RzjslhkkLMk2O0ZHSHMIbjbZV+j888Bg/GmWEbB9UBhAMVkyhdzGqgGmSEaIgJahD
	 ZocPsCzQq8cgNTw/fgH0mAkVBKEiUB3Y6Gx+84E7PVQQCS6urzV8+bXYUzCKZZ9Yw5
	 zkaWSP85l/s5CI650m2seU14IZR/Zupbm2tK/voMttjqg7lcFC0WBlrY9zU+fBWRA/
	 KXesSrcVGsXRqXV+h5q53SPSrUzNn94iRWer8r0t13XQfF7Yh1+KrDKE7ptBiJTwfl
	 JuR8gD0UXFN4+DGXvA4PTp7i86D/vxPmBwxKPDX8qCohQoPqn6Vsj1YYcPSivmal9R
	 MtOsK6tXcHagg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EFFCD3442;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 07 May 2026 16:35:56 +0200
Subject: [PATCH 7/8] iio: magnetometer: ak8975: add scan mask index enum
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-magnetometer-fixes-post-pickup-v1-7-37827ca68fb3@gmail.com>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164567; l=1542;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=45ZXc1YiNJiCl0IL+yOuRiuQft1seVNg1PtV4bx1wjw=;
 b=8if4tekMMBmxdS45/1kZMsaz9PNGpZ4IwbBFvguwm8eckjlgxKrn0F1iFIQkuWJYsWZ06o7BP
 eIZ1VOF/jhgDoo7zUAfIZve4uG274J4PRMDbYEX83yoOLUUY+L+bxR+
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add an enum to explicitly define scan mask indexes for the X, Y, Z and
timestamp channels. Also, update the struct iio_chan_spec to use said
enum for the .scan_index parameter.

This prevents magic numbers from obscuring the hardware channel mapping
and improves code style.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index fde37cdcdd053bde1630c2f73ab717f9d008e2fa..d11f025e146d098508f35ef31c1ccad544612535 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -238,6 +238,13 @@ enum ak_ctrl_mode {
 	MODE_END,
 };
 
+enum ak_scan_index {
+	AK8975_SCAN_X,
+	AK8975_SCAN_Y,
+	AK8975_SCAN_Z,
+	AK8975_SCAN_TS,
+};
+
 struct ak_def {
 	enum asahi_compass_chipset type;
 	long (*raw_to_gauss)(u16 data);
@@ -835,8 +842,10 @@ static const struct iio_chan_spec_ext_info ak8975_ext_info[] = {
 	}
 
 static const struct iio_chan_spec ak8975_channels[] = {
-	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	AK8975_CHANNEL(X, AK8975_SCAN_X),
+	AK8975_CHANNEL(Y, AK8975_SCAN_Y),
+	AK8975_CHANNEL(Z, AK8975_SCAN_Z),
+	IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
 };
 
 static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };

-- 
2.47.3


