Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746510;
	b=m2YY0CBbxVza/en6futGNMZ5JWFBtXR6j8kvN74ECQ4UjtWOet7HPLsOFFbiNX6O4qJ7
	 r8OqAf9t/qFSDjoblziI+wT3UhMeQ/2eFbF4Sizo7a3aHtmT3ipCohs6buUihg+pWOqji
	 bSweQSPnNX89PGhK3g9G94pro+35aCWBjicrt8oV2E9ssnTVv5mLlUOQLUDjbazPn6ueL
	 g4I5RCj9DPD8C5+aPD3ZR86290/6LpGgGqlegpIBPQ6KJ59jGgdWYqcxgKh6+RHWBrQ6Q
	 Rs4L4Up1agh43EpEnTvAmEK9j41rHIYZ/qB05+WSldvQGRHCzg54qDqmzvhZcUIIXMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=WvLKGjsnwQSscR6jQI0B1bkWyy4lcbv+rNW733JqcOI=;
	b=4yd2IXLAIVHys6RLCB9kz8uewiqLhNL0DM7dPMJbmebGsridDvv7PSjuzCC9NJChY5aD
	 +T1Tnok3d+rCMDfIGvaFJ3m2F9xnVT5s092A1YimewfCS1ZLl34TmD2yML0KeE83Du6VF
	 jaQems51yG4PzCeild3TtYL4qNIP/sokVrx79IISlntP921eo+u6KpYAWdM8B2urqF3x7
	 bXXkZg4m4EHmDmEzJ07SumN9FxEGCQGcbUc0xq3Qarb7Id/hvlt0IKFwBtu0qKU2xwzRQ
	 4W4biGiUGU+5DJ3vp9PcVB6rvncbICVZyMVb98R9kcEQ+N7nmpLXCPGEJEHrkbfSBkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pS999K9y;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2480606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 02:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2480606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pS999K9y
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f037bc348dso60334015ad.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 18:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795746509; x=1796351309; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WvLKGjsnwQSscR6jQI0B1bkWyy4lcbv+rNW733JqcOI=;
        b=pS999K9yHq5iT2/gyzZhzmRUoI2JkVatIcLwBpAuJVPV/cffw3Bn24K38ws3SLbuFt
         PTLF8SQYViSAXHW0vcPctNeMG4JC3Pi1/dfcilj9OMrXqvlXsNQPFsBaIGqwvstJD5g8
         tE6COPglBjVSuoFl5Gnny1MBiBPzgPEbxpuH8er8ygn1O76BOX0k8zewdUCXZIlFtdsf
         m1G/GUihL4jPqJw1YqxLCPAz3f7/7bYHrggsUxlxMMsvjJJDbcn+PMknG3dx7jfUrc6x
         J17WyeCRZv2U58CUbrDwCz1EEN/b+YPfjwc5G3IeNULfYHy5hkLNUCugVg0HVeqxDOMW
         nDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795746509; x=1796351309;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WvLKGjsnwQSscR6jQI0B1bkWyy4lcbv+rNW733JqcOI=;
        b=s3PFdDQ3bZVkh2R5kOjpui/G9zSXqdcTwlDnHgqK+hNVu22+kylb8wI+kiwE/NbMvQ
         nIA5UMXDaBTZZImE21Z6ZttF8JUszmCxU4+ghZnapSqE81PHxInJvP96t7npmWfMWPJd
         seQVneFP+jS625FTSOKIwG/lk6NkPeUuJTdGedl+HngB6a80HuCO6eV+HGq9zC0Z50GX
         zNHSe9b61ZOvQXw7D+9lTMonC1s61iQcJiWIWLVcEctQLxyCVB9Jv4Xbgxu0iUnwlIU+
         v9LTmBvQ73R1kUhQm6loH8t2ZmnSczni7ArMevn95PCUAf3xNX1MRuuUJHm964sbBq6e
         tu0w==
X-Forwarded-Encrypted: i=1; AL+hErFAEqtjFrnLurkqU0LWB88CwvKMzMET6SEacoIBIRBi8f1BEkRk0gLZbMIMQqAxc676eDClNac7WeI=@vger.kernel.org
X-Gm-Message-State: APuU4Z85+Kys3gdTWSo3mu1Tg9gZrS873r00/++e1zTvXtrR/gkEINF2
	wMKAm/sXeduXFT2z693lazkzIdnidiQNgLurF/H9F0G7FosM1WMTr5UT
