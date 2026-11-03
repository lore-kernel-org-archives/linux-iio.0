Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793695376;
	b=2jW1ymaz2iKgghs2zHJKHclakEjsmCOa9WTu/M80RWmhMoD2DoaZPvpmwt92uIYp4lPV
	 R3Ek12DtkPyxwreN6xJz+lzTmY8FFXTLjm+VjLUmoawg7jHxk/S8tYIYGI+Y2hr5LEaOg
	 XZk/ZmInFaRb5/qCaFtmZuXftmMJRqwL6NPRd3bU7u7ySWiy71t49QdXvU0dN/c0FATlO
	 sczfxJtvz6Ufm+2xRwpOE8I9KG73HFt4KhrZk+z17I/dHKd8YjXnwnoo7xruyXxdDPb7f
	 AAZzTzoD5JacqON0PuTWQDiqt/Du6Kfb8t2XipAEH9rjNA6biryEtF5XjO/0Ciatxag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695376;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7sTZJyUq7mKy3Fxr6vaWDbX2Cxr/cZcHPJrauTyc4Rg=;
	b=gVEbZyquWuVISF2GDSUfX9tyyqbLIS2mvQXXdOtETS/XmueO1bU89c2KCtGLDQy+AHCy
	 M6v9dxvsFdWL1j4Cz2se0HHQzUwp2lZC4PXAqBfH/vmo0qHVq7HRks46pu/irlUu+2v2w
	 62dxRy9UOAu69dLm0mtZYDQAyEJ89/rhOLZl1XLNrLXNahbbqy40yeJBQ13sVwhhVl422
	 vCSsUXXV5KcTJzprzJdBpSRk8Fq8mJ3OxX1IsALFiPZWVypPr4QtpsYGgCWhk6v3n1z42
	 KRlkCuXN2jeE5EFGp5lJJJhS4FENxfxmXnzGEuo3+Z0Y5wVr+87E8LFthU2DfZBgMMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lGF/X43v";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A7606A95E;
	Tue,  3 Nov 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGF/X43v
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793695376;
	b=YP9qtoqnEOO6hg9ATuFdkxjAPUWE0s4JeeXNxAf7LJTaWyDjx/03DV0ekLKo0uVMs1wm
	 +l6h3rxuLDQr5LuTOvHRHidRnSF1kh7OIFWZHdOiWCJBKdTlPfvBHaC7z6YrCmzUl5nnI
	 /fIijRSDVHb/Oo0Cs+g1tJR8m0S84jLE3qV0LvMQvj7Zuk24dV9x+9o2viJPv4CR3w4mz
	 QPF8d8qkcRpQkwAxgTY1U4TFjqleH1vbcq4k/XCWV4Wmy6M08yjNxl5vSbhpJ+jcGgj/V
	 4MejlvZL6iYDwj+D8/Y7xtGelyT/VkziqIAjOJmDmnvcfQD1IKdxGdIVN09WP/NbW7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793695376;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7sTZJyUq7mKy3Fxr6vaWDbX2Cxr/cZcHPJrauTyc4Rg=;
	b=zqm+fu1NmfK4/ZOvc/u60ptfisD31GwyJEpv1+gt4sddJplDKK9NeYVSn8CyHutFTFKr
	 8Z75Yb2PKgbicnJjqh1/5G0hdgPvXwM6gFCaxE1Xq4cxTPaQABwdvNkBcy4lMIuTQ7/RW
	 38kv2NiDJXyVMC48R05gMQtaK5fOpytDP+dClXkN9v7/zto6Uesril9eMuJBDFtHmXHJt
	 drgcX0bYJeVU59X+vMEs3h3ay6QXTRFH+caF3JASnVouVFKKiGbAqPE9KBKbaC3HJ8YQN
	 nzDz934nN6SgJptcsBwU37d+rOs8Rhfdz0Xa6jblHHugf1ZV3amp+ZNL0O/utR6esgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6DF701F00919;
	Tue,  3 Nov 2026 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695376;
	bh=7sTZJyUq7mKy3Fxr6vaWDbX2Cxr/cZcHPJrauTyc4Rg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lGF/X43vZBVbt9XLJZB8PFxQd+f1nm/KTZKCY+1sD2PvsDYVJ3OnbsMYjXiJ+yE+N
	 4LDlq2kXDuXcXWCNZagmYlY+jdyKU2xF3YvEflb20YHgRokIIKM2mKLMpPHWIbF4f/
	 7QdymwbtBdMjOq1Nz2cZks661WP/69Iw1xEsy/ZJvCy3cQla4JPi7GbXPjBhbu163g
	 aGysZsOcPARbEQNuEgjQkhXqDwkycJDqcV5k4YtOm1Pzc+R8dFurvFCLvhITbWfNhT
	 E4HRjQG4Q9fhenm7bxxh97vF9ntn5WQfWfbSCGSioek6VzMhyi9ntK2jb8qjub1BhH
	 iiHXbfi8YeA+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E79BB4682A;
	Tue,  3 Nov 2026 08:42:54 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 08:42:48 +0000
Subject: [PATCH] iio: light: al3010: fix out-of-bounds read of the scale
 table
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
Message-Id: <20261103-al3010-scale-bounds-v1-1-6110c2ffe3b4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g0kKtb2KsXFzJjWFBnLRKUg3
 r2jXb7F/xuYJBWDe7FBklVNp5jBlwLC4OJLUPtsKKlsmKlCN1bEhBbcKOinJfaGVPv2xiKuvja
 Qy0+Sp37P66P72xb/ljAfK9j3H2ZFq3B3AAAA
X-Change-ID: 20261103-al3010-scale-bounds-04b891eea476
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Dmitry Osipenko <digetx@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793695374; l=1752;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=wBZCgtZERGB8XNugFlSt0efy2L/NU1X8KF6SrS/tjqs=;
 b=eOxXoHadO3NIfwDPw73bTr3xABL88fOLiUqxWGYFz/ReqKOrnjHjtblVW6gtg31s2IpM+nwcz
 i1LeJ+W1TRdC9gLAmx0fnlNmQXR3TYwujEkq6dsM0FmaZOsegLX14Mr
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

The gain field read from the CONFIG register is three bits wide, so it
can hold values from 0 to 7, but al3010_scales[] only has four entries.
If the register holds a gain value of 4 or more, reading the scale
attribute indexes past the end of the table and returns garbage.

Reject such values with -EINVAL instead of indexing past the end of
the table.

Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
Found with LLM-assisted static analysis of drivers/iio, looking for
table lookups indexed by unchecked register fields; the fix was drafted
with the same assistant and reviewed and tested by me.

Tested on arm64 QEMU with i2c-stub and CONFIG_UBSAN_BOUNDS=y. After
writing a gain value of 4 to CONFIG (0x10), reading
in_illuminance_scale:
- before: two array-index-out-of-bounds reports (al3010.c:137 and
  :138), and the attribute reads 0.000000
- after: the read fails with -EINVAL and no report is printed
---
 drivers/iio/light/al3010.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 49f6d8336dbe..481dad5097b9 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -134,6 +134,9 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		gain = FIELD_GET(AL3010_GAIN_MASK, gain);
+		if (gain >= ARRAY_SIZE(al3010_scales))
+			return -EINVAL;
+
 		*val = al3010_scales[gain][0];
 		*val2 = al3010_scales[gain][1];
 

---
base-commit: d1425b382b9cc5bd19223fad8ba4a8af3dbe1305
change-id: 20261103-al3010-scale-bounds-04b891eea476

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


