Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523223;
	b=aG/8XddLFia97XMKRfACyLwdPjPq6TkOu29Mvp9YFzPCxf997gpXVkYJubuyUZLNY0Dr
	 yyAdn/ZXEei+Xsp6wR1zQcZPg3zi61EPBsIOkesfr6UTaG9X49d8yHBTsUMSn717Vny0o
	 IW+xgcnNnBXKLDyvoLWz0wD6JBHjwImJ/noQqNrS/8SDMl/l/HmUra0EcNQZ2InmGp3bL
	 hGtE6X0U9Ezj8X8cwuan4cc4xkATlw19dxYerDlenSmsBwZ67gUo2n9edeAwjo+IKqRpx
	 /OjE19F6VUl2FszlaYNdheXrKmFuIeGMrcOgvD+62z6ge2fK9VvwLco34kiJc2mdsVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523223;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7iBsynOA997MaNK+FvhIcnEpmHFM1YPoFPEf5EtVI8Y=;
	b=1vk9XxHTENpk9htZq0H3MBXyf7YqbyWKBVJYd5GbncskOOP+eNPKmxqb44IYSxBPt954
	 ZcmO0C+NbbVoqLcwz0v6efs5bInFKQg7JCxROfi8aT01EBoIZTRj5ikRBAm7jD+NIW9Uc
	 iD/xE6uqFl4sLFkCcCmKna8navMirrXcahfx9rhZDMkDPDi77vm9nJUUcs22zwyZfxQwz
	 3ZSlgnfDQpO4eAkyHcWwh9uPPQRuUU5LKix1c4WetGahMMPh+X8JlM4cpeN6Gwljt3+kP
	 yZOkCQvd2YudsW/5kKbvvPAHXc+ceIJ8+dVNTNQY8NEbtlioZlUYx4R7VAFYW7Ngdaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=JnU8RBab;
	arc=none smtp.remote-ip=43.163.128.50
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069E606A31E
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 12:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2069E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=JnU8RBab
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795523212; bh=7iBsynOA997MaNK+FvhIcnEpmHFM1YPoFPEf5EtVI8Y=;
	h=From:To:Cc:Subject:Date;
	b=JnU8RBabbkYR6dtZfIfLWewuStzL/5t7yyFDr/hR7HWCeoY/9cHK3N3VtTnRR4ZYc
	 DKhju0Bc0pxjSXUMeLpHgB0QnDrSVHYJwRV9zqWSYSzfzWzFfKddWErNpp1T1zCElz
	 3tHB/d03pz/x8AikPZEUatR7AbfK5Szp/J8fl8jE=
