Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBD32ED2A
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756403; cv=none; b=HlA6mZGNNziBP3tIbBPE+z1F9dZaFhIdm1gRoU/418nLZqFO5iAARKX/CenqO/kFD+eTV/qQHZF8qP4OoV0dOntHlXNifMbDhOoc+y8/nKZC3+dGRbty7BNaj2yEc2Mq0KTg/VBTSRL/dTSpO+1W++fWw6mWWcqh75iH/VYkxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756403; c=relaxed/simple;
	bh=tsO/mYFaEUMvZc2LAc3OA4nmB8LFQ/GJH7pow3bd52A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iYtzs4xX+TJ+vzEUuaX1PE7aPDhsuGk5f8UJ3JJ5FZsvvOrhR9qtLAOLX5j+692TlxPE4AimrV4iDDyqKOiiO2+RiM+ktsNof23xbcguH3mDovrHwrm+lqBH3abvo5OHLvSLYQ0fMIdnVeZejxt+dUiZeiN14ENy+IcGv5o13So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7WUl8oV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7WUl8oV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806bf39419so1351375e9.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 12:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770756401; x=1771361201; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMGv2vQvKQYUADdNnCmAW/VA3ahvinln9Fwhr3ZpQZ0=;
        b=a7WUl8oV5jjPJ9+PoeXKjCw1fby6IUc8JoUGNUEKBVnRhDDLH8gPKC5SI+VUFYovEz
         Cp3GSsasX+MbKoqjs3o9Kilus4StV0gUs0KnQmQE4tAe50aPfEf17niTqXsGT4V5qUUn
         bPlAPsdwnJQusezDm99XtQxtR6asF07gLwaq9kHlcKNo0YUp54HH3qetrN08z0NnXHYZ
         GgJ0zJCvmxLTIKX8PCCcpN4I5PhTbc1ykJUooB9aQXy5JV5CTaj6U+aHnNIdi6whr1Yj
         dJXFif+1aRIJsIp19Y//jNEnclnn1HpPu33nBhVP2skw2BbpKEBO/XXrORqBBcKknfeU
         IRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770756401; x=1771361201;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMGv2vQvKQYUADdNnCmAW/VA3ahvinln9Fwhr3ZpQZ0=;
        b=tYI3mq9pd35iZkkz50rcngmvhjpXZDZrTMSDys+AIK28P9EaISkceaFPrkhaUJJWZ8
         9FN8iouL2lwV3SPI4fGNjvsiOE6PZp32eFpyNG/OqnlncMwfAxl/KoVR/FvUGMc4n6mg
         ltWhcTAYw4Jubox3FHXZC8o0oA4TSdHmWBSXYITcDwCXzyq4gycacjMqxRqaVircssVL
         DCHPIB2yXcNXI/CWkXeesVLbExg+D94h6xnWe2xuvfoNs0vYrYOInx5EmvcoEsGnhAHK
         wmkmMgLVF2eKROFkdPe5JyelrUPEh7deoVTR9zlhDCDqW0mAGPKa/WHHi3CtaEQ9AmAS
         lhpA==
X-Gm-Message-State: AOJu0Yww6Ip6klRvCZLytbb7Mc0khZmoEZTSOs6tDqdgXoZ4qy864TO+
	sVi45qNslFMg4pYjG1Zb/dGwgSRCfIVFBtiFqhu08uqZJwBb5EqF0IQF
X-Gm-Gg: AZuq6aLRrVW+xoNQH9OhO/QVwB1g6IkDMuffbQCNH1ncNVgHU8ETXO9r5khbgKbK/xM
	rg/mMhJSf/DNK9NDrlGNKSE1Ij/IaP0Tm/gtwC0ZyG45+Eo6wVAo7ffZKMng6xTl+4DvqXNkQan
	BHdocqwUaZSwOkgaXFU1O/W8Tc20GjUJ7duO3Z5NTSl9odkFVqTaojZdR25bDHe9ytJo3V1Y72H
	cfpww8rhLNN536y1a4BfiwGtAXjT9lE0wEMNRceYdBFZzT/FED6ff3SKfBRLQqvQdjgf1FHw037
	sWQvdi82PU2OjQdSSeVqAnvrSvOpKV077nFP7BZtg78rGGr08nxd2xNHsSt0HUaDc+MdpAu8tdS
	Yj0ohBCF8Jp4oNdHRJlZGeJ4IQMORYlZT6HBAr6GxWV5k9D4S2793W53/c7DJCnkmey53LBUs7h
	KWcTA/ubqiNInMeAEJbmuO39vclA==
X-Received: by 2002:a05:600c:3b8b:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-48350511771mr58266075e9.5.1770756400685;
        Tue, 10 Feb 2026 12:46:40 -0800 (PST)
Received: from [192.168.8.10] ([2a00:f502:160:28bc:a26c:adcb:8da8:2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7d6f3esm71451965e9.9.2026.02.10.12.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:46:40 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH 0/2] iio: light: vcnl4000: Add support for Capella CM36686
 and CM36672P
Date: Tue, 10 Feb 2026 22:46:09 +0200
Message-Id: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0MD3eRcYzMzCzNdkxRjI4skC/MksxQjJaDqgqLUtMwKsEnRsbW1AOy
 VWSpZAAAA
X-Change-ID: 20260210-cm36686-4d328b87b6d2
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Capella CM36686 is a combined ambient light and proximity sensor
developed by Capella Microsystems, now a subsidiary of Vishay
Intertechnology Inc. It is fully compatible with Vishay VCNL4040 and its
driver can be used for Capella CM36686.

Capella CM36672P is a proximity sensor which is fully compatible with
CM36686, and in turn, with VCNL4040.

This patch series adds compatibles for cm36686 and cm36672p, as well as
disables the light channel for cm36672p.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Erikas Bitovtas (2):
      dt-bindings: iio: light: vcnl4000: add Capella CM36686 and CM36672P
      iio: light: vcnl4000: add support for Capella CM36686 and CM36672P

 .../bindings/iio/light/vishay,vcnl4000.yaml        | 17 +++++----
 drivers/iio/light/vcnl4000.c                       | 40 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 6 deletions(-)
---
base-commit: 132737e360b4c0daa7f473faf0f55cb04ee3e15c
change-id: 20260210-cm36686-4d328b87b6d2

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

