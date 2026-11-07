Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050246;
	b=2yJaxshjbpVam39kOZCcmFC4IkESII2fWqSaG3fcXxCj2vOj0n2W96ZxBYHR97PXhEAa
	 qNd/AwFbLzgDi6cCy1MHAJv27PaPwzmIZkZap0UM8dQgol+vxkbGgrXu5kad0mBmGtV67
	 KKXfekmRcLpLWm4HXMkOATbU3IMvWE3BhW+DxDbQl4zaKZPk6QbYG+UnwxVZb8QX2n3X/
	 EmhVMH/GtMPEG57YWtLq6e2q/qCM8X24YOVpEcRBf5EA7M4ct2+E7i+foHDimRhRra7YE
	 rSxAycm9LktZ/4EMJrWizDlqMtyBbqQOUycK0IsNhcb5Je4yYq6fBELkeB2kzSEexLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pkGF7dkpGYtBI88D5ga5Ip1hipJc0zynNLG1qkQ2iRk=;
	b=3KtU1g9cdGz2poJE1V9Rfm/K1eM4vFk9ve23mlMF5SNf/DmBT3z0xAGLSz6NNF8yIJYE
	 hH3hoYXB1+sXixKP8WdZRWl4cQFpM85xaxwi+Ur1sXy9AI58Tzw/IUaTBM9MeR4oiqVZv
	 BgDO6SlMRpNaLpEoyYh8ggpeM6w2p7ATVoShXTI6s/b4/W8331jeWjhyIORH9XmvUQcx4
	 1pOMGc+VKaLO2nei3qcZggJpuqXgAn8fjllvEReywk8FmziLXqAz7wJ1ghZ+F8ZVSGQw8
	 8IIkt7M2BzpgNsZU+08DQyyyGuBDgYp/y9pSdwQxvDYMDGYluaHvrsoYygg6WtlE7gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E02Q3ZKo;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE8606A32C
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 11:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2CE8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E02Q3ZKo
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a315ed211so501293eec.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794050245; x=1794655045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkGF7dkpGYtBI88D5ga5Ip1hipJc0zynNLG1qkQ2iRk=;
        b=E02Q3ZKoMrebt/8vjpyH5PF9yIbkv/JfHGW3cxCNbqcxdCf4hFIJ6MMYnV3dIeO/+U
         PJUzpUpejBY+uK8gCaJFUBvaSWFu2dvr1jbutoFvY4NycwAcM3XKpoFsggGuy5FdwRgS
         HP3v+SmZtafinZy4Eo5Kb1nfGNmtJqkRfJaJuXs3WSvc5ot+iOdtmvEJtW7ecKcB46nR
         sj8DqeM1pahZk56NgtMHUxv5iOph5mJ/Pnry37fJdFqd4jbOlqvjGrIEqOXXCXT5RFzB
         QBqjeDFIpMxEhwdxvpWTM05MZC6L4F+Bhu6GWQDi0w9ejeP5l9aEc81PAr4wq1Idt9Z9
         TV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794050245; x=1794655045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pkGF7dkpGYtBI88D5ga5Ip1hipJc0zynNLG1qkQ2iRk=;
        b=rC8f8upZSlSwfxmw1qQSXJ0FPm6prEeApOFBUZ3Zu1BgozZu8qXP92AEeBtHUJ58pb
         ZLiYwt048n2emUyfFyVh4WTXpCjW2YpmZmX07/CT0nPNopTZhAEQ9su6GhaD8mmwBwvY
         36tmw/TkVQnvBt3ztqJ/VFOXfD0pdq18ASrAa6eSr/95AmF7GRCBBxxHTYAUlyMxSoLd
         ifzQhHDW/UiBifaIQxsGrnKhLrhj8luLzQVJ4uxUEfDpncF6dvrGCEvcu7P5/L28EW7g
         BitfjX5YEc02DF+pscBfzVhC3cLcF7lCrH+MMn7T/ER9mqWf/sPh9nNHDmrjvsEzDsCk
         otGA==