Received: from runtugo-virtual-machine.localdomain ([220.200.110.148])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 6A40E444; Tue, 24 Nov 2026 20:26:36 +0800
X-QQ-mid: xmsmtpt1795523196t2ibrleao
Message-ID: <tencent_1EE4F65B31B1B056C2A8FD618D533F141407@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uy0nnMNyXTNpZTu7QEWMciOVnZAxLlJJWKpTXHrYl6LE+DN5Ugw
	 l1tPvRbD7ZNkApa9C2H4WntFJAKDxSXjUXk2EqL8pxwvW2qkWBb8ScEuDclxNA7jJK3BiaseU8v6
	 PHpLEFNESXBVTKhVcRlLf7zEjhjrZ8jOOX9EtKtybL8oCOvMtO3UNc5NIklCeoyhTemigsUd81Ih
	 Ag9xdaJmylbxbvDf5WEuz5KflEGwSqdI5EzRgMoJ3GOlFrN+XoYi3u5UWYjr4Oi6E+5CXoBbmW3i
	 uO5moQ8Y8Jo4Af7fAlb9UGHBjPOIc39fWnYzWCBp50Oo5OX8k9mX6uiPtXKfkUx8MregOqZYP8ex
	 5QLuh5flEVQT2frQQy1zON6uO9QF4zWBslQudS+1jvn1WffmRhHfWSFgeqB3WlA7dFJuH0lQMkMR
	 i0IbDxbv2Mcl1yoIgQl6HOyTWynBmDT46nfVIqKqwQqM33YhMME+NcSBwmPkQdZZqybY9Jbo6k0e
	 IuRfRd6GNmkptAN8roktcXlxsFiQK7o+3viV31Ie2eDFew9Q8iL2p7gWmdf3BByEqX7B1VbRKQse
	 7XV79jWTU5Zg/481O6oaA3h3jsO6iFeCOd+NQNdLvQJxz30ZcdfdastzfqRr83Lv+BEI6qbcbm6J
	 3gJ4i5EO5R25D8vMT8R5JXykW4HN6zHpJTwDnmsZfEprZEILElVR5FC+7mcRmBlTxhP/8ASMzuSq
	 86cCEVqJoh3LhkHR/BAt8DdckjkKY4QEPzHh46bRduHKvJ2+OQXmKidN2e0ZQTQYBKu5VThIJ72E
	 anr843+7UxLv6wq+xv/vY2nqTYfJ4dsCBKxMmtda1RpYKwEMbgeCKYmTjpUyblE3vhTBq+0xBMjr
	 CUsyFNg0Mf92O+4S95v1MkI0TiUO3EEZm/TdOqgAlS0ys77i707l6EljWPFJg/WWjypVXhTp3yXB
	 nJNqq+BchhsD3B/e5Uq9MITBfoMqrOZvkz6E5XiVm3ZPfY7V5g6BKT5nYeDS8xsObEwqkdqqwP4C
	 XWwhaSoiI6iRDacH3h
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: liu haojie <2669793217@qq.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	liu haojie <2669793217@qq.com>
Subject: [PATCH] iio: buffer: take the source timestamp offset from all active channels
Date: Tue, 24 Nov 2026 20:26:29 +0800
X-OQ-MSGID: <20261124122629.6239-1-2669793217@qq.com>
X-Mailer: git-send-email 2.34.1
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

When scan_timestamp is set, iio_buffer_update_demux() computes the source
offset of the timestamp from the end of the last channel that was copied.
If that channel is not the last active channel, the trailing unselected
channels are skipped by the demux but not by this calculation, so the
timestamp is read from the wrong place.

iio_compute_scan_bytes() lays out the raw scan as all active channels
followed by an aligned timestamp. Compute the timestamp source offset the
same way, by walking every active channel, so the demux matches the
layout the driver pushes.

Reproduced on an STM32MP157 board with an SPI IIO accelerometer/gyro
driver: with only the X acceleration channel and the timestamp enabled,
the timestamp read back from the buffer was padding and a repeated or
decreasing value. With the fix the timestamp is monotonic.

Signed-off-by: liu haojie <2669793217@qq.com>
---
 drivers/iio/industrialio-buffer.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4294101..a8a40d4 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1109,13 +1109,25 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 	}
 	/* Relies on scan_timestamp being last */
 	if (buffer->scan_timestamp) {
+		unsigned int src_loc = 0;
+		unsigned int si;
+
+		/* Skip unselected channels before the source timestamp. */
+		for_each_set_bit(si, indio_dev->active_scan_mask,
+				 iio_get_masklength(indio_dev)) {
+			ret = iio_storage_bytes_for_si(indio_dev, si);
+			if (ret < 0)
+				goto error_clear_mux_table;
+			src_loc = ALIGN(src_loc, ret) + ret;
+		}
+
 		ret = iio_storage_bytes_for_timestamp(indio_dev);
 		if (ret < 0)
 			goto error_clear_mux_table;
 
 		length = ret;
+		in_loc = ALIGN(src_loc, length);
 		out_loc = roundup(out_loc, length);
-		in_loc = roundup(in_loc, length);
 		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
 		if (ret)
 			goto error_clear_mux_table;
-- 
2.34.1

