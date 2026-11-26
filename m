Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676130;
	b=So4I3wata5OIYQ4usPHmtD1IM+MwXM2xkS76MOttZ2HVeOO1WLMojJpguUfm6E1UpJwZ
	 qhCmJe7/C8FE9zVdphdOeV83Xj7yy/4GMkRLPwXaPfAGmXugFO9mlxHO4vFASCcPufoiT
	 V7pfn76Ko6814pi0NbHra6GiYrRum9rgCO7C+MkS57CwNbilWAVlOkGUgndxxXX2EG0Ls
	 L6vQMLonMr8zzcK2earsK2FAnPyGy4YkpHF/LBjRQT8Re7se+5YPiD2C/195nwN4jfKMo
	 IXhCNVmlYGx2fo6OXseI3hiOk0w7nB/MekedZDV/q7onIL+wHKqvHRGz1Ui+HpMFm7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iqbQqcdSjyv2aUti1jwoQTqpIf6exML0ZMxImf95UxM=;
	b=l4fxNdBTPsAwLGCnZhy9svcwBjdl4ucN6szP6VcrsohMqjfGfQ1Ooi0XM240IIqKR5Eo
	 bqm7Qt30+5qIcqLGjxN0jK1+kdmYwwCRtr7yzpZiJh74TPrGItpVA23IP/2wdcNApCzDT
	 KLyjnAFJqhyoJOqYT5mSLFkcA49MYr7u+/aVRXkQtuqMwCYyZBYW+5LLOWlSEKVuypumc
	 P3WgeE836epMJ4/PJUPrTmK4ZLS65I1Tj1clD+F7O2LvTCzJVoBsrwa1twPJKrVV9K92S
	 d1ZWkiNlrv1L5hMH65gVfNOETtzQaJKz/kVOKlzBb1JMAaVJ1TicTmg8hr3qIhggaZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FM8LkwKR;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A5606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 06:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 726A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FM8LkwKR
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f06ff94acfso29555065ad.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795676129; x=1796280929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iqbQqcdSjyv2aUti1jwoQTqpIf6exML0ZMxImf95UxM=;
        b=FM8LkwKRoJm23W7XzvaZ4+GcK2obMCuA0HAqO2OxkpE2HtanpM1tLQPX3USZ1iXPam
         +1NF37DAxnea3UIuOG0jW8xrDVMyPTJ8Yomt7WXHB5bazenk5murQXoDd1qiiJVTCh5f
         tHs763cOMkE/JN4AWWv/6w2zxF11RfVs42f3sAi8zlYFZ185k2fkVXGr+RzBWuFf6v3b
         Lxk3NIi8Yti2AShqFLZVIJ2ykrQOmc1aUvkYujfbmYl5ExwaVOChgAfvUFimSSxi7Wu0
         S2jKezmXfqNNsSHLxQYYkDLO1uSVG3g4yTbhy8xuBoxE1foFwuxqPJ8/AHweVEacEqzX
         3yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795676129; x=1796280929;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqbQqcdSjyv2aUti1jwoQTqpIf6exML0ZMxImf95UxM=;
        b=azimjJhmv0pNROfxdfjoMTgGDi33IS9fQXHdJW9U96n4wGQ5Y0p6fPyNkQB6eb81ik
         FotaCafNcJJu5++9ykZD53BK598aqxQ+OO+H1dq17W/j5uGMweueMtMrgRrr20AC4WrO
         6tZM0GfRQjwrB2ErAyeZyIl36Q358IpNTSIkcZawWl02bWKvfacvNcMmJIp37I3agHzQ
         hncF6MQbjYXkihkBZYQtROvJ2sTwyL13/V9b0yLyrk80b/hm9DZuOh2lobs8lk2cnCLa
         89p3Ssu3zeeWRDQ8DcB8LDY7yniAPEveBnHBbpsgB1r6iH7iZ6R4JYzrlwZv6VU9q9Wu
         wI3A==
X-Forwarded-Encrypted: i=1; AL+hErEGfJIqqyxq1ByqBtzaI3v9GtPhNpVLRf1OC3ofXYtsotCYDXLFFilc4xJ9OsL8igp38yTUvbF9UTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iddaPIueDmJeNJXWe3Ixt6tWda22YAcleNVnwZKd7Un9vHl0m
	0MjD3z+sqtcrOOgV/DckOCfQ/1ODIstQv7KodZht7wsy1K6+UL+dFpDC
X-Gm-Gg: AZFdTZfZdmM2qPyC/uZZfyBJkhx5v1777ogOwOY3mJmuuQ4WhRuX9QTPtFWfG8S3R40
	9yrHpDaLLgE4jPJ7BNQX5lamROD+Z1C/JPp3isoSM1BvC2EOLksnPDCGxr12l2rKERLvx7edHqT
	ur0R3sGnsyfO2Tc7kzNDmror127Xs5bjdT3e91Cujvbk/GHquTayG+BmHJr/BtYSeMp370JfBsI
	ddT0udHq5oTPlpe4B6GIK0vqlm/QPCG9PFbm5WTXO0JrwykObgcANU06cs9+L1mK67dfx0BiL8w
	aSAVIiyxWbqBkK9iK7a8C11978CvyvKdTgUgM3et0b7bh3NIlIGYw2P+MaeCcs7DdFC1Kn3/qmL
	EU/7TSbfZMNCmsAFNjf3C+bk6zqvi73o05G19ghY7b+aO+wMbARyUzzbVs2YHuF1F1iqpbIjo3h
	0mSX0aiawc1xvU2WPlEheiECDvutv3vACIAzw6e7VhcFAsZpHR+iW5OuiqgpGPd0IRBJ0arsBuf
	phlUWZsiohBtK0Eqkdi+/3YvPmINJDROBvZjtzsOydv36uO9kEtOvVViEOfKk8l1JLk0RBOBYzt
	3Ql1wsqNg6/bspOJsC57RBSOjjp+tfXbaVpUoblhLJS+VHuXq5WnR3ymr/1wxuLkRFIZEdMOotH
	HxHGYGe+bHdicBx+1diPpI/q+WUZ+GAv5RNF8T5tkNmoKuv8oa/EecFXYUkBCnoSkot094x0n9m
	s7xg1jfq2IprGV47v5kOp4sEM=
X-Received: by 2002:a17:902:f545:b0:2f0:585b:8d8e with SMTP id d9443c01a7336-2f0585b8e12mr169456435ad.60.1795676128663;
        Wed, 25 Nov 2026 22:55:28 -0800 (PST)
Received: from kapoor ([149.40.62.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ad2sm98854535ad.16.2026.11.25.22.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:55:28 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Ilia Snezhkov <iasnezhkov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: inkern: guard fwnode_xlate with info_exist_lock
Date: Thu, 26 Nov 2026 12:25:16 +0530
Message-ID: <20261126065516.678227-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126060615.63790-1-iasnezhkov@gmail.com>
References: <20261126060615.63790-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Nov 26, 2026 at 06:06:15AM +0000, Ilia Snezhkov wrote:
> Hold iio_dev_opaque->info_exist_lock with scoped_guard(mutex, ...)
> matching the rest of inkern.c, and return -EPROBE_DEFER if
> indio_dev->info is NULL.

Thanks for the respin. -EPROBE_DEFER matches what the !idev path
already returns, so the race no longer looks like the -ENODEV
"keep looking" case to the parent/map-list fallbacks, and the
unrelated num_channels check is gone. Applies to iio testing and is
checkpatch clean.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
