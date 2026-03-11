Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12D3B8948
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222548; cv=none; b=cIUkbO//kwWk7YFJ2rW05KTleivroINgfkTxeMMXD3DZSWnzmHfdf1HVCIc4OWOgygMc/MUWggUAfR6f+rB44VLGjvkRm05v2oGCUL6Pa+QUKvBtk88IuHz+wwTgnZ3OdBZSpi4iacXZc18427EUkYaFbKh5+x3qg4f65okmdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222548; c=relaxed/simple;
	bh=pZTH03PvjyWFTzvxjXzXUdxVTRI5tD1whEymnGT/6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7F5eZ/Ofjw53iVd90XQrBuXTS38vSE8q1SLkYwYWi3YtYvPheRyUwguDrz1kKTd3wy82OBK8czOe/Pejxnpfwjbwn2WcSoaE/kk0c1lCXg78XK+8SjGcRYD9aee2Icaa1AIC9+q0lSLp3RBVc5fG/wL28st5gt1FFXTwbbXBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/TqjSce; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/TqjSce"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-485392de558so19639985e9.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222545; x=1773827345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZTH03PvjyWFTzvxjXzXUdxVTRI5tD1whEymnGT/6lQ=;
        b=Y/TqjSceR8G5kcgTfluanAkZB5QomHtQsHs1lVHfHSkRCNbmRvyGhFlkWZEUXAy08h
         Giln0vQoypHepfkXpf/fbbg9LOZNvHV3d5pyqFMZ7Ed/3PqdblImMAeBp++iP1Yeoq6H
         /RLC1sroj4MhfnNEhgW6EI8nDTh8Ai9VEs1MdyDIhqqcS0o+K88vQ05+cXOEp8YQFbYa
         QejLFrKGfEKwmPzTyf8mhOuHXfMlGwxRP3L85yqxRlnVejbjbZNn57skW5VFfnP+p4Og
         EJNNw5ixQ/KJ+mCaomoa1g5WyKU+wWJnlSbzJdzAhnmD7YPG5xhpMc4P3AkpPPQrpXGB
         552A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222545; x=1773827345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZTH03PvjyWFTzvxjXzXUdxVTRI5tD1whEymnGT/6lQ=;
        b=hX+DVvl7Zfq8CaynbNoC3pzE2WE4nu1+kkX7LtzOd9Bc9Rak3ksVxPeDWmJSay3cf5
         C9u63JnUzFbZICSGJyQsItKwLQ1JHY2ATDbod6TjQdU4pCWZYBAaNbHEpFb+NA3s6NuA
         5wML1VUud7mtRWUmQO5RH/6ptovjHq9XN3xl2kk3Pnc56XyNgA3dLR1+f3lxnzSnNrVk
         EXJ/tV/WMlaVaF+hGGtZSvEXQUVOnbOOBM8tR2G6F7JpsmSuE0Z4lhfnnYbqMc0y3KVZ
         z76qkx7lKzPZl43cxcBbTlyIfoj5TWpwMzHYrqYqLtERR+lWKVLLCDJdk/U0e0RfND8I
         zcyA==
X-Forwarded-Encrypted: i=1; AJvYcCXs3JUDFvCLn6JHrjZgYadjPrzcrcPuqkM00SEHkj3mEKy0OzmBf8tylsf34G9IKIqmpYhrZr1HXZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2NRvjYFtQQu931yIlJXHik2r64emxV4VVhCtcNRe1vARWMWi
	FTtL+Vq8z04+qT7G8EAXnW1SRcEKqZQsGYAI7LwXigiv2JUuEnsV74gh
X-Gm-Gg: ATEYQzzmbnmzrbP1+NPLdAOrZszMEsKmvhaU2UTBZqMv3Kn0eJlIMRt87l6SY4EL7vh
	DnTYB3MPj46W6JoBRQzya8wQVCPIEZdj1hUh0a+UX7zCRg0KpVAWQd49qRlRj6y5qvqAAbsyRTi
	F6sFiybwqHfy2M9ZlPBob691n8PbbLOrfUBlQ6/v51XsUcJq+nEL3E9z7ol4Vp87/5kPsRUnFb/
	x2SKhLrmqAVj4BcZfqod+IZcK6XczqYJwhL4KrQzWVMru7sR89BTvU0t9V1PaMMWwyAmFE7g1t8
	AZqdXHjYOoTpcAJS85CTBALx/O/br5RfFhguQhcRAkTtRqJ4Qbs7SiXDI5ztT/SLKUJfs6KeN5U
	HNqyyfvTPHEHnlHPu1AkOprbzlus4/ADF7BJUhuVhxkjVMoeqpKhvfTzbhVOvK6ULyivzccSkZ8
	z+CVxS1mCBwF4DTYTdDKWyAYXohPaUevM+dHoPAmI+kyjO1/kEyvHY7Qv4yQ==
X-Received: by 2002:a05:600c:3511:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4854b0ae565mr31303265e9.7.1773222545398;
        Wed, 11 Mar 2026 02:49:05 -0700 (PDT)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e67ea40sm3246775e9.7.2026.03.11.02.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:49:04 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: krzk@kernel.org
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Wed, 11 Mar 2026 09:49:02 +0000
Message-ID: <20260311094902.9252-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a617bbfe-0339-4334-8b52-dc85de12c626@kernel.org>
References: <a617bbfe-0339-4334-8b52-dc85de12c626@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

I misunderstood how the Suggested-by tag is used. Since
Andy explicitly asked me to sort the headers, and the DT properties were
provided during the v1 review, I thought I should credit those direct
suggestions. My reasoning was simply that those specific patches and
changes wouldn't exist in this series without that feedback.

I now realize this tag is meant for original feature ideas, not standard
review feedback. I will drop the tags across the entire series in v3.

Regarding vcc-supply: I made it required because the driver currently
fails to probe without it. I understand now that this causes an ABI break,
so I will revert it back to optional in v3.

Thank you for the clarification.

Best regards,
Taha
