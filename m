Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC7457E67;
	Fri, 18 Sep 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748408; cv=none; b=mxu0IVjApPYBBqNp48Klyug7a6E9zSF9FLrEvwHz2HZztPRvwH4mw3ynwna6Wc/oRfhYDUIV3o7eH4jqSZVlYx0ndEED0UVBcTcjHZIRiAxCKrkZ9XV2Ap3OKRT5AKslcMOq59vAUqMpNrshcDdrKkKnz2bnVgOacLvmFSmuOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748408; c=relaxed/simple;
	bh=ZiovcvRhT3At9RG8JUrJeV4aCFPYrSk1pYo9vrQdCvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6nR3BdROmJWqvEg9YL9Dvk4B7eQZMrOau8iJV7U6NRGAzdccjQBNkjXh+0wBTMIZ6r/cERF09U4h8HWu4o7Q/augSkMhKRc2LZWfzGf47C6CD7Y1IpYBv7UgakjD/z3ZEZAMlS5VT+Obln/1VpiViQ/9s7g3/393Yx0l/gIVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from iv-work.smb.basealt.ru (unknown [193.43.9.250])
	(Authenticated sender: iv)
	by air.basealt.ru (Postfix) with ESMTPSA id BF5CA23399;
	Fri, 18 Sep 2026 19:13:25 +0300 (MSK)
From: "Ivan A. Melnikov" <iv@altlinux.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Ivan A. Melnikov" <iv@altlinux.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Francesco Lavra <flavra@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: tools: Use proper macro to detect _Float16 support
Date: Fri, 18 Sep 2026 20:13:02 +0400
Message-ID: <20260918161305.1161852-1-iv@altlinux.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__FLT16_MAX__ is an internal compiler macro. GCC defines it if
_Float16 is supported by the target in general, but the support
may depend on the exact target options. For example, on i586
without -msse2 I get the following error from GCC15:

  iio_generic_buffer.c: In function 'print2byte':
  iio_generic_buffer.c:141:17: error: invalid conversion from type '_Float16' without option '-msse2'
    141 |                 printf("%05f ", ((float)converter.f + info->offset) * info->scale);
        |                 ^~~~~~

To fix that, use the public macro without double underscores.

Fixes: cdd445d4b2a9 ("iio: tools: Add support for floating-point types in buffer scan elements")
Signed-off-by: Ivan A. Melnikov <iv@altlinux.org>
---
 tools/iio/iio_generic_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 000193612aad..9ea93984e0e9 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -131,7 +131,7 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
 		printf("%05f ", ((float)input + info->offset) * info->scale);
 		break;
 	case 'f': {
-#if defined(__FLT16_MAX__)
+#if defined(FLT16_MAX)
 		union {
 			uint16_t u;
 			_Float16 f;
-- 
2.50.1

