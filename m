Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB98388E6D;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=mcjFlqZLhpkgrHptqoXuFqjyD4py2M3ArY6Qe2fmTSioItzMguhJIP7pIAqLWIfglRoQu0Yy40eHx6ostenwM316dwUYuwsDY0ufjQiwErthRWmsD4wKJLDA9R67osTqVe9QAvFIN/NwxH23bfVL+V1fz1RrIIZvS0wUcPfvMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=quDLPvJ1jqF1IEN0sGM2Xcmta6unSwyehYUHPwzXRFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMFaWdUGwpw/F0O1MfbzgsR5qgLVhXqRQDvz1Mu/cQck79U820EhOxKRcC1NOENnQO8rN5IRoOtSdD2jCd3GLH7yLNOAN9W4Q0ivtn/MPOP8el1ugcveUpmBph9t8d027N54sIYDuN130FEtp46Sa+rPzPGmVWc22+XeT3ZqSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNYszEkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNYszEkw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 121A5C2BCFD;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888115;
	bh=quDLPvJ1jqF1IEN0sGM2Xcmta6unSwyehYUHPwzXRFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BNYszEkwT0vV++4WZqPrlHb3ErAktpJ3zsvhg9k7LW1zwtwaxThE4TtWKin2Kw6rw
	 BtanbK7pIhg3exL6xZhdKQ8zXjVGxh4llat2dbgEJfw/iJnL4SvsWqhesLPiSa9Rvl
	 rcYechXmImNK5SzxK9HIbtU+OoOPd0YST9jdrlW0cQx1xr6a64aax52GbLzC1GUknd
	 D7+lOEGZGW59jhtWl9npAmRIXUGrotSUnErtMfgB7AV5sWB2O5Mhtbjrr/hfhpncDt
	 rY4K9fcM7RxmX/nRw7Q4/vEgt4syd6/V6OPW20d/Zoj25iq/GmfHlpqQzPWR/rxbos
	 FlKDnVQDkWy2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD71CD3430;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:20 +0200
Subject: [PATCH v4 08/17] iio: magnetometer: ak8975: avoid using temporary
 variable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-8-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888112; l=1365;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=DJjDCl9JnP2nB2THH5DHs78YGFDKy3vPdtw59miyMxw=;
 b=4HuQSJ58ATnlexHcyGIojYi2gWz8oe9LlrfwqQAt5SsEWh81yrPSEQmZGp+CI7uGe23BPng2q
 DBXxdbBYblIB0p97Vybyf1Z5sqviZu2IcqI7hLGxkX2mZCv3z2VanPs
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
index e399a6508a3e28931ec2efe07924d5f30cebf442..00bee434432f07e8e0bd7fb2b4c97cd2995af7a7 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -739,7 +739,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	const struct i2c_client *client = data->client;
 	const struct ak_def *def = data->def;
 	__le16 rval;
-	u16 buff;
 	int ret;
 
 	pm_runtime_get_sync(&data->client->dev);
@@ -776,8 +775,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
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


