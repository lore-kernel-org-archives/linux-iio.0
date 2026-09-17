Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786EC4F7CA6;
	Thu, 17 Sep 2026 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679680; cv=none; b=AjWjyAGJpCByMuHuoagza1dmvOiamEEDl2KEjAHcIgjbviZZK0ISTeS9c+6goWP8XKah6jJt2xFoiVQngrbUkLqOTwXgr4VGilQ1D1VkWvQ/h2LgxhErFcfy4qfW/nAFTt6T1r4oYRuyDW035tqgpDj2QbmmYZzL/Tpd6gxLikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679680; c=relaxed/simple;
	bh=q0SEPBWeK3nIxwF0bKwGntwoPbUAhRXD9/HBLCwNE/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K1as5d7acKKex7kNNb+WTgS6WHWR06v5/WlmysVzHsiljXQDTxQN9Vx76TJug1IVmWHl4mJyAQ1/cfxPenW3mc8RGhOi9byQ+FzP2mNExnim6cQbXHRc9OJAxbxXdTaIE0Q1WtPDlYkmpb/F2LUcBpeY/dqv/65NcQ74pn6L56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul6NCAls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul6NCAls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C30B1F00893;
	Thu, 17 Sep 2026 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679679;
	bh=cBLyprx6LZPv/E+fX6K46YxitxV+tYfebQEvhO11c5I=;
	h=From:To:Cc:Subject:Date;
	b=Ul6NCAlsTdgBH5wB+f72RH+uUX3Av/PJO/ulQqXo+j0LPY8Q0UIMX8lWCjGY0EXXu
	 6rw/ssKDI78MU7MgZjZgEtkO5sji+gRi1a6Nkc3IBw0MzqYsFFJzCgHtz1XSydiZjR
	 na9nrbugpIizd/1SxFl+NTUpDLeUQrE4ZLCTpcz/rkIxPRacbx1qOJYsztgGYXohum
	 M7CuIJLDrfVX7IAZvUIrY+GRwQgIkQdxrqD/r2AMDN48LzzXPC4IlsBKI/7JEZH9Ec
	 Nm1/2aeThh9PZBoK6u58pyUCnsBnEpilTKe/skFJmQgUVg7pm5GeEM24ZyenYezuVa
	 VBRWTtz+3cnIw==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iio: adc: ad7173: Remove const from chan_arr allocation type
Date: Thu, 17 Sep 2026 14:14:37 -0700
Message-Id: <20260917211436.i.689-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=kees@kernel.org; h=from:subject:message-id; bh=h2t5ueYqEhTDnoT0Pe0hmw4lG+a3B9kD/dC4Z1eaLwY=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrImy3tOz23Wul9TrBPLfgteWkGwlaOupH/2Uq+LmId E2tPNrTUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJEXgowMV203RQf5/35Ruz7k TsUzPu5J/j7mKkedXs5/FlDP4BJtyPDf7bvehMOhvhuapRTX5Vo7Pey7L6Ck78EtZdPLFxrP48o BAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "struct iio_chan_spec *", but the converted
allocation type would be "const struct iio_chan_spec *", as the size was
taken from "*indio_dev->channels", and "indio_dev->channels" points to
const. As there is no general way to remove const qualifiers, take the
size from the assignment target instead. No change in allocation size
results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/iio/adc/ad7173.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: <linux@analog.com>
Cc: <linux-iio@vger.kernel.org>
---
 drivers/iio/adc/ad7173.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index eb47175a0528..fdd24f3ec1de 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1801,7 +1801,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	indio_dev->num_channels = num_channels;
 	st->num_channels = num_channels;
 
-	chan_arr = devm_kcalloc(dev, sizeof(*indio_dev->channels),
+	chan_arr = devm_kcalloc(dev, sizeof(*chan_arr),
 				st->num_channels, GFP_KERNEL);
 	if (!chan_arr)
 		return -ENOMEM;
-- 
2.34.1

