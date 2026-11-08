Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131809;
	b=mq+VO9T9eKkeVkGTIC5Fs5BoAWr9cqdUcdhPMF34SWqxqm90afyVa8Lw9f1+CUpxipFs
	 LEh6LTkoF2lStv3gPW91ive0dqFWPlLfZMxSxdPE0T9xt9vk2GEHoV2fPcaA4uJiY1mJr
	 nvdYaSzf/jg9TBW+AIZAW2Z9zdEvIT/iw73F0Ewhw2OHwFDrFvY01KQf9s8qGnlDldjUG
	 WuRllwsxvdwDOfVC+wW9+JK/M1ZyWpRpmu1fOGVp2DdENxlt2QN7qRglBwi7pNgwXcBl2
	 qHGD3CIfXEQ9dLfgP86DELqtqJFpDEcreY2pXoLUVIX0UpwaXGt2pafPkhqkwCdqhvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uqi3gyiVeJ5V4q5i7p+1+tL7Q+jROIpeI4BmduF5Zrs=;
	b=Kx8yByayIKONlEtdSfnaIQ20/ikMYn/44Y/rTd5bDYKy+upzlFtqQufwYcswTd62j28s
	 S9jP7YTM7KHAL7beF1zDwBQg31H/s6Zu7gx+6Xj2PxLZEpwFpF5BZeCb/kXGGdqe/D3o9
	 XnK3Iqghs8448oG0HdxQfUxMYJ6bzMXGhv45YmBZi4/9lCKEfNSM369S5vuhb5tXpIo5a
	 KQ5BGe9LlejtdkNh4BgV2dEdJcgYAovoBVd2F1Cu/yojubY/zzY2cDFjW5yKToAbrjJC6
	 vIeHAS1gmUnJjPQIMsM0Hil1ijY5KdwMVLgBpeG1Mo5NQsJwOGbGt69oz1R8fXI73yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6k18Nsc;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671D606A333
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 09:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1671D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6k18Nsc
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso2248966b.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 01:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131806; x=1794736606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uqi3gyiVeJ5V4q5i7p+1+tL7Q+jROIpeI4BmduF5Zrs=;
        b=d6k18NsckswXQJHgdv7ZJdN5lnDDlUwL1IC9wGogAAcQnYo3m/Svt3Moax+Rcfwg10
         NnyvNM/9ItpHXc1Z2AS652d13hEAzr+N6eP5UKAYrEK+zJvLq8i3BzEdR8MXFRMVF385
         awNQfBN8ngK5jSTbTZRarUrRM2kxH3IAuOw1srSgxGfPCqkXw93cmdw1gmzj9bbTKXNR
         8MCECcBRKFdPq4kuu6XZQypB4OYiXym+TiU3FVahUScgUPoGj0xtFfVO46q9DCIh3D3O
         BEITlOGb67SAAh1uk0sKos8qGzbbewGKY/9dHdhDuYtY0AYM2XTTvjgE+AZcO7km0tDd
         9S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131806; x=1794736606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uqi3gyiVeJ5V4q5i7p+1+tL7Q+jROIpeI4BmduF5Zrs=;
        b=H6poATRpU31N33dZVTYPFv9Prgnm70Rfn8d7XognhGBPaHJnrRVHh2tazFeuP8+wbL
         dNyFiOeqyHzyzMKPOd4ZsSCwo0Lgu5uNYsEIIuxIKPpyVixVVruu0+99YyW3VqnTQieP
         eJHHorJ9wPaSw/+ZP/9IPOx1O3Rxpd9/+tpzvjvrSlCE3v59hgY/a6BAwPvC8+QEvTsR
         Amf35LNSbH5hD5qOZUsYpj5CF1cDqaIjS3+fjUbsrz7DCgqSekBXNSWhvtyh0VUK8vMz
         o4vwqwHoeVye/SYQ6vdmwEKFDBLYwKUOJIc5rc6wcvSEMxLB1NCdzEOJeZzff22ioDxY
         XdKw==
X-Forwarded-Encrypted: i=1; AKwUvBzR7D18EGHTcb9YbTp8qS3XtRuPUwoAhfPBoLSyfOzQuNfSgmZWPbLFLMDhyxXvC1o1WcZBqcTLwwc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6z/xGaqI4wO8C5XDA2BoaP41fD2ENRd7jb75Rcyala0jR/Ea5
	QKPc+J17oOV+VnbuBPyXUSN7H/fDH7n8pw9o6jNHvIiuqbynouFNPo8h
X-Gm-Gg: AYBFou1dLsiB6u+ET/oDGyok1njN4ea/2CPKd7qt6T1+0c1Tfbx0/lladeYy4QCeCz6
	JyyMBN9t5s70Q0kpSSIFs+DjaEGoCh87Qb+MzRTbCDjvYwXPTx64++BIEsTL9EDZaAV2sdLE//a
	+V9698eWcAJE0/gUWMYnNQWqkfGb4GjdoYyqWcxofmeufiliuewtH5fGsv6fvfTxJCmEusc6bDR
	g996Hjp0KJN1psZd8EtxIO+letocJoL4BvCQnXKDu1OIjaEf+arhS0WRlBfIHBg5KZAmfKlY0c2
	FtB4yQPTOe1ymyZdCC3G8gaFo0cMWG7hGbFFitJHfKDsUNgKx7sN3WLib/FieflYPcQiNob0IoD
	VK7DA6ht17NVrlxFD6XjVlJczvqw/vKjtnzphB9RZECpE+S/ts2JyYRONXr2e0tMcq8Gr8yPDMz
	KKkzeVuAz29tUWzGO02PQnQXzxrnnVr9RJCyVYkCH9HMT3nIZcV5Ae0+YZKblg+u9RakY1AmUQ7
	MNdJPNyN0DxBGrAB2gW3y2Chc7v4ZfLOZdfnKews8JKH/nnICVMWRK763UTWYKvrD6RC9f6SPEr
	nHtBDGSfpTiHuGn9WeFtPIxF8HP9pUV6ooo33IiEO4MR0Y3z+eLQy2Wyy+NbM0dazlqJcodNHGm
	5/xwB2gBj7Q==
X-Received: by 2002:a17:907:da1:b0:c3e:d0ca:d2fd with SMTP id a640c23a62f3a-c4d6d35bda4mr86080366b.12.1794131806225;
        Sun, 08 Nov 2026 01:56:46 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a9bc2e2sm48920866b.83.2026.11.08.01.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:56:45 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v1 1/4] regulator: dt-bindings: maxim,max8907: Document io-channel-cells property
Date: Sun,  8 Nov 2026 11:56:31 +0200
Message-ID: <20261108095634.100517-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108095634.100517-1-clamor95@gmail.com>
References: <20261108095634.100517-1-clamor95@gmail.com>
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

The Maxim MAX8907 has a built-in 8-channel ADC. It does not require any
Device Tree (DT) based configuration and is folded into the main PMIC
node. Document this behavior.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/regulator/maxim,max8907.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
index ee1a305d1c210..ccdeb9ba21e26 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
@@ -27,6 +27,9 @@ properties:
 
   system-power-controller: true
 
+  "#io-channel-cells":
+    const: 1
+
   mbatt-supply:
     description:
       The input supply for MBATT, BBAT, SDBY, VRTC.
-- 
2.53.0

