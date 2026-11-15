Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794731885;
	b=GbnpvcNJ83fBbIyVIArCfaM0RBhUEz0nyrWa5GkQOF0ECE4KfJo5vlnZQGr+PMjP0l+u
	 ok7WeFhC8CzpBwYe3OE1Rr7WXOyrl2dGuldtQ75lOSqgWs5cD48G0USWvtAxmBrKFhE5J
	 w/fbD22alPF2iXcoeeSX9pmFaktm9qvKHnRIQtRKY1HbzfhDiAH0Aix2APakqYVsWqQvw
	 PLadY7afCynKjXemMWsrFCKaKz91mYVxj1Txz/XLWCREzjDYsAENsw3NsOXPkB7/vP7fF
	 Cq5B8RvCa1YDXku6/HGFsrSfjCS2swRx2026qbFOcwQOkiZMM8fR+42Ker0bn1uafkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
	b=NoH5YXX9WnI2PCPz1+35sz7nxvm5Xnd4VRjNqz40K833MmmWDhGMBEKzAGe0zwrjxyHh
	 OEQlOnV9EDDLGnjNhha+TQU92ajNc53iSipFp/t1obD8VtiqheYO/5Ti22Ui49oZ/vp4a
	 8+sghKiEiE+k52hnR3JjduYj8MP89kysGNuq9aPV+zyYQzOp5zQtjXSOU/IGisXMTNKva
	 zslGQPCk3I0kZYDjmSuChbjgiFlWkOZwE3U/mKczCsG5D9QA0ctPa/dUi7vGhRfEtuXka
	 n/dkqixm6e0YUZ3+3qYHpNtuPkxfaTDxBLrKIgTAe8m2OiM4BuOkxGfuTDbFCHSo87A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvVKeoHM;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B72606A89F
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 08:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B72606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvVKeoHM
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50933bdf4bso503647766b.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 00:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794731883; x=1795336683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
        b=qvVKeoHM4kmAdUefhbLzNsQaTehL/q6/ivDkdZOAGX/7czeIdJxqhrwmPEW8Gh/6F7
         sbSVMqL0foqRicWhK1ok6tB4VnEe93keo4KAR8lG/m2/3Wwkm5LeTGifc8ZAHmpzbzLF
         rGUP7AgUkygDQ6beLqTYBhv8JvX1VsTYvy416KjYN4vxzhbUFhxpFKv2km7H2mbH8XN8
         oHRnQN0UPr/IXDAIFItpyZABunCQGaOI5pDRNb1I8joEPua4W4PM+Hy1Xb9c29rgSLyi
         4/JBVnhylkZCvfegBFoCUhVZ0SGbSPe8tujYYs5r4yTgwat0TidTciy4GKiI3mrKLx0j
         MUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794731883; x=1795336683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
        b=n1d3dLTIHIMRyhR3684Q/iFjzMAiOiN3iq/3ycxbYG/uLDMq3UxvngLI6Wm3LKM7Rc
         bQQN9T5Jh9i1ZgfHybuDfalaZ8Cjgvyqh2QFSWnWvd++HmKZk5d6qNcLIyqdHDJmO70Q
         rfXun0naFZHOgsppIcUzJkqvvxsXyR0K0gFalBN/WYkaOO0RrP7aOxRNy2NfLeSEPbBI
         H0G6s4w9xIOWNLVzewsfW7YJFDWFbTucyB3UQvoHdq90ksavXjxRLpfPIEn4J+BmkeZm
         Qr6/+cgoWmJg36mkNFaVxzcKaPvpZu+ndDRdLDgA2tkyLyV4/dqO9tA8CPajJ9k/6Z+f
         jy1Q==
X-Gm-Message-State: APuU4Z+sHikrJPwyuA9Z15rNSE59Mh96a097yPyvkCky9MtKr29uqM7Z
	NiSAdlIVBNN2OZmLQ4Olq+wvJCIeTFn8kefmLn8p0EaZ9BQwXXE/5QlB
X-Gm-Gg: AYBFou1LiRnEWnEQBr3k+FV79S8+Jk4m70vyuCGbvlVtKjbC2wMlE6/Bnb1FwKaK1Mf
	EJzDVRPTQ7PgYi0/OJ4ni2Kf+Iz5DBFHhBxn4YWyoTGlHb8CV7qeCnrJLd/juskb9yhWC5OoHTk
	Zf9k8Lw6rd0YMh60FxmLDPhUM5tug+UunqE03hbUwfYe+dCZ98wXiLVHXBtHC46zgHiPf3DEvpu
	ynL+J7mJF57dzRcr18yEmn2CG229rKC1MDw8EKna6/MO1K8RtACL2WUiGeTWpK7ccUcKV0q9iTz
	2l50voCoRXLI7qW/E0qvkiGIco+8XYm6F6Xd5MEvD0LAkPF1jZkGEGuOq1q7h9oif9PvwEl9Dtc
	GhA9NDfqx+lZla7k6EakP9jjBsVshAL0i6O96bzz5NJzsSvqlsfYyqNtE0d61RsOV2qHdKBr7Ho
	kW0dpvnM591/SAfxtB3oFQTp4mHyPyDA870MUi9VWnEMjinX2gKH3u71yLgx6z4QacGL6LRDGze
	7cVhIAiSntnDVg7MNjQwSGwbBZWBqyHqB98/OIlSjUHSB4X7NOhFORx1vau+xs56TXphAFYfGEQ
	aRwsk/9grtGwEEfB9Vb06PLj4uKGEY4lvlV+zWv8nV04FTH6G0toZnGORTpTKiCYJGAZrhOqPTY
	cZJQ6xjwNfw==
X-Received: by 2002:a17:907:d01:b0:c2d:d4dd:8d0 with SMTP id a640c23a62f3a-c507c3c72b7mr878493266b.16.1794731883335;
        Sun, 15 Nov 2026 00:38:03 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5ad9esm284815666b.2.2026.11.15.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:38:01 -0800 (PST)
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
Subject: [PATCH v4 3/4] dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
Date: Sun, 15 Nov 2026 10:37:40 +0200
Message-ID: <20261115083741.62140-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115083741.62140-1-clamor95@gmail.com>
References: <20261115083741.62140-1-clamor95@gmail.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

