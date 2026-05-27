Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98078426D33
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892533; cv=none; b=fzbVzvHk5sCGd+y7Wbom6+Qy9yu8ljgpVQJ1PQg1JkZnsFYhmrcom6W/O6oyKnI0/NFGS6XAhdcwTjZBk30TeF42yjjI0bmxYB+mhIQS6Xvf+1afqM7rxEKXz34mm9iUJU5kFBMrEdWsldhnvuxvj6dSUVJdRqrxt6b2O3JrLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892533; c=relaxed/simple;
	bh=3WvURRv+0iGdxA52spNK9Vrx/EhqkX/wdqaVWGz9pO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9buMrLh05358sB+voPfSBYMMrlgoazuncmizp0taQyuWA5lCTTkIbFE2wYW1BOPFHLJR3Kr117O2I/W00+gIKyXlAWA3XNyCRWRO9gnPMYq/Sa3BcUK3hvM0vafozszmacibQewcthxW/dXQdjMPJ/1136UL4yjojNkib8aeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peaWFW+B; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peaWFW+B"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-449de065cb3so11599591f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892526; x=1780497326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96VfRnvZ0QCw3hUcAbbbU59S7RhhCddL2r3UDNMDre4=;
        b=peaWFW+BO9b7N9ANM6TmONUvqn15q3Cuw95P3PMhYTZnIRb/26wbvozr485/vijz5+
         7OJDujmt3TB8a5dVL2oJwXCq9DeDf5cJmVhdFih0dw2+4UKtGdXkbfDOe44hlc7cvXXE
         7Z4w3kOUlj9PsmP7MS+kLK+dlRYdrApf3f0MtcdyCk2s+NOy0TW7TF42oHygIobSXtjF
         NYnsMwxoITP2Be5y4K4B8/nZRm9SVu0kHHLLVdyO/FSF44OyqhMkt2YW0MY/5CShNpH/
         le3pzH4VecRBsVmyv5mjJGrLHwaNzzRLngivDlNGXnI8rFPOWsx7J+U9mPHH886bZPG8
         yVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892526; x=1780497326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96VfRnvZ0QCw3hUcAbbbU59S7RhhCddL2r3UDNMDre4=;
        b=Q8j9NXowHsb6muozexSIlCuOPIFnu5jH7ohdesRlITPCmHVLjfl6Mq57BONcpzqMbv
         8/PPgYrblYs5UvyL6Yoi22UFoFwjAUwyORNg/gKjyqvGHQ1XZ2HgRYoCcMEAIBl/6hdo
         IeQvaGl2i+D8Iw3ENJz+cCyQ6SmiFjIlsLJEjZKY/Hhb7oztXIt7v9vZxYh/AkhEML3o
         R46U9ymRk86DE/rDhaK83x5i/8NdTLMATkxAKeMkjOTCaxD677uEGu5USrrHD+ynA+di
         K5HTm8nvPaBUrpZwq/sxh/byEr0BxKWtdeWKlp7LJen2mNly3o0ySlNmKLjlt1RzUv0v
         9uAA==
X-Forwarded-Encrypted: i=1; AFNElJ++xIfVeKXnw6jUX12PE2mSIekGEsYwTJZTSQFQRLd4vt7q8pbrXjSdqU6XT9+rWFUxUUL941C4rGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzix2rj7YS83rtCzIkgUs9FMST/rgRqMsPG0EXWy0KtTlFhOCm2
	KeuNWYXkDlXL69Xm45apWmrDk7dG9AS9Par4XvqYyEAeXtRP72w6JM0h
X-Gm-Gg: Acq92OGX2HpuHw71NMfEJvs7nytYGxSWAUVQ6qzVPpnnNDx43bzaGzYh7DuoXW7/ZtM
	Zzd3v+VjI6xc64hGmiboMgF3rzAj4XNk1wp5owerRD6WDpBGgPIog43Vn7KHwYe0VgvkRMxNt+4
	3l2OmF75oLiKbLhmbgr7sXcwoXtX/FWS3Ir+wsii+/8jhp18sLJEyLK5RZ1Dk/ZBTsImREr9jp9
	A4/Hljh0ANlT23RaO25rzx37jXOums1I6SHthPv8hiBzjS4SjApUWY/Vk8pSdkyQAsj7VPMnJLe
	GPZjoMn2T40WjpYbSO0ag7PUYoE5ICf7nJjfHq6WgT5oG8jA9vhhNToOo5l1QOooPBV2g5CnhM+
	RCEBJL7f7QV3Pwzewyugkdr4vfh6DZyumkCKNZPNnP9A+oRkqlYhHImARtKOoi/2Ow1C85jWvhj
	6++5AEsuXERFcI4bk=
