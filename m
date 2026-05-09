Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1411925BC
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286509; cv=none; b=d8sFJrYQHgsOy4vjaLEaZMO2Cqa8LkGsDXj4dIGpb7Z9VN50bdjiAonyBB1AQTYtn5h499md5en3do8U4N6sUoAFxs+DAPJTO07frYIesOukGD5rFzu8Hs92o56mZ5w4U1NbGSeYVZdhN/on0jp/5c2cmkRiq+6PNJTTutuKKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286509; c=relaxed/simple;
	bh=7/DkAt3WkgM94rIW8zYQ6Op0WHWHc7sHiBEw2cmj5t8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9g8QERBspYLuQGI0FJpraoC7kNZC/uZ2X1ubbjy7IAqy+QdmbQNLRnC+r1tuupc+o1HnOOjlorPFgihukUyEmz2nGNoKf0QAJNd6nI+V9H+1GGCmMrjqWdpyL4Xlk6Sdaw+oIY1ninXva0Jd9cpeZryl/ZgxfsO+Yqw/mCyTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0ElGgQZ; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0ElGgQZ"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-130b2295ed0so7489973c88.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778286507; x=1778891307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iejIHb6pGlbBShgUTjZwHPgEaz3LQOLC3BiQeEmGwrI=;
        b=r0ElGgQZSs4zNbzQ1v80MFUtHsGgKdDT2PntbwxWBsWJdGxoMYAa7qamH34FGvGuuY
         bxJobHSF1fYFOrhOONWnhqbAnWfVZZ/2cZaXWF+LfkM2raH9vISzKinPO+6SUH2LLDI+
         1y8G78wQrr56QPnFOZpyY5/9AP4mT+yF1d0jKDoTxZE8GrGfYNTShjG51mmHLnaSl80f
         nQUDqaVz+JnOZN8bEfTkPMAb5Xk3UQ/iF4uiKGVRrQnLZpsDxVI3cARCmlZlWtJOoI8P
         RSYcgKtkWYIZFABBPetvPR/Rz9dlAPuLgHdYXUfgGK+ZngeIAa1Jjs4yCk3gtXqGfiNJ
         oAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778286507; x=1778891307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iejIHb6pGlbBShgUTjZwHPgEaz3LQOLC3BiQeEmGwrI=;
        b=ZU07KC18Q1hzFHT1dX2qTL6D+HTo0gJuTo/3lLeu1aDrplaBCz3+xE6ciTY7FFXeDE
         orMrEmu8ZNvSQaXSNcPPx0Q6e6LX8rZc7T0tcyjdflXe9gIQhilr19ubr+etM0HVVl8W
         Z1SwsiVb/Ibspld73wFg+/xV9Tra5RFHyDk98KeJRDU7hEcJ3NASfr6j0PNv35+zfcVD
         XB19ldWQYyfP3+V55+kXGwxiv/c+Bw/UCwy0Ytqd6Fu+wYz/mfgFKsm/LNuQDrk6xi64
         rB/Wm1pEWkdLAhfTDmIZumVLuPPQe6Gp/0bGEu/zW4NNdcBqBDz6LCtoJPHkir8k1fAH
         UZGw==
X-Forwarded-Encrypted: i=1; AFNElJ/3T0gYajR2bmW0QxwA0bMi3q8HMcuETNm2cf7rg6KdHdMrLNDEJ2yVkRRmHgwvJ1a5V1jh8DhsxyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdIMFluVeSu7q6I48xMF66FcYC22r4LVAZyFVbVfCM8U7800n
	FX9Zs0PmbTH9AZgjoIuTBtVRNrroaAXsXr83AUIlRuxt8d6NQ9GUSnc0
X-Gm-Gg: AeBDietmDHUAfxX0Zt/XdwmY0oZNTquNVNVQI4a0UVbxqMFRih5gQp1qT7+Hgu0Njmt
	ACkPw6urA5ZDtj9OcCTguOnRSobSopqYbjfxRaGFjXOPNuLipK/j8SLB/ZzYJKdlygVAFdyFoOy
	cAsNtGFHAW1aE6O0Z6UAD61GEn5Xlx1lJYRovtF4nHFaRWD0tP9dG2c/tn1nAqlvyQ/nHx8OUvc
	8T9NfS9asZ6hvGvJjuCu+Se6+oqbarSbjszNLc/hmacPV2X76h/9tFgTISizxx/P1qmyL3qaW7P
	a38X0Wa35i9+Fo+9UwxC3lEQNnsQS8UppU/XOTq99+Smh0Th9+QOk7mrWjiHHfCSVt/Fr3V7nrh
	ynw5CQGiimNzSiufyk7eQFb+6fcPIyjK3wK9lPwSy5kgmH0Wt4tRHRojvAwkXaCCTpObssz/3l8
	J5kZ2rlJDPIPeYw7D6iJ0Y8nCHFfDl1eNSz3WeqJUp4K+fLCW30EYx58w=
X-Received: by 2002:a05:7023:b07:b0:12c:8f92:c6ba with SMTP id a92af1059eb24-1318eb3f318mr8576106c88.34.1778286507125;
        Fri, 08 May 2026 17:28:27 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm5979234c88.2.2026.05.08.17.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 17:28:26 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 0/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Date: Sat,  9 May 2026 00:28:09 +0000
Message-Id: <20260509002810.78372-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Add SPI peripheral schema reference
- Fix example by adding clock and regulator providers
- Fix SPDX license format

Hungyu Lin (1):
  dt-bindings: iio: dds: Add AD9832/AD9835 binding

 .../bindings/iio/dds/adi,ad9832.yaml          | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml

-- 
2.34.1

