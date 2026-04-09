Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601533BBA2;
	Thu,  9 Apr 2026 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742061; cv=none; b=fDep6pE18UGqOibaU2YoUUU4YC2L8SVa701v55x1TB7ag7GPO3hvqdhnWyTiAM3elvOvAQdqaZUfXmZj9DfKf3ErcmWLfxK2keWbxk46mhvloD5yJya9+HglfzjOEJo7EXND2N40nBiJjuuB8Wu8zqiZwefegZSow8hQAe2x/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742061; c=relaxed/simple;
	bh=YYzVlUVOGB/cmDKJ90NTjs2SsXlsVdU9paeVy6inhao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJe5PGSQPNIIdKtMQkjEpFE4E49eWBkpbF9i3UrOtlaawUThtuPwesi6ysWTpm2Thz/0/+8BJBxkgWIw+MUs8YjlvGQLJPF9ewpxpvoaXHiz1RBu3q50h8jJNyC5VXZIgEIj7VUXVIVTz5yJQoYw2QqcUwe2b3ct6dsB9/5u7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kSjpbub6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kSjpbub6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838DCC19424;
	Thu,  9 Apr 2026 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775742061;
	bh=YYzVlUVOGB/cmDKJ90NTjs2SsXlsVdU9paeVy6inhao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSjpbub6epNSPGhnHZgQWy4Y1e1eS3uRaqLw0fLCUCypPl+HfyTq6mPJz75vcmWzz
	 3KPNvfiJh5OJKKgiJIbXWHyLHKCA6AvkdfNtYLKgaBeNRkYZydrLYxb7mR/vgfEvZ2
	 Q4qcC9dqHGhJ3k0uQPw9YcewPuTI9njZJjPJbnHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH 3/3] iio: imu: adis16550: fix stack leak in trigger handler
Date: Thu,  9 Apr 2026 15:40:49 +0200
Message-ID: <2026040949-canopy-thirsty-362d@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040947-overhang-fax-02d0@gregkh>
References: <2026040947-overhang-fax-02d0@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=YYzVlUVOGB/cmDKJ90NTjs2SsXlsVdU9paeVy6inhao=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnX1yTmbdprsOfirT0GfiEtO85xt1j9z5rCXhccszb88 JxvTAyyHbEsDIJAWkyR5cs2nqP7Kw4pehnanoaZw8oEMoSBi1MAJnJsAcP8+m0Zs5c4GT5n3qzF Jbhqt+ryGWJmDAt27505M+j8Bc+WDKEJN6x/8F9dqsgJAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

adis16550_trigger_handler() declares the scan data array on the stack
without initializing it.  The memcpy() at the bottom fills only the
first 28 bytes (TEMP + 6 channels of GYRO/ACCEL data), and
iio_push_to_buffers_with_timestamp() writes the s64 timestamp at the
8-byte-aligned offset 32.  Bytes 28-31 remain uninitialized stack data
which leaks to userspace on ever trigger.

Fix this all by just zero-initializing the structure on the stack.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Fixes: e4570f4bb231 ("iio: imu: adis16550: align buffers for timestamp")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/adis16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index 1f2af506f4bd..75679612052f 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -836,7 +836,7 @@ static irqreturn_t adis16550_trigger_handler(int irq, void *p)
 	u16 dummy;
 	bool valid;
 	struct iio_poll_func *pf = p;
-	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8);
+	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8) = { };
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16550 *st = iio_priv(indio_dev);
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
-- 
2.53.0

