Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198545;
	b=5cxE7nTkBtJX7ZLn+B6FywaEco+hwJCREL4EPDQBh72SrzZVb8wZgA7JXRz4S39F58QC
	 4i7t2yPW1V2L2r765Fw8uq9zbOKzv04q4EN+d9v57bUmLe4SJHe4ge0v0vvnC/DInPMGi
	 QtNIGQAq5DMVAJYURDLVWMiK8i+PIrhqDkIq8Oka+4xEiY49ocaUfwqGFQCYy4AUBEfgO
	 pBKc8XgVl0GClqpGVF2b2zIGlqDz/uYy+f35tGtgM8vNg7CdUrnEN0QWxbm4XHtzVH3Za
	 jd39T5abcxeU/gg+FivSHXQY5/qVYx5yqM4HwG1o7e9RVZAPjW3pQbvs9u+pLbJbTsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1rRcWrhO0gOw6f3hvEg0w4WO6plOJ13E1cEe1hkOKP0=;
	b=a5zZtt7BPVo/c52bOpW2ggI7e5X31I9eGZH9DE29Izz/kNN/3QKyije6anvMm40BXpdb
	 O5rQw06e+P9iom26GhdUMLBtwgOd2mtN0ZH5HXGGY2k7ZV1cnGNO4AdpU3KTfkySzGAz7
	 OpW3o1wPp2GWfODwHLVY9rXbjbhv63rJYiCyAXvOSvPttS8PAga3ibgWBY2cxO/hhxtgJ
	 bZYOdi7ph+NKET0m+Rykya1JnYfB2UZpTxbjzJWQ//QizkKkkcIwLNmn3SIoK/ip+jjXh
	 1KCp81ODqZL09NJ1lmQw//ZIb03fprLU/p9W6cErGhsOhvueREAI1rZKvxrZ+HKviSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaCfqzrF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89919606A337;
	Mon,  9 Nov 2026 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaCfqzrF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887171F008A2;
	Mon,  9 Nov 2026 04:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198545;
	bh=1rRcWrhO0gOw6f3hvEg0w4WO6plOJ13E1cEe1hkOKP0=;
	h=From:To:Cc:Subject:Date;
	b=aaCfqzrFAWH0ybqNE5Ij4gGrUKOs4ck554llk6dP3NApvuXWcXBXfIi6mA+fvmH2u
	 IqaVGqYEIAN4bANgWNejieauCeHDFymPuL+DGRzYLy9hCWrYtWqRr+ykLIyZzxJom3
	 IQmgcMg85Z6+mPXv8o+URa0Va4afMCC1oDG7NiSbeYc091fAKqoo5zhkeC3zNyr0MN
	 qWy+Q2J4La9BHO8e9YKc97T//lbZOb9rxmp6eoqR8sgpxW4xeD9huU+k6FGsqLj6vO
	 AMIvuobQR6wd06rpAnx0YSVK04CTPhkrgrK5ac6mwyyO5vLX2vyeFse7J//VGzOhc5
	 39BHgXkL52UMw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Song Qiang <songqiang1304521@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	Waqar Hameed <waqar.hameed@axis.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH 00/14] IIO: Ensure iio_trigger_poll() is of the device owned trigger.
Date: Mon,  9 Nov 2026 04:28:37 +0000
Message-ID: <20261109042851.1326940-1-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Resend due to wrong linux-iio email address. Sorry for the noise!

LLM used to help pull this fairly straight forward series together.

The primary aim here is to ensure a clean layering between the two sides
of the trigger / pollfunc (push to buffers) divide.  The caller of
iio_trigger_poll() and iio_trigger_poll_nested() should be using data
relevant to the trigger, not iio_dev->trig which is the
current_trigger for the device. Most drivers got this layering right,
but not this set!

This is also step 1 in a plan to make iio_dev->trig opaque allowing
more control of how it is assigned and avoiding traps around lifetimes.

Includes one precursor fix that has been broken long enough I think
we can just merge it via the slow path along with the rest of these.

Jonathan Cameron (14):
  iio: accel: mma8452: unregister own trigger rather than current one
  iio: accel: mma8452: poll own trigger from interrupt handler
  iio: adc: max1027: poll own trigger from interrupt handler
  iio: adc: ti-ads1119: poll own trigger from interrupt handler
  iio: adc: mxs-lradc-adc: poll own trigger from interrupt handler
  iio: adc: at91-sama5d2: poll own trigger on data ready interrupt
  iio: light: vl6180: poll own trigger from interrupt handler
  iio: proximity: vl53l0x-i2c: poll own trigger from interrupt handler
  iio: adc: ad4691: poll own trigger from interrupt handler
  iio: chemical: scd30: poll own trigger from interrupt handler
  iio: proximity: vl53l1x-i2c: poll own trigger from interrupt handler
  iio: proximity: irsd200: poll own trigger from interrupt handler
  iio: light: vcnl4000: poll own trigger from interrupt handler
  iio: adc: at91_adc: poll the enabled trigger from interrupt handler

 drivers/iio/accel/mma8452.c         | 11 ++++++++---
 drivers/iio/adc/ad4691.c            |  4 +++-
 drivers/iio/adc/at91-sama5d2_adc.c  |  2 +-
 drivers/iio/adc/at91_adc.c          |  6 ++++--
 drivers/iio/adc/max1027.c           |  2 +-
 drivers/iio/adc/mxs-lradc-adc.c     |  2 +-
 drivers/iio/adc/ti-ads1119.c        |  2 +-
 drivers/iio/chemical/scd30.h        |  2 ++
 drivers/iio/chemical/scd30_core.c   |  4 +++-
 drivers/iio/light/vcnl4000.c        |  4 +++-
 drivers/iio/light/vl6180.c          |  2 +-
 drivers/iio/proximity/irsd200.c     |  4 +++-
 drivers/iio/proximity/vl53l0x-i2c.c |  2 +-
 drivers/iio/proximity/vl53l1x-i2c.c |  4 +++-
 14 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.56.0

