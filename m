Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154167;
	b=ZA70WoW8htGm9BDUd5LPx6cs/Xped20jROKHr2fVG/n0Jsmpmj3n+O6lcOhv7fhrap/L
	 lR8mlbu1gzTNZCj46NXX2b0vcu23QXgRUav2jb5aa1WLoupx4OgI/EglcnHJnjlSBmQ6b
	 PfvnNh9JMZB0Ag3cjXhA+s64Vg9w85op118//rD7/ygWdDrYF1Ey53B5s9XZa0/vS19p4
	 wIW/v/r4ISh+56lmMGvs62V/194kFNt3argZUufAZ2GuE7wuARRBEM1GDmQfYZBf++7Gf
	 htvUlHaQNN8YVbZDzkbtE2NR+ZbnkKbkv1FbqZKU5dYODMqzwLIZVA2xLLYVEY7nV+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SzFXpQkfPDM3m3i/dGse7HfQ/Rq6VRdrmurJpP9q7DQ=;
	b=WFdic69zHQSyeaYCaDFH5d56fRb2kcFDvbJUCMZ5zDSNfNcyxpDvRDdf7Y4touY/E5Wf
	 m342tolN/KC3glrzZBXNVUDbAHQG28PUYKG3KMstosfbxxjVYYMFv4loDiyzvBEgcP/5O
	 GJkPLimftnBYClfYrp6eyOOuttgKf7fiuv+xCBcV/0mETxopfNlzaZpqLIDKM+pRhOIxG
	 r0mbCfU4K+x2kemSoV9nv42ZteUNMbtqljY/BWMrUTgFR+6OFV+8QGLR8P9GYHrXpFe9k
	 cvETURacoRVRD6n2+Nu4/3tMYg/SxDAKUNGbcgy8eX4AiY1nM6CJ056mY4i2v/DTsjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fZ3vHGWW;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE107606A324
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 02:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE107606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fZ3vHGWW
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ec20398b05so371812e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 19:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793154166; x=1793758966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzFXpQkfPDM3m3i/dGse7HfQ/Rq6VRdrmurJpP9q7DQ=;
        b=fZ3vHGWW2qbUnPcwE08qOOaSAjEdJU6q+I9tjUcuLD7ttFUvtQOjRaxrDin1CC6NsR
         3XMRkGjmRs7lWw1maeVAIxhJ6N49/dCtKTVHQANQoQmoTydHbufX2LGDEaT6wr5XRrzF
         BJSG9WwZLBipcqONXmtL/LVgW3X3haaiFTqmp//VtSnMz4ZZn5pY2d2B0NtsLyW3gZrX
         0XTy6vusOk9WqV4OHf78oIRrDzeXAPRpRpifjjnJ2r5J/XD0U7akdtZjAVSB8T7jpnVb
         fYaz4x8xKPnTC8C5WLWxdUbXW62pUSRDKBNssPhPV/3hlNm7EhrXW2wNOStLP/xI1Sn+
         5Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154166; x=1793758966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzFXpQkfPDM3m3i/dGse7HfQ/Rq6VRdrmurJpP9q7DQ=;
        b=uA0aa/br8uIF0SKqymL8qRiOXyupC0WtOvrnrNh1gyyVwpTGy4qaoQMpco15q0UPC6
         PnlMK46bTcmCgTZHSYs1CzXmPo/jvGbvaXrSMfNk8Gj3M7mB4kxDe+4wJzouNyXnXXN5
         wzIwqVYvZXxHpihiJzglMj3B6b6cTJCZt8WLaN/xgz884lbRhQjlKqMbFDaWxrI/KsXc
         gBq75nGHr/yKTWBlJ4gRXOOxqDv3wwlk3r8+Ayj+kq7iMn7dGoUvA9iclFNOp/2451tj
         deGXw5sv0Kv0l4cokfviozM/nHgnyzclZNb0+CTsxlX7GAbZ/DSUi5tLYGMJ3HGjVGnZ
         mCzw==
X-Forwarded-Encrypted: i=1; AKwUvBwuhPtnKl3muI8T8ZzTMEIfrF6Um0/fOAnNxzZhCg0VOOldTNyl1nXf6Sh5NzJRX7T63DHzpF+fn6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3H9isIB33Rt6DmDh0g+zDy3V8IibC+4cxVeLTvhvPu1CG0EbM
	ZlQ1xLDMFX82qwGaJCpthaO9O0OqRfGGkRvc4/RoWczwrYJVjYcZRfZhJPOsxKTG
