Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3E39A06F;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=ILAZe57Y2ghAhvMX25x6Ea2Qe/nYfH5PfqZ9PYGWwRC1OrEFsQcxT8OLNMUSvj2GOei15wDMZGVs+sNJneD8zPVOXcVidpEsqY2xdCZ46c1AQO5B2Yeld4bDgzXTm3jgQ8Ob+xg1YhAFLOGGmWi/hMXm78JI9Y3zDzf0u6fLX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=kDDrvck3zNcILrzQWfrEiyjO2FiM4dDc+fCM67atdWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYRFsDU0wcEpRuykTFKgT5wyldSDRQPWm4GHnBRvQKCI1RPqpgwuX/C5768Li5f0TENTRW2n/qD1mKkJePLSfEWifUwu0y5JGXCRchX4BZ0mdHaRw2VJ/J+HlYXzUaMz+DIWpVPpihCSc8fqRT9uBLRAao+ZkT8WY7q/EfdMsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+TMCAc2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+TMCAc2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24920C4AF0B;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=kDDrvck3zNcILrzQWfrEiyjO2FiM4dDc+fCM67atdWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h+TMCAc2KqPtF4NpmRBlkB5fyguuNIs3sEm+5CMZBwPXiLaz89WW9sZF7WyqgrykG
	 EQR9jr2UeJz4p5308FrkJLxHhADFqT7ojClDNbiGlvrwG643m1tkm5uXrn4ooj5RBZ
	 17B2s4i3zCkxCYkco/n31mH3sgCsFET33QAYJpMRNcCYWi+YVZNhBMYLhvWEjsaL6I
	 pNh0xwl2QoNLZahRgU0PEGAt6w1bJD62yTyjz+SLLP+Z1/vULuSqHdYP0F39RHhdx1
	 tXVKnfV3/04x+rfpZDuQvavhunz0NdAsE6XhakZZ9LT6W3E2HDSy3vCazj1e29BAeL
	 ms55s3/3kDQcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2CECD3430;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:04 +0200
Subject: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=936;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=vu8QJb1yuLyFcW/eHFRBV7iWnKQKcFBYR1HYOhcgk3k=;
 b=jlstmsmr9rHtjiwZtiji7dUG6o95VqrdldlZGMejda7uEfI6j239WLxuLEgzK2rbL2sj4UGh8
 yoMoPqGfnE8DZaKj0Q87Tm9nfP6y0sAQ1ooDKifiCxwHwIrDY/1ta45
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add a check that ensures that valid data has been read from GPIOD. If
not, log an error and return the negative read value.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 129c98c97071b4cf8efa3abf2364a3abbde129ba..b3caf5f3ebf29bf701bb214aa480fa7afb2651c6 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -658,6 +658,10 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data,
 				 timeout_ms * USEC_PER_MSEC);
 	if (ret)
 		return ret;
+	if (val < 0) {
+		dev_err(&client->dev, "Error in reading GPIOD\n");
+		return val;
+	}
 
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
 	if (ret < 0)

-- 
2.47.3


