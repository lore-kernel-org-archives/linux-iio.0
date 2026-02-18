Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251B2571D7
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771387003; cv=none; b=SAkkS55aeTQLh6IN0gPKwMetBKsumQ4cTfwWugApM1+1Fex6b060KxbOHdhHBypQx8UZGtVLaYRvreHZUYUFkoj4B29M3D4pnXlDjHWDZevBAdEFBkPpi8lg0YLJz3tqNaYaUxqzcJIQf8VheBrRZcLLkmj7+xqsFXm2FUGXeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771387003; c=relaxed/simple;
	bh=ZGRD8f/vmgHsS4cPCM2Vag8jMW6GX+ve7szwf8ZsQtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jiqM8gD/8aHdR8sHGnUSsoj5HORFrASU0TEJE1OwGtJtlLmmiGvM1O0i/kwuc+nK8ezrsSToCjS2YrS+kKNeBjT0wQPmUMRuMeLQ9vagPsBpUTOkIAZmedMS2gG/jqChwIUbnMucpAoL2QW45jAIQ+h0DND/muGsARzlYbkiApk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs//meXO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs//meXO"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824a9348603so1831796b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 19:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771387001; x=1771991801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQzJOwtLsDmI7U71IMGws3J6zNB9Jw0ZiqmOd3FTqN0=;
        b=cs//meXOMVmf9LOC5Q8gOiNAH6Z0vJheMrOqnAKpRZsSHXJd+FoKw59Fbpk+W59sKr
         zRPse8n24DLS52+zgGgFSgLYkTg31981w4u/T8RkB1vpZ10+CmR/XbCWNgo04XGQvNC2
         HYdj0Jbo1DXOxsou1lhEAtktIw0PydluIiqQoQjptvmKq9u3CswA26LzeNHLQjxAtCD4
         a6HJKcx82G8vGLQKvdiJIgQz/oR+puQlQexvtUNFuJw7qxogSCQbQmDeOYHI1yV0JAzJ
         L3j4dYNeSJR/4emq1PCUQPh9yqtHD46gbFksuwwMpDVmCWEKh6R7IidL2SRk7D6P6DYx
         98kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771387001; x=1771991801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQzJOwtLsDmI7U71IMGws3J6zNB9Jw0ZiqmOd3FTqN0=;
        b=WeGn8ed5sJSHlK9gQnR5VMcXBBJkmMOpzCc7UVwogY+Cj3JNr6loPuxAWJKzlBfxAe
         eL6y9qyEDCrzvSO57pQvIW1ev9wfod7/XyfkJ9uY9fbmnwBBemDXAv2rwqJgZHr2xNgp
         IWdlK+4dPSiKSIGsbKR50eLjpI48lK558htFDWRlwwDxkhGIXblYKztJhQCt/WmxBzNc
         EleG46viwR+Q5eu60zWzBAJdiFepYpB7GZIv0VEypDLO63aXyiEuhD/HcPP4eAARQYi8
         hSOE0Zixv4Dni8XcXPKCPDhUywoNykbpjVr4cTa2x4BEvU5juOn8aCCQr4sn7i8V1m0v
         Oj9g==
X-Gm-Message-State: AOJu0YwissK8EBIXkFeC6yAwgZSLr+OhOTI60KqPlcCBfjtPj16X15Mq
	f5mu4YPB0lYZp4C0pfcqdKUMtUrewMrFaCmqxQVSUXsOB1a5//kaD5n5
X-Gm-Gg: AZuq6aIV18wz2R9h4L5p+CfWB0PBIekQux4gbyDBYQGtUPBiudAZzs9+/LsEIxyMbDq
	V8c5k+MJKnrVvP3BxzYSLmGyiJ6vze/vIyAB2xRsHXUkQMccZK6kCTHzsh/F6vWobETmrdxfkZF
	C52U2CAahX6nA6h2wfy8CQmGSF0dN2YM7kLsCyGpUNXrXoQEhBM5jZ2wyfdkyLzq4wdGOpNyFjJ
	yj0Gz8gG9ayAq4IzdrCj4fqlKu3XhkvL2Zfvr3mf8reLbjDgOuQkaa34X+VEuJaD7FwxIUq9YVg
	FQcAMkMuj6KnHBz+3rmBxHAaZkIeo213Qky/1kJM8lYvjGgNT9I4YowcoEoZ8/A1yhbFSOckADG
	pBqBWr4K0OFkJLeW3PhIAS9ytjjkotS03COzCfYiGHXsBuwQZ9a7Xp43Ajj/kXsVEmttN6Cp+QJ
	lwSG3THeJTtrIwn1yAtuzNrpBtbKv6iD8RClzAPOTqfk7Q9+WsSiAEmGB1U106Od7LzdVxPQbby
	1Dy2k9ZR9Y3WQDWaw==
X-Received: by 2002:a05:6a00:1c96:b0:822:7fd8:ffbd with SMTP id d2e1a72fcca58-824c961b794mr13785484b3a.59.1771387000839;
        Tue, 17 Feb 2026 19:56:40 -0800 (PST)
Received: from pranav.. ([2401:4900:c0e5:f625:e469:adfc:507c:4ee5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm14871165b3a.50.2026.02.17.19.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 19:56:40 -0800 (PST)
From: Pranav Kharche <pranavkharche7@gmail.com>
To: ribalda@kernel.org,
	jic23@kernel.org,
	conor@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Pranav Kharche <pranavkharche7@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] dt-bindings: iio: dac: Fix typo in ti,dac7612.yaml
Date: Wed, 18 Feb 2026 09:25:49 +0530
Message-Id: <20260218035549.17871-1-pranavkharche7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the description where "Is is" should be "It is".

Signed-off-by: Pranav Kharche <pranavkharche7@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Fixed author name format (added space, removed number)
---
 Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
index 20dd13706..624c640be 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
@@ -9,7 +9,7 @@ title: Texas Instruments DAC7612 family of DACs
 description:
   The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
   guaranteed 12-bit monotonicity performance over the industrial temperature
-  range. Is is programmable through an SPI interface.
+  range. It is programmable through an SPI interface.
 
 maintainers:
   - Ricardo Ribalda Delgado <ricardo@ribalda.com>
-- 
2.34.1