X-Gm-Gg: AYBFou18OWj9KWtPUfF+vxyFk7GJFVJGjSFg2vbJKSNTdXqE+4PyDS+KmDvE0FFnaZl
	vpZz3UybBB54aYLJxnHLYBBHwbgtRYV5ORMbqBoYW+R9IQ5zL6W3cKmFsFHkilXNZ86hKQXYgBL
	3kcmHggoi/OBhdeBjH8cOwfMY7+UepuYIDA1RYxxzM5f0atBwPDswcfbc/y3yNrOfQBWT39Y0tw
	WNFOAXBYPjh7fCeah3xTxJPxqZTcpgn1g33P85mJjxu0SnI7hANLvSH3S6aO++CWMeBATS/bauy
	3kpZUigkmMKQEu7Za0mQkoKi84gMPBBA6muDHs/Uy5saErZzSzvC8n7gwB6jfLvvMLHezaBhAWB
	LkpsHwQp0XNjcRrErPSqfPeN0AFdl7FCKwBz2zHf5WvF6ip76GoCUZDOzMtBE8tnj1OQk3cSaDE
	JDVa34PFIyNQKyaB74Y4puLf16wtA7in5D/EFVXRDYuaBiDMLD5S4bUpJkijowy6HammEvQQ5UU
	jpwnJh1QEP/+dnx6kwVY8zSC6UhMKccylNKDT65eunmzIXg1JfhRrpVo+yayNWZMaYKaKKa5C/d
	txM=
X-Received: by 2002:a05:6122:e146:b0:5ea:be1b:1b24 with SMTP id 71dfb90a1353d-5ec4cbd805bmr534752e0c.13.1793154165588;
        Tue, 27 Oct 2026 19:22:45 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:4df:52dc:4559:394e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f8dfcf1sm415927e0c.3.2026.10.27.19.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:22:44 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: adc: ti-ads1298: prepare for more chip families
Date: Tue, 27 Oct 2026 23:22:36 -0300
Message-ID: <20261028022236.30455-1-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025232608.06a5762c@jic23-hlaptop>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com> <20261024231335.280955-5-stephanbrrs8@gmail.com> <20261025232608.06a5762c@jic23-hlaptop>
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

On Sun, 25 Oct 2026 23:26:08 +0000, Jonathan Cameron wrote:
> > +/* What differs between the chip families the driver supports */
>
> This is very standard naming and purpose. I'd drop the comment.

Will drop it, and the other generic ones. dr and hr will be spelled
out, and vref_mv becomes internal_vref_mV.

> > +	/* CONFIG3 has the VREF_4V bit, which selects a 4 V internal reference */
> > +	bool has_vref_4v;
>
> I'm lost here. If it's about the bit, then name it after the bit.
> I suspect it's about internal reference that can be disabled or not?
> In that case can you name it for that functionality instead?
>
> From a quick look below, seems it is about what of two modes can be
> used?  If so how does that fit with just one vref_mv above?

It is about the internal reference. On the ADS129x it is 2.4 V, or 4 V
when CONFIG3 VREF_4V is set, which the driver does when AVDD is 4.4 V or
more. On the ADS1299 it is a fixed 4.5 V, and that bit is reserved. So
vref_mv was the default internal reference, and has_vref_4v said that
the 4 V option exists.

For v3: chip info has internal_vref_mV (2400 and 4500) and a bool named
for the 4 V option; init chooses the reference once and keeps it, so
read_raw no longer reads CONFIG3. Andy asked for the same.

> > +	/* Reserved bits of CONFIG3 that must be written as 1 */
>
> This one is interesting. Normally we deal with these by just using
> RMW cycles on such a register.   Can we do that here?

Yes. CONFIG3 resets to 40h on the ADS129x and 60h on the ADS1299, with
the reserved bits set, and the regmap has no defaults, so
regmap_update_bits() reads them from the chip. config3_reserved goes.

> Please use FIELD_GET() and fix the family masks to be values in the field
> rather than the shifted version.  You might want to do that
> as a separate precursor patch.  Looks like there may be other similar
> changes in driver around fields vs value defines.

Will do

Thanks,
Stephan
