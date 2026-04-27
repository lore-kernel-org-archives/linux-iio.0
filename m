Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808C371881
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322433; cv=none; b=RzoIpWdcanXrHY1bPJ7LXglH2OSGnohtBjgTckgBoa6Z+/OkrPfObQuQlgnUZFB9RSyf5kv5xlmhEmhrFzgQ2UFdleqTxBacD6QAOhCnDdF7AIbFFZlAjTOdCjql2dTmkH5QCorow36cwdAJRYQPVkpf3imkWm+aM19g6/j4jaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322433; c=relaxed/simple;
	bh=t4YFRTPbanMTM2uGw+mad+5JU83E835EcMJoSr9+bA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+1f5HwXTLlQHkdwtLilXKYlaJbu+CaQYLeeRG5UALVVAywif43LqNaqQOzN+4kh2RoEKk0m/NvbApd6V3LfTWpsZoaR7IMJBorPC68UC8CBSZMuZhKj0hx77jmH7TL3RVxatC4N1orWvWJSmK+A3hY2+g9wWfEQZBUPPWwyuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrpV1MoM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrpV1MoM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso72705225e9.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777322430; x=1777927230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IopUK0bLn3UHP3mF/fqFymMBy6awXnq6qnTuNhwG7fg=;
        b=SrpV1MoMM2+iqdmx5uIKXh2SbInpWpXWTqch1reK+rQLQCtfVdNf0cpHLnVowErUPy
         sCw6Xjwn5fU+Fc51V44H1gr6ZDKtIp8g91qNBwEUKGv/VzVV8yu7tpw6Lh7r8yJoaxPo
         V41Pi74xnF9ZPKjMxOqr8SrsMFNWLDlpPk6yVWh3FAlMuEKmtSStWBhWJSDqljwQID04
         8+63A6nIC4Tx5Zcq5BomiFZYFYdMMwCtciQJSgKBggkqWxOtaporKlWVHLqYwGLEqe1T
         NhaslImjCVPPw+S47ZCwP+S4YGYBWjUMLkZmSnS3Fbq6+IbYSmuzKp3vvYynqYnZ4g3J
         jMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322430; x=1777927230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IopUK0bLn3UHP3mF/fqFymMBy6awXnq6qnTuNhwG7fg=;
        b=tC718G1E2RqyUT8NhYGEhgRKkKZy9+Vimi1B3FHl/42GJ9jf/3gOZSeLiwO0Ya+Phx
         wdU5Rr3yS0qByGPsahHJYfu1ocqoYsp1nve3y8f24QXuBocizHbhV8dTa8lUIDNbKj8k
         Iq8Lxc8Wjoqyo6k/W6qGrDptYXeyHK+KkBJh9S4BkZmOUM+hrz9rI5Lm/QuBqBaQGcPp
         iPDd+wHtl91+eKluYCIRTFfYoZExbyY6zqBuci0vmviSxpvI3MiyP640dM7LtB5xAAYx
         kKj5lQKmDLLSmHslusgEtfqYP6hGGIp0YXkyE0vUpqUSCSaIv5NZgejF0gS6iFV5zFZZ
         OB5w==
X-Gm-Message-State: AOJu0YyJ5sWEQyAQiDqyamKKg8JFBNhXjR0PEm68YEydduPZolN9Elhs
	ZfM+h4ttVWbE2ZgrRflQ1fZJRgKSKFwyHAlM5yoDFIsREufjkYRg6HNB
X-Gm-Gg: AeBDiesZ45MAK5OfMXXfoxwIoIyYAfLKIZ9IFWlqPbobd/1d1PAPAfJGE8ZRywPURLV
	zM/M6CSaPRe6CCFh4vBGyQgaTPwPMd6CJ6TXtwarIWVjWrYF0PnVrwEtsXRgZg6XhGz4xvmTvE0
	CG8baBDE+qG1O12lLksbHKOReVIO7uUfWph1EwgU9qz8puQd862+pm1cBeKItwO/KxL8WzVLTot
	Qz8qg0MICvFAPjyZMP3sRGLNNLxQaCBZTo1hwZYijxqycbx8iKMYXDgCTBi0bfI4MrQ9VnGGiQh
	kv+FQeQES7hoJLRXeer/m/PiZlCHH011VkRN8D4HySewOHjvSDFIJsDCvPILulKgXhv1QNLR2FL
	XcKcad9ZctMykWPs9xqBFDXI7yvQQMzqs3bEllZUVk23VjcyZWHXgZHaIVVwtKTey6LX6GLC6rE
	I7mheIbSWd567f53JfadJ7BnCGJ5A1ZU9yOtVhWyEmaEoW8MzbYA2okiHiMzw=
X-Received: by 2002:a05:600c:47d0:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-48a77b1cf9dmr1543215e9.24.1777322430477;
        Mon, 27 Apr 2026 13:40:30 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77afa168sm4999285e9.7.2026.04.27.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:40:29 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: dac: max5821: fix return value check in powerdown sync
Date: Mon, 27 Apr 2026 21:40:23 +0100
Message-ID: <20260427204023.22184-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function max5821_sync_powerdown_mode() returned the result of
i2c_master_send() directly. If a partial transfer occurred, it would
be incorrectly treated as a success by the caller.

While the caller currently handles the positive return value of 2 as
success, this patch refactors the function to return 0 on full success
and -EIO on short writes. This ensures robust error handling for
incomplete transfers and improves code maintainability by using
sizeof(outbuf).

Fixes: 472988972737 ("iio: add support of the max5821")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
- Replace magic number '2' with 'sizeof(outbuf)' for better maintainability.
- Remove redundant blank line between i2c_master_send() and error check.
- Update commit message to clarify that the 'Fixes' tag is primarily for 
  handling partial transfers (short writes), as the caller already 
  handled the success case correctly.

 drivers/iio/dac/max5821.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index e7e29359f8fe..f3b45e1429a4 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -90,6 +90,7 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 				       const struct iio_chan_spec *chan)
 {
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
 
@@ -103,7 +104,14 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 	else
 		outbuf[1] |= MAX5821_EXTENDED_POWER_UP;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, sizeof(outbuf));
+
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(outbuf))
+		return -EIO;
+
+	return 0;
 }
 
 static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,
-- 
2.43.0

