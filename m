Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4973603C3
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452235; cv=pass; b=sUzfb52R3SNCF/7g4vJA6rb85e6aKVuRRf7mDTkuRlmQvJbAAR+pA8fEqYIV9GLYKZ751rsA6CnE45j4SISn80K/dCWclZp3BROmor7B8SQX8GAc1RJlel36yL5qCvrsajL7qo/+W9l2gXxbmxeAzgi+gTBaAXkTZjRt4Vj/pz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452235; c=relaxed/simple;
	bh=pMQatoLJn7LPYfhjMKxOE1X3JwF3SMbI1q49OGFuMl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTRnx4apN0qhUwFZyxycXx1HCQA7iWEJIXQlPAfrLqkjL4TkvlPWwTmypXjqw2PfXfiK1GNty73Lqat4fYXGH4PnttrN91ktynvvOHNrDWgkiDdybFZ4pyJhY1A27oo4pm2sI6ADiLnZ5FLoh5HL879u0Up3GxySppgZQofZ/98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OkppxAwU; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OkppxAwU"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-827336c0994so2603073b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 03:50:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772452234; cv=none;
        d=google.com; s=arc-20240605;
        b=SvSOm35nm6xizCvCaK4fYJGDl68W/6ZhtgAOg+shju/7z1NID2oZbRiK1nJGQytTb1
         HAC3wVF5FIh6esv3zhD8Wbkq0xjH71glVKi4H4Y9EWKcSLmml8IfIFTneelXFB3J5Ll0
         SOkYec7lP7a//OqjpoTPvmHc4rajKsQtvkp4QMXU9v07Yc1vvMrROLPu/HUaPAOzHExe
         AatFZH4JchPS3zzrDMKeCJ/+01ejPVrTc2cJW7yUz4gn5b7fTywWc4sOWCYhKiM/A4+6
         gO6PhSyjQLUu2qhkR82zusmzNv6PgiL8eB21a5q1ZB7wuFOM4lkdRYBM2bU+PC9ChR2W
         VaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pMQatoLJn7LPYfhjMKxOE1X3JwF3SMbI1q49OGFuMl8=;
        fh=ZE/1BeZ9dDlk5jjxapHzo6sCIU704WkepTebEioSAUc=;
        b=gUgIdBfpe/z9L/AJP3JX5uCOpv5KyKQn3wi7i3nix11OhyI4LRzQSg/I9FWkGkPfA+
         oxV6kXZjs04L72FYeVcY1RMRfcD/+n6FjKM+Z9ZLy9hVrEg+GPVDF/M08XlyR3Q/p44k
         uZ+hnajD0U0ZIocfqdaA0Igt1/E3dyhx4ccCxrCM3YZ/d/pLCLizK3iFKLlKRD/R3OX3
         YGH6MOm5yYsvvMnK0VZ9ejlX+TmBaqPGeD+KhEVkYh/PKiZh5oeY6O1jNzbq421ZbUS5
         JWOrFnOR6h2tcfUxuvbfuRU5XIAOHqmnIuR+Anp+U9xmAk1QypwYukoxI+M3rkYGiseS
         137Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772452234; x=1773057034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMQatoLJn7LPYfhjMKxOE1X3JwF3SMbI1q49OGFuMl8=;
        b=OkppxAwUxAXo4mIHOvWdyBd1wr6sGrLekFJSGf0LJRTjfboh7ZaG6nFAa0Vsxm9nwW
         STN/V1q7qhlX+H8kxKkCrfsHYUMbLiPlOuCOH+MwYPfBICCO1ySmDPzx8uMS5O9TReQY
         PMauBsF7mOLWBOriibtODYY/kAbac1lM3pui5AHwa860o3u8fW81S7xmGL/aBbuznhAV
         +NKgj/V+76r/PK7w4PpsnxPL4QdoY4HakR4Vr0e5PFQx1f9jIb8H2vNfGRl1G3t2fVTM
         5vhQU8C+V+wOIaVE74hHHJYT762cZy5TLCR6RH+KECIfT2+YDbwQ9Msr3R1FNi3vx2Am
         u1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452234; x=1773057034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pMQatoLJn7LPYfhjMKxOE1X3JwF3SMbI1q49OGFuMl8=;
        b=ftp+cSkoR6bGLvXESRPjxGrnXqYx5sWfwCIqaZvk40Gye0WYEDX/oj0hwPylwQ+c08
         5KuwVgfZzT6RNBYUnXdFlmzDMoaxxeKQH5s1No4ILDxpV4eei7PhHpmwCD7N20hErtFm
         i97ARutEjCxUmJ+wrxR4q4ctBlG4UqRgsUARPWRj5VR0BPYw3vUzkW+eEbm43g7FIEqt
         FqyoF1QLX8xqRsiDk+SKQxwULucujGAq3twggM2k5QMwPaPAzgrL17/FUbtT27MvmURz
         MJ+OMsO3+Z8rETiAKg5r/QGUg/so52AeuW5taCarN1WNCJWYCPPr7q6ECEgYABLn7Jq4
         qTwA==
X-Forwarded-Encrypted: i=1; AJvYcCWuKDC6ZCoM5S1tijSupaNlmLLWNV5E+8ob7+St/llQDoAfx7lgKTaJ50NRUQ0RDNFUEY4I6NR+7oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7ic5+fI3UdgFEOQcU0FzVlNvW6SQiG/XxliV751Eu5PUFglx
	fqo7kqZuD2zZ96gCTt3255L/QC9l4+YZWNQRNaPddUZpWigWM2s9keUMfT4F7Wyg8DFOJDeWzgY
	8zocpbJe/NSPPJ4C/2IwA7ylU4KG1DpI=
X-Gm-Gg: ATEYQzw0fseMce5KsMRU+kUdK0lNgcUyF/Ty1amqAPtWRJ1CXNPIFcwIGS1XvtTzAo4
	61r3SATATPGPq828AcZ+mQX1GI+3bq9RT7env4PgLd+P5tcddHFIRmBVD3P2OHlpiGOYmOX1Zzj
	1DPCXyVVLte6EunASVCzkj59tulW5AhOJqQaqJ2lzVuu9VlRSt65k7XzGTR39DGsbk/BET7EOI1
	L8+Q0PDXVlcN1aSABbdbsAEmTsdT415VEipvwOc/E7iO90ZG62CpOsiXZfkmTUIVkuXovf3WuIv
	I+OwKiBo4OxRvbHa3SmY9grLgLgLK3yp+i8cagb3
X-Received: by 2002:a05:6a20:1587:b0:38d:ec17:180 with SMTP id
 adf61e73a8af0-395c45380dbmr11083219637.5.1772452234257; Mon, 02 Mar 2026
 03:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228065840.702651-1-nick@khadas.com> <20260228065840.702651-4-nick@khadas.com>
In-Reply-To: <20260228065840.702651-4-nick@khadas.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 2 Mar 2026 12:50:23 +0100
X-Gm-Features: AaiRm50FgM0_ss2LirCLzQnYitD-NcE8mXa7mwvdIpZAszvT_xHoXBROvJuWmHI
Message-ID: <CAFBinCA-sFP1ueM5CCXHWXxrHgbjYhJejq5ShHCZzs7JKm5uAQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] arm64: dts: amlogic: meson-s4: add internal SARADC controller
To: Nick Xie <nick@khadas.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieqinick@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 7:59=E2=80=AFAM Nick Xie <nick@khadas.com> wrote:
>
> Add the SARADC controller node to the Meson S4 SoC dtsi.
> Uses the newly introduced S4-specific compatible string.
>
> Signed-off-by: Nick Xie <nick@khadas.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
