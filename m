Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C33148DC
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945149; cv=none; b=A963NAZzkz36L3fXR4dOKqcFrKHIumqiymkoBE4IuYzFRFsd07D57nteycLlthFCsQjWck4R33uezZ+IigiVRqhX/KHFyR6AG3rMRN011RZEGbTsIqiJyD3Og3mLF9kC+/bG94FpAByJawCWvE0HuO8d4plJ2nmvUz8JMWeFX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945149; c=relaxed/simple;
	bh=btysGyDMTWyYm808BH1DcatlYaRod7KITpbxDYHgSKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhiJg1vdJdSiBQzKpqES3asWAN4BoE9GKjalsiU6H+6z8Qq5GWkp2BCQSjcy3SbOuFhYNjD7j7lD5a/KW/BoPOWlTM4uUeOhwrhTga2hMHtIFpDH7ov/owL8nX0bw8conxjZjQy5fWotOgFvDpbXSpzjcrdpDDUYjMCIm5A6BKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmvSdOqX; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmvSdOqX"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d7e5e8c907so401269a34.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945145; x=1774549945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvvMyIz9m6P5qRNX/2YBjZmJuc1YLtVPBVOQ9GiKfTU=;
        b=DmvSdOqXr0N/imU62WL64ENoutLLk65WOSION9WkL5AXIOToUjvuRfKwJUzpefjKOQ
         KU/aT7eszxnRmQ702HGm+bAkAq9I/eV1+yFOjdi1rmi+OqAQYbkbmrL66U0q6WJPhiBd
         6MBrRXSzQ60gNmc0I8NJQRXsIJ7MDwF4z44DQ0kdsVrQ58F2G9hlfXHo6pHrY+VyYYzN
         JMrCAQQi/rmkCZaEKEKMwgm68bxYLJXWPXR29IDtkT9arR6G8ITgHwR92SepvyXxWB9X
         BWmGwSUhn0veAh2od3jEOPHjc0N6wzN00FAv1VJysmbdL32fkkx7b9CeAAQkLfl82SdH
         +4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945145; x=1774549945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XvvMyIz9m6P5qRNX/2YBjZmJuc1YLtVPBVOQ9GiKfTU=;
        b=Y7ucY3heuAh2PPhZ3qxRg4vyymtJ6txVwumqM2uJebOsbzMAXXN1ePSMziOrj7hqKf
         BJbGv1hFBpD2dz+fQhO2wLzk+2QV86xwG/5uavxzCJwDUvVr2TLL0R24w/W9sKeOkqx9
         FdcCCahf97K4GFm8/78XNXD6whnRF2ID6k8drSzMvm3P0yw/RSrW1Fcp4+4SXvuq/ywA
         9D4RjNdbnaUz7ZNadGu24AG8mN3dBHGFCPh5BF47aWzIottByXLA53nOQE5/3v2B+ugO
         C5TYzGiI1GBg6+0P1oxQUNiqx59kOGFrurCGp3vGAjh0Quvdnr4NfQlXgcb+H7taFII/
         5Byw==
X-Gm-Message-State: AOJu0YzVpniUCD9w0N+UTHmnlcHQJNH9arU2fTLCJHI+v0JwYisPYAHA
	Vb6jqxJiSAs8aoTshjp8Ieie1tEw+g5kGgASPz4Dh3doRCAz15k4WVyw7Ybx6g==
X-Gm-Gg: ATEYQzzbcixI/f0jhpy6n1I82Vf6Ri2CR5m+V5OgYrcvupXaKLEdajhgi7uB5tD+MPO
	iS/Ycif+hlnP6TC8qzRT8obIvO1ZtUb2TJp7wLvqd0ZqLGToNhWxy1i/SB4e2QwTlTzsa4RFuxO
	KiW6kktMVlvnt3mNkehPgwYIdMBQaQLBVEsWVU5hsoliJkwwdHHG2pp47tOwJjODjcpQ7/ZpCrr
	tf7mTkKuPTXImzAJVTsl04H39e6j1bWToJVCFUHBb2t8ajrpIv+t+m/na6Tu1Ap5JanWRIJygJK
	sQ6ELObp8Xgnf9OpYTmkgXwHu9JLMT9TRToYSfr+Yq50Oz6eqXptPHUey1cBi2rbfLZQ516Y55a
	OUyBrUZJdsvXkaoC8QYOf06ZNagxvMVDlCsCFQPk+R7r85KoElyLBTaonAxUXCM752CcKM2D2X5
	VKFUZdpwwlby4NeCW0s2Qf
X-Received: by 2002:a05:6830:82a5:b0:7d7:e3b9:58dd with SMTP id 46e09a7af769-7d7eae7a567mr191239a34.10.1773945144869;
        Thu, 19 Mar 2026 11:32:24 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb11csm172193a34.13.2026.03.19.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:32:24 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 1/5] dt-bindings: iio: imu: add icm42607
Date: Thu, 19 Mar 2026 13:29:37 -0500
Message-ID: <20260319182956.146976-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319182956.146976-1-macroalpha82@gmail.com>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add bindings for ICM-42607 and ICM-42607-P.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..b69c6bbb6f6b 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -30,6 +30,8 @@ properties:
       - invensense,icm42600
       - invensense,icm42602
       - invensense,icm42605
+      - invensense,icm42607
+      - invensense,icm42607p
       - invensense,icm42622
       - invensense,icm42631
       - invensense,icm42686
@@ -53,6 +55,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

