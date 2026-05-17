Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3A31E106
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009569; cv=none; b=Uf1ELXyBTfueLRotk4l9GUr1CxNxlJVrL610Lg1bWPcE870Y5+PmkMG2Wk+2s/gjVULC83Kh0xW9QM2Q76LfiwX0OWYiYz30/Ep5oNADf+LbJLUNqaQfu/ulNEkz+HDRREOLT81ashhCDG8Iu8J+cETiY8SdY8mwcYSXsV0sWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009569; c=relaxed/simple;
	bh=OI09udj8QTe1SX8de+cOIFJErQM7mv6XXzOib4wIeKc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:Cc:
	 In-Reply-To:References; b=Xmllr2KIcM/dUqSoUQHKIpc7x6pjkHQjxcouo1GT/ru2MnKPJgw3fO7ahcCHO2N/uMP2W6dHloLVbBenCxBNWFunag1UNQ6Pg/mvxwCvC8mdFnxYHTxSUicahyQWknnCw8njIOoKZcsibbu6mnL08MIA04pt+Mk9+h5A79f/xbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm/oBWtR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm/oBWtR"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-393a44854d2so12936801fa.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779009565; x=1779614365; darn=vger.kernel.org;
        h=references:in-reply-to:cc:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sq8VdtxezKBE/tpgvS/F1F66FwRdNHAyIzqyCnGxbYw=;
        b=Lm/oBWtR4uM0Gm7GgV0UzA+Oe/ST1N0lzHk9tc9lPW0XaF4AVxTAW7NWIg7ChKSkgY
         0HLUnwTsIFBAv/ZMI0slr1pB6922AN09+TKfxQ4DxXfmXMnzXksU3cLgVw/7ZiNP5Cu8
         fEd3UelixryOAVGMwwgla9h9ToBcqUfRe5+jJYBCatPfguhBC0hvZGKvnECDD3b1sie2
         Lk6xnuyFZsA9g8MheozFdyCm9RnjU2n60rrDse13KM8I6n/6DauwIl6rflVe7r1Elw33
         a7vQPi+3QZujG2QTEwQf8fQocZtZI59fqtfrCkpND2UetfmigRdRgS7a5Uk6JA86NMSu
         f2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779009565; x=1779614365;
        h=references:in-reply-to:cc:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq8VdtxezKBE/tpgvS/F1F66FwRdNHAyIzqyCnGxbYw=;
        b=irabJNbn2/rFH44sNEGEead1/XfTXI+Vf+nk+SdjR62PoUNYN3QWBkd7t8Sywo0Fdj
         f36B0Zr7DXiwYNVY58HMef+5SNDiHgMTxpZlbFXRBYf8dHzdgiLTKlb5hekYKz1pTsSY
         cDD1u4zcZDEB0K1J3RXE4PPaqlqUU6wO6JM8NDwc/ZqHJ04xyTRFjOAHjqzhjJ8MSdjs
         QCPzx7rFkTWxaBozoLAcP9nUj7pw/n1Lf5lSksTDQDo+/Bo0HlPgbY5/A+jN4iO7PpjH
         v73OkRSyGj2mm1mANIpSmXaDYFqqRr7WLCUIXh1oR8ARSe2lUDdSrUF+zaFn8prmisdu
         lrwA==
X-Gm-Message-State: AOJu0Yxp9/HX4KMlxxvZ4HZIuWKuxRaK6ukvqMOGhVZgBJc1Rcu+6+10
	HltjHh+XMGyupUEa/W6MznHGnMN38RA5KyzAOPfTjyYL1qDNH2SPIW69xF1SH1Ki
X-Gm-Gg: Acq92OHfgSvXubMFE8McvU3Td7lDxdfHX8GcofuRsDuf070OFF09cMOgjavbtjyywPr
	AvyB1KzMNXBr2gSI4UQ2+GeaMzIxnRlLl+1iatGXfzUE5WA6Haw00uN9BDSdoZFQv/Q3v5r4kgy
	+PiFpBOtqOS+Y3TD3HXU2KCcFNMGFh6PWlVQxdsUi4XPFu3AUq7Ij6o9EyJUIGM91ZF+lmSyMSI
	qm7utDu74efZUKUnGeOJuKJ7oE9Y/v3BtnPl9ncwrwJcRNUPwUfQAeqQ3O41gf7TPUopBv7MdUy
	pn9BgAEQpWkzwMiwIZyXBr0PxzA63puoupTKCGxxgcqBTfwWxnGbkrKxtzoweuYyu1YygzUBPvE
	ssJRtBp/KZlR4yyOQFGTrvcPC57+moF1LCv2q5sbczf8deZIn0maR+iPpCRJjUSYGmLxDIQ7r+C
	VWmFkLeWT618SVHY0lOZJMPkCI3bk91HuZ5qkObNAUbkQlCiPpWE5TgxN1L+quG2UW8w==
X-Received: by 2002:a2e:9793:0:b0:393:ef2b:fc05 with SMTP id 38308e7fff4ca-39561d630a7mr26163241fa.16.1779009564993;
        Sun, 17 May 2026 02:19:24 -0700 (PDT)
Received: from Shofiq.localdomain (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887f7b99sm4036831fa.42.2026.05.17.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 02:19:24 -0700 (PDT)
Message-ID: <6a09881c.7a23d47e.35947f.2f62@mx.google.com>
Date: Sun, 17 May 2026 02:19:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6010766939070927020=="
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: dlechner@baylibre.com
Subject: Re: [PATCH v2] iio: accel: adxl372: Add timestamp to FIFO data
Cc: linux-iio@vger.kernel.org
In-Reply-To: <20260516211935.36773-1-shofiqtest@gmail.com>
References: <20260516211935.36773-1-shofiqtest@gmail.com>

--===============6010766939070927020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi David,

Thank you for the two review comments.

Regarding the timestamp accuracy concern from the v1 discussion: the commit
message in v3 now explicitly documents this. The timestamp is captured once
per FIFO watermark interrupt and reused for all samples drained in that
invocation. It is most accurate for the last sample in the burst and
progressively stale for earlier ones. This is noted as an acceptable
approximation for coarse event sequencing, consistent with watermark-based
FIFO readout in other IIO accelerometer drivers.

Regarding the function choice: Stepan Ionichev identified that
iio_push_to_buffers_with_ts() writes the timestamp directly into the source
buffer during the loop, corrupting subsequent FIFO entries. v3 switches to
iio_push_to_buffers_with_ts_unaligned() which copies into an internal bounce
buffer without modifying the caller's data. The size argument remains
st->fifo_set_size * sizeof(__be16) -- the actual per-sample data length --
which _unaligned() caps at min(scan_bytes, data_sz) internally.

v3 is at:
  [PATCH v3] iio: accel: adxl372: Add timestamp to FIFO data
  Message-ID: <20260517091735.135610-1-shofiqtest@gmail.com>

Md Shofiqul Islam

--===============6010766939070927020==--
