Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547542;
	b=mxJV4bvBOqSvwT8G1aiR7TZmCrOH7U9yvbhhQmVS6MHtEi4G0uGoXZgO9+VbNlwbM3Nl
	 FFj98IbQc5ifUJVcVZIrFqYBgQbABTgzJ9GntcHFrMCXu7ZBpvFTB4rBH2yUFRCLzdjll
	 XnAQcVr6iqES41afHqH3U/f9QPPvjobQubeXTpgjkInxWZfmOwbANK1KKtudVcuaaq7z0
	 emEkFWedJDjy8HvJZRz1mjimji9lHTHUgp+A+AxLpUEHwY82tyZ2AGdFV4qMCDB8o9xcO
	 Had5ImWd+Lf3qAD27DS+Nvfk00jL9DvKUZrEv+/lvSENCQXpAjb7qfDAZum56uFe8tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=JEo4SJL60UN9Juaw0FQhaKBHcMW/EpaacJVnI7bYB7Q=;
	b=UI5ETx1h1Zhcb8rfnAG6/rlfx9H2k3Zwn3pxMidT6QFjXdyiNR/r+fQ30ASbWFp+K/u/
	 VDD5GU5fcVfsnXdb/f+I4Oci8/yInbFCtOWM7+5DpQ7rtXWzFy0sjP0qskoElYFwSAhKZ
	 3qJ17P0nPm0JbXRaVxGrpS+YjfgfYHyE4Z3iwQeNlxaV3a3EiXsc+2wssZVFFCw9dnPgU
	 qXxZxB8zTmjPzs3xkaDBsoXzneXz1qbXtfEp7SLtBtF0MFCpwYcaBqPzI30OKUyWIIZTc
	 3/yTB27vltX+Ppi141qoFGXgOhLDoJGYaGgTuld+IERSGtnUlCofbfF3bQNGrByersA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGf0ZvmP;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E1606A33E
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 05:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D32E1606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGf0ZvmP
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2ee9e7093so117854137.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 21:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794547541; x=1795152341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEo4SJL60UN9Juaw0FQhaKBHcMW/EpaacJVnI7bYB7Q=;
        b=DGf0ZvmPepL8e2KEp1ekz4S6MbmH+GxLJmOKiWTcQA1a7fGC8JtuCGKuHluxXfjY9o
         nwgF+ENBB6JD1mWmr3woVp7TjvdQUwGs/PG+viXzGsozGFLNcmktkQ3wydwVglPdTQRr
         XcMI6LWQ+Zn64nESzIDR/pMONdxcNTJIlNjg0UMpWdP8EXxXXTkjpc5ge/TZFcqb2XPR
         +LB/b3Cv+eH3wG5VuGH8BpeIiOg4yZX7x7ohe48+0tFarYaclPU88iM2Lue7MqWWUOWq
         2xW/m72dGCnqEB3JPoGcVoAMg8aXrV6G+AvEaQe1uq9X5yey2AONliylJp4jcstjMAQj
         qU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547541; x=1795152341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEo4SJL60UN9Juaw0FQhaKBHcMW/EpaacJVnI7bYB7Q=;
        b=s+ayozTWMYJm5GLGpDRQsScHSdOsVhw35vslIijc8920/Cgh7YLAG443XKdu+1hHBA
         MA/m3Vkg09bOY2ehn1sNXyK7dImZwD6eX6vbtMZoPokEeIFpURIpqeEVs/9eI3X3Fhse
         CoVMCCN4FK4mTbzLxmE34S/LT+JTh/YTadjx9f+alvM5uQBEVqwrgSTXAPk3T33XrWEs
         lCRuPN28Abg+8r9JrIoOYKlj0LTH7AVvUjfr6yI7LYWAdONXmKWRCaNzOaWBxsq8e8U5
         LYpqj79oHYNrkyYx7sI3Ow+6LeDkhc77n4KTDBKsDLjqLuYPEurl1N/35Zswgf2elN4Z
         xahA==