X-Forwarded-Encrypted: i=1; AL+hErF1cyuu0ys8m3oWP5LGg2p5BV3P5pQzvX4Qyynh6OhGI6mzcCIIDkUpSr4t0sonYwLsFnWM5panaLU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aNzzVwZU5+P3b3dT9ZySYRmpeOweNuNPDVp5RZnP0V8R0681g
	qaCZ9PQATH4NJv4YLerckigbXu2Xkh0HPUWJG6bJ1xj+CWetXfoVfOod
X-Gm-Gg: AYBFou3v7v0cNN+MVz8gaTPot8+s57CX2Sbh/Q49BgRd83nd2YD80/trealDxAcv7Lo
	cJqS3hG4UQfzAIPLA2XGemzJeBrTa5cYHvNqHQ5YfsZgzqOwsXqdNkhEeb0NYmIZPe6Qg3+kMdY
	jZ/JHFAPwb6zti9TUK/Lmg9cJA8PE+HFg9HgMcqx6MSmvfPymr9RNakcmWOSa+KAhQgCM77Xz/+
	rZ5su3vQ4cUhy7RhrqLSwpLFGKlFEahSQsL5C2ubDaBT3gYiJX7nbOcNRerHtu91kH62Q4I8Gpy
	9Qc6KSOnq6x2Ki/+ICSOwOSvf51E1RSY9X/VsHswa+kZlI96qRGuyb2Qg3nn84oqXAkqoeJJ0Yc
	99F5CsPB4hR5uWmILbs9+2ckupxauUsTj9kcKyyS6cwpDCo67ET3aNJad/3C96M/ARDeNiiiuIJ
	uy1BK5kItVqzUGt3zr4fYS2P3mmVrEsPIdfM9Zg3mekrY5HRKknlAtNVcfKEobAcqsmLqanryzM
	tJcS1PeYPCPHrHdo6pw3L/e7YCRHo9vmuxf8GOHHf5undd7Udp5XxD6YbQ6hjevt/D14qCtoqwi
	Pf/STB0oEPguYKz2+xM+kO+mx3r3m+uR55nAm7GuBsOZj8/EOJasF/2BlCQ44pC2JztvwmdOel9
	EqgSSW9B1ZAVauXoTCk0YFjwrny0TXcH9nTCKGrvEeZ0uONWwrn/c7arRuMO5FRLt7YpFz+kWH5
	j7675dxY8hU6/gMK8TB7GFo+neDbphcjiHYbgaRU0G6g==
X-Received: by 2002:a05:7300:6da0:b0:361:a195:c46e with SMTP id 5a478bee46e88-370f427ff8amr3861783eec.1.1794050244748;
        Sat, 07 Nov 2026 03:17:24 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fd0000sm13284120eec.21.2026.11.07.03.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:17:24 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 1/2] iio: proximity: sx9310: reject unsupported hardware gain values
Date: Sat,  7 Nov 2026 16:47:03 +0530
Message-ID: <20261107111710.442318-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107111710.442318-1-kapoorarnav43@gmail.com>
References: <20261107111710.442318-1-kapoorarnav43@gmail.com>
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

sx9310_write_gain() passes any value from userspace to ilog2() and then
FIELD_PREP() into the 2-bit gain field without checking it. Only gains
of 1, 2, 4 and 8 are supported (and listed in hardwaregain_available),
but other values are not rejected; they are silently changed:

  - 3, 5, 6, 7 are rounded down to the next power of two;
  - 16 and larger wrap around in the 2-bit field, e.g. 16 sets a gain
    of 1 and 32 a gain of 2;
  - 0 and negative values set the maximum gain of 8, because ilog2(0)
    is -1 and a negative int becomes a large unsigned value.

The write returns success in every case, so userspace cannot tell that
the gain it asked for was not applied.

Return -EINVAL for anything other than 1, 2, 4 or 8.

Fixes: 227c83faa2f8 ("iio: sx9310: Support hardware gain factor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9310.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 2585b9c6fb69..27b5d604a409 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -665,6 +665,9 @@ static int sx9310_write_gain(struct sx_common_data *data,
 {
 	unsigned int gain, mask;
 
+	if (val <= 0 || val > 8 || !is_power_of_2(val))
+		return -EINVAL;
+
 	gain = ilog2(val);
 
 	switch (chan->channel) {
-- 
2.53.0

