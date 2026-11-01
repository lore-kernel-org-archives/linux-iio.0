Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793542533;
	b=f4vJFekkvHhXU5CiPiBWUq8ePaafKCu+U1uHNqSX4k5ds7uL2TkE2lP/YtSlZfNU57AR
	 EUt+zwgeVqaih2kdk+f6oNhc6Z+P0enaOhM2NJyyCTFVyRoU9bDXqgT9IAf6dhLKTeMG8
	 SwhAAcbhTLRJGGMnUpPbJIy8/6aGqJ/YAeTdD5NR/6o0RxzOcTa59ChVe31jvLRad1XA7
	 W2KNM0ktnacZYpxnJLQBRiWLm3bJMjp0Xm25oJiaprm20zQJ/YG39mvfOPZW8ut1Xy+7/
	 C7Kav9fWo6+nAobh1ELLiIe5aCf9+R1Gt2ISLWwZjOq/vvP8QBOjew/Ey1+cpC12rwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793542533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xu7FC3Q8JkhKAZXkmoQyecqo7Y03cSTT/z26JLOH2q8=;
	b=VJdmxPtcCcr4gZ1uyh5JGxoyrYEkO8TdpHePHy9C1Y/+udbKH/FD6gMbG0jyPp9XbMh3
	 H6LUd9SoUCHy2v0cEtijAhkOikuIxlwYiEUFFuaAc1wGks2U/PTusd6u4WXQVivExUWfT
	 NzA/wAX8kj9VJ3IHStoZOJy+BioUk+ASi7n2v3Zbn1+fVI8081gzKcWK9niaqAsKn5brX
	 HAejKTvi1V1/Q1hDcng8pPzOjc4z7KrkMdPqZGrz6UR0DTCYh39ltpPbXtynkp9QoMhjl
	 ZF33tOqE0oXCZM77b1//+gjLK+vaXDuEldRuacCzULZA8u33rrcv2AHpjM+bVreLq8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hE+tk5Le;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943F606A327
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 14:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2943F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hE+tk5Le
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c315869241fso302957966b.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 06:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793542532; x=1794147332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xu7FC3Q8JkhKAZXkmoQyecqo7Y03cSTT/z26JLOH2q8=;
        b=hE+tk5Leam7kz4ZKTkBOYn/U8XAqhR+uwoX8FgHVXR95UB8LGxUI+qygLbNQGE7eLg
         3jqblPI8Kokn5TT6IY7vj17bYWcpr6M9OespfMNJxJ1Ly+S4nB6YTF5FYF3qIcM+jbHx
         B7APhQF0iWQxtChIhY3TEKNlxf70K2GGFVVyaZCfDksj5CDLm5QPloaBzzPKRnJg/YHc
         YNsgz5koB4952RoF5P1CEBiQOMZqKGDbM3S9p+AvFZv96GIXF6rfrI/FAOVvoUOUuNtx
         8PFj1Ci/n+flAtpWnGqIdvDa21jJuj7+ev+lc2dTIoYNS6dqNXYwJpXaHoXIIadtxLcI
         Ae0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793542532; x=1794147332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xu7FC3Q8JkhKAZXkmoQyecqo7Y03cSTT/z26JLOH2q8=;
        b=cqV1X9Xc9gRpbAsyBHcQ2JpbXCi+HU3/oYenuNgykyMDFV9WkWR2Zl4jJ5nQldWGgF
         U1L7GQ0LWBhVQ+AUjIyEJ+AfSFlRLWjQipbzOH6RJKMWbY8y28o3mlvOEGDF5GT5+Xtf
         WfxQwGBH4BtrYkCAM2pD47rBlIMwFA6ZIM3FRjVPe3RsZHG1TGLrktpHeHd/goQdmyb8
         qXpeXwSGg4YQNahqMdt1mNaM8nuW5DaTstMXW5S+Fk7cjclz5ZcOYEehdv2zJ49vHySY
         /EA1OH7pZdsNJl3NF5nfW3/T/cy+EEpAw8xgiI7JEhddQi8Ys/zjZaoX83IEuMLF4KA+
         gZXw==
X-Gm-Message-State: AFq9FYIIau0PEPND2GS9Y3uI54yvUQCBvSyTl+r4Vg8G1hLQ+p5zXQ82
	hJpLmrQs5TLZJzk7Si4blPnN/6n873R8dCUdYmiRdZVME3fqBgzU8I7B
X-Gm-Gg: AYBFou3jKlqrvjbEeZz2m99o/+Idp4WvvyewklF1XMGDaU+Iw0lmrx4zvR0HHj9ollj
	dpwieHsbVHpnpurb6Nu28QWrU37Z40oIVCh6yNHJXgmd2EBELr8YDe/wvUrl8idW/TP05M23CZn
	5d5G9qOc/iBNnKjqWp1fm5DraULQk041vIYcOU8EBpXRIx6tUmEpdEIbXzi/oG3G9PlXT/Ev6Yz
	9xpCi6l5roVlkafEiL3Cvy3YIfEBRWw1rd6pSrkVhpn4z9BkNbmLh0q27jF+/r/GgcxDzadczBz
	3D09Xv8xhGx4pDa90eobRvOooeiKA/gvs8XHEDEl3CV4EtL3ekaQiV0vh3MOvOsuKBw75WWDBfK
	7RNcqtHBcvHbKketCaTMmY+I9pusUU9/93CqyubxBNB1VkUOnxVMuqFOJxMvCJ/1NliGq4m2QlQ
	6xmE5JIzw2fSo2CktAqxnF6hHfGrEHJobaGez76y3sgmSlTThHUANmiDnxjB6DGLqkD8Rc9uOQK
	F4TBS8by1Ladvwd+vrprC52Zj/ShEN6rCp8wy4dP2mfcsJK/XY2wKfY4aQu8uLxJA5rfxbO900Q
	SiW8nOYWXpfrFXi/DGFBTJ99yU7KSyIhiN83z5dLgv1RrONJHw==
X-Received: by 2002:a17:906:ef07:b0:c49:cdc8:10cf with SMTP id a640c23a62f3a-c4ca7aa04a1mr633438066b.40.1793542531418;
        Sun, 01 Nov 2026 06:15:31 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18ec5sm281769266b.12.2026.11.01.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:15:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
Date: Sun,  1 Nov 2026 16:15:06 +0200
Message-ID: <20261101141507.119186-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101141507.119186-1-clamor95@gmail.com>
References: <20261101141507.119186-1-clamor95@gmail.com>
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

The LTR-659PS-01 is a proximity sensor similar to the LTR-559ALS-01, but
without ambient light sensing support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index 20abd7da080d6..85ac3b540c206 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -17,6 +17,7 @@ properties:
       - liteon,ltr329
       - liteon,ltr501
       - liteon,ltr559
+      - liteon,ltr659
 
   reg:
     maxItems: 1
-- 
2.53.0