X-Gm-Gg: AZFdTZckRZbM0+goWgdRvToLt9Ed5XbCZfLSsC9t0MtEFQtFxp13bNO6+LVVgKqL06j
	hVnBnCPqzi9y1TP8vJ/xEKq5+8Rf3THJvtbeqz0i/fla1A9uv1rYDuLVtN3zI9BUwF3oHHiCaCB
	b4tMoPD6GoA2by3wHJFcdUFIMX9hY741o+noCMBLOp1baQprh9rjP0UkqguZchMRMb1VuFoJmEC
	GdmLSo4Py51tGjIEoXP+hf4CU9VH7Jnm37z3FfpAVuw0Wvwag7KxerWuXPSPAsKQRYOEPT4E1wo
	xVUjY+rZW0Fu8LSrBAazBpOx6Gb1LhslEqbhJSokEuebSOkrep6MY/KQlMEQOowR7xZnH08xp6Z
	WP1ouO1riE3mA3pfwlxkDvLZTHzXKuDHdGFbSMls+QZR9rfUrFHbC4zPqDoMngTYNxjDQeMeMrm
	8cGspOAGmTDakNRf2Ogu6e4SEPEyiZ1jgFBck3N9nhVP9bToPem8Vq0nywGjlYJPJrC3NeDy/LS
	K299qHe7prb4mpM72Cefb/S1A7UfzkqLluvT+ZXsXqDLOIuk+w7xjiWZ8xUEC6/kqZDrrcaEZFu
	KeXcJIiZzs6EMuYuQAtQ1Jo+ka4+NHdzGzniYt0toV5Y0IEq1YOV+NzwgiUXqvT2ysH2gQo1EgA
	=
X-Received: by 2002:a17:902:ea01:b0:2e9:8ef0:cf6c with SMTP id d9443c01a7336-2f03f1ed55dmr230265165ad.26.1795746508987;
        Thu, 26 Nov 2026 18:28:28 -0800 (PST)
Received: from mac.lan (114-45-165-38.dynamic-ip.hinet.net. [114.45.165.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84027sm111030145ad.7.2026.11.26.18.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:28:28 -0800 (PST)
From: Ilia Snezhkov <iasnezhkov@gmail.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-iio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: mt6359: fix MT6358 VBAT impedance
 resistance ratio
In-Reply-To: <RyeVHYGoYxuKtlQ0QPskoF7emL4yakkPeBUW--rPVYqvaAM4Q5Pm1GACcF4t-1DjyxPPOMNyfAiMnTxVqugYC2MBKxUBhRiDDjtcPNK4Z7Q=@protonmail.com>
References: <20261126031013.27701-1-iasnezhkov@gmail.com>
 <20261126031013.27701-4-iasnezhkov@gmail.com> <RyeVHYGoYxuKtlQ0QPskoF7emL4yakkPeBUW--rPVYqvaAM4Q5Pm1GACcF4t-1DjyxPPOMNyfAiMnTxVqugYC2MBKxUBhRiDDjtcPNK4Z7Q=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 10:28:24 +0800
Message-ID: <179574650424.5055.6452827952792020438@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list

Hi Roman,

Thanks for checking on MT6358. On our MT6366 board with the vendor
mt635x_auxadc driver, IMP reads the same raw value as BATADC (26737) and
converts at 3/1, so the divider itself is 3/1 — but comparing mainline
mt6359-auxadc.c against vendor mt635x_auxadc.c shows two differences that
likely explain the timeout you saw:

1. mt6359_auxadc_probe() unconditionally calls mt6359_auxadc_reset()
   (pulsing PMIC_HK_TOP_RST_CON0 0x0f90 with 0x9), whereas the vendor
   driver does not reset AUXADC at probe and relies on bootloader setup.
2. After pulsing HK_TOP_RST_CON0 (0x9 -> 0), the vendor reset table
   (mt6358_rst_setting) also sets AUXADC_RQST0 |= 0x80 and
   AUXADC_RQST1 |= 0x40, which mainline mt6359_auxadc_reset() omits; the
   reset may also clear bootloader-initialized IMP0/IMP1 configuration
   bits while mt6358_start_imp_conv() only sets DCM_CON (0x1260 |= 0x3)
   and IMP1 (0x120a |= BIT(15)).

Since I do not have a mainline MT6358 regmap dump before/after that reset
to verify the root cause directly, I will drop patch 3/3 from v3 and send
only the Tested-by/Reviewed-by RQST0 fix.

Best regards,
Ilia