X-Gm-Message-State: APuU4Z9DAvTiMd6ls1aes5xcYZ0T6Xs//83wGnheCjSFNnn4dX7hXGqT
	Orciqv9ny5z486O1gXi6JWwtXE9eiFNoC7EEIAQUHVnsfN1uIJB9w+cm
X-Gm-Gg: AYBFou1Vno4JeiHSJdXSg0wnm4liSgByDXc8D2XasU9Itg6Ip1UK9TT3I+iOurr79uH
	U+W66kdS7F7b2vwMjnRiMBtvRGwDlAH8Yg/62outeT0Jh/xEM7Hc6yfE2EeMi/rcB3Hgij2IHRa
	y3Hxy4H2pO3XUgXG5c8X6O2bguI710F7Hyj/HU6m1VeCUshw7oyioHHIJLHF7QFP4TLO9PtjYuQ
	Ll/FgwzmbzEixUVmJn76np2iSsv00kqF0/ZofJCJRX6iRWG3nhxVAgZn6PHE3JdN5KKGHVb2O31
	Ozl1K6avRU7reW3U2bl+eO/4Xb1drJ6DJbPh0K+j3zULwyyWPHm2KI81fH13seQXVlU0+/ufwVN
	QPNZlBOP9eL98rQ3ISV+Fac7Idji0njDXwvm7arr0UgVy3HiwFXbajK2rfPCgN1zeyZwqySA9v1
	o8JkezpznrFc020mf5xuL47Je6NC0aafkAg4Vttdt6qtp9ls8O5Q2MsvLLpFEyz3qPxork5mjqZ
	kI4vrracp2nzkhZE8Xji5Ice9Hz4N7A2nnMw+n77sZgYV5Bl275Jw3ZlZJNkQSjAYJ0mgT+7Yru
	z05S8NQePeFhcCiIeQs=
X-Received: by 2002:a05:6102:6cf:b0:7d2:754c:23e7 with SMTP id ada2fe7eead31-7d64d83f820mr356046137.35.1794547540758;
        Thu, 12 Nov 2026 21:25:40 -0800 (PST)
Received: from [192.168.0.8] ([2a09:bac5:565c:aa::11:1e5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c8425d142sm880439241.5.2026.11.12.21.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:25:39 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Thu, 12 Nov 2026 23:25:32 -0600
Subject: [PATCH 1/2] iio: consumers: fix kernel-doc parameter name in
 fwnode_iio_channel_get_by_name()
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
Message-Id: <20261112-iio-kernel-doc-v1-1-e382fc9a47c2@gmail.com>
References: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
In-Reply-To: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794547535; l=1097;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=XLVBA7MkGfQk1XAHfgQHRCqSoV3TsMKT/Mo4vTanYWg=;
 b=4UNaLh4Xjy9XLOyTAMCY+rMNrM7R7jbPfavdbwChqNzbyNvqMxAuBKlo/AoeLih7yM1iPuUw+
 B9/VHGt962TCllskNza411pnfSIrX3rV35m5UvJja9eFJjaM+XLrreC
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

Rename @consumer_channel to @name in the kernel-doc comment of
fwnode_iio_channel_get_by_name() to match the function signature.

Verified with ./scripts/kernel-doc, checkpatch.pl --strict, and a W=1
build of drivers/iio/inkern.o.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 include/linux/iio/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 5039558267e4..b9593d24950c 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -101,7 +101,7 @@ struct iio_channel *devm_iio_channel_get_all(struct device *dev);
 /**
  * fwnode_iio_channel_get_by_name() - get description of all that is needed to access channel.
  * @fwnode:		Pointer to consumer Firmware node
- * @consumer_channel:	Unique name to identify the channel on the consumer
+ * @name:		Unique name to identify the channel on the consumer
  *			side. This typically describes the channels use within
  *			the consumer. E.g. 'battery_voltage'
  */

-- 
2.56.0

