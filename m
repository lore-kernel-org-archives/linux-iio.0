Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A3C8F0;
	Sun,  1 Mar 2026 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328293; cv=none; b=Uu7YC3zvJMjwc6mZUFq9561RsLV9es2pqvKw6ZcGkfMxB2NBkwT10SUGtboHMomUTh2njclZXyNeEgBWQvyOgBTlMHxl4zNN3KrVwrExTVtsuOC8aYPtw0rNhfm2RugL8PhaeGW141YaqpqsAce5lxcK2iSssjydLQvzFa88B9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328293; c=relaxed/simple;
	bh=gIBuM8xa7/3gO2Ejm6BuYAW0duRVNl2UN2laHkXY3Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe8qHwLEfgWX+Olky1m/p7Wb/yEtqWvtyeoS+4DNWnNLAJOpp+quf5JekA5KeGgFPxyTrMoAqQx8O6i6NDP14ihFzCX2ViRjH/F7ULvzcn0t0DywfbxiQ9bR9LAj4mvPfqE3oMnIpJ7sS3aXQBXFttJf+0AcHEutkiwa9Q/RYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Quw6OLXH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Quw6OLXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2037C19421;
	Sun,  1 Mar 2026 01:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328293;
	bh=gIBuM8xa7/3gO2Ejm6BuYAW0duRVNl2UN2laHkXY3Uc=;
	h=From:To:Cc:Subject:Date:From;
	b=Quw6OLXHdoZekmpYJ/7kIl0ZFTSUS0ie8OdoXSgI82ag88wKqXTknHEjfabs0Z5yc
	 TSQcq1YnDc5c3AY0vVoTHRFWUUfuL2alJuGDbSnmg6pQYSG6QO34EhKQKQ2EslrybK
	 onVeXYZyK7QLRxG51JlhTl6atpI795fRukw3vubhq2ofU4HNboZkXpo3UJTcoZMB0M
	 0FA3bJJbLrDJAQdLi2G09SFMhuZaWZV7o5y56lWXB9bfnBfMnqHr8boSArVA4etOD7
	 nGkCL28EUPLZ7GYVAZtfFAM6wa7NifNg43wsjj2lILjw/Q6e0qM14QZB6+10z2GvPf
	 8uczjpbS3/Iow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	antoniu.miclaus@analog.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Subject: FAILED: Patch "iio: gyro: itg3200: Fix unchecked return value in read_raw" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:51 -0500
Message-ID: <20260301012451.1681808-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b79b24f578cdb2d657db23e5fafe82c7e6a36b72 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Thu, 29 Jan 2026 17:01:45 +0200
Subject: [PATCH] iio: gyro: itg3200: Fix unchecked return value in read_raw

The return value from itg3200_read_reg_s16() is stored in ret but
never checked. The function unconditionally returns IIO_VAL_INT,
ignoring potential I2C read failures. This causes garbage data to
be returned to userspace when the read fails, with no error reported.

Add proper error checking to propagate the failure to callers.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/itg3200_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index cd8a2dae56cd9..bfe95ec1abda9 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -93,6 +93,8 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		reg = (u8)chan->address;
 		ret = itg3200_read_reg_s16(indio_dev, reg, val);
+		if (ret)
+			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-- 
2.51.0




