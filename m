Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279533822A7;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357343; cv=none; b=Sgoo+A+xm4YP5sljrd71HLUW6ropESW1S9BIpB7/hKhNak5yni+68TNe9BJbD6rUl2/5q7d+PeZByRfaQ3U9PKJnuClBitiD/wTuWbt0hSaNGX7H1mlxKoxjJti93XvY1Hqp1kzm43j1oAnORtrSzYakEAWU5EdtuNdcvvd29do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357343; c=relaxed/simple;
	bh=KCRa3TW27Gjb+lOkL2E1dbv/STupXKkCrH3SSwUpCac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7xOR5vmtCs0O2ClZjoeHsYMfPsUBOjAtq/I8N4yR40zuXg7BHSMjN2KIUXbnBHdgS8JQM/oKhPg7jp1Vk6xOBbK1+iRX/K/HVMzVwNTkVNJmZPZKVqk+NIAEtG9RgD7ReRYTly4qmIQCJ+PLUrGF2kD/waEdWPz2lMXgfQS69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnOgIdnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnOgIdnv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8F07C2BCB9;
	Thu, 21 May 2026 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779357342;
	bh=KCRa3TW27Gjb+lOkL2E1dbv/STupXKkCrH3SSwUpCac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cnOgIdnvJuAN6S2Q8oP6puktcPZA/TYE0Hyv3wJpuxGc7aklOedj8QO93MkDzijP1
	 fMnY+XLvCl0N91W8WG4J2DbJ56Yuq7Au9UFk7SX7qW99TkzmU0TOBFaxfNagdLUBxt
	 8llWCyJoxxg1iK22vTq4j0GNuW9va1dTzVopnLU/xQppJMxNn/ikPg1PvUFRAO+N3h
	 VUAAi/fMMpxKk8rTQXBuYtS7gnFt18UuvhsXWoNwBv19GiCe/qc1I3Y30AIwQqBouY
	 qEkhwGnE6GJAL0Z1CFZYQJJx/V3paoC/O56uE/Re8/I2kYfcStzVx6oGRo4jWJAWTV
	 /Y/Df8RtKVNRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2297CD5BA4;
	Thu, 21 May 2026 09:55:42 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 21 May 2026 11:55:38 +0200
Subject: [PATCH v3 1/7] iio: light: opt3001: move device registration to
 end of probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-opt3001-cleanup-v3-1-820169dec8c3@gmail.com>
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
In-Reply-To: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779357341; l=1994;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=ZczGFIQbqXOXLVlXU5uBirkleYkJeoHuapeGlc+EZuQ=;
 b=6EuN+QHD5HXCI+/JLhT3u5i9ocSVNtKKGc+Z1MIW6vDkxxv+2sbL/6Yn2gJnk5iqAQUNw6ZPj
 V71NdptTC1hCPp8lFO7IITMQQy1aoKNfPGLB7Na2wPAUDFwjbNm4hF0
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Move IIO device registration to the end of the probe() function to
prevent a potential race where userspace can interact with the device
before IRQ is configured properly. Additionally, switch
devm_iio_device_register() to its unmanaged counterpart as current
driver implementation mixes managed and unmanaged resources, causing
potential resource leaks.

Also, add iio_device_unregister() to remove() function to correctly
handle teardown.

Fixes: ac663db3678a ("iio: light: opt3001: enable operation w/o IRQ")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260511-opt3001-cleanup-v1-0-f7879dc3455c%40gmail.com?part=7
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index dac3d3818d0a01b4ca53106fa38bb54b8c5373d4..fe53a072b21ddaa26a23c76e82897fdbc1e4d846 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -874,12 +874,6 @@ static int opt3001_probe(struct i2c_client *client)
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
 
-	ret = devm_iio_device_register(dev, iio);
-	if (ret) {
-		dev_err(dev, "failed to register IIO device\n");
-		return ret;
-	}
-
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
@@ -894,7 +888,7 @@ static int opt3001_probe(struct i2c_client *client)
 		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
 	}
 
-	return 0;
+	return iio_device_register(iio);
 }
 
 static void opt3001_remove(struct i2c_client *client)
@@ -904,6 +898,8 @@ static void opt3001_remove(struct i2c_client *client)
 	int ret;
 	u16 reg;
 
+	iio_device_unregister(iio);
+
 	if (opt->use_irq)
 		free_irq(client->irq, iio);
 

-- 
2.47.3