X-Received: by 2002:a05:6000:470b:b0:452:d03a:7aad with SMTP id ffacd0b85a97d-45eb38a6d8cmr39575261f8f.36.1779892526169;
        Wed, 27 May 2026 07:35:26 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm6239763f8f.11.2026.05.27.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:35:25 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: jic23@kernel.org,
	lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] iio: flow: add Sensirion SLF3x liquid flow sensor driver
Date: Wed, 27 May 2026 16:35:06 +0200
Message-ID: <20260527143515.102794-9-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <4349f634-dd7b-468a-912c-5ceb8a283954@roeck-us.net>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260524205112.26638-4-wafgo01@gmail.com> <4349f634-dd7b-468a-912c-5ceb8a283954@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 24 May 2026 14:40:51 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Sice you are at it, it might make sense to also support SLF3S-1300F.

Done in v2.  scale_den = 30 000 000 (500 (ml/min)^-1, Table 15 of
the LQ_DS_SLF3S-1300F datasheet) and sub_type byte 0x02 (Table 13,
product number 0x07030202).  Re-checked 0600F (0x07030302 -> 0x03)
and 4000B (0x07030501 -> 0x05) while I was at it, so all three
entries now match the published product numbers.

> > +	{ "sensirion,slf3s-0600f", "slf3s-0600f", ... }
> > drivers/iio/flow/slf3x.c
> What does the "X" refer to ? Why not "S" ?

Done in v2.  Renamed everywhere - slf3x.c -> slf3s.c, SLF3X_* ->
SLF3S_*, Kconfig symbol and MAINTAINERS title too.

> > +static const u8 slf3x_cmd_start_water[]	= { 0x36, 0x08 };  
> 
> I looked at LQ_DS_SLF3S-1300F, LQ_DS_SLF3S-0600F, and LQ_DS_SLF3S-4000B.
> They all also support Isopropyl alcohol (IPA) measurements.
> 
> Would it make sense to also provide support for other liquid types
> besides water ? That could be a sysfs attribute and/or a devicetree
> property.

Picked up in v2.  All three variants are factory-calibrated for
H2O and IPA; the scale factor and temperature interpretation are
identical, only the start command differs (0x3608 vs 0x3615).
v2 adds a "sensirion,medium" DT property (enum "water" / "ipa",
default water) that selects the start command at probe time, and
the binding (patch 2/3) documents it.  Kept this as a probe-time
choice instead of a sysfs attribute since switching mid-run needs
a stop anyway per the datasheet.

> > +static int slf3x_verify_crc(const u8 *block)
> > +{
> > +	return crc8(slf3x_crc_table, block, 2, SLF3X_CRC8_INIT) == block[2] ?
> > +		       0 :
> > +		       -EIO;  
> This returns -EIO on error ...
> > +
> > +	for (i = 0; i < SLF3X_PRODUCT_ID_LEN; i += 3) {
> > +		if (slf3x_verify_crc(&buf[i])) {  
> ... which is then ignored here and replaced by -EIO.
> 
> Why not just have it return a boolean ?

Done in v2.  slf3s_crc_valid() returns bool now; the call sites
translate false into -EIO themselves.

> > +	dev_err(&client->dev, "unsupported SLF3x sub-type 0x%02x\n",
> > +		buf[SLF3X_SUBTYPE_BYTE]);  
> 
> Not my call to make, but the driver is way too noisy for my liking.

Toned down in v2:

  - Unknown sub-type / unexpected family byte -> dev_dbg() and
    keep going (also covers Jonathan's fallback-compatibles point).
  - CRC mismatches -> dev_err_probe() in probe / dev_err() in
    read_raw, one line per failure instead of per-byte spam.

Thanks,
Wadim
