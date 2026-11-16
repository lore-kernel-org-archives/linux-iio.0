Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870011;
	b=mkBO54lpHgwNkhNz4PP5ZoMcBKZuZQ+5JSpAmrdFgXwVPF+sZ9ER7kRq7VZ6+AaA2dpX
	 tXWcF44MykfdQy3hCr3Fom0mf0M6eet7VPUgpvtJaWrG84b65AeOGvZYLrZd/hFeEpl/c
	 1f6gawH1B5kIdEJS7TgJpmQqJmoa7ej8xG2OJL1l4z8nYVXIxKRoMfI6ivmj+rIk6FjVy
	 rKxWnq027R7SQ41U/Uc0VYnjT0SRMu1DoSX2BUIE/Y1diCacEUPUHF0TliKOq/R6HXJHI
	 o0N99a8iEeitjDXJJEjNPjND4VlmcnWPxAM3kDQ7dBkE18i0Mgf5K1BrJGt0qoHdtQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870011;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=kUfZcKKb6bnahPacDlI0TXHO5cA5YvJ416iMFlw6i3o=;
	b=vQsE8Gn6/Q7/AsM7B7LxJcGnVUgfMhBYm/gJS2BurtSH2ipho90XHMAsoIb3gm5/dmHr
	 NSb1m8rYIs90KocsiV1Vgv6hu4BUJXlcjiDK6vcsHtQmza7Kgrt12jnHbRhLR5xm7UmPr
	 NKAeHtlSaDCCybQxxQDn/y+AOJQyhIyd6CYY3e0DUsm9gZkLaH/e0G89h9QBbjHU3Rn3D
	 4clPO7ussqB5Hc9+TBqrwQ2Am7GNJN9SjLIntcfzWOaVWNEDIg5YB0cEGwfTFe+PP1ARR
	 pQPrw+Syveq4XsZmhonjfED6RWolXuH+AJOyvigU2ev1t2YpoKBOhIfModBvAfLwnbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B75606A898
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 23:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B75606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b4e246acc2so10465967b3.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 15:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870010; x=1795474810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kUfZcKKb6bnahPacDlI0TXHO5cA5YvJ416iMFlw6i3o=;
        b=pduMpcLzWWzpS8QXXjUjETdhF1v+tAwMiDFbayVjTm9U574Z0+m1LcIIJUY/fEYOdn
         4dnNwQSfomPk2c+HNtKSKpwJBrLw7iXkpi4t/icNAngfh8B8vJA1l9MiG5Y3TVNOy6+u
         VJ8Ybu0qvqHXqEGZZosZStwnaQeA1DigVhn54bqH0UsIPGA0DlaUwa59+rIl2XLY6otN
         IhcKjxSgM2aue0lf0JGymUP8aCdAt20aLban473oDrdmQ1RCsitsYaPAtvx6F+o+rry6
         v6cT6fL0bfsLZ1wLblMKoPnXhI7hx51RROFudJn9N597Nukn/L/FU3xpJNKfQrZWeNp5
         34fA==
X-Gm-Message-State: APuU4Z/riGpe3FfBTBBWYVldJw6sx03TSP8XgXOEXh/+y3rs4BymEbwR
	X0DcQQRthafCD+V0J8pAIS25VnF7j1qjRsg/ih+5xWAiqQEtaQehVyMo
X-Gm-Gg: AZFdTZccXl9fQPWy2Q7P/qLvFaUs8Lxk3sqlhIjXI4/W+dyb0llNAewFNv2ZRaAYc0g
	WBRQzuQXp2oM2YlDEE06PGNb6cfUFbzyrXPf9uW24ZjxNVB1Qsp4PRofcbpAlxhCLdcvywF4Y5x
	IquoN88OFyrUoLoVD644dMXaieWs8AUv4mTv3cUobO7XN8y/wAsNIFKaFE1zFnvef7fmyduw/S1
	8FHCHxsr3iOW7ACeNHAkH+nYcb+zt5GB1TevNjoSKFmQgh9hr53bkizRqs9wV6eYFwBxXWtmgSJ
	skTQ55iFskHopki8iAVqS19bur0sn24tqjvnU4G/oiAz1BPxC3BiSV5uzxbECJQTO7ZVMhVXAg/
	gohhPc8Xyz2MWAYhQGiKZAx873tedws5iEQWE+xnm5vtjlcytmMqArHxDxoT22ZtOGHn4plrqrr
	/avu0HNiVBIuKKnJ4+zDFHw5zIKZXdpr6mCu51h19YI+Z3Rrht5VsIFvPEx+2oFSsffeTIHS49P
	lmv3bzaqz0oVwTXlJHydnBDNqjwSKKen4lM6W6aWXvSPQkWoypybAv6g3RTmjsNdYXdIlKepVuw
	H3lHwJ8MS02uNqP7i2l+BTkQRn8BQZ5rhNcRQmD18t0Bl/8e39JLgGwiX9j6KXFVlvKP4VKHx8u
	Z91bAcfcOzY0fsX6a77Pre3yiUMGvI7qQ9r8=
X-Received: by 2002:a05:690c:c510:b0:8b4:dfc2:bea3 with SMTP id 00721157ae682-8b4dfc2c23bmr18799997b3.50.1794870010106;
        Mon, 16 Nov 2026 15:00:10 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ebc50e40sm10721347b3.17.2026.11.16.15.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:00:09 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 17:59:51 -0500
Subject: [PATCH 2/5] iio: potentiometer: mcp4018: Report the available
 wiper positions
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-iio-ad5246-v1-2-ef6b7c06d4b0@telaak.dev>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
In-Reply-To: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

Implement read_avail for the raw value, as ds1803, mcp4531, tpl0102 and
x9250 already do. User space then sees out_resistance0_raw_available,
and an in-kernel consumer can learn the wiper range with
iio_read_max_channel_raw() instead of hardcoding it.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/iio/potentiometer/mcp4018.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index b10b4b920dc0..53471bd24640 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -49,9 +49,12 @@ static const struct iio_chan_spec mcp4018_channel = {
 	.output = 1,
 	.channel = 0,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 };
 
+static const int mcp4018_wiper_avail[] = { 0, 1, MCP4018_WIPER_MAX };
+
 static int mcp4018_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -93,9 +96,26 @@ static int mcp4018_write_raw(struct iio_dev *indio_dev,
 	return i2c_smbus_write_byte(data->client, val);
 }
 
+static int mcp4018_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*vals = mcp4018_wiper_avail;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(mcp4018_wiper_avail);
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info mcp4018_info = {
 	.read_raw = mcp4018_read_raw,
 	.write_raw = mcp4018_write_raw,
+	.read_avail = mcp4018_read_avail,
 };
 
 #define MCP4018_ID_TABLE(_name, cfg) {				\

-- 
Git-155)

