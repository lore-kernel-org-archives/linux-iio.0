Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393A23E34C
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608390; cv=none; b=sAv7hGiJJHiMZhYJfLJwc4eejrKQR4iJ8l3UjY12X+WOYLpXHmZalZh+Cpik0p0pDsyoL298U4rnPtGK0VV98MOYyg5LcrXWHlLt/uJjeUM4+/nZiBhk/mIr9LWtkZjyWZKjQqVJbQtdliFKWiE22QZ9c17eOJk9BiP4GqhYHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608390; c=relaxed/simple;
	bh=ECn+IK/VfyQCC2gxaQrekOjXex2M2EXhTLmhUg6BTQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvrXWeAlV8Tr3aNTSNoK3K3/bHGMklTQZH23urBlrJBl8In3K8OBteLPh05dR5E7gFP9kVF7BmCUZdtM2WVAbHAE7fs9VReLYt315okgnvAn8zNP+Vh6PyAOB6ivDJa9BEEJ6VudqBlUzQFtVxyUUctg3dDOSIWwNNsM9PhM48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/uwdRNW; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/uwdRNW"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1233e05c77bso286070c88.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 19:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608390; x=1771213190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY93OIO5iWMwE1xSdytzeXaZOhP6N9yAtW4y2SpJcLc=;
        b=e/uwdRNW+k6JQJ1Bl2dNnVqgmvIbpG4vV+wrfrIE0n4T81hhl9kMcLyscnR2v6t2eo
         ibTt4AaCiGHrT4Rbs58eH4nsFNLW2QG9Y6BCReHviMMunwsKgZQ12L8h5kFCn8wQ/4sO
         2XybvY7w3mCMtTHTfrsp4U07M46GOX7lq4LxMFusndaHmxSTSmycdQ+oKl/j1SdZfpbS
         OsuhWra6R35B//1D9Xnkp0ptN718Dh9w2S4yXU9Dd/4SElbJYbOqB8w58i+1CWsK5uK6
         2K2VmTvGdr5sv8knMrkc0hnn5MseVw64V7KZCTAucRIAbHgs90qt0+4qVktL9L7cPtnN
         PqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608390; x=1771213190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oY93OIO5iWMwE1xSdytzeXaZOhP6N9yAtW4y2SpJcLc=;
        b=ERfa5YlhDIkQ+wdLxgBqo7AGBm2uun3/3hBFHL7zi+1TfzcsISYfpq9cLi0OiyC+Ys
         k7z1i82fU162Cc8/KuZbj0veY7us8YNj+VXRu7DjFPjjt1Qxp3UZydMklFbdw55c0/0+
         dTAd2C2wSmCLLW0D0wQDBHUXyoTZueSdgU8/t7U/aGM8B5ZG30dWF4YSl0zdZrYEZaUy
         nSc66i15JiBwzhLqtiPUj3auARq5JXHr0Wz5bMuNGUMVVCQzoqI+ldX126sMccaJBMxm
         2yFzZIusi6RjKgsKJx1mQvCBygpZNInzUDOgbuoPgJlnfzlquKEu6Xi1rGOXnmOXteKw
         eOWA==
X-Gm-Message-State: AOJu0Ywge4t4eyTndN2KaSEjUxHdvxuhlRSwxRj6FcV5No/lJUspyV+0
	u+MhoXCH84GgTrzu0Fruis1W+L4KEA/fSQBFaNnSfpwgZ1XaN6Oi5yI9FeTQHQ==
X-Gm-Gg: AZuq6aKy+hZJ6chNlKOTL1QPz8sMu+StBhLFWFWkdMhgLtL237yYVN+UC7JKnxBIQTU
	kN4eTvxEertPthX6Vv/MwDxRLtQ0qDyBiD2lk+LclJlbLURuO1Sw6/qtTvosRRt5fIGYlL2Ep8o
	H9ooNY7J/XZklvbPtLDgszGysK+/g964B2IK9JMDAhOHZ2p3/XaliC+tvp5Y1kP3sBe93BW6Op4
	9hleCoGw44rFn+1PI0ozn91IsKV0oQVmKiep0cgz/G0zLBDesFpkCr8QoFieOg3A4Zrnr5ECJQl
	7rRKX8MiQIE3BGxHCj7LdhbIxqAxNnuN4HBmv6uKTou4OZOCk78DYb+Teya0hzvfl8BnDHGNnvI
	v53NBZSTWfEJtAbfpLxBma4gaWbyEFwbnsuXzwJ738JgNXcicLbkqa9OPhtQP3lMUO4NqPNpfWm
	qkfjmiQ7RyfB8=
X-Received: by 2002:a05:693c:360b:b0:2b7:2b3e:699b with SMTP id 5a478bee46e88-2b85682e73dmr2193316eec.9.1770608389797;
        Sun, 08 Feb 2026 19:39:49 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af5ca2sm7682073eec.8.2026.02.08.19.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:39:49 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Mon, 09 Feb 2026 11:37:02 +0800
Subject: [PATCH 1/5] iio: proximity: hx9023s: fix out-of-bounds access when
 copying firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-upstream-20260219-v1-1-2b4d74e309d1@gmail.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
In-Reply-To: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=ECn+IK/VfyQCC2gxaQrekOjXex2M2EXhTLmhUg6BTQM=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJmdYT/OMs+4mFak0L+XceOWF0msMpG3F5R13jJ+8vKAZ
 8ibYKWLHaUsDIIcDLJiiixnXr9hzVd9uCf4t2sGzBxWJpAhDFycAjCRYimGf3rBAfH8vU8MMs0P
 3znzwVZ84/mAY6uOH43Jtrvl1jKLR4rhF9O3jbdmcfrK/vy8YPsNjT3fuENeFKtnmFizOuilJnX
 6dQIA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Initialize fw_size before copying firmware data into the flexible
array member to match the __counted_by() annotation. This fixes a
potential out-of-bounds access that could lead to a kernel crash.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 2918dfc0df54..ad839db6b326 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1034,9 +1034,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
 	if (!bin)
 		return -ENOMEM;
 
-	memcpy(bin->data, fw->data, fw->size);
-
 	bin->fw_size = fw->size;
+	memcpy(bin->data, fw->data, bin->fw_size);
 	bin->fw_ver = bin->data[FW_VER_OFFSET];
 	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
 

-- 
2.43.0

