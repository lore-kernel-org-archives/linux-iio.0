Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3039B96D;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=oMYcdc4TAnGPMo91KACKdpQSX4oHncjrRcsddi6kTEys5JV5SullLPu6IFZ0JDhlZRya4Sh8CMfNjTFpRtEsA4CxitzTqw9iuxXzZ/jhMZZG5oGN9MFIIZYBTMQHB495K4dJ3RgV2i2czHR2atdVC52f5DJWR6m6QWU48l05HDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=6PPZ8OIbllbC/AgJ1WUIv1DKozXjBUAztl8j/VavP7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Er3ymusFgS03VqVTPMKVzK0/fduzh2AZ4OVnwF5o2tHM7dlVb+dAMY58BW41iRZAC6L5aCpyfsMxowCtNkCKxk6Z7uOMVDHK6XHQdf7lAm6OtOQJFIQ7Is9+nCzQE68tZxZ1jiOdr+PYRx9qCqLFoUI0Wgq2yqjHQjN230z+JAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJEcnj9E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJEcnj9E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33D5AC2BCC9;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=6PPZ8OIbllbC/AgJ1WUIv1DKozXjBUAztl8j/VavP7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IJEcnj9EujS0wDtaysupWD6APgzasJ2nsxX5AhQZaHUxeA4JLT8AEqFAgazEpLZY6
	 6vWzqgPoXZkjJu29mCKKNw/Aok8XWBg8AB+4mu9xH6v784vQuWMkKPDU7XL0Qt8NkI
	 ar0aMWwcqvdEDiVSJGrJHaGil2BDlhsLbzBhwtdinv2mLao+41tzb2eDJ9/SzIbi0N
	 XtKKWw4Wp4qK8l3dXuUNRwZrAxtiWPLfXOUBl9d2WYhfTOsEKOymAgoP37ja1GCpzD
	 ICSFmv1ND+PVSKnUxRz+hpI/G7RHBdBCgpn9Sw6GIW1+59FTbeUogOn2M1SuLjz+7G
	 DaOEgBTUwsfSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B848CD343C;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:05 +0200
Subject: [PATCH v5 09/18] iio: magnetometer: ak8975: avoid using temporary
 variable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-9-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=1365;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=8tLL2kiAufULoRZYDYBqjmCH5Df7RX705WCjX2nmy9g=;
 b=HLjOdUCGBtz8iLcZ+OEaf1xTWD7x6kYzf+n26VECoqWCYM3it9G6K88sc0rW0u/ZIVMsl5cmN
 dM0foXTlMeNCzMmKQTJGuFZ5U1LgQ8mu/uBogWI3uu3vkvCIzoRZIWw
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Avoid using temporary variable in ak8975_read_axis(). With that being done,
the clamp_t() call becomes idiomatic in the driver and can be factored out
to a helper later on (and if needed).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b3caf5f3ebf29bf701bb214aa480fa7afb2651c6..c36d068081066ef6b42cc2f9c3c2e8978ec51623 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -741,7 +741,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	const struct i2c_client *client = data->client;
 	const struct ak_def *def = data->def;
 	__le16 rval;
-	u16 buff;
 	int ret;
 
 	pm_runtime_get_sync(&data->client->dev);
@@ -778,8 +777,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	pm_runtime_put_autosuspend(&data->client->dev);
 
 	/* Swap bytes and convert to valid range. */
-	buff = le16_to_cpu(rval);
-	*val = clamp_t(s16, buff, -def->range, def->range);
+	*val = clamp_t(s16, le16_to_cpu(rval), -def->range, def->range);
+
 	return IIO_VAL_INT;
 
 exit:

-- 
2.47.3


