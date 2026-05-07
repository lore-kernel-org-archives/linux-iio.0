Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BE44E044
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176303; cv=none; b=n9YILomawMyp9FxZU20ce6P59aAXWyY7IsDqRgfDFmhlC01Iogt4rF5pZvaP4xKrPlYMj72pYnjKS2EnovPDRV/6a0jJ9TLzvwsCJB6KBIHEfYqBODDdvCDXyBBjXNI0KSpdRLJpilqsXR5PkaH7XycANY9km0DiQT8tZVDg4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176303; c=relaxed/simple;
	bh=B38IOqeFfFEppjXfMCpr7xIO8vRC+Bfgc3JP/cw5xm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THo7Vojt2GQo0TkbsNbxMKKakADPBpQyufHvdki2A0ptpRsfjpoJSQ9kkF6Vsh0d6W9mkyTWSPlDzuKlAcYoIxLTxxKP9pnsI8Yl2uOuFBk4T08j4i1/TI88CIJBVZ8ez8FsdC4cA9aTJXB1cvUiXVByFDC4h6LPS+5MD1pfPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMwPrlvF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMwPrlvF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b788a98557so8884615ad.2
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778176301; x=1778781101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rc0Nr67XnnVTxV7BDLJj1fMkjn78kINM0+eAHzS03dI=;
        b=SMwPrlvFv4yHnxRJNKUvzmRh5s1kKMcayX5Se1LJM45ZbOcpqC+3RPbt0yvS7KKVEe
         llcKEfsdqgQyBDYI8OTP+DWnE1KSazMfi+fId+/ejtgADi4TDWIvS1n5MfL+gUll0udq
         XhMKx67rfnTzUThzClXR4X1StluVkObrJ+Iv4lhVyv4vsklfygOmgDmtFwyh747U+msI
         mwUotMIVYBJzqSNd/oDjxKPGEE+ZFC9M2fMKBA/I2IKzUzZyEfsmz8czEhaGcLTPCK3C
         k+9SoWaVwAgwamnycJ3pc9AB1RPSKMhz8A//7Zw/sokE+iJt+fAy0tjULXzag85jY/jC
         hj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176301; x=1778781101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rc0Nr67XnnVTxV7BDLJj1fMkjn78kINM0+eAHzS03dI=;
        b=MyvY0uONN7H2naJfzKO+WmAk9qRvppHsWSnO81ENbRVk4l5NZaBfdUlbexe6M3CV01
         c2nEnLTCstvuZwOyi5tWxvGZsquSwrwYEwui3wBkTFhdUCb0zslf4XAG/kHYE9ffyER+
         xHUBpuwTo9gCQ06YUb80Riry7rAvwa9qUR+fJMV22VjwmveVkMLQpR6OsdLfrRrK8ijo
         W/cDwXjj036HEkOjLmVPoFugFDkTnzNfoajvGAyDLzwwJBYP9IN8gTUZ4qGx/gVNAadB
         Ji6/hqux1hRwnvsxvoFj/EblenS6ExhX9QpLKQSp6+bzLhovDko3rJZ1JczHGgh5MpZT
         s0EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZO4WSuz1ym1ZRrJG5dq9sZ8fdYCKtl2tNv9irblrTeMklc7MYcjQU/V5sGVp2ySZQBy2ZguJoSso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObOkD0YrCoPrrXaGbzQV3LTT3ws2+700wtjR0s+ywz2jNiT5f
	qZsaygjikhjtCmUWkP9fXAVoVU5uxq7ZSs+qS0X24XJszmNo0mOi3Aw5
X-Gm-Gg: AeBDiety/0BsAEwaUkcgNiBwVca8AwK3VE5y52YInSegGLFT0r0SqZRJdCNEe5zRBS9
	3s5jvcPJAa1sMpTtqE4oDd/Pnz4niUmui2vAB2m2415Nb1LNgfVm4Qr9Vg9vaOWYUlDCNQ5qGaG
	uo9L91jVLeqFlGjJAJhBOdN9FZubRqdzQs3RQNrdQFwOhZpZN55wgHd4UhfMaHoAwsC0+k5Yafp
	j+6Zz5nrwUhuG86aLLnFtPvdvnOv7kHE8nzNTQH23Pk9QmH8LmKX7lHm/ldgrM5Wtkg+TIqQP7b
	CT5Vm/B1V8e00S12gurwhOSH0LKa1XzWZrIN6iKmntJTU37+ShoqmOeo/huVYXj+2atNrhIgAYv
	r6YdRVk0Rr6Nol9vfW11Tq1gLl/m5/G8MAu6YhJelaVeZiQXRZd+8v1QaDPTa5nL3kgWcmxra5P
	KABwneQi0DGEk34FLi7lqeTUvCEBOl7yF/mKfhdT+wBb5DbE+C
X-Received: by 2002:a17:902:ebc9:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2ba7a372ff8mr90363425ad.38.1778176301374;
        Thu, 07 May 2026 10:51:41 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae7871fabsm3153525ad.71.2026.05.07.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:51:41 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	linux-iio@vger.kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] MAINTAINERS: Update Analog Devices IIO drivers entry
Date: Thu,  7 May 2026 23:21:31 +0530
Message-Id: <20260507175132.3063161-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507175132.3063161-1-sanjayembedded@gmail.com>
References: <20260507175132.3063161-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Lars-Peter Clausen is currently busy and is therefore removed from the
ANALOG DEVICES INC IIO DRIVERS entry, with input from Jonathan.

Add Analog Devices mailing list as contact and Nuno Sá as maintainer
for the ANALOG DEVICES INC IIO DRIVERS entry for coverage support.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc42e1cacd6b..86b2520d18fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1861,8 +1861,9 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
 ANALOG DEVICES INC IIO DRIVERS
-M:	Lars-Peter Clausen <lars@metafoo.de>
+M:	Nuno Sá <nuno.sa@analog.com>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
+L:	linux@analog.com
 S:	Supported
 W:	http://wiki.analog.com/
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1

