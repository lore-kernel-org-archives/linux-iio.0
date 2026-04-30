Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A54266AA
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555756; cv=none; b=kK3WxRobVEdnEFrcyASpW2E5wziwIth7pdyxy9rLh6wmm/3LK4/LsK0F5XOM1P0S2qpBN9apqior1oWKbvWF5N2/oPxEPLYcArA9qgZgedmUa4wlRiiq0vKx0oi8TvyQpxVGeIC7TeAubxFctJ2bvqv5/4IQYq/zHHlODauk27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555756; c=relaxed/simple;
	bh=+T7FgV1mogHrRsPMhZRBIlCYy4ttKhXCc1OP4y+pAZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LuS0c4Tv22yPvItx8huszj6Hw7hxI/sHnPd839T/N9K9PCgcwRTuOVuRmiPwX2MX8q8agxNRIA66ErdL/FyFf0v63rK5YztsHgJBSQFZPItuCRKvpixhec9B5SEpc5zf765Dc4F9im2+4p7eA6xla75G1TWFh/MIc2VU+1PmW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8zYz4EL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8zYz4EL"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso461952b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777555755; x=1778160555; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhoJjw/yclazRSR0mz+b2Qwy9yZ2wSGuziyg4ybL3Xs=;
        b=Z8zYz4ELoaLb3z46LbkEuuK3YSY8EPRyjlM2oHXdyX6lmPkcuWuUa053tMLgWzrw/E
         5bVJAmaeDwAFV4ETrUrvdigL9HaSJ+MBTDUisRTWzMkKL8+UHsnfPXSOluSGk2uilGeS
         gREIHdidyQblXAjJ6yMaoZIpEx2FjI7pGpfblCg+nbqWRQKCu6hVq0cwB8DJF6HQ1Re6
         pVCdCK0JqlANjayAwcbze7Cjzwk7/Xav0kZFQ6+QHuJRTdpl3C2sUOjywukEs6IGqq4t
         4/oO3R6eNztZGKEl6EGWq31KzhVix4qpFzZfUwtFtOY1dIwQ1TgSRh9P+EZw7koXP6un
         i/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555755; x=1778160555;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhoJjw/yclazRSR0mz+b2Qwy9yZ2wSGuziyg4ybL3Xs=;
        b=dZWfFBHTZtS6vUbmWZVcW5HI+C1PgxtxVOnFxRNSqMgcXEsOar+tNKIZOAy59MRmeQ
         cbdyn75WiNGFNXn4og3IE3IM300xHvXrMAxGW/oAHB613DsMwFYr6FzJiN92DtxVP0af
         vR05nR79KIpAKG81+TnKThh+g3aaP3OiMlRMkEJZkkzEwqq91123/k6326+oHccqKkVw
         v7u1l2osxG77qfqEgpeK2qPfefsArwyw1dk+byvZ9HicVyZvU5ddbrLbSFIxIvywo1Os
         wg0K0M5GWdBgVViBlxoGyMNlAFVBXAf81G0lgJAbZx9TqKHCk23fiFhuOSJQ882UNDAG
         /f/w==
X-Gm-Message-State: AOJu0YzPs0YDWvwTIZj+kD243zaeszybuaWOnbrCzWkyloBIWc9VeylI
	hrE+XOCalpyPxWgTPyFfoRzdX21oqy9HYTwOAppla8zJDbk+FNgwFV5s
X-Gm-Gg: AeBDietjDM1/6j5+tC/Mx+eq5giEXxJnv1440odkGoWvBB5JB75ukU16nYvycILO2MG
	XoCxpxf+9fmp+mgUTJhnlayUTO0CuxMcrp2T6fXX/b2snJYf81R0VB0E4816g6GljNW7KaXZaBs
	P5kCLBguyM9hWAbmTF9YWLmInbMqRXcDEqUMUfw6bMtEX4H97W5M4UeLECtHci3MTwKsce+L99P
	VsfjHXVhf2+rI4yHlMDyvxXZOtnwFsucPnJYI3w6/XIkyD9XxAznP8M7IPPK53S5piU78lynTKm
	25A1+B5k54W4tQogDla47qvBrOnmjMcDVvIvMtdZyIV14Jrkt75ytPzl8SSjrNlGmvMRJMLSVa/
	sHULgu9cdlJZxjVAvSncFHx2X28JQvAQeSTO4+2ojCjg00usSQUwtMR/3nqAvFnI1ReCINg86zB
	E6bVseI24ZysnWOhjmfszlutTIXRa60lG9M1T81r2ctFvKEkp67JFfjMj6pC0qP1Yfr+W45R2ij
	dwDZv5Tx9ToqIBg0NVgWlZUSkwPYQ==
X-Received: by 2002:a05:6a00:3d4c:b0:82a:7734:8c6a with SMTP id d2e1a72fcca58-834fdc952abmr3507125b3a.48.1777555754312;
        Thu, 30 Apr 2026 06:29:14 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed6dd823sm5518855b3a.38.2026.04.30.06.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:29:13 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 30 Apr 2026 21:29:06 +0800
Subject: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in error
 path
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
X-B4-Tracking: v=1; b=H4sIACFZ82kC/2XMQQ7CIBCF4as0s3YMIFR05T1MF5RCO4ktDSjRN
 Nxd7Nbl//LybZBcJJfg2mwQXaZEYakhDg3YySyjQxpqg2CiZVJoJArYvzxKq5W6MMGMklDfa3S
 e3rt072pPlJ4hfnY489/6b2SOHAdr25P3514zdhtnQ4+jDTN0pZQvljfw454AAAA=
X-Change-ID: 20260428-iio-buf-4c8559020a54
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, sashiko <sashiko-bot@kernel.org>, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777555750; l=1953;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=+T7FgV1mogHrRsPMhZRBIlCYy4ttKhXCc1OP4y+pAZY=;
 b=od3ODozzIleYJiaARpw3ZND1sfhIis5Mt6qAuvw064lIYDsrT8UrraPOWadVXIkEC9U7T3VbF
 jwB2Uvk0E7rAKWf/t6iqZIctw22BHdKPtJ5wuQ7uO6Nbbtu68CL8REw
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
was using list_for_each_entry() to iterate through buffers while calling
iio_buffer_put() which can free the current buffer if refcount drops to 0.
The list_for_each_entry() loop macro then evaluates buf->head.next to
continue iteration, accessing the freed buffer.

Fix this by using list_for_each_entry_safe().

Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
Reported-by: sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647%40gmail.com
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix Andy's comment.
- Add Reported-by tag.
- Link to v1: https://lore.kernel.org/r/20260428-iio-buf-v1-1-dcc63ff7b800@gmail.com
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 24d7df603760..700528c9a0a4 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -85,7 +85,7 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
  */
 struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 {
-	struct hw_consumer_buffer *buf;
+	struct hw_consumer_buffer *buf, *tmp;
 	struct iio_hw_consumer *hwc;
 	struct iio_channel *chan;
 	int ret;
@@ -116,7 +116,7 @@ struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 	return hwc;
 
 err_put_buffers:
-	list_for_each_entry(buf, &hwc->buffers, head)
+	list_for_each_entry_safe(buf, tmp, &hwc->buffers, head)
 		iio_buffer_put(&buf->buffer);
 	iio_channel_release_all(hwc->channels);
 err_free_hwc:

---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260428-iio-buf-4c8559020a54

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

