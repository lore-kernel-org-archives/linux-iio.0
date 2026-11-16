Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862428;
	b=WNDIJkBCs65/CYE40lqtHXOPga/AzziERE6WLWEmvwzQncmJCYU23krfWQXAuEu45swq
	 EYBWjKwih5Q+nowvCYVV0s4odFUVBY8pT/1zJRx273/9Qym53C9bCoULs5OGXknS8vwog
	 KZCFoisiRL01IP+jLf2qV9Tz8cp1vdfRh+LQ3KhTu1LndZN2F/NDOH5k5h4Dng0lG4+HO
	 Kz2N/nU0uJkyOCbcWwB8HNOECRNgXR00ufI7uVTcU+BPq5fgsrVfTh7+SIetXnmQysC6T
	 pNWVlUU5uSLahMz8+vvP4GY7j3o+lNqIzX6JEwKKWcR3rqC9SGo+UrFoVVPVEr9lxAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lERwLl6L3SB+cW2u0pTxZJmstnyAKlq8LHXRUJrT0o4=;
	b=3t1pscI6uHhPnMdJwA54L8Wn5lNoWv2n4L3PRXZgkgl8+TEjfQO58/laXaH5TVTXGTHZ
	 gvXiDrvQkXg5KYrluMMymcE8kmE9YiR3TKes6XKesN41R6MnJcV1X7VdhI2+9wh+JcAoi
	 eAazrwe+0K61NZKIGALckmKgMQYqGDMQZpt33m/JTThe7aeVSvZwZ5/Qp4PPc86hTSdmC
	 y8ZOsYTD4sjn6h55SfEze1znaM/f8myn+r6RILe+D6EgCkhDtB0otGoQYRtb3GOrCKnMU
	 otMLIkxbrV680qOBvYozTFM3j53+uDKEcSH/UyaxJQ3SVoI0ueuJCr9ADLzsuHVe6AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n6sTjwj4;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C176606A330
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 20:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C176606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n6sTjwj4
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3ada81853so3594301c88.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 12:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862427; x=1795467227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lERwLl6L3SB+cW2u0pTxZJmstnyAKlq8LHXRUJrT0o4=;
        b=n6sTjwj4rgk+1fS9VfWSzK4SVhUEPnjiU+zeYTildALtOMi9u/kBGtcwgu9CCmANDD
         N+Z0pEU7LWaNBrvKNNXPd8ckyhIrRWuuhVaZYStJCWAzQdf7RuBegp3UXjJAQ9xK8Lid
         h6TwCvLCHX4R1CJ66H1sGaZr0uzDN+lrb41UgwgUumh+2LQivp6QmSHftQ8CQXcrdbm2
         OycwRc19yNRBFD/8IB/6GcZjqsW1YYm/gn6mmz0F/dTUxg32GAcMDvuYJkaeQgN9jTVb
         yGKuJ6u2R+MXPMksmyZB4gepvv+kO3uas+dfyBvVB39OXa1pXJmT0qL23VIfKgw9F+J4
         ipGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862427; x=1795467227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lERwLl6L3SB+cW2u0pTxZJmstnyAKlq8LHXRUJrT0o4=;
        b=0d2phtxDhcjb/OSID09fg91rRbg9899ldq66lVE4gV5vg9Y3h0XzErn9jUPV+AgEP+
         9nKLNQcxpvRvjckmeeohnlLJtef0iAWPrrnSK6d2rEuVlX8301FIWTfqGaVEk6k+Ouyv
         1Jhbl1zd/a+uHMcsLi95Dm+8eAI580Qw7Ni/msI0WofGELqthOy2+3fZlXyWVb8GXWLB
         r4GloJfHAFcLyKLa3RspORvIUgs+BbCywQiGHEBvmip7wWcXNFsorIcQTR/H3+0vt+TH
         S22i75y3QNobdWoixogV5aQHkP/6f0ouVSdQhC7h83OfaAzMA+lb/GtmIifcQIkdXDQv
         2oHA==
X-Forwarded-Encrypted: i=1; AL+hErE1v88UqignOPYI4Tyer1pIC3evpzDaO1Ic7JqqwrmT41G4qsGt6CDu4w4uweqQNtzkLkO2UdlH0MI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r884koMwrNGqUlCVQGjbzeK8ZPzPVn3BTdOlIgooq0Ws0A1YF
	mA1k+gcBWIYqeoHq2UixQW/aJcrHpUm92gXpCZKN/hNpuxp2C/hocTYc
X-Gm-Gg: AYBFou1SRyAn2blV9TPHv3jJgT8gUPGIpTsHTZT8h1YgmEsLCT+D8KFxwcO3pnDMpP9
	0gUzlNdiEC8MZJVgq6qWtIU3epzoAhK/ReDdS0ysPmtOAFlp8iZKc+VnBm4d3fG4mcMZEnISA8E
	xwXUuwaGLTu6iOseut+UMIxwuy8LfIuJph2qK+3Nl962ty+Hh4Un9R8DOf33rGONVcFkYUFl1pM
	1Ksbs4q2wecwAU+LD4YiqxxD6xwkV+LZj3MAzCWFaYij8MMHBJ/1R9Bo/+OJ2e7qfOsZMLgdq0w
	QNecJmyIHDL8vnUBCIVtTA9tvUtNdaaJKiuneaY1Ya6lTI9db9XAAytQfQgc/Qb6UXkV3fR9kG6
	7bxSDSpVV+1+S7JLTp22gzZR5AM4+GGZ4hIcXFA+14NQ9NwF416etZ7CkoF0SLfI2trHjD0Tsua
	tEFZL+Mj3P+oyjqscmasmfFUmyxMrT4X3nkzglGBnvBvTCZjvPW+3VzwKZg7+78fI1bSYhhW06/
	bK42bQ5nI49vy3mxA9oEStvy9hmSXCoQDco2I+rD5mk+hpVa3WeHw+gUugvN/KlCn8J4T0ZdxRT
	Ad0l8s9MAFMhcJlwr4aDjrmp2uXL08+K+wOsw7U2lvUF5dwx3Bdh28z/A/l6WVyPfhd7arVYGVW
	PweBSXPfs0fgFaPnyXgrXdNw8nnMH/K3BY485teSv6BdMFG6xixF/bGV1aYorT775HnC/67ifuM
	0w8sYgnGX5hFvg2EbLnkKaOMeT8LZ0lHJoKU1oXjoLIQ==
X-Received: by 2002:a05:7022:3c01:b0:1b2:43ac:d3a3 with SMTP id a92af1059eb24-1b5031007b5mr9815178c88.24.1794862426641;
        Mon, 16 Nov 2026 12:53:46 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm15293497c88.4.2026.11.16.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:53:46 -0800 (PST)
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
Subject: [PATCH 3/6] iio: proximity: sx9324: reject negative hysteresis values
Date: Tue, 17 Nov 2026 02:23:11 +0530
Message-ID: <20261116205320.26070-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116205320.26070-1-kapoorarnav43@gmail.com>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
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

sx9324_write_hysteresis() copies the value into an unsigned int before
comparing it with the threshold, so a negative value becomes a large
one, passes the "val >= pthresh >> 2" check and sets the largest
hysteresis instead of being rejected. Return -EINVAL for negative
values.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 39760c92552b..9b7ac1d56e53 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -638,6 +638,9 @@ static int sx9324_write_hysteresis(struct sx_common_data *data,
 	unsigned int hyst, val = _val;
 	int ret, pthresh;
 
+	if (_val < 0)
+		return -EINVAL;
+
 	ret = sx9324_read_thresh(data, chan, &pthresh);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

