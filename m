Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746650;
	b=viR59palkeNdOEHQY0K0cjERQm64XzN9a0j5gIiUn4qe0jnCRWWgkmDVLfPtjrIxSNIg
	 QhKpEJP6u95Wp52iHPbstwA/Zy4VcbaSn8S8UMuwvVqQMmRysBmu455oBKaTSi10cIrE3
	 kcD9SoWgnMbZB4SgrqUUgICD2Da7wGDkEBpH7l1jpKANlE/dc4tKNevxKf+EwgeehKddd
	 xfBywOVvzeMeRMlZQWauy3hNqagXV3MyTuF0P9RZgqjsbubaJA71p0x9v5+Jz/cdR6XM2
	 7EiS23VepfptpphyltuHnCnRR0YVlGmQSAXoHy816JeTWNd66DUD6N5TPN7WUX5yYLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iks0aFSHOkkGNM3nhF8ovnYM+3HT6MOjrI6VZAWf4VM=;
	b=m1/egA7keQf/yJCxmOg5NoPS0S83nmdWhHamh62FtlqpNCzAB5dXeLHKO1oH4SgzLse2
	 PprJwszt8v+kjvn1Qx8aKPs+yj2rbTNiRXsUXUnO0R26jOttimsSFKtyFp7I9RgRy1MZh
	 iUfq0yT31GsfrCUWPtvUsLNRyMLg+KBxUVKidj6eYiUjWuB7JR3DHZzoV9zbV5sr+r7vS
	 IFpZfauhCM9UXj4J7Ns3vtl1tanlJ5EDgHNqsyiDTAqX6ESaoP4OMthqCFeMqPQPXZ1s6
	 XwVRrsOkWrdITJCPT49NSDQcUa2YGZXVru5xKSWW8Pdhx7ESQIyYFyKXKH6BICgqKnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A6QAjipA;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C61606A321
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 09:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C61606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A6QAjipA
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so1269215f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792746649; x=1793351449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iks0aFSHOkkGNM3nhF8ovnYM+3HT6MOjrI6VZAWf4VM=;
        b=A6QAjipAxdnOPrYJOoNxB2QBPlprucEwxZlX6TPKJR+HagX2O7ucfY/43nX2EQSRPU
         VjMNJuH1sGvjLlGsqPUe3l/d0V+/sp1J40eDh/aVuRtkOIkM8Y2IauFbk9xR0lOx7RTd
         bqO464Mxhzza+zphrnJlB5LMsOQ2vtWW+uV8W7Hg7ceQx4bDGoMV2NZhH07b4KlNJ1ei
         VTir+57pAE80mOGeGmYlBZPRONGU5a9R5eLMmj/kdof4AfIIUdZFouqRwHDAtGTkSq/P
         irSkC69s29//Nam5JDtH2E0G1Yr3l4PFU6vzD6ybbs0Ap+1bdsMUu3jEY4spzZFFsCRs
         hAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746649; x=1793351449;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iks0aFSHOkkGNM3nhF8ovnYM+3HT6MOjrI6VZAWf4VM=;
        b=a3Kp48CDd41h9A62CBCrSfzZklMHeCIjbMu1CUbQYHDrZvc/8Fvexf+u8R5D96QpJg
         4RDlR6uU5iVjTiAHMD1TGzfv3EuivttTyyTW7atjhU9qjKPH6C3ykPa3otA2ZLvt1YXD
         JNKAv3cUVpFQRoU3UMNJx2Dy/j8mtpeFV+vmVU34ea2K5EQgb6cNVxVjn7uso2djtF5v
         Qmgxv/qei7fg1+mX/ncpNkb5bA/zJJrLwz1d+RIu6ivudseOCmkHWr4lpdSOFh51Zw+B
         5T2KXJQGxWRQp/B3JDl1NnP6cj8//eYkpuQo3SkKzX8Mc2l2jr2FRpBi2NuMoAYxcBOi
         eU7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy1/F6n+e24iotv37gpdjwGbYekyHTe2JkCV3b4m3pKKtQegYXZtEByxHjltUv/ej/QT9nkzOzTwyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkeS82DFts2fsKByqGBFUjQPtdeY+odO9Bj5n1e1M/fzx40yRs
	Ss0PWeKKU8S1JRhNNBtjoYpISEEn3h6ImB0ouaHN2s70UmCfY9+Z1Q3b
