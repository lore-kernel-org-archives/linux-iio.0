Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613640;
	b=m7hTIFSBQxYnStQhcHclms2SVveU5V3sjC+WE3X5M3in5NxOCHnXCCLwxmMS8QnHztCQ
	 +CaGPpYiNFBLbwVhUruZawM6GmNIa2065tBHJYcrY/RENSV3YmPJCoHNMVlkBT5NJIxic
	 qD6aopD3DZDjKLTOT097aRDuq1viWAwMdDQB4HSzaZKWmlHDzm2XMOb2mVPPoBiappI9K
	 marVRcKh2yUMTyxHKh3Pm4EVtf5X2upBzrjc90YpKqkCBvf61Ui1shAHKAHfiIFIW2ysp
	 PanooHYvmfHGZY3MhNkEj+ztzdjbcaiGp1rC4QHX4ziO6DpNv6VPRebeCkAJOOTrnfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vM/UltC3mjiYHkIRq2InT6fJ2QKWGWxo5IzwL3zPAbQ=;
	b=WQ3Nkv8Ur6Cm8vAuh4BXDySs8Fn91Q97xJOJGN0C56sGNgcnyqEhnBv3mCiJpDzVHNFT
	 KnA8ayPeqjNhTb1MI886pz8y/+k2srKfveAu270o4UQsvuay3kWJWjgydxoXalM3zFuVq
	 mVbv9uUpMIbCOFgXPjEBNnaoUIrAHu58hOjAIp19mKkglxH3ri3E2a7c9ltIVTTnE7aMg
	 mCycr+IVKwSfaIiEhDzFRkZpC3xHg0glES0Q0KEmqEPbHV/uK+ipM5k2cSDXDiILmwtBv
	 N74xzc5Me1fM5bfG8I3uBManp6fPkbKaetwhfB9f6gtuAz4fvdkcamubEiqAA/8zgpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OEbwZ6Wf;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A66606A32F
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 10:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A66606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OEbwZ6Wf
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc502d509c0so982987a12.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 02:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793613639; x=1794218439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vM/UltC3mjiYHkIRq2InT6fJ2QKWGWxo5IzwL3zPAbQ=;
        b=OEbwZ6WfYnx4BRWAPtRANX7r0R/S0dHZ5D+UbeaiWm1Z4OZbLHmYyDb2DBWoT7Y5Zm
         CmHr6hGYlKBkhCYLEumiLboip6cb4p+WUeAzLLxyYT1DB3NHmOytZPrmol+Oxr30QTT3
         wbYRvBMUwn56FK0+SX41PKkQ9VgqCYNa2oGdT72zZXRl8QD5I7uBHhN01t7d3Ci553DH
         fzozQ6LuHIKdfOYBNX6IoKbSfABxmrBctTiMV2dSrZAmBE5qzeYrqyY3S01T7ZA/bIbG
         oRS0wC0SzTGJzNsP+pf/xugzWLLvRIdOJvTo/gZkdaeqLsG+kTltwmsQyEF9CRBtXJcE
         dyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613639; x=1794218439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vM/UltC3mjiYHkIRq2InT6fJ2QKWGWxo5IzwL3zPAbQ=;
        b=a5L3g+oR2yPo8x+PK0uwTirM8V/gn2bFjLgF8A7fNaoJUnL89T/D5sCVPIm95tuVqP
         a1i3c47HkyR/dVPfxrHeHBtWx6QdKKSCq+pKwPo8Ef3I6hD+E/02k2Mp8wRjKZEVfOU2
         +Z8cenezTKIaezkioo0XbzmlKDkuniEK0IHuCipPC8WkHrk3HDiAsTxYGJ1rTgYgm3RU
         LAaWY95i9HyQ+NpLmmN95dt6WFXszMxtd4h3zI74yACYxXY7THzZmSUhqeKyTZqHVW1z
         AoiyNiBLtHYObZjOqE8DoTpILPEG9Bj2f8oMsouLNTgwFQoH0TEvXIwugl0mKZVoIZ4K
         O9KQ==
X-Forwarded-Encrypted: i=1; AKwUvBxos3J2TDQhdtyeJx4mBxrgoTyV/9kWlZ554Wk+xKWuJOsLALvhVfT2BMVpJTl70UI11fKEj6d4c+Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tao3b+TpQfM9WWPl2lOESb3GYKBjzdzRXnk/gsdU4W+yhMftq
	KIRvFFZ36O2Dd/qR6g1T3psiy2nKN1wEYC44I9mk8QCs/6hon+GmitG2Gijafw==
X-Gm-Gg: AYBFou17SKBWfK0Z/LwP+eHpNTX5SFISInRhKKS/5fjcJ/I5TYibPNc2IGlROpwxLhi
	2pqfVt/WYEbCk2M6NnSIqPmQCKr3xQuVelOxxbFYnkLLwFZi8PFiW93dDyRzYGfrSQ/mHmKS0qg
	Vp2aNkNbAKHa5WDbr/CbfZtl4dW5lqrOGH8vEKSTILpuVVELwbH1U7glKp7Xd9+z3bqfZv73hxI
	RB3xntURFiHw/zL8Zx3sxehFV9M0Oandq9Obqo/yRt2VWNufpvi2RHduEG4+XSAQkHStpZ9K/du
	JAAyV3Dn7uzA+ILTwGCRzEmgaPbZnmgP0g6QJ/STB/FfTTUH5OQ4Nue+9eJwDBbXb/kwtniKUp/
	LGqJf44Pjk+ybATWJ1eVzCZ8A3ZkvhVU2hMzR7C2WoljlSZUT7PnmrI/Bk/XqNKGDGXSME05iPV
	mXa/U3E2z9aeLjXxSEXeRNryPcTgi6YQ6UxPWG60q18AkBHCvkUMfQg/efE5zffU98A9WGwayky
	PncUtofYYMC5YBjqJ4U9/QpAu/ZOBVESevnzWapEqAeMitIJpPnPlgbYieQOPNBlWHb0nn8N2IU
	Xnawfviauf6/YTkQBPHkrTd5yPD2YGDjO8LzMbA18X/rX9xl2GRGgYtswCZDSsAN7teAMId+WP6
	vORRUrNle3J8ngTlhJsb+tyUbqKSl7NOLkkCI6fiAUEebJsWzE37KjMmHEPL/Ju9GGA==
X-Received: by 2002:a17:90b:4f84:b0:3ab:e588:c275 with SMTP id 98e67ed59e1d1-3ae897ccd23mr7150902a91.20.1793613639055;
        Mon, 02 Nov 2026 02:00:39 -0800 (PST)
Received: from localhost.localdomain ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm13592447a91.16.2026.11.02.02.00.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 02:00:38 -0800 (PST)
From: phucduc.bui@gmail.com
To: wbg@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	sozdayvek@gmail.com
Subject: Re: [PATCH v3] counter: ti-eqep: use devm for runtime PM to 
Date: Mon,  2 Nov 2026 17:00:31 +0700
Message-Id: <20261102100031.5573-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20260802125903.1425262-1-wbg@kernel.org>
References: <20260802125903.1425262-1-wbg@kernel.org>
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

Hi Stepan,

William pointed me to this thread after I sent a similar patch. It
looks like there has been no v4 since May. Are you still planning to
send one? If not, I'm happy to pick it up, keeping you as the author,
and address the comments from Andy and William.

Best regards,
Phuc
