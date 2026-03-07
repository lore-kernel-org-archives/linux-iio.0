Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BE346FDB
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880534; cv=none; b=cottTiGozejEcbH+asrontsfDy3DtLv17AfQlbBWQ5ED2+hacVbfbn7cL5sBy+Knr1RrMv5JIl0ViiyCEAXQIB1PE7bkXKnzdGN0S0wAoRiUVdaoDvFnKqiuotGz2pV0bZ+gvdo5f3KTaZ+jaWcybEYre1x9YmZdB9RtuD2jxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880534; c=relaxed/simple;
	bh=oD9J4PTS3e0atENopQQx0f2jX+RbV01Lv/Xbd3w6cZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSxM2NcR9WD+W9Yn8iRPrfnpkRYiXg1/14/Sy5pOXfRPJ5iMvEU7KFbTjkqjt3kUQjXjgc9dMAELbbalbhhZsD9N9cDZUHd9svCOSIJzOz8Iwinkq9xmIU07VmAK+NJAmKj5K0Lxcs9f+JrYQB1XGS4mykNiFEj6Otj0w2vy6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVZb7d7a; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVZb7d7a"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso29783875ad.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772880533; x=1773485333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfXVdf6r4/DncUQjA173ENwjELEIP0ISofHv+Syat6E=;
        b=JVZb7d7aiJhFCebOIO1AJB6if3B96gHL/Z1uddb1IM3+f8YzPFMgb/hKzCsIBw/7Ss
         0gIanUcM9ytv+Sw9mVf5lWEUL4PA5K+u44m3At+mfUAlKnyIKAPdMBpg9JiTLqa44MnY
         nSvcJp9XTJoJWyiBh7DgEIb9l2BCA8yr88PFFlpQVRIxxS7mWVDUkvVvsnYWTUsPUDE5
         xWBCh/eXdbOKZVl/YMYlRpF1ORtKVSKmxiG9+47JzuVmg5By1xFEDNebshKUtwQ6OFtH
         eRbuiMmtgPH28ECrQejyPbVDANgnp+/OppZWpsYcIiG8l+fRha6qQZvuHNp9rz3WjhfQ
         0N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772880533; x=1773485333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mfXVdf6r4/DncUQjA173ENwjELEIP0ISofHv+Syat6E=;
        b=SFtklAs9t2sPLvLqUfGSgawnf/+yJIFKyR2Yc4wHviPLNY0PneAQPWSQ//Zv7ptaod
         sn0nta9nXzBEsBBKYy4RoAq8qwQsoatj0LUyrkKrjB68rG821GB1+K4Qhzpi1NNpO0Za
         ipIJBjn9F3WefN5BQu7mNmSjDxgXeefWEO5B/0p8aHv1shTdiIFPr+R8Yh4OtzF+cluC
         h5g4MVdWxXR81O+SUxIC/2X7211O5m6Fc0GdDlNUVKN2fTXc81M/XVxphleZk18ftn/k
         n4THEyoCiePR9SOAAnGaM94Eh2XVJRS9mvAoH4/xPXzuEWEEGP61qosdWMC0V5VJLmW7
         d9WA==
X-Forwarded-Encrypted: i=1; AJvYcCVLkqRbzA0iwKGpL0E10L/Jy5bnXqqBMYziF8uf1HONv8fqVCEmVdYMAssiLS2dg1/AOTmdkmbhcAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xsEW36JCargWaB84lipmTQ4x6Mu2MuvCqg8TlT7K14zOfFTK
	M6jMsK4x6wua3b02fXgFo7iAGX6wxKJafH+CUlVaLLPAcSiWOeM0zMd0
X-Gm-Gg: ATEYQzxy5PLfNZXucqxN/5q67bdSHEMwxsgjHayFz+Ixuc+aFhdhInef5T6w35hd8v3
	RR2YffaXOpMkdH5d9EsceI9QD4yKWQp2TGCcZD3kXahTkZ3HDoQrr0YQg+ibci7pyBW5H6RjsCK
	1xrb3krZhSe4eHM3L3owZOeSUCsGGV21UOjKj2urHplPUNqiD111/VgJqZZeE7hlszAmtecfvUb
	7549BCPy4/tThrRZ2JdfeJJVXspCS4iJFIdkF6KePzDhVpdLsIDYZ40v88IYjiJWdg+UzePOTvS
	c2uKkRxkKPAQaubCqTF/s0p4315KqsWxwNzYR8CD1PZmYpllLRIhlUCtDXK8fXF3nA3KmrakqaI
	y4gg+F9DbFDQVkDYiv/oyJqQyOeHvWZOgqyOOZpM9i5br2g6SN/7G7TyjZu0zxEW5eRB6iNhjI4
	GjoYMAykftIvvArtwH6f8AS1qw
X-Received: by 2002:a17:902:e786:b0:2ae:5a70:476b with SMTP id d9443c01a7336-2ae824399a7mr52631775ad.15.1772880532927;
        Sat, 07 Mar 2026 02:48:52 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:49e5:cff6:c6fd:2f81:fb7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78d48sm49541235ad.22.2026.03.07.02.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:48:52 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com,
	i.shihao.999@gmail.com
Subject: [PATCH v2 4/6] iio: cdc: fix spelling mistakes in comments
Date: Sat,  7 Mar 2026 16:17:03 +0530
Message-ID: <20260307104705.49129-5-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307104705.49129-1-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix incorrect spelling in comments

- becaue -> because
- reenable -> re-enable

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/cdc/ad7150.c | 2 +-
 drivers/iio/cdc/ad7746.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 427d32e398b3..274fb143dedb 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -306,7 +306,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
						dir);
		if (ret)
			goto error_ret;
-		/* reenable any irq's we disabled whilst changing mode */
+		/* re-enable any irq's we disabled whilst changing mode */
		enable_irq(chip->interrupts[0]);
		enable_irq(chip->interrupts[1]);
	}
diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index 8a306d55c72a..cb97e3c978d8 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -606,7 +606,7 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
		return ret;

	/*
-	 * Offset applied internally becaue the _offset userspace interface is
+	 * Offset applied internally because the _offset userspace interface is
	 * needed for the CAP DACs which apply a controllable offset.
	 */
	*val = get_unaligned_be24(data) - 0x800000;
--
2.53.0
