Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357302;
	b=V4ocsSgG+ap3rdXFcItKyCFSQpKPGz6+53m5Vt2xltpaaaOvJCM8mPDUQ4tCvWERD2sm
	 w3ydImIjgHjhwu504LjZz1SsPFSirDKcvlbQCAMOTex0SlwVIF5H6VLgOxbm9pc1W4vHx
	 oZeUugh9KKcdsBstNAE6PlSSnOj+X+cUKivFMa+ZcPxcExLijgo5ynqlLa+HJINN8eXry
	 4cZapl4sHw7ICIkJQV392Wk2IJVse/SJjnrIYcVmvxi7+zXWEFifuB/IZ9q27G7l59nXI
	 xZ69vuZO4TM5sDsxACJvLOdWexkI+0kgzZPTiBPk6MtSNAAh1TKfCir/C3bVfBk3vIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QpStEmyGQQsu84SS4INTHakUVlKWH4EpwsSW4OFxdxk=;
	b=ALCSh65FNDPU2PPCexJjz9eolXkuJKoYaB3jY33VYBi+v6arNAxvofXoLAvNhToBEfit
	 l1e0e+Sb1LyoZOhXpLVxxlzu7MvyFtt5PDbHYMKp4YOFMWNWkUL284iTrZQmfi4tsDjcy
	 q3bxw9vK/T29nIi/FW8/miLcHX+rw5LsUH0OitsU7eXoOMvZFV9nJg6cVTNpgQQY/kdZA
	 cS6y7Xe8+bLAmVDNfOuOt1+9gmQyyVJEfOnyMLag0Hl++xJnJcGWBmR2Bhqc2odRWIoC+
	 1Bu7mwN7JpEINfSI8+Fr1iyYXGmRqTqhY0T2bdIOziECtFsePyrJwfqlmcvWPQvVTxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TgD7EExM;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3A606A325
	for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 10:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81D3A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TgD7EExM
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so465869f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357300; x=1793962100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpStEmyGQQsu84SS4INTHakUVlKWH4EpwsSW4OFxdxk=;
        b=TgD7EExMtyLX1qNBHnezhB8JBhjJjNtwS9ret5xVef7xr1FZxQuVCJBSL8QXqaWLPh
         Pa2KsJ1BUKSAm7e2GHVtKOE+L3TqU3tq5yRoge6i1E24PkiIocgQfexJ6bv2ZVy7/5PN
         2SEdlTV8QmhWQdwsJNwWGFeSxzR42/QEz6IdOuxLum+hxvgoorU3j/lxqQumzs88zOaf
         Bs165BifaTvp7zvnFilHIDVSairKJDJk4MGH9YY5jq0nvYv+NJaipzT4fzEu4/eq0Gys
         1w0EQbazUBPYw976ABPowMYajY9jsaZA84nCI2axFc2g0z1TH3/6R7v8v88kV/Pb2fWZ
         4PEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357300; x=1793962100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpStEmyGQQsu84SS4INTHakUVlKWH4EpwsSW4OFxdxk=;
        b=SdTrTYTLn8BmifbguGjAdnOaTnaxGWO2TUPRNmi5ACy7MSvKY6pSKIhHzhipkpS1j9
         Fq+twEOBvxQxrdpega7W6Z0a4GXpnDh+7uA3vzi7E/bimOw7fiY2hsdvJB3qMFIKjW34
         qCE8qpJi0hWNOqf8zRQZMBIEvL1AIAR7d8VhU2yMA37P61o5Zvj9fwWAzrIBzNIhxdes
         LTpETYSwwSO3YQXblR5eC91cSS0m+2HwESnT5Hd4UMPWbr8291D+jXAX6RfRlofYNxRO
         dHcihIDsIMlLb49MjjAIqMn4Bzj9SP8fVLbfoADZ/7YeNP0FHKt+OYowbNpg/ZDe+p2u
         Om0w==
X-Forwarded-Encrypted: i=1; AKwUvBw9QGs1HeA04Qt8f4x2K1D2kUMN/UctTkS1rDdegrsNmV3BNgpbHqd6ulDCnK0eheo6MfyhfBVqX6A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuTnyqf5bwldS8OS07kwJalrmPP6YDu9NZzplhoc8eAUsMc3NK
	+adcCcjZ9DD9bb4Q1vQOkJKDBV5bnGq92PgjABz0GsXafNtfDJs6zTYE
X-Gm-Gg: AYBFou0uko47LXdKdS4VarKNJGg1jOwnCbrbmk60lABAY36SaWZhNjAQEKgdOKMWECJ
	0+exdulAMk/NVwdR+JvhXVZCpZpl8XtJPVTS31d1zmsckNRqkwElRfmV8TEo7mm723TEQcBBv6l
	yt4rMjnZszsnKZMYAZh+XnoQ5z1m43XbpdA7A1VQ1AQZ1QLBawLBXy3em7VIyUG0UXKQ4vf7c17
	Tm6nEJ8oODiHuxzxVVnUhK/de8H0ufA1OOU23hb8pmwRviWsFuiRe6EfErNZI3T5BGc3i7DbK7s
	y/EKeCZckh4cMb163CyF1fmtngQ/bqMn07N6ZnIMyedVxakroDGDKulekmSzgE8Cc84Z/AZwFYX
	Si3AWHYTkILPjMKp8CYRAbMja69sdchN5m68eADPk8lOZvM8gKhf8HJpxaeCnghpH4JI3V/eT7x
	td46AodKJiMMCJ/1Y1cVd6EX5R4Sd+M+VVeAXrjLG9J3orrssKIHFuNdB7RkAFvCJk764NvOcNd
	qyo/ycSFnILumy9EYTUC/FfA/iC7qMXjFdYACV6D6MgNQ8v26bSpj5Jl+6VcF53jGSbuayw6AeD
	ZbUk94la3msFR0b+5pjIK0s5p2XxW3yCH9hs01g=
X-Received: by 2002:a05:6000:26c5:b0:48b:e50:714e with SMTP id ffacd0b85a97d-48e6e50d8a5mr4237079f8f.36.1793357300391;
        Fri, 30 Oct 2026 03:48:20 -0700 (PDT)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae25dsm2240473f8f.59.2026.10.30.03.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:48:20 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v2 1/2] staging: iio: addac: adt7316: replace kernel.h with bits.h and kstrtox.h
Date: Fri, 30 Oct 2026 12:47:44 +0200
Message-ID: <20261030104745.16693-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030104745.16693-1-abdelnasserhussein11@gmail.com>
References: <20261030104745.16693-1-abdelnasserhussein11@gmail.com>
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

Drop the proxy header <linux/kernel.h> and explicitly include
<linux/bits.h> for BIT() macro and <linux/kstrtox.h> for
kstrtou8(), kstrtou16(), and kstrtoint() conversions.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..d4b759ef637c 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -10,7 +10,8 @@
 #include <linux/irq.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
+#include <linux/bits.h>
+#include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
-- 
2.56.0

