Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793788107;
	b=3zRze3e3ey6ugFp1HZHBYy4NS+Ul7WuGUkWGtG0FU4pb3pJ9HTBVc22MmYmDdHThB++A
	 zqrIctIY5CT1gl2Ftaend6s5uqSXeXmPKvjqfpyyHbJAroSDOEKsoaa2DnzZ1VKy6bXKK
	 HKJWFXxwuuuRtPWROVOnHMF7a7zkHMc0pgwdyLcUiqRzvKTZjVMNrxMpTDev9mP8Bn5r5
	 j0Rkbjpw5G+sdrDle4TdgeBYfmDOr5IQo6FhSC728pCF7uNaBwxeBzjh0oVuevfdROp7/
	 whwsnnVWDilc/fZXVMaTtm7Wv1MkokAzY9ohmnhOK/G8uD3EpCG4zIuW44nfHBXE07Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788107;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LLeYIGEM1LvlGypEmHJ5K72laj/fRggqINnoHOCWiUU=;
	b=K24xDZ8gT0ZpUTAOcN3kvRCA9+z1IivHEoYU69cX2jQgSziSmlEhYsqebcvEJQ/MU9vf
	 woy4Cx1zCpKofYKL5vB+OiEJuoCfmmsUJoSHeG5gjFSqqLXiWW/U3lL3LQf/W+uXxHl4L
	 4BVrf8M8+Vh/PMDs/86FtgsMUl2SGJvStnp2wTkT/BlDDWh8BQMMuZLnikcI2OtR5Q5up
	 Xv5oPOTDGEG/iGWPU4tEUpM7QLPbKbu8YcXkR6RoRbgf6aUigWk9Om34bn57rMeBWahZj
	 NXlPGM+tmhLqMlAUvJudTbE1AtN4AbnwbrJNADEx8RQbAhsdyEG39CwkKYQOcDOmwQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgGBNkEU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702D606A32C;
	Wed,  4 Nov 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgGBNkEU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793788106;
	b=3AhJO6ZCR12aHKYFPzkZnPYNCW7fSmd25eA4Aye+zA58qZqsJpCy1iUgkT7IjT2ZuDJv
	 QHbmJIPg7OzC/N9zWzKucHrbYsnO3R6qZbtGsysr8/bdfETAsvtjH9A+suCzao7MBNTcb
	 RfwngBtor9EodbH1+cGuYW9KOsa+kTrEfyyQqflIZ7WDQqwNE2Dz7eLZPdwVPZxHVaQGK
	 emYKjd8bXVjc/gM0n+0dUp8srda5OuGZW5QxfbzR3BFacGw9OyIflSJc2ihI8QOCruFy6
	 EFWvcEhYmhlkQpqYA5iJMeipKGSOnct0vfrU4nGjBi1uPTGxEFw+d0hSvfsURCr4lYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793788106;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LLeYIGEM1LvlGypEmHJ5K72laj/fRggqINnoHOCWiUU=;
	b=jbc47dQ1FrEHXlxhcQvriwZ/lENLfqrF8sEl+qJPTIhdoYwU8PEL4IAexcPKymeeA8GQ
	 W4VXxmyaNJLJ/TEpe05SzoOiswPrf8eBHlRt9JzVscbZHkxzNiaWvJxM6ZkY6q0BEftKM
	 LfnoG2SLKOJ5gQJvV8Nlsq2lkjq9JKLR7qk4Z0EVrEh8k4vo5mIKtr9lRkePRRNi4aOpJ
	 sups7ge6f9mRWYt73i1S0lsj8gSExeUvo0t7Vsx6wnu4GNaYO31RrkNNCn+sU7pLmto8f
	 OVN8xIGwfK6+aFswaOJD/R14mS13dX+JZSL2drJzgYnzEcZQmeFyULBq/+VlVTccvUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 27FF71F000C1;
	Wed,  4 Nov 2026 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793788106;
	bh=LLeYIGEM1LvlGypEmHJ5K72laj/fRggqINnoHOCWiUU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=UgGBNkEU2DHtMbFY2OhEEkgpwjAwLqxTDynbu0FHJzenuuXHbRGjjGdXNRbBg8/si
	 E2QMN7LJgzvlI1a+yyzxwCfZ0Iy5AB/HgCcdODJm0k7tFtsTIVH4Bkhobfg62lGYq9
	 ISKEmEnYRvqijKtmD/5YNs14eZyWTWcC9sSQ/IqVep+EivjiKSmyGps28XN8ocmfBq
	 e/pW8sKjGNeVXTACAnW4WrNN9fV7kaqzLkpdodtM0BC3cfu3vbMwr4cQxvQU2HHI/o
	 4denZae5EFkboJ5YaNxNnUz5q4X8xKcAJ2rDdqfgwX/oK0gHnw3MahFHTC68mstUsM
	 +BNY/GTfvakPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 97EE346DB2;
	Wed,  4 Nov 2026 10:28:25 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Wed, 04 Nov 2026 10:28:22 +0000
Subject: [PATCH] iio: light: adux1020: harden sampling frequency table
 lookup
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-adux1020-rate-bounds-v1-1-2db71ad2cc21@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMAyA4VeRnBdI6ihsrzJ2qDbdskMdjRVBf
 HfrdvwO/7+BSVExuHcbFFnUdMoNfOlgfIf8EtTYDI6cZ6YrhlhXJkdYwiw4TDVHQ8/Sp3TzQqm
 Hln6LJF1/28fzb6vDR8b5fMG+H6oMYnl4AAAA
X-Change-ID: 20261104-adux1020-rate-bounds-61e3ff96e0f3
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793788105; l=1810;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=cqE5CwXxkaaFLmmwvn2ph1c33wcfTad0JYMx5iByIGE=;
 b=HsWSTDAh+Bqk5NAHtkm9e0sJLQeq4gRYJlTkT2QJ2TcqrrvK28afb3e5qZY1ydY360J4nNLGR
 q8mKXJR+bnDDJdhmnRE2xFLGHP0mEn/Srx/n4zGYFyM0sPumlE5GhYM
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

The proximity frequency field read from the FREQUENCY register is four
bits wide, so it can hold values from 0 to 15, but adux1020_rates[] only
has 14 entries. The driver never programs values 14 or 15, but if a
misbehaving device reports one of them, reading the sampling frequency
indexes past the end of the table and returns garbage.

Reject such values with -EINVAL instead of indexing past the end of
the table.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
Found with LLM-assisted static analysis of drivers/iio, looking for
table lookups indexed by unchecked register fields; the fix was drafted
with the same assistant and reviewed and tested by me.

Tested on arm64 QEMU with i2c-stub and CONFIG_UBSAN_BOUNDS=y. After
setting the frequency field in FREQUENCY (0x40) to 14, reading
in_proximity_sampling_frequency:
- before: two array-index-out-of-bounds reports, and the attribute
  reads 0.025000
- after: the read fails with -EINVAL and no report is printed
---
 drivers/iio/light/adux1020.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 0ea282ecc99a..d4281b9754c3 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -414,6 +414,10 @@ static int adux1020_read_raw(struct iio_dev *indio_dev,
 				goto fail;
 
 			regval = FIELD_GET(ADUX1020_PROX_FREQ_MASK, regval);
+			if (regval >= ARRAY_SIZE(adux1020_rates)) {
+				ret = -EINVAL;
+				goto fail;
+			}
 
 			*val = adux1020_rates[regval][0];
 			*val2 = adux1020_rates[regval][1];

---
base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
change-id: 20261104-adux1020-rate-bounds-61e3ff96e0f3

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


