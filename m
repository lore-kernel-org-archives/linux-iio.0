Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5433688C;
	Thu, 14 May 2026 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775800; cv=none; b=HFJxqhTNDhVrIAn+I6IwM2qYF2PIWddx6hpH0Bn2ofzac09RbAfklDDqNSJ7zTcJErqSpNc4xOxT0mF4MfoKHuVb/5Yw4LGpMGZZCsxU1Xl4Wpt2O/FnwtzitOeeDrXiVv4+lUmDsZQcIR72jMVxCmc+3psptc3bNhEqkHso+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775800; c=relaxed/simple;
	bh=+uXcocYebzROvpeQREnfaRR2O0qkqi7ZzoSmfwK9e2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akMPrWlCkJVYZKD4dHOzMXUre+YXJ8pr66/qSqNuejEqBtfvXBA2s44tfr7VLRzUqD6JXi5bvfXLU8ZRLfVkkweFBcY0DPZCNfrpS9MGaihKTuRh4PmQT3J9dMcekcF/LU9OKpSplWFfbkYYLhLoJ5Kf5RIdz5aFGX7i+qr6mZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j5+bMkVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j5+bMkVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82228C2BCB3;
	Thu, 14 May 2026 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778775799;
	bh=+uXcocYebzROvpeQREnfaRR2O0qkqi7ZzoSmfwK9e2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5+bMkVSZQ/Ievpqm2XNQIwOcbnN9zaWJmABYDymwoKBFf4e/uitrFt/PxAO0SrmX
	 wdbELWbu+BrFYBcR7rfs2R7qOQu2y6EMQ6j/zoMHOGs1NINFomUqC/HlWxhI+QfG5L
	 +x8/CU1LB3js8Ji5RFJf3zmW88GksvXmXz1F0Hjw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sam Daly <sam@samdaly.ie>,
	stable <stable@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] iio: light: veml6075: add bounds check to veml6075_it_ms index
Date: Thu, 14 May 2026 18:23:21 +0200
Message-ID: <2026051422-hungry-dolly-0250@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051420-strudel-graves-f6cd@gregkh>
References: <2026051420-strudel-graves-f6cd@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=XsUhPROMAFmxnITST+P0ED08hGkNjmkbdzHg48l7TSU=; b=owGbwMvMwCRo6H6F97bub03G02pJDFms335/uTA7+r+7WN9OAcZfE/Ued256p2a3aFGemJtoa G5tsRdHRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkbAfDfJ8e33XFlzdqLDhY 8ZnlWH25uvfSWwwLjt78GLiY++ubL8sWNCcs3rxXVdXfBQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

From: Sam Daly <sam@samdaly.ie>

veml6075_it_ms has 5 elements but VEML6075_CONF_IT can yield
values 0-7. If it returns a value >= 5, this causes an
out-of-bounds array access. Add a bounds check and return
-EINVAL if the index is out of range.

Assisted-by: gkh_clanker_2000
Cc: stable <stable@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Sam Daly <sam@samdaly.ie>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/veml6075.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index edbb43407054..f7eb159e5cb4 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -100,7 +100,7 @@ static const struct iio_chan_spec veml6075_channels[] = {
 
 static int veml6075_request_measurement(struct veml6075_data *data)
 {
-	int ret, conf, int_time;
+	int ret, conf, int_time, int_index;
 
 	ret = regmap_read(data->regmap, VEML6075_CMD_CONF, &conf);
 	if (ret < 0)
@@ -117,7 +117,11 @@ static int veml6075_request_measurement(struct veml6075_data *data)
 	 * time for all possible configurations. Using a 1.50 factor simplifies
 	 * operations and ensures reliability under all circumstances.
 	 */
-	int_time = veml6075_it_ms[FIELD_GET(VEML6075_CONF_IT, conf)];
+	int_index = FIELD_GET(VEML6075_CONF_IT, conf);
+	if (int_index >= ARRAY_SIZE(veml6075_it_ms))
+		return -EINVAL;
+
+	int_time = veml6075_it_ms[int_index];
 	msleep(int_time + (int_time / 2));
 
 	/* shutdown again, data registers are still accessible */
-- 
2.54.0

