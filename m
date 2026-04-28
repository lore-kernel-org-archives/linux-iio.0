Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448232E128;
	Tue, 28 Apr 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395739; cv=none; b=qjeN6igP5y12gvnsvYPpFhcm62HjFL4TY4IVt2QNK584inVTj75gm3ASNIvzRFOKNUBSmSImCZB1TRC0GehW1dow2KoUxr4DSJWW033wBYry3f0ZQfpzCb4GcOm50lhpD4kiWVdJEIS8bbrp1RuTf3Z1pWGjLPn6S/R1LoyS6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395739; c=relaxed/simple;
	bh=KmgA9JgsrbAO17H+F7bCU2SdGapgodBy3ZR8O7nYaAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWwmBlZKCkuaoJtb6x97VU35TcHC2q6zlu4Bfz/3noJGI/l9pA0CnITi1ZvSpRSExzGgJOODTdH26X10RjZjr+4gd86T9JM7go0hSpO8ctX4wMSs2uiYY7lY6BX6vjTXzeA16rHCQROYsEhgv3wCSWdoKvJ8SHMe3uhbvPLnX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtFmo4nG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtFmo4nG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6702C2BCB5;
	Tue, 28 Apr 2026 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395739;
	bh=KmgA9JgsrbAO17H+F7bCU2SdGapgodBy3ZR8O7nYaAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rtFmo4nGH4dC6TG3WtWT2605+NZViTMdO+8dFRPZ50Z4lQaMJyYb/yGUTN/kD2O1g
	 9OGvCl9wqnOtb8IwKuW4iooUQ4qVSwkQPfm6jm4/QCAxHA7z013l+yBRg1h53PqQ7R
	 0/B//rHP0tAV1TzJcN+vw1o7/UzY1kVFjWFkPJzIqGU+3G5jyj4RYGc3u20nQomKcp
	 AP0vryipIro3qYZ3DicfDr2G5sNc7EH4lsJYJxXOfJap2yNidGpCdyPQPrC2XNJuuH
	 X6GXU0RIpsDQFXM2qcpI7nYvWhOKKJMUBgVB8A3XbkSND8oNE+knthU37jJwHGsJ5c
	 Be7Gw9ZdTSlqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F5AFF8876;
	Tue, 28 Apr 2026 17:02:18 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 28 Apr 2026 18:02:17 +0100
Subject: [PATCH v3 02/11] iio: dac: ad5686: fix input raw value check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ad5686-fixes-v3-2-9cff7bd67a15@analog.com>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
In-Reply-To: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777395737; l=1003;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=THkmIKMHt3NPcgwfwdWS9HSyAjZViHV2lms1HDMm1Nw=;
 b=0TPOt5FDyt3qU3Hin50HwrK8+Pwv9Rjop7sHBTj5kUJz8tdx1bXgV9vpVa1+OnPp1H2SuGSLG
 zWJsmDzyQlPBkDeEBByFXkzfaAZ+zLNk5tZuzQUvLp/E6CXjlWJbGRH
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Fix range check for input raw value, which is off by one, i.e., for a
10-bit DAC the max valid value is 1023, but 1 << 10 equals 1024, which
passes the previous check, allowing an out-of-range write. The issue
exists since the ad5686 driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 1fc54c38b629..076fe8b8bd85 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -154,7 +154,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > (1 << chan->scan_type.realbits) || val < 0)
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		mutex_lock(&st->lock);

-- 
2.43.0


