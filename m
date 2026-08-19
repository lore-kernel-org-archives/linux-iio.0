Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1373D3324
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127783; cv=none; b=rr76l0ovtn2WnSBQ/jx+irsFi7xjwKmZlvzVitioYSJoDRVIj+VBM/BcTqvG7HWucwC7Ddt0NNtXUWfjPgTBRzuKmGsX5UU3CQK4v+79xvpkohR5FLeBICFfSBQdb3skr15NOgbkVqIzuuwhVbm+ncmYRvpAG2jcA4PVoktH9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127783; c=relaxed/simple;
	bh=InVNLkHC4ZARvuE21sm2nFi7LoSlGZM8sBE365B18EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5nJVkSOzET/lGt7gJIHxp3nxtqitHrzRpT4p53ckEKid0L6wUoo/TdlfUXjBtuneiA734EJXbWhwSp8+6MaIhLUtSU41oAt4jzikKrO19EGTq+xhR15ijJUleQMZ+dZ0QNG5/wd0GAYK/tbAlC3Tggf4UeE3CRX8W000VigSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7SmqnQj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7SmqnQj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so7228505e9.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787127780; x=1787732580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InVNLkHC4ZARvuE21sm2nFi7LoSlGZM8sBE365B18EE=;
        b=b7SmqnQjFXhQ3lb8GEhSkio9sFBUgyHvJOl2yFK1wRXilA3TsjOkqo+Tw6bmifFllG
         z3ZoXX4pf2j3KN//CXePKQdEQRbLTOE7hmL01N4kRrvizSEMCvqMKle+b6xjTcpZz3AT
         aGQwtvVQKTMKMz2Ln7ToqfBAfpNSRoQYha5+ToxhXLsptQn8E0WY54yy6Ofq3qxb8JMu
         sDaywK06N922UrukC7BJ7mIh6B1D6w0cFVI9t97TrPTT4VG76G1WAacS0zZi+fSrmp3v
         WcYpllgeQ19TDBfV3H2BBVyYgRDvzQUT6bUUrbyRRyPQVkvumH6+jJilA0Ik+gfTPVsE
         ktzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787127780; x=1787732580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InVNLkHC4ZARvuE21sm2nFi7LoSlGZM8sBE365B18EE=;
        b=WRIT81jBDdDX2miK07Wl6w9RoFt3k1mzq9LubZTmZs2aLwMTG7w2Dqu/c4/3QfF+X+
         lzKgsBLXOoA9Kb6Hf7NfDYhzAWvKiJDAlzw26tVUvjDsbSczizs9zgrxL4o5SCj6rMVX
         9F6+7JZjy7t7dRur6Z9KYbZyxBW/xMr34DKXl1QomuvROLIZ5taOpTCDfnWRVbHgxzrm
         220xehzQmrm4ClpLf3c2v9zlnOn7cRsW1CkzhnUtPsluDaNhN3TehqPbbC4hA+tNbzWy
         WY1zU5zPoR3+33xd2Vurz+fRsEpswC7liXKgGzXcuIS2ijd2ZD7A0G+Tj6j/InzmxGB2
         Q9tg==
X-Forwarded-Encrypted: i=1; AHgh+RruwQ1sadSvwru2+q7WkZOURsASPSKGDGeaQB0ZSojfzGtWq28AaEaPZko7VK+UFb0vbt8a5Zgracs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCSsSl2GCZOq0rNSvOZK9UfjOq2Xi+NGElpDZ5jhEnizGLKPT
	IM3s8xhKjS2WN5SLeHv6JeMm0bGcNwNT+Ax0D+jdN1a8c4cO7zKtcxDx
X-Gm-Gg: AR+sD12ua18nJVLN5h/s+rFiaqxWVe5kPqfDli9GZ+vPRUSnrchjRu7hCUy/JZZPTDK
	80z7Sy4TmwHNXms6Eb8iazlKef028XWWqilmZlXjETXY9v5LciaWgMi1DVOhMZz3sbpBsY7x4k7
	tlVrfR2dVP1ebhf8o5ICADqUsHJ41aTp+41zjYLXbq34qPSrsF2Os+BFYES3ktUWAqgIiGr2+Yg
	awFqAgOcyxicBXlnbrtLUdHfUsPlulnxGN+OWD8KYY50nCXjjVRthOt+a9vfnZMhI9ZvP+c8Mtv
	gArvdsC6rs1s+U9P/aZh+3t9bbPhT2v0Q4vgQ+lyxHPmrpmTAAhAwhqE8Jj/OlbPMY3Tx1TPNDC
	Syt6Ecbyb28hKSPvdE0vSwIa7WiRdFxQy0ws0Wk73M5LAh6S14BCnVh/11ADTLUAElVLpXa5v1E
	dMk60Irw5FbH1O6GXKpF4EzLPmhqeOpO5O+k7nCRa4fee9tbVhB/x4FMteo08svDmwBp/BepNTI
	BBsUJ1FLAkopi1nqQ14KRoz1Qurhkw=
X-Received: by 2002:a05:600c:6990:b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-499aa1ba0acmr51276245e9.9.1787127779675;
        Wed, 19 Aug 2026 01:22:59 -0700 (PDT)
Received: from fedora.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9ded661sm35634895e9.2.2026.08.19.01.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:22:59 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 3/6] iio: dac: ad5504: remove legacy platform data support
Date: Wed, 19 Aug 2026 04:22:21 -0400
Message-ID: <20260819082221.11227-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoPjdqzHrU5j5YWz@ashevche-desk.local>
References: <aoPjdqzHrU5j5YWz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This breaks the case with dummy regulators as far as I can see.
> Has this been discussed in the previous rounds?

Yes, David Lechner suggested in v3 to follow the pattern in
adc/ti-ads7950.c. Patch 3 is an intermediate state. Patch 5 replaces
this block with ACPI_COMPANION() fork.

Best Regards,
Taha Ed-dafili
