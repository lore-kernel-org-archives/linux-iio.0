Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49085282F0E
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850164; cv=none; b=TlpO7Ad7xpNV1JRu76HMgs5Zk2OYnC9qghsNnp1C26K1ZZdvlUlSPTJrgRShZMeXG0eT5S+HUTA7KnCXVLUXaf0+NCcLExnd/inemh6lXSWcloti55wz1iyABNFDavnhRthbrZ7XuX/nwO/d8pNoDRP0iN73EDLzJjDYjX70eMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850164; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhSXjCfNRwVKA/K14OqLuqPATxlTartkogfo34KE2CM+TCHmMKnIgNu1nO6EH27OiwmLflmS9XZOmXaPhGXwmAv/NhlVx0s7WOgoMKwIj9J+/a4y6IKqLd/UunJ87TMwuJLuVRqZ8bI5sYhC7fK0qVQEhJSUnBXoU+5vs/kkjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/ZHHQXT; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/ZHHQXT"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4358f61c9c8so3073074fac.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850162; x=1779454962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=R/ZHHQXT5LT/OpUyeSSXwomFmMh//HnYHgtle092bHJhtvVoK0VAEoLwYUgzdbMOFc
         F6Ueu2tWLFLe9cKrkhXfPeUaXWX+xAjm1I/zBoMJCdN/H5MWLfYLjmQkhC+TPRQVERGJ
         yXt+17gH9MK+ES/rhyo6btxAP39jvLPRMpU0BDRdP2LIc97vK2e/oaZwibvj0MYg18Ro
         kVFdJH+qHvGNnjLiuUgeQ/lFIIjMhV45Pw0GQsNKAz1xkr5uR4G5WESOVEb2qKP2BeKH
         Rlid9bxPRq7mzSn6OVfrdnBHl0PtAP6tc7W3qifIxzcN2ZCmMGlIKfe/9qnNyLSadxmJ
         UTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850162; x=1779454962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=NWSq04hBzuRN/cSbLuLUg0giHp8u1YYMEj9sKTHtqTLdtD6woVV87GwUQMq23Tcs8B
         EL8NykIQjrgw3vWQDuE4cvNmM6S37KAIrGMwhLRdghRfLIc7Zzfh4EAK5NB3ak+/eY8P
         lvWEzRv2NonE6dTGiqqVz4pnJozsfjbpclYXqvla0vgKJgeTl1nBYdYUWRsr1mAera+T
         VaOzbbLLlKMXwhozsPUNZuwuJaW8675MkBMaeNHcCGJALEEVvL3R28jqBAeM3dCiNEda
         4ayOljjhPnKoWM8ZwC7xvMQ3aQzHlQYtESvnafmq1EUAjwLL9w98WZLczng7QHD6egHs
         RmEA==
X-Gm-Message-State: AOJu0YzrTeLh9t3HdM9NxzzOSI0RerMqd4cnBOceaUCbsvJC6hOyZnsb
	dXFsI2eSjOoaHq0byLBmaNqUkIRzTCexzeYpGIEsZaG4LIoPOmivssao7hlgyVJV
X-Gm-Gg: Acq92OF1J3VhTlbvpdoX4EKZ7sSIv1RuLA066eynzLe2c6t84mpodZdP7jpdQRvVMXo
	hgozXKWI1Pb3+eZY623BgLGYePHLllW76sUy4cDQuTzYa0wKYuBqijojWCWwzPbbBHd4Kzx0kyj
	HRZ2TPsb9p11yRJFTqY6jLgz4sCMfcyd2kPQvGIbKJa+hiK9Z7cHQc6HlTmPUQCoOTXvdwO8dL0
	m+DvGGKtVL28l14jOpGIIyYlMiLZPh8vv7HAyfLnTZxz3TpS5/1lLUzM+sNxh3b9mUFH2Xzo86W
	BZk8r15FoFDifRf86TBwfxOyu9EHf5tsLw+W5Czzt1rhpmVTMqVARx8YjOJnSvCU2fZcxayA8wu
	p/lqUq8X7YU3GsDdsb0WtzajmMDz0bnimIBrIlBfzjePox9wJ49z/Nz+/V56SmqpyKaWeDI3fcO
	EbertcsIVx02IFVCN+wyyXlxA7k9Nihi6kfpKywiLLPA==
X-Received: by 2002:a05:6870:548a:b0:42c:5ca:e7f8 with SMTP id 586e51a60fabf-43a2dd598a4mr2483451fac.26.1778850161483;
        Fri, 15 May 2026 06:02:41 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc53f2acsm4155822fac.14.2026.05.15.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:02:41 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V7 01/11] dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
Date: Fri, 15 May 2026 08:00:06 -0500
Message-ID: <20260515130018.237378-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515130018.237378-1-macroalpha82@gmail.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add mount-matrix attribute to schema. This attribute has been supported
since the first revision of this driver, but was not documented.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..9b2af104f186 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -53,6 +53,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

