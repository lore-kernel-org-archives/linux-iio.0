Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117982;
	b=HSBIhF+ifo+NUuiBcrNWknreg4DqrtzL+CmZz3NRXLG9N/t+Sf6gK+0XlEyo49HYOVfH
	 vBxAhGQfjp42Bom+hNg2ahfKl34AbgMHG5y3KjG+Jtuvdqh2jFU31J2VPR5COT8KpcPSi
	 6/6WezinQBNExjBKhjU7dxD8q43pW2+qX38Tld4IKacrWzL50DwEtJKAb3FhtibYuvBcW
	 QWVHTM09jDanuocC6cPhwyln/4w1jSTED21pXa+VJNfDyUlOvEPWUfskFsdIkb2hA85nN
	 Aq0GdYvU/fG+OeZbEdfu5y/dE+m9ZW2UGDpiMvTmyLcXEusoqWlk6jXkkX3bEokFDkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117982;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FGOpxVJ9RRidwBz7Yv+w2MkAdL2TMaexvtlQxqDJBOg=;
	b=JF8f32oXQzYInMLNfsoHi/eJq73H5KySMwEcPideYI38I88G1X2kPeJR3bmp/C6w8obv
	 fWjf8gKUxEzNokwS2BipqZRfzgWm2G/GEx8VgWNg7L3RqOoz2zSNhTXk1yETxy0iVn6ii
	 EGtFzGiL0QNsa3veNAmYq+MonCmAHcxwm2O6jS0qWRaO1cXn+cn2t3J4YLEP/5gH3MzHd
	 nR4+QLfvquaJYoM00TTrZBVJ2ebVVryNi+YpmBEaRrRWL/crDNJ36jiC4TnTr+H5O1lA6
	 KFo0Kt04I29Dpx+OyXuyxFb33h8LuZUno3jrs1uFQ5Rv/UrsAg10m51zvupYWhsYqiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=obZeyWA9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151160A3811;
	Tue, 27 Oct 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=obZeyWA9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60B81F031E9;
	Tue, 27 Oct 2026 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117982;
	bh=FGOpxVJ9RRidwBz7Yv+w2MkAdL2TMaexvtlQxqDJBOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=obZeyWA9oz31l93t6vZac7rOBclrGgzZHYgGFd2bsx8u5n+C65a/itvnHlfUGNBRK
	 JhGvznCA6MzxS7FF1B6+wVltPw26uhCVfabTR9UH39Dw7kAKnGC2TYFEi4nPlwDwhd
	 6gWQGmbLM3pvB4ftFvrscahREVNSKX3XuWXpo/hY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:13 +0100
Subject: [PATCH 09/15] iio: light: tsl2591: don't divide by zero in the
 dark
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
Message-Id: <20261027-llm-char-misc-iio-v1-9-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matheus Silveira <matheus.feitosa@usp.br>, 
 Lucas Rabaquim <lucas.rabaquim@usp.br>, 
 Stepan Ionichev <sozdayvek@gmail.com>, Joe Sandom <joe.g.sandom@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=r8OrFpcgk00QR3ndaiB6BKAMDXbk6NbeLfV/2IYCBWE=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjPtZZ/mVS5vOMVH+YUpV6vr8o8vWAr3/1lmvEFQ6
 E7yw/2/O2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiitsYFkwN/l4vserG27kG
 B5dpzZcUKr6k945hwdyn4jX2spNLJrWG/JJbKFBlqXBlHgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

The computation of the illuminance divides by the count of channel 0.
That is the channel which sees the whole spectrum: in complete darkness it
reads zero, and reading in_illuminance_input divides by zero.  Depending
on the architecture this is an oops, a warning with a backtrace, or goes
unnoticed.

Report 0 lux in that case.

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Cc: stable <stable@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Matheus Silveira <matheus.feitosa@usp.br>
Cc: Lucas Rabaquim <lucas.rabaquim@usp.br>
Cc: Stepan Ionichev <sozdayvek@gmail.com>
Cc: Joe Sandom <joe.g.sandom@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/tsl2591.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index ef3ed9635a1e..286dc09e170f 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -416,6 +416,13 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 
 		dev_dbg(&client->dev, "Counts Per Lux: %d\n", counts_per_lux);
 
+		/* No light at all: the formula below divides by als_ch0 */
+		if (!als_ch0) {
+			*val = 0;
+			*val2 = 0;
+			break;
+		}
+
 		/* Calculate lux value */
 		lux = ((als_ch0 - als_ch1) *
 		       (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;

-- 
2.56.0

