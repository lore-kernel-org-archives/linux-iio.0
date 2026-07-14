Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2C3FAE09
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017040; cv=none; b=L2FSLejMAOHCMJ7QxsbgjMoHdujX8BUaQdB9Rpm105GzF9FK48agTtzqm75Y3f3RYCiYZVwFneB+/3jJzQHTDpRmKLUYezHTZYtiQGYS/ys8klxz2ag5pqEt+kZibZhCm6SIPiHgYspXo1AUfe1n7HrZJvhuHtLZtj92Qc4T4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017040; c=relaxed/simple;
	bh=0Q9ueRtJpn+0V8fYajXPPgDhnxfHEHQJcd5MZ4mr6Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wg5TuzRSkdvxX2XTXfgleNikVEU2Z6LWgh7W+l1I20O0f4YJG8oci/ElvilFJlC+p8vIr1u+/5NcecG6/mK7TPWWpyiWXQAIjjHJXcBYRlcM3hvBN2snrcXtfLIS6gCQyaBbNmTPFhUQqqGWppd7gvAgkd76gczUeBspQB/908E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoPf2NgZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoPf2NgZ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15dd4b9132so573097866b.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784017032; x=1784621832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmXY1tinEamMA2gpoRwrr0YINADk+qjq8kgIZNm3+Os=;
        b=OoPf2NgZVRHvFeI8zG55Hxp8Zex1dK6//4U3HVECoAX05l0hgAtzlC5jMJIANK9yVI
         w5S2+ci/Zs4Xau82/xE2xIi+b7LFfxwxcmZjCqkWBA8B78q3VKbM5l2tuKMSjD3EkG0+
         GzEYKINNESMcMXGn8kjRINZuKZHnppyi3qwZ8KIWRhbHO+uYhucHBnSQxRyBQ7MQCvpx
         eMvKK98a3jyMUHjbTR6staWQXOCRvCjmNNJNoxLeJvxaUYAXIvrje3G3ue4mON6NGEMy
         42lfOZ0w+wUGGeVCDIMnwKu0dPUKyIGmppgSVMj/7GKnxIgnZ5Uz4u0VJDnV1qGSV7Dc
         EPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784017032; x=1784621832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qmXY1tinEamMA2gpoRwrr0YINADk+qjq8kgIZNm3+Os=;
        b=USjGyLmpbBdhkKJBrnsGxpSVEqV97/lNZYiWkRVcmgAEmDS1GkdOyrLRN7mLT6+2Pu
         0dijYgu62lejgpp5inlBZUzIkHs7V0Kf8+ro0uCgCbPaOHB+etLD91CCWH3Y2fZNB8AA
         MVDQ1UTEGB3fmKFkCyDjW8xQeGoz1Fjbk2CT79jwjp+qjQ5vXlKfKXbk/32GHNJKJoDG
         UXLKzInW19vvfIebAiVQ3qKsJKNniIPC9beadV9AybG8gu6qvgfRgg2CzdNTtrVyw/Ql
         Ey8sSHLYlLmjmsZdVlSfg8JslhvU6xIxmbTvwTyJigxSgSt8AZwOZW8QinyPAl4Gq9c0
         vFsw==
X-Forwarded-Encrypted: i=1; AHgh+Rpv1sHfANpBvOAUyE/99gvXsEp4KzwmsiV+LYjH7+BDDxWPZsELkflK3aV4osvSTmICgRxnBqB7P7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6gCj95e7GRgpybuLP5urmNU5P7vcdwkRDsPcU2sRl9It+I3k
	qeJxu/pJ956KUJ8GMgvI0dGF3Zug+mk6+tTrefYzrlpvBHxnY4rJtgfs
X-Gm-Gg: AfdE7cmt680DcqBjmnfGEnStbF+BSbd4Kg4mqrwY7cA8almqMB3E+mWTdeaus6sZZDa
	clfZBhAfDfHyaCWTWEK1kVAf2IO5G5yXCAWn/3NTzMMFaitHEGVJxXcNjilH4YlwLKFZ8xfL3Al
	/+QkphJhvJl9g6rWZl1nyl0SCX6u6eu3IgDwWYiPmSsLSQMTSIjeJjdb6ESSzzVW5Njml6Kmt7x
	IlLk5GyzvWQGsJpN6Ua40qgbMtMDgW7so9M3n7FdnnENpnTFUhBrvBt41S5HFbdBLFbY3UEM5BS
	MhYxFvWz/FqeoCiR7KvGXiqL5HOEDhkYPHoBT5dkfoRfUrGssr3+iZQHAR26CO6IVi1L37dwhNX
	bxd5WH/gB0nmAXj7RStoHAfAdMck03jtzKaH5gWR0FLZ64ETqqP31gAjO5d5fiLqvlWh0bVTRoi
	jHW64ugNbXklp3+uLtypX/Ermi1RnCITTLzVXgDMT9DZpKPA==
X-Received: by 2002:a17:907:60d1:b0:c16:558:e6a6 with SMTP id a640c23a62f3a-c16678c8425mr68187366b.5.1784017032296;
        Tue, 14 Jul 2026 01:17:12 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15e353d2f8sm723085166b.34.2026.07.14.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:17:11 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] MAINTAINERS: add entry for GPIO counter driver
Date: Tue, 14 Jul 2026 10:17:09 +0200
Message-ID: <20260714081709.17846-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714081709.17846-1-wafgo01@gmail.com>
References: <20260714081709.17846-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover the gpio-counter driver and its device-tree binding.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06a8c74577aa..14f1a4e9fcf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10984,6 +10984,13 @@ S:	Supported
 F:	Documentation/admin-guide/gpio/gpio-aggregator.rst
 F:	drivers/gpio/gpio-aggregator.c
 
+GPIO COUNTER DRIVER
+M:	Wadim Mueller <wafgo01@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/counter/gpio-counter.yaml
+F:	drivers/counter/gpio-counter.c
+
 GPIO IR Transmitter
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
-- 
2.43.0

