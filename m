Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117977;
	b=xMDEpbtjUQFbX8OGsFzEPVp+hBQNGdlZKsFm1kzl0Rpz0NTx9wGZW2ChH8trC2YdXanL
	 O4IUy9GUFtTI4KjmEklbQZ6wSqYQL8SUrfBcsQkwlfXHOZxF/7uucnAHWK1jZceCFgr3x
	 Y+R7JUSk1nFrIayB0arf3A+xRkZSAkUyKJ1qD8c54FBG1QiXJ64BhiHdPCIejRjcyFU8s
	 dqb+GR7LQszQn3a2HZZunOoxV6NwGXQgv5vNqrt0nyWfnVk7UzH3YxK8oEzr1EUGcTNYg
	 T2wEH7IxJdBlX4FmAf+11rbsUwLNYyeUXt3B1ccKTQyed74AEwjMZZMND4GHeEodpIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117977;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Gf4KcARZ5v8UebLD5/MNZ9swaqhOwOySwmr80WCwNzo=;
	b=vBnzus8UVNd/Z4j15JO0PsxNjIC+BBpNOFABmU0KPCADmzsIr8GGmN8KPVpnBiOehXiq
	 hlGB1IHk74rnUb5V6gHi1JFjA2NG7cSX7EUqgbehW64oWkeYIbGQA1NxEX9HoFNJIQHAl
	 5q8T5Bse041dtWYbFPyOWsh1U6JB/6wl7PIOodgG8MWR93WxjfWJXhoUdUyXRBcNDCNff
	 XD8qr7yMQbAbJGUQlL9K0otqzwYY0It8xTv8nL+7vnRqUHJkQguD6zkE4BNfvIlhjHyTt
	 ZmOO3ZPzljoQPQZNP5QfuoU1CgjpmOAtLGhGEFgwWeXvMyLJaHkWQZrbm03XXUSRorg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BOlD+nDJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859960A260C;
	Tue, 27 Oct 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BOlD+nDJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2876C1F031E5;
	Tue, 27 Oct 2026 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117976;
	bh=Gf4KcARZ5v8UebLD5/MNZ9swaqhOwOySwmr80WCwNzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BOlD+nDJ1MnbyDwAs3OzMki65LyfiPgu0WtRc3WNIjdjULa6pb3hTBIFd7oR/dUhd
	 37DpX6R0742t+IT479zSG3hh0WFhVqU1h+OhX2iFYtFK4PC2z4JNS2C88KFBY1wjQ8
	 v3O4DkjfYCYcI2juTYF8mmth38olvRhLTaBDPBUo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:11 +0100
Subject: [PATCH 07/15] iio: addac: ad74413r: fix the values of set_multiple
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-7-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Cosmin Tanislav <demonsingur@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=dh+tocuqZuPc9+UB1vOrVtPhUC+YsDn3wPuJnuiYcTk=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjMlsCv8ftO2yjpAWr6gQ26zV0OJ1LXmcDmXI1ZM0
 py5u507YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCJS/xkW7Nv0XCyHKUXiQoNk
 ssI3ph3XXULZGebwM25dfkrl6Kcrwmb9LItyjn/QreIDAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

ad74413r_gpio_set_multiple() walks over the lines in the mask and looks up
the new value of each with

	if (*bits & offset)

offset is the number of the line, not a bit mask.  Line 0 is always driven
low, line 1 gets the value meant for line 0, line 2 the one meant for line
1, and line 3 is driven high if either of these two is.

Test the bit which belongs to the line.

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Cc: stable <stable@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Cosmin Tanislav <demonsingur@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 2e5a58e48a89..20db890d958b 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -312,7 +312,7 @@ static int ad74413r_gpio_set_multiple(struct gpio_chip *chip,
 			return ret;
 
 		real_mask |= BIT(real_offset);
-		if (*bits & offset)
+		if (test_bit(offset, bits))
 			real_bits |= BIT(real_offset);
 	}
 

-- 
2.56.0

