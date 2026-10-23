Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783776;
	b=EYu1q3CBONPcLb4WQjguk+Nf82ZR53XeaRURPDFiMG166qzPzEtc699Qmw+ZXvZrYns5
	 qjXBK/lE7193d1fjZ65ZCD9H6snqOK1MkD1OJrhjf6iLPFvqtaawRij+lRwv7yz5quPH1
	 fSd3bWmC4IhlZ0EyJQrtqSW7ga738kjIP0DgNnXahw9QS72zfViV6chlpnz9VNM4INV/f
	 p/1vkF0rSO6f5y2W9aZKOUz+c3XdoSWhN7L+XcQHWCBp8p6tH2I8t3PJlB7ijgDiFm9Je
	 xHbLTdnxZJBwZoC2Pw3/dYVvv8//ZGidHNi/5+VY3cd0zHfErdAZ2zTl1h/xXHs/hUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6mn1Ww0z7f0hBkiKdxCSd+R1mw+SIqi/8v/FSNDtdzA=;
	b=l7Chr8/UP1KLHKRKJDd8VAhPR1X46S9viws5Gwg6WxdF8Fnb7lZBBh8A3qaJXuZqr9js
	 8D4QU17Wpf3Q6jWUYfHTeIyQrssWAUx4anLnH5sChTYjfGTluezLZhjqWsSnyTxcAFCoM
	 q8hD+6zObgQ/QjXxFpcPesXsBP4Naizr7Uw2XmkT9yi10hmfM4wYJOnZIVo1MlHiy7G3S
	 T6AluR4Gmsu6rbqM9koJHRQH+DyNX1pVpJDtGe9zAJg7SQOKUzbQyg/MszbKFJyg1WwSo
	 3iuzU67UQgkiH+XRwLvhEZ/SP2D2ekiENQOcKM/YtZhTiTnjdd5ztIJKD1FdujqYhiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JAaq0BZB;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9848606A31D
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 19:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9848606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JAaq0BZB
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so1232830eec.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792783775; x=1793388575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6mn1Ww0z7f0hBkiKdxCSd+R1mw+SIqi/8v/FSNDtdzA=;
        b=JAaq0BZBYU6590Hp301BXikOqbIgPmYN5FbZMFNrRnI1i3Kml6z9+HOlsTtnxbGWAy
         fLPZfZLe3GsBc7cbkYgh1hm7YsMLLDCQlRvXuRb1PSqhIzH2HdyuzF28Ajed9ip36xn5
         CKzNCKxx+WPf4VGWU/ik9yLmR3ZxXMrdLv/7I6UfdhhZUH4KpxM+qkc05Gi9i38Vyjnm
         kykHOY9dB+tH5vHd3E66cRFwHeLMuYJdnVC0NpTQ0cBHjzdCKg241SaSdffUxrfDhQG/
         Xz/5W//qCWpneILkiThyMn+C2D5grA38zxGiH+WyTLevi0cyWzgBSp0JLCareWCWF1yN
         Ipkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783775; x=1793388575;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6mn1Ww0z7f0hBkiKdxCSd+R1mw+SIqi/8v/FSNDtdzA=;
        b=X9E601EwPgiQYqWPsAE5bLgso7HIaQn4z0AcM24irSI6gxuf8DOATtGMMaA0if+Rtk
         iYU+7zV8pr1UfKPA+qDaMnOPTsmYR8n9UR1k90a1891Ivon6Jiw5AhE1yK0LClu0w5kv
         LALyiSyJEw5h05cy4IrTH4oLwCEPZDKXW8alEpbsOObd08mAZh2x5Djs0Gj4zLXqgIjH
         kfx7wjV+rBww6UjUS6t626y7hjeH0Dn9ap3ja5TqwFtT4Cwair7Z1Kc1IjazgjvzbPjn
         XiyIBqzvywRAnUdENKC2lam5TNRaBmsUeVw+DW/65wNsv9RPqcuYqqM46u0r/vC8yxWs
         UbAw==
X-Forwarded-Encrypted: i=1; AKwUvByN8qawDIKpFWmEPsKxzEYOsVeisrV93TaPbWihhoTcgXf+rKhEDEWXfCDuTFsrBC1FurAI5molZpw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5E8pwNUvv39qdI5R1xhiY2gXhaoW+W9AgeYoKvpYhkuBrci1C
	coFxFBovSbj7iKSaTNjj8I5Q5NXt2gIdCcMYgqnq7YY3VXZXfuhGuiGx
X-Gm-Gg: AYBFou1nP+wf0HqCtmxWKo2re1CKWTFKCprPRiXVhkcLIFENUACGjgk9K82Tc+OVp0u
	lNFI3S1KDYnGTp31xTAO4AQfA4g0zY/dfPM4Gj4hletFNuVkm8QNledQi5IFRyBSyQH8V5x0pir
	kJSAOMTtFofZ1FH5qyPN4wBwewfqbB38GTHdl2W+wim4xsIIYQwwziFPaF/gUIcCUXCegvFHoCL
	Hf/UA2d+srLs/Joz0wfD5xCAr9AnN8DKYIIxFz+kEvp7tUwfVQSaF8yjHGP7QvmQqiWMjD7cnda
	8kIZhW8rFWc2PwrYBdEcR03Zv+EDjym44pY9AZZBVh26o3tN20x6M32YS45rSLZrZdvrMJElY3g
	kn2YS9SZQhsj1ZGU7TWxXI9g+bHVdCQJkGzpE3MwVd5DMJ16/PSQefhhvg83URI+zfKj2VL9ZRy
	n4vxUiu97vI4Z1y9gpCtF+2yiomZAawYsFqebAd597NDeVL4Agcny1gZAPWNkgZqM0Dzuc9scGU
	ChPL4D5C+dEhvQatMjp7p+FQXPTQ6hMTjknO33ymJqv5flH3Tj24fqc9V7hkuzpOqkHMTPYfFA8
	xlTnaCrJ+pT8cevsE8ODaX2tAOCx2wDHyVU2uL6XORHPWrdrp0a9jZcgunECUAIpxc0nekeY0k/
	WIePDE2W6IPM=
X-Received: by 2002:a05:693c:69db:b0:369:8d31:a902 with SMTP id 5a478bee46e88-369e836af38mr406889eec.2.1792783774526;
        Fri, 23 Oct 2026 12:29:34 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm381308eec.25.2026.10.23.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:29:33 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Sat, 24 Oct 2026 00:59:26 +0530
Message-ID: <20261023192926.228467-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022140615.30710-1-kapoorarnav43@gmail.com>
References: <20261022140615.30710-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 07:36:13PM +0530, Arnav Kapoor wrote:
> ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
> ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
> channel specs and lets ams_init_module() fill them for the AMS node and
> each of its children, without telling it how much room is left.

Please discard this posting. I sent v2 again on Oct 23, please review
that one instead:

https://lore.kernel.org/all/20261023185652.195025-1-kapoorarnav43@gmail.com/

Sorry for the noise.

--
Arnav
