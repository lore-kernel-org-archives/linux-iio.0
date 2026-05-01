Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71437FF6F;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626921; cv=none; b=TvGEsA1cZDEkAFjNMtvensa7uhWyC/G93pWDMcIhLYqXqmTZp2cvIQ9OUC4gVywmbMjt1XRhum7RbcQz+Cj60Ws9yCseqEkx/BRg61mrynpcnAFejPjhrTUmTe9mQO9wTiDg/DgM+QfBRkHCq3BeBl1UeO7IbCRc3gjoMu+vygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626921; c=relaxed/simple;
	bh=7Mc0VNRZ1CCHsXaSFdFIyxqQMqScXwRjdBvOyAElbig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbhZbcRG7waOC1em3VmY63auywILUAOxN0/MtexILtKMYFiQLFpMru26rlwyIDrmGdmTzUvnxE5C2Y//7+rB3rMML4V2RtX5q1XsHYjDXeK4a8Gox/4GU6W1qBxbFTfw2AMrf6SrRCpPJY6fEWMv3JBFpWwrZEZJ1VbU9gXa8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQveHJeW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQveHJeW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A11D3C2BCB7;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626921;
	bh=7Mc0VNRZ1CCHsXaSFdFIyxqQMqScXwRjdBvOyAElbig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hQveHJeWX3JMkDXI41dqGm/vBF3I8Fu1Q0ZhUmaIcD6co1eGPTlNmS5W799Z+6RV9
	 x+trZzM2RND2YhAHWi6S92qEhZsbd5teo19JARKFclpvt/FqjANj+YijgW1yJmtecn
	 jbH19cRwGbnYax3AU4UT6S5TNRN2yT8lI22MHZm0dAxRNcIwj+pz2HW7hjKEicAgVI
	 nrsAVVwzBbDjMMDoId2ajurr6kTqjwiAMGEmiqoeHSQ0dMZeZqUpSwAinSU9DqKWj3
	 8axf+i5Pl6VvAsq8ZfJI7TY5dprB+avBYi/ctng5D8p1XOVRu86cgIAf9Qj/2Z2c72
	 jHxcHeIGvfNLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9260DCD3425;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 01 May 2026 10:14:55 +0100
Subject: [PATCH v5 02/12] iio: dac: ad5686: fix input raw value check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ad5686-fixes-v5-2-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
In-Reply-To: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=1063;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=vDIfN7HwJer2abOZhavJmea2PyXmNcae90gQrhX9MT8=;
 b=oKohw32tW9ASvgh5T6o/jb6ynGJ27HhUPEqPzkgqpKGImCUSgVlotVfHy9UohhJnopoBE5H/V
 5maxAZB29fnBL6doR+usU/SeuGMKMQ8TKOKPppcBa42JQoGVLlOl7Tu
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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


