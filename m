Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4832EB0F
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781930415; cv=none; b=r5SRdIdFyWrDFeei8WZnq8jERm7aJzaJXum+IK/GdIP8MQzxT4CO1sebyogZFxQP6qibDfCUle0B5jSj1pzkGANd+a9ZvW8kB2jGTt3a8+gV425yO1kUYGpkXytEqSvtrsrQu4v5yY8jVux4ptSuoGHNLJyMi6GqZZ1KpBhhz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781930415; c=relaxed/simple;
	bh=j/KlcuqTGo4rbWXi3VJtgHO0cb10VIMP0agIXghvbZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f31kNs/TgOxbCg9odtjIsropu9zfHJquACdynfuMOVJHCTD2YstruvFccUcKXI0CLQwv2NhhhhF/zBvbAY0LgcXpc9Y5Hsmth2n8pZ0k2aKCAIYL8ezytgOnnpWOtiKdOHmLRPTBoAHEmuv1z9oqPczRO9KPnHj41c5wrWzM8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJpywN1F; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJpywN1F"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6fa36a1b6so2050001a34.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 21:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781930412; x=1782535212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FJeeU9eoXdSFt5ADMYLY67sHZOm5Ehw4SyZLtOa9Yzw=;
        b=dJpywN1F/Rlzf93Nzv92+iinhn7bYEcUztekYMIkHR3gZtu838O5lEn+nLPcq4ymji
         8IFxZg6jRPsDFXSDZaEjkVhyIuLGEIuRB07Qsl6zy7e+wxeqykwBr4S2hjLwFsyUP5JJ
         FLsLKebt/xgziQZueS1qIdZoVilQ37M6OTMgC5oFhoA97FHy7Na8aGuqKBGQ1BrDbmMr
         6VzdT+SDcWUHRboWKodNlKLeifSlMIz6CNAvVmqOF+tRJxBMxeTxDNdxzQDdN/5asFrT
         nr65iPp6WwQSyfytevq4gF8yCr+IGtEljPJlQ9vQVTwVWKyCqRnoZf6ikaICxZgtNX05
         uz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781930412; x=1782535212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJeeU9eoXdSFt5ADMYLY67sHZOm5Ehw4SyZLtOa9Yzw=;
        b=S30c0bEBHNmPM+9uPDybE/No4Gu9C0erRss/1mCyuzsKGLaiaVeJgglarF1JmAaqVw
         qp4A3MdzhQZnmsxhDbZ6um5sAgrOyZ9YjdQjqP8rGVX6nYrPCF6DreND79uTublwLm2+
         2eBAIJldQSHr25iLU0Ggz6pdU7N4Qq/Zhh7+uNy2uWQZP0+9ms+N5zmhsRUIBhypbF8B
         Zb2dCUknyub9RLbI6nB6K7HEQsguzguvdRJMXeDjEfBOMymPQcBTzyn3KopIOtp7yrEG
         aXjLgLpgEjgV++Pqcm1gALfKDov1hRW9BWMlQJMc75MbkyEb10EllLly5qbRA3cEaBTN
         RBfA==
X-Forwarded-Encrypted: i=1; AFNElJ9csdN2rUeRP6RKsm99OT41L5BQ0CJ29r8AEj1blYoM5tJJuSDXowRVK0k4SousT9UNJwznxWJhFrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKX+GJsvf4G/yXvS1N18pNc/qurpFZ8Oi4YHwuHH0vaFzvaVp
	yUxB0iJNoMJkuQ35DuURyq/od40Lt57X9DnPyybth3jcje/RDHVV0RuW
X-Gm-Gg: AfdE7cmJnPLPkVXwTcbhNgjsSaL3JTswA1LFeCQ+4mHek133Uwx9gGLM76uoYHOZU7v
	j6b1i736iBb7CyUkiJ5RSKkz4dTlxt7TXHJx/JVDwEhWTakHTY0ueJ69FeRvAdxCnFkSS8lcOBu
	yX2WWKgVOZHJDipzng9ZZwpoNjo5+pBzmTITma+ReTFrBtkPdFUBzUe9YbcpKWCbhODMVFkMJax
	B26lnD76FGzqwM+yGhPm3LelT8G1z4Av/S+zXUYprWqUj3DboIRxcEbzy5Ub/e8cYSlFQ6aacgD
	pilWWBY7HbXsy4+iRi2HUu8jQzBDuru3+acuzQHGtDHPKk/FptRML5WOSSLUp7ApErJHjXDQyFD
	Sxmn/AywvdforSjOF25O2MmdjfQmvIA2bfI5MVe4yLWNN9ZIepbdjqcK/E765/nWmt5T0d2UJBj
	sdECVdkQTxSLOA7WWVEdoMupfTfmJyzmAWJzHr85P5vDexSFvPzZYKG+1wGA==
X-Received: by 2002:a05:6808:2519:b0:48a:8dfa:5219 with SMTP id 5614622812f47-48a8dfa5859mr2516921b6e.3.1781930412044;
        Fri, 19 Jun 2026 21:40:12 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0ddd7bsm679754b6e.7.2026.06.19.21.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 21:40:11 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 0/3] Add Sensirion STS30 temperature sensor driver
Date: Fri, 19 Jun 2026 23:40:04 -0500
Message-ID: <20260620044010.1082621-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch adds support for the Sensirion STS30 family of temperature
sensor drivers. It currently supports single-shot non-clock stretched
readings as well as the entirety of the STS30 family.

I'm sending this as an RFC patch as I unfortunately do not have the
hardware right now. I have compile-tested it successfully and have done
a tad bit of testing on QEMU, with it properly registering with no
errors reported in dmesg. Unfortunately due to the way I had compiled
the kernel used to test the driver it did not expose the I2C bus to
userspace properly and I was not able to retrieve values from the
driver, but I can continue more testing over the next few days and am
happy to answer any questions anyone may have. Additionally, regarding
dmesg logs, I neglected to save them while in my testing, but as stated
previously, I can continue more testing over the next couple of days.

Maxwell Doose (3):
  dt-bindings: iio: temperature: Add STS30 devicetree bindings
  iio: temperature: Add STS30 temperature sensor driver
  MAINTAINERS: Add entry for Sensirion STS30 driver

 .../iio/temperature/sensirion,sts30.yaml      |  49 +++
 MAINTAINERS                                   |   6 +
 drivers/iio/temperature/Kconfig               |  11 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/sts30.c               | 321 ++++++++++++++++++
 5 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
 create mode 100644 drivers/iio/temperature/sts30.c

-- 
2.54.0