X-Gm-Gg: AYBFou241kb53dQ5y5ywwxj8Bw0yvuC2dgz2as+hdHgsJmGel1xuWoZ1kdiVtgUust6
	2fIrwd5CZv80tCM2aXzFJwAzult11w/hVhNviZ8crfQOK5yO2ImU7lvdzUouc74B8dsjNz26OUJ
	RY/8Sg5113Jyv4wzO8N7wxJqhlx6p+HgmX4XZhLmAFryoUOA8Dy449+5U8EY0By+ZVg+HhUtfQs
	yjhpQosviIyneJJrCvhLjA5u1DwZcqY/50ulJPMnVjN7rO+iVeNAScAVOmJeVKG+MskdQSYQnO4
	HUhsA3dTP5RoNqjE4+mXOdKKrSPmoeZdNmPG9ShE7IVrqoPEeRSSdMzEkRzVK53S6j83ZQ5Rt9q
	NSCAAboymJs0uLFKQp1vCjuRQtZ5KW7m1PpSsQeAKiIwzG3G9dkESXZBFt28fTW3BwwgVEBX16t
	vdJj1Lu9I4Igq19KBS91e4YIVnM8G2688oifH4TXMNwTDu4jeiTPU7vaAd0hY9UYp3eZIftmpVA
	fPP/0sPX+QxiQvbbP0dJjSpe0jx68d2wRiwh35/IHhQa/ajjJg9lVKczB0EFaD5E+8TLSEbgB9G
	jnudgayU1GvgUTKP1eh2QBTXfHe4puyBsLS3OUD1eXPJEklYfrWrs4tA92DaBiuQJw3vOKKkBpt
	ZbHj6aBInlB+mx5JjsV06ngtHmmjboXsRsB9zQaqgzOsXfJTl5FqUr5A3AUc3LJVcUrsnBpPapo
	djhBiyEqLvuigcwYW76Nyu+xCiqQl5zqsVwr9TmD6HxcxDJ/o3xN6tVJm325BcPQ==
X-Received: by 2002:a05:6000:1a88:b0:48e:884:affb with SMTP id ffacd0b85a97d-48e2d273444mr10748908f8f.24.1792746643235;
        Fri, 23 Oct 2026 02:10:43 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3803360asm3931375f8f.29.2026.10.23.02.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:10:43 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:10:32 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Stefan Windfeldt-Prytz"
 <stefan.windfeldt-prytz@axis.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@axis.com>
Subject: Re: [PATCH 2/3] iio: light: opt4001: refactor driver to prepare to
 support more devices
Message-ID: <20261023111032.0000019b@gmail.com>
In-Reply-To: <20261023-opt4041-v1-2-45227f82d05c@axis.com>
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
	<20261023-opt4041-v1-2-45227f82d05c@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 09:48:14 +0200
Jesper X Nilsson <jesper.x.nilsson@axis.com> wrote:

> Prepare opt4001 driver to be able to support OPT4041. Extend struct
> opt4001_chip_info with fields channels and device_id because OPT4041 has
> two channels and another device id.
> 
> Datasheet: https://www.ti.com/lit/gpn/opt4041
> Assisted-by: LLM

This tag has been deprecated.

> Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>

...

> @@ -388,19 +411,19 @@ static int opt4001_probe(struct i2c_client *client)
>  		return dev_err_probe(&client->dev, ret,
>  				     "failed to reinit regmap cache\n");
>  
> +	chip->chip_info = i2c_get_match_data(client);

+ null check and return -ENODATA on failure.

-- 
Kind regards,
Joshua Crofts
