Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7C3859EC
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223375; cv=none; b=fd6n3sUoHY7pO21EBKJKRba1yrFLJZaMBXbGjbYBoztZffzAk0XXWS2z1P/82GidmXf+4ClfaH6zmWo+JdWbpiRYOpfAaMn4H5znjQ5VMhD11lQuWMZuKBT4dE74FmtjjdOufESZz3qS5wQojk3jv5uYcxxp0FgAy6EPOL/7pL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223375; c=relaxed/simple;
	bh=bc5QG0qfOT3JkuoLEz2SVAqPbdoa62KjYYqYrd/+rEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxq7RItWRwApIByTYQn8NSgrrPz53WViBIRioY/Y9I4uOPRZY3Ky/Nd5BCYJk6B5K5TmfqPzfBKBwo/C4woKoFQJKevWibkbuUQbYsLqhnqBPVmQIsNVRsaKOPbe7rjOikadWgibouiPm5RqKUUy5dIJ1xpZrJfTfkULK6WfKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2I4Awai; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2I4Awai"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953ddae026so14263275e9.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223371; x=1784828171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dFLXNqHsnzDqTBRxYwiZ9Q7DvX7sx+x3Mwjt1PQZnaw=;
        b=F2I4Awaiwf1CdU88dbTwtfeGZG9WhcZgwygT1rUu0vHN3qnXGwzY9tBRXXVvAzC3yO
         JGiwyFAca3ghSkyEV39qc9pLA+B1bFmU3bJ0l8z9WVfV50piKq9kWiK9rrUvjxJunnME
         WmVJS9/KDF6xZftwTXlEsbCztY3kcvQhqxlkVbJ/tph7x1nNwKwAsDA2G6FszaVe6nHM
         86p7tg/SZLUl//AVb8uPgbeBSkMiqz23rGb9xg8wNEzf6m/THluvvXvCvoo4XC2SzjFb
         Ly9AcSK5/QX87zu4IKM9Zef/9mzOnaMeYso8nwxUccVhBUJtwoxFawJO9OGCfOlnRgNz
         E4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223371; x=1784828171;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFLXNqHsnzDqTBRxYwiZ9Q7DvX7sx+x3Mwjt1PQZnaw=;
        b=mvQJxzbjmlB3CNfNvEhx2W9OmtCgC59gKzFizfFKptZzzJuRzVw6xjDZfpSjowQaoE
         Y4e6CZzxq3x+E1py3z06m1JVvu/C0ypB1D8jC9L3fIS17Hxipt85tkR4U+TxE0bMR531
         65euJ8Y4+XliRFR4SDChOu0oykoXxUJ+8hHzVpLgkTePwC+Wkp769wvG35gXegAd/ORE
         nMTdJluOO3Ar/igePpdosR5HbAYQ85I5SrN/w2pcSoq1K69N+O7zvPjfoqbA2sWo2jtu
         KDWQcpKwgBIuRY5/5lK2n5TEHRDdBbEkYNwYLQYCFMTAxQm1d1lIFwpe0swWtG8AGnMd
         UbSw==
X-Forwarded-Encrypted: i=1; AHgh+RrCYGbZZVF3CiYpf771nrIH8AcbglBn6oDE6yj12GEKkysoll11b9W9Qd0rESYv+VavBSMprrwGQxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1GSKvkcthJhxQdpTvWMWI8sbOJaFCdkPMaJpOKCJxPdwIUVp
	vBOYVgFGZJTfvB7pyrfSLcPeY4HynSkhIq/Kcho2CXyFw4XZy7lSMzyJ
X-Gm-Gg: AfdE7ckjIkD+jfv7Osx0jD9m38YCGjrsGKS2bURlQADHTCMoFIr4DkLeFEir1EdBwvr
	zCNiSSggIiX2SYqLw3XSIIPq3ZFDpJjnRf3zFIwptPZRJ/1w83prSviIg0bRY3a8i4vuOceDoej
	2pfbjQMeSDDoH8gMocjsR9W39iYiHCC5HQBQfsW4qzPAclS8l3bQH+7xZjQllzrOBAid/6uBJ3B
	n6xYwDH4q0HfA0udZNA/yuPC6lZy/jhS66NyPkYPg5d7LqK4G2zAcBvE2aRsd5k0BPJbfLSWZEl
	IX18fLWAp3BtzP1G5Txao442OheZwur7AoTCXObM6HCcKFyvauB3ZA0FujTUTe8q4WoMhFxr9we
	jxYj2ipYfsAg7aB3ESBlMtZNDK9vXySvFGl0ZfDDXZdHwX1mrA6UkFuxG8a0TyIASalnwEvcu22
	rjLzGJ9RXuyTznCtOaglC6NMvIR9LICeBYbJHfPAriZBZzZ2ddWyDBVrIr8h2Xxfb7m3I=
X-Received: by 2002:a05:600c:8b4b:b0:495:3dd7:ef06 with SMTP id 5b1f17b1804b1-4954839f167mr3249535e9.12.1784223371240;
        Thu, 16 Jul 2026 10:36:11 -0700 (PDT)
Received: from izzolab.play.pl (77-236-3-190.static.play.pl. [77.236.3.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954812f0d0sm7983005e9.12.2026.07.16.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:36:10 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Wi=C5=9Bniewski?= <pawel.wis.me@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] dt-bindings: vendor-prefixes: Add Cytron Technologies
Date: Thu, 16 Jul 2026 19:35:54 +0200
Message-ID: <6200a36aa6daf63eb913016bdb4de114ecae5382.1784221074.git.pawel.wis.me@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1784221074.git.pawel.wis.me@gmail.com>
References: <cover.1784221074.git.pawel.wis.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a vendor prefix for Cytron Technologies Sdn. Bhd.

The prefix is used by the HC-SR04 ultrasonic ranging sensor binding.

Assisted-by: ChatGPT:GPT-5.6 Thinking
Signed-off-by: Paweł Wiśniewski <pawel.wis.me@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7..cd4674569133 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -397,6 +397,8 @@ patternProperties:
     description: CUI Devices
   "^cypress,.*":
     description: Cypress Semiconductor Corporation
+  "^cytron,.*":
+    description: Cytron Technologies Sdn. Bhd.
   "^cyx,.*":
     description: Shenzhen CYX Industrial Co., Ltd
   "^cznic,.*":
-- 
2.47.3

