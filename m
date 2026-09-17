Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC002F39C7
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632563; cv=none; b=p0HERaMfjTR8Oau7Wfh18oNrr4tSP6LrairARvi4sZ+VhIWal9/Hnx4rUo+Zel9rlMYFE9n94MJZIe1VRJ8WvsSEe2nuqL1v2axar/4Sx9bH3UrpdMa7GuuCqkgTASoHTAyhBvTw6kIUzR2E7PqK3ydBYEJYAtPRpR4zqD1PzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632563; c=relaxed/simple;
	bh=cjQ6RYzc2Amucs+53IxcHHczFj1kbL1NRf7Hpsxfmg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGbaJc4rN+tbO9G9iyzXSjr5ncjtWLAvkw67xhU6mx0h+OGVAhhsRtlRk6c6QpkGv/q8uTN28n4B9S0H1naiFw+AZVNGefiiXfIPmiTBjgEGF4aONpg/8FR/g/eFSGqmfVIkwLaRx3irCFIkqjz23UAPZnD757xrii0G+oBy9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVuVJaJJ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVuVJaJJ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso1202645e9.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789632560; x=1790237360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jNDQvvdETqkQqr6M3U+s+GuEJjts7GdgrSSwohM6KmE=;
        b=iVuVJaJJbujO3c5XIHUBkcIUF60Dg90fOoR5t5RZFE6rFpNU7J9ze72C++C7Fze1lu
         czEGzL1etuAFkPVmgj6F3qnBNdtbdOkum7Q7nJYPKG6a+42ZN3yUN/cYqNsOUVQTRcvs
         ojuqxBKQBjz5nEa39AluoXFMKUQ/6lx6yjug/YoCZPFvfHUOk0ac2ds6w0BrLJr5/xHw
         euby7eAH9j2yEDITeXe+KjSMtYQl4OQf6OlEZh4l9evvki88sfHP0CtmEIvXjsF3xXhM
         nEopzxxIijx7s+gaoEPYOt4Sun//rhvo7QaAFxBZxm92eY7WU7mrYHQxmPQI492k5Uc4
         XMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789632560; x=1790237360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNDQvvdETqkQqr6M3U+s+GuEJjts7GdgrSSwohM6KmE=;
        b=QFKlXDH2t1qAVtupdBvVzabzBxVT3SDoNG8Zegfz7ZZ24Av4+MXThE46nVCd7qRgvX
         hdsd+uF6oiex94fIAIt2Eki+irAb6jfsNrQcpMqrfuPsRAjf8j5Rppg+GUWkcsjRlyWb
         C2/V/uAxSQQ40T10TLfmPX5CrB7e5NLsJ7oOH8pTL0S3fKIG8ms42G60cLjxUAw5CJNm
         A//p6EEvwS7VXfa1aONrCk/tN/5bdFhw7Hh8p6Or76CUGXd0HIxReh7pnyu6zlaLgrs0
         ANTIzOIv7/AMAQwicRhBVPnyJjyKlwReLW/o7UlDcejUY8ObDwfLCA5SMkgnLVQliDhz
         W/mQ==
X-Forwarded-Encrypted: i=1; AKwUvByaStRBv1/prZl5e6gbRw7RbJBjtfwiqzJAIOCi0wcYxDYxzVmGrkvri4kntY6lIhZzvxGgb7smtio=@vger.kernel.org
X-Gm-Message-State: AFuF++k3CvXtLbR/4Sw883NSreBwLiIu6LBhrodtl1cxZVenn6XtuxCU
	lMs5hP1E6wONfqAK/0k/Lvm9fgblqBHDqlVst4mrVqeimfsP6Mksmojp
X-Gm-Gg: AYBFou00JmzZTjuGHu0xEWYyzJ3X7Yhw+T3zQe6WpIPOv7HI8QgxQ73JnYt8ggUxOU+
	SldVLUntdfXDf8hU4s4tOEF3oq25mSPFWidO59AiAD5z60+4nWLHYfGR0vL3IhbuuFys6WRbd6h
	RqRCp6gGRBrDLkmUpr135k9IfUXX7tixBgig8srcz6K94da4PhRm2WASpYuHb/T56vkOFrf1Uvo
	ohnIZ7B86QnGIr/pUYjyGthCIFP0CR+rC3D3T6k4NHizENK6khN6or7f19hliirwpTCT0R/7B29
	I1wn3HzyGUID2352RvkNq6yB8UDol6JpY2iWRZtwyX6NmoJ8NIIBc+ykn31SuwQVnGtqXTwVMMh
	uii4+vzYnrbpvg/Pw7B+YR8GLUuLDtldztw8DqYovJ8wAohIXlbNqbxm7qdd2E0V4ZUhfna/l0g
	4bi560RMAXRfeS/FomRd/9kY+vGzeQLicvWuzYJmmZtTHOvQcVg2a7mR/mQjI5sm0vGQ1R
X-Received: by 2002:a05:600c:1d25:b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49fbd1ccc32mr42120145e9.8.1789632560321;
        Thu, 17 Sep 2026 01:09:20 -0700 (PDT)
Received: from omermac ([82.222.238.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e84805db6sm85566375e9.3.2026.09.17.01.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:09:19 -0700 (PDT)
From: Omer PALA <palaomer100@gmail.com>
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: accel: add adi,adis16203 support
Date: Thu, 17 Sep 2026 11:09:05 +0300
Message-ID: <20260917080905.7654-1-palaomer100@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add adi,adis16203 support to adi,adis16201.yaml for
staging adis16203 driver

Signed-off-by: Omer PALA <palaomer100@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
index b6ba7ad1a..73ea8f192 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - adi,adis16201
+      - adi,adis16203
       - adi,adis16209
 
   reg:
-- 
2.55.0

