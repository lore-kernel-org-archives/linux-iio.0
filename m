Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB3C342517
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590307; cv=none; b=ug7vqJ50DJJTTSLH1ggQI6PUTDggdeBmEiJL6O8FWOdvjkyQku/TnU/KDUYoM+G+85jwiHAMDU0Aoz7A0nvSb4YJMUdcU/E6ZE8qMWLAQiH0+QRrwcQr6D801gzvEsTCn8vU1SiL/CgpFqTwGz18cj9Bq5P+O42J5EU4jgToJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590307; c=relaxed/simple;
	bh=0gH5splTLge0qFLUbiMZ48KETJ/EIA4/gs71mKtYXEw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qS6Iz7SrO0pq2rkYNH5gBmrtJVSy6cnZwAQ4TQT7nHSw6guhatiKYocT994/FHi6a2qIVy91UTrwrgUBdM+1uUK9yUgQhR/WybwLG3SUKKg2Imp4bBbtrEippZoXu++zUM3Bp1NJ/FhBqL6GkHwHkTqBH6+4ZGoXeDvBreMgcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6J4wawk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6J4wawk"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso4029708b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775590305; x=1776195105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKzg+vKnmYnL3O/HB0WjkVGMY8fWNk1HjNQ+n3qETYU=;
        b=g6J4wawkEA7mCdYX1OSQOWAddP8cmTah5ont4u3xkJelPm5oW4Ayl72YlQwlGcImIm
         S6HDPHYPnGtdLu+PjNftT/PRSsYOZ7oK87fBQup5CqTRgeuYqjCTYfMHEeIeTSiM7q+i
         RcBsJad4OshKcgMC4F3TSnVmgJ640oxtF0H37RUPQDcCF62OwJi4Jciawtx45odRfBJJ
         9ufe+HVDL0zRoG6g/kD8MRcZlGMBEbl2hCt85ACAljyQFU079Vs95VL/G1jkviCsu7DW
         UUxU2ICLaOn/8dXS2ATq9gI1DlORf8rHyrLYeWhAU8WVYtby7IdLaBPesGG7P4CJNCZH
         7sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775590305; x=1776195105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKzg+vKnmYnL3O/HB0WjkVGMY8fWNk1HjNQ+n3qETYU=;
        b=hvIrPA5VKHUMYn1n99bIA0VNmK5ZJUJNbw7eXXHWJmVcMKIi6xYAkiP1wXYDvnZ5cK
         bC/sceeI3pXY0ysee0sAEIK8lypRzzxKGjupUlwOG8zHGtbxSAdoi8hdhkrbTcIY34pi
         x9u7MLD7aBh7HHlSjUTWDreDe+ENtHvaJyM0gQF5kYVAixk954R6bmNB9PQ3irA77WXJ
         PusTefPeO/Cmm6FYQVo/AOTIQ1NijOD9TKRNwPe+E/KzY3T65LATXpupCeq8vzUJZ+lR
         1j7xUKeq8MI8T0sS/B27XSB+un7reMmZF0ConBPuLGq/UvvxUmI7k+EZnsC5HRIKyhJy
         e9TQ==
X-Gm-Message-State: AOJu0Yxc3vb2x5XOI3U/KmMsKCZ2hFK4yYeO7oiL3V1KddklYaN7xFtP
	xCDrYkdgb3MK2SuMVrxkZ9EnFGne1SjJ94i7fQ7bjdoPFKPQOFXd534Ksci59kBR
X-Gm-Gg: AeBDietAbouPXCX1ZIZaj1gkjuYM1e2XBC7hZfwrdbortpsR/t2xub9NvY4SqcLxDTc
	gcsA2un0ldAV4wxR2RrTUk8wGoQghA4egQ5P+MVUZK3PUR6g5ddG3eH8tOhpIsRLsOZFEhbi/Eg
	gsHSmMbhUjyl0Fp+vClCt7efsepjQbhgFepR9T9TtYcS9SSyA5XWYke03NWaHhPg++Qqobu74az
	FqEhxAB4VpdXZOVeW1HsvNSn1flrupmxPleF8WIozsBJLv7fVev0vz1qL9HArT57WbL2ZFweBi2
	olH5CHGwzWAq2KBaTfcJ6oA2ZDwms0VZL9F46dsbdyGnYrVhWiy4M9Pmtc1uJqYxthmjMlXsLww
	Pl1xhZnu+qYjOxiHVMYCEfOzHE5JgVRuIq1m+gIYoNubyuWY9dJ7HslOpHouisr9zvY6mm2ApDA
	kJxl9qK2YXJVeryybwuzlrDWLxfIYJogNj/WILvHnw8bGa8ucNkYrQA0rV/PblVyjVzCrCk9Ql
X-Received: by 2002:a05:6a00:cd6:b0:827:3946:a23c with SMTP id d2e1a72fcca58-82d0da284ccmr18564106b3a.10.1775590305410;
        Tue, 07 Apr 2026 12:31:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:31:d01f:cc7:14db:42b8:5cc2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b60199sm16704846b3a.25.2026.04.07.12.31.43
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:31:44 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org
Subject: [RFC] IIO: hx710b: driver structure (separate vs extend hx711)
Date: Wed,  8 Apr 2026 01:01:39 +0530
Message-Id: <20260407193139.15696-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I am working on adding support for the AVIA HX710B ADC.

The HX710B is closely related to the existing HX711 driver. It uses the
same two-wire bit-banged interface (PD_SCK + DOUT), but differs in how
conversion modes and sampling rates are selected. In particular, the
number of trailing PD_SCK pulses selects between differential input
(10 Hz / 40 Hz) and an auxiliary channel (temperature / supply).

I currently have a working implementation as a separate driver
(hx710b.c), along with device tree bindings and basic runtime testing.

Before preparing a formal patch series, I wanted to ask for guidance on
the preferred structure:

  1. Keep HX710B as a separate driver (hx710b.c)
  2. Extend the existing hx711 driver
  3. Refactor into a shared hx71x core with common logic

Please let me know which approach you would prefer me to proceed with.

Thanks,
Piyush Patle
