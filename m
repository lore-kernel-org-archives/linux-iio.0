Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDEA2E888A
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670818; cv=none; b=pSkQ3Hd2WfUeBPnickTxcwPQFbRSi/YNh0nTjrIXUsnvP2hERBoIDq15lA0vg8nuyJoVvqiRDaVBTc25dwuCmG48VmNybv+pFuiwC7veHR3CT2fQxGIN4ci+pCcm4g57wzDQTbVW66WiQ85lLJFBu6zBJj7Ld0J8ASsrIVtuCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670818; c=relaxed/simple;
	bh=u+kevyPnLxU4MQJzmWoPjbtQ03xVLIdoxI8EScmBTQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs7A1aCJcntpCmAtLuT3TfbPPN4bQyGROVDaOsWT+HZXn0Hee2gZ3UvengB5RK52xM49Lnl2yJYpO+5v9Kax2mtp8ZIgKfPQSknTN0+C4RQ1GmHE74vCwR3PysGh9nu3QKlAV3uyiTSLROujRKKLofD6BR6eO7lRK9MSRtuDOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBUuMZD5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBUuMZD5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a102494058so8160215ad.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 23:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670816; x=1770275616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbYFWWObFu3JxW8GCC1dOuwk0ex4MEscks7WeB2S5GQ=;
        b=dBUuMZD56ygmqlup/tB2HYmD4L58ekk4H/0qFbRMxlW+yOwq9wHe4ZOBi+dIaZWAVQ
         JY3BHLEumkynphtCaTwi3IbjdQI/N2A1Ge9mkdJMBQDr0gz6BXZmQ4ycvJ7XdpnnCy7p
         PnzpQnky502drpjyzT+FFZWQ7WZ8aB78PgMz6m4sdkLVYMmEZfP7RxI/Dx7mYosSxJS6
         lAM/hmjhu9CpG8i0XgmvKaAbHj0YLwdO7aB5NrDfHEJ1JXd/Tech0I28BfdRbg7Of/lb
         Ld859nxNjzIwuw7xi8/PVvP5+OelTUqGkbAfXWuhkDBH/Zv0NuqDM9ScUoBsJIyImBbJ
         W+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670816; x=1770275616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WbYFWWObFu3JxW8GCC1dOuwk0ex4MEscks7WeB2S5GQ=;
        b=Z2qn7N3ItrPWNPFIbZAG4COAn1qgxNr1T7yD7Qv5k1jPJdSbfzhPokQXLE5bys136e
         KsO1it9YSENFUbSzx3rh4JID9Qjt0mvfaunm22aPT31xzyxK+1+sOG4rqPm+FSggPdTY
         Mb+LxbjL9uJznLxjs6WhI3bPhgyOlstLB2xvs0COkKvgah9t4SxfYo+X8nOKLFdC47wG
         v1jGzTyfaqAZPylq617DEmraDrc+uQhWs8oJ63hw6YRa7IEiIpll25t5CMI+cNuPd+Co
         HMZYOVs2JLfDvenKtdRqc3GvHV35d9ZeH9LuTY8fnDlGFtSJ+stHItJlFCF29tLKx3NO
         IGOQ==
X-Gm-Message-State: AOJu0YwTckpMGBfOUIBxU86KbBJ2IoalHet8IOrqAsJHu2zFdrOSYWgQ
	U15+McA3Onw87YNspF7/sGlizvtnlbgfE5rZMK6by5c5OmcNwLlM86/os4eth+nM
X-Gm-Gg: AZuq6aIGgV6a+Z8nEJ2+othhe8TtF22mw9fqF5pBy3vlUhIw98dBfHbShHS733PUaY6
	yyPnM7dmHFaKC4DoGvHlT7oKK8QktUYog+mSA/XvK3RN5EgcyEohrjK6/pIgRFIN9zCQSe6v0rs
	02EhVpKhZOsw1Z1GpRExTmQ6IPrfkEk7iYM+OtTknNjd4vT2bjSDO4+xVO2SS6j0RqsyRjzEQI4
	rN1E5I5YH+4GtkymPvYpr7fBC5MmKyLrP3A+qs16kYNmSwfSXmFdAe1gMj9zXga7KAkiNCaG9+k
	OPzyaJqioCtzykYJXgYiNTdvkGTMa1saffp+XdcT7aXze+7J1Jyr/nc8QCxWZElPdHWhHLoGYSj
	eb/5J386SlIJSni2hS4JzQBjSxemdXUnL16kg3r9TTLeOkU4qAy9lLfP0XfetVk0978WYClqr+Z
	rXzZZOBMP+DSIMGh4BwXpQ4snjj/JBBiqvBvoLiLRdKftY5K6OkY6c8KGf9w4=
X-Received: by 2002:a17:903:2445:b0:2a7:8c6f:939b with SMTP id d9443c01a7336-2a8bd511218mr17357335ad.27.1769670816149;
        Wed, 28 Jan 2026 23:13:36 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm44160135ad.93.2026.01.28.23.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:13:35 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH 3/6] dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055 magnetometer binding
Date: Thu, 29 Jan 2026 15:10:59 +0800
Message-ID: <20260129071105.389493-4-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129071105.389493-1-jerrysteve1101@gmail.com>
References: <20260129071105.389493-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device-tree binding for the bosch BMX055 IMU (magnetometer
part).

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
index a3838ab0c524..fced5630cec9 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
@@ -26,6 +26,7 @@ properties:
       - bosch,bmc156_magn
       - bosch,bmm150
       - bosch,bmm150_magn
+      - bosch,bmx055_magn
 
   reg:
     maxItems: 1
-- 
2.52.0

