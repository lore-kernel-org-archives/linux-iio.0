Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B4400DE8;
	Thu, 17 Sep 2026 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679633; cv=none; b=pBh8VIcINzBZYhoVjLOsR6B5VnmluFdzf2H1e8eCRuzHtVwLmSKEftuBsHOorkUjJOSIzO8UkPQnT5d6ZwmxTkqjvZSN0THvLg5c+X2TNgisk062j1SSikOFGwodB/5hp+qOKq3n7dIr1G1gFKEpO2dAMX9l96IoncXnUnMSiIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679633; c=relaxed/simple;
	bh=P2A5tcaIS5uPSWM4FtraX6oZ5yGNkRrTv9+BNNprbhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BGxY0AK/nVSw9JG4RIyt8S2fiIpI7f/FEeWw6UZwWbSDSUI9rEIw/rClb1qLZez1yzyD4QBwxyPL+LrEbzObDYbwzpW+8jW+zQ0ZFWD13PHKpDynExaS9EGkwiK6sKxd5RRXG31cS5FQ3nUMlgBmjAyGrhaW3tmPSvjsQ7NhZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9KbJ4nD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9KbJ4nD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D55B1F000FF;
	Thu, 17 Sep 2026 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679632;
	bh=m+BEMs2HFo+/zsf4xP9dM4nfNiKPqrhoMv0PWeCQqPw=;
	h=From:To:Cc:Subject:Date;
	b=E9KbJ4nDX3jPlBY+RnMPYuqDTauVIrm3JmE/qSKGSOk4mixjL9SFHmJxVZkSwXt4F
	 QLC+1dDs316IcLtleyQ67pE7cTM3LUYiOqYkCaYs928wIxUMH21y+sra+u7yht8ftj
	 3ZBVp1Zf7hdLeBS2XncBiY87zBUE2QErOqyz1nwwyBVcfeW4iv+I/zyE/YP67WDeL4
	 yYkgwg0eyEgvtLaxol/VwzkbBIxyJ7itx9B2gMPu83btiNq7bvAd5G/VRqntVfiNxq
	 MWonT1HFpakUDAPU2VzKAD5JTYJX1Vk0ThlS6hm55LBH2sG7LXeyv6e8kv4cUV8RjP
	 L38K2EbYp2ezA==
From: Kees Cook <kees@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: Allocate ext_channels with ARRAY_SIZE()
Date: Thu, 17 Sep 2026 14:13:51 -0700
Message-Id: <20260917211350.i.934-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=kees@kernel.org; h=from:subject:message-id; bh=sFcwuAATgIAD4dn5uC9YDgu9qRYonw+OXygz5aGIfp8=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIvi2FDL8MjuS+uZx0LUT6R76IY9KkpJfhTYrn+gVe 2v8Uf9hRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQiOhj+l3sHVJWdERF8kKd4 2HSz1uOIXemzlLjckr78U0x4fVImmpGhY2Ps15lKGjPUi4R1zx2dHnS27tUD9/+hWVZJbAkMDEc 5AQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

This is allocating a copy of magn_channels, which is an array of struct
iio_chan_spec, but the size was taken from the whole array, which would
make the allocation type a pointer to the array rather than the
"struct iio_chan_spec *" being assigned. Allocate ARRAY_SIZE-many
entries instead. The resulting allocation size is the same.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: <linux-iio@vger.kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index d6a1eeb151ca..cbc47fa5b101 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -766,8 +766,8 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 			IIO_CHAN_SOFT_TIMESTAMP(3),
 		};
 
-		ext_channels = devm_kzalloc(hw->dev, sizeof(magn_channels),
-					    GFP_KERNEL);
+		ext_channels = devm_kcalloc(hw->dev, ARRAY_SIZE(magn_channels),
+					    sizeof(*ext_channels), GFP_KERNEL);
 		if (!ext_channels)
 			return NULL;
 
-- 
2.34.1

