Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794224347;
	b=xysNBLLh2+4xMNm9lyBmFDjHS0HBfiOaKIYM5Vh10W/JaPPk1VG8RL06oFe3qQsL5WQ2
	 7MxaMBxkU9DlTSXlUTVCy7oVauunL/3SGe99UbNp08MGJhRXheswuJ6KgXgpqaS8LRfod
	 pDdfs6eibQAMxkhswjvODk5NHKMZJ1ZRD2O5/AivY+O3VAIDOv+1VjcpHQRsq397WEckw
	 sWOn622eKz1uxAUC0W8jc3cjKiJ/1HsVLB6pGn6ZOoXookpriQZxQIz/CTAPBEEZLIgpn
	 zdxIH+nUZmWsl0ooIPqYr6stwdroypwUIUDhEXxOavd7pHhOQGEZKH9hwwMlDe7eYaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224347;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sGURusLgWX86zeWwlkvJEoTgmEXteujAKyrxsu0OODc=;
	b=rUSxAQ7UF7f+9OUZYcOvIo53dZPxT6/WrJ6IzzXeM++FrtiSR/2Hd94iLaBak/H0FutN
	 PCkUYwhc4VNYSsErJqFxIpeLGSzsr6OYWPMUVQkleE/XvBAtJVRgC3Uzzn9EGnaIkE+nP
	 8TraVIVz/p8WUKIX+nrNxNIVQm8IiTBokAaVXC0A9V37oxQ82HpEbsP20dq9MWqXWBE5b
	 sKxnY0vni7FMThbMyYc90GywFiW31ymqjagfhwO0jIySxd8haHhTQoFK+TjDLWhyI2KxV
	 kuefEsYH+TiddUXLw9Y75lhqLO4tRYpwpj4zAmU+d7u6RXx6DDgsvh2MXzz7iMBlUYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wm9qB9Q9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D1606A325;
	Mon,  9 Nov 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wm9qB9Q9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794224346;
	b=tlF6/7yFWJEfzjjWmNiEQyzeX5MoW1LMYyLYX1a9+CnGCg11rXJtO3b2iGGVfoXEkuJT
	 aakbyBzW56qtPVQA6J66rvc3Lb9+qZViMm5PfJ1QGWqDZPtk3Zt0Q6wMJ31npCg3IoGRQ
	 vtvgT88uww9bQnVJi4msNr2Kfa7pf0nVrbGTV+CVfhzEeAcjSukrpum3r6wCNrVG+xVSG
	 o6v1iBJMv4AcQxy+97QelXOqzQk4z6yTiExyE2jQXseQBLFxsB2D6mX20i85mI3tqz6bA
	 ovddAi2+Lxe/EyE81VKYqEKX3yDpUkHbN4SGHOSX+VlJJWD7Sefx63ViotTjRzrDUZw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794224346;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sGURusLgWX86zeWwlkvJEoTgmEXteujAKyrxsu0OODc=;
	b=XM63riUldckC8tM5NZorkr2o7iyqRAxvtu2i7wS9gHcOJ7XmbE+uBYZ7HCQUujf8c4cu
	 6GiaSOEy8G9Dptf9nQwVNBrJbsiPNwISz3D30q7EXJlv+5xmhJwIrOUQEMx9EBa3iLpQC
	 BzW9guMwdIlxuj8UWhRpUGe9G83lpLiqLEFw4KVHMM8yYO3sYUYhHYcwRuIG/Wxt4918F
	 fO9+wXmU8+w8dgX6Zm4Y8J9hwkCEOssmqBV53DzyQu5U2YyqxaFqV1L392CGbOhg5ZbW+
	 viggcGlP/BNKN+R6zUX6+WljSqr7vL1NJba8XLngN0y03Z42T99Y4Z6hcd745LIC+8A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 39BA81F008A1;
	Mon,  9 Nov 2026 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224346;
	bh=sGURusLgWX86zeWwlkvJEoTgmEXteujAKyrxsu0OODc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Wm9qB9Q9JCG/TcTKLuZQCZCxr9FuMqLKUSJ6DGXo71qu4gNhFkPGqwxaV0uzzdG/5
	 HZzeneNv8ZctOCzpeIERJxBMBw8s9clHDGCaBlSvN2QhBLab4UA2U/7Ekls8GMzDpE
	 N5oE4q7AiYd5eml6vqYdX/87DVdGGjUCB7mXAQVYdJ6yZ4RApJyBOBotuQaC1Meuv0
	 /4qnuXSkjJAo76Qzo8O8lqarhFg9AMx064oOeg1tjd+DkUYLcDlg2quY49SOb6In21
	 NTwvvuabCxydJJmYHIywvDSOh+NMXHa0reb4PY1hMRL4wTUrcOfbbLH6Go/HTMSN47
	 TfznoUV24JIfA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A326F483E2;
	Mon,  9 Nov 2026 11:39:04 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 11:39:02 +0000
Subject: [PATCH 1/2] iio: light: adux1020: fix interrupt clear value on
 SMBus-only adapters
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
Message-Id: <20261109-adux1020-measure-fixes-v1-1-fe1ba63f28bc@gmail.com>
References: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
In-Reply-To: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794224343; l=1379;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=r0ZSbO/Ld4MVFSPmXF2iaVAjnoCBKisOgRdgkZhMCRw=;
 b=Lv77MYIhtCIDIjnpPc9VCu9My+u0Qn91R1RGUysL3NaIsmiXtHiDCQ42UFSCBZ2Ncph52XTl0
 1EgtEa/iXfOC5Ef15NlRhdop9O8WTPmIbbIYcj7wNb3HZyOIXszNGUs
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

adux1020_measure() clears the mode interrupt by writing the inverted
interrupt enable mask to INT_STATUS. The mask is a u16, but integer
promotion makes ~0x00f0 evaluate to 0xffffff0f, which does not fit in
the 16-bit register.

On adapters supporting plain I2C, regmap formats the value with
put_unaligned_be16() and silently truncates it to 0xff0f. On adapters
that only support SMBus word transfers, regmap_smbus_word_write_swapped()
rejects values above 0xffff with -EINVAL, so every proximity read fails.

Mask the value to 16 bits so that SMBus-only adapters send the same
0xff0f that has always been written on plain I2C adapters.

Fixes: 356543545576 ("iio: light: Add support for ADUX1020 sensor")
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/iio/light/adux1020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index d4281b9754c3..cccd509dd18a 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -346,7 +346,7 @@ static int adux1020_measure(struct adux1020_data *data,
 
 	/* Clear mode interrupt */
 	ret = regmap_write(data->regmap, ADUX1020_REG_INT_STATUS,
-			   (~adux1020_modes[mode].int_en));
+			   ~adux1020_modes[mode].int_en & 0xffff);
 	if (ret < 0)
 		return ret;
 

-- 
2.56.0


