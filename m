Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795573964;
	b=kpuDtWwroBGfvN5ZBiSD3ZXrRhgJlkV+XvVgPBDH0x8kBoz/9MWCaWZ9vcu5UesBqsgt
	 S9OE/pSujcb9zg2UUuykaEI7WzQhc5jo5FsbX3etRRo7h/mG4wG0M2z5bHJzM5wfQ0LKs
	 VnanheNt/Kq0k5gYrKtybPLhWtaJ8AL812anySRywpQnEstd9epPWdf74yvcRUSb/jkZl
	 lZj2Qc3UGKtoePXYB65B2LZBYRHcNNTqZUwy1Vph4oXedx15ynkq08BIIH1sSxZV+BYYE
	 PG++Ydh92DSmyyw09uNlMZz6gCs7qFsojxshKGHDciNW944nZMr6ILJ8inAo00lSyug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ZON3wd5LTh6DpO3AOL2NcXrQXtyEk2i6wBI9GQETg9A=;
	b=vEiLe5jdzpY9LMu2dzyBAC3z1RgrIoqYWtcvPMT/Nejdbb2ZY5IHDUsnZwSVhje4vrsW
	 +ECY3bQOwyBq905YBXjqk/MRtoR5j94tnyrX1TAyt+2AnPmRXqDFoX/aeJBNNJ1VKegR+
	 ayMpE8TAgk6LIlyfmbb+AB8kthlxvP7bJZTm0B/DQBNQLEEHIVLg/+6SQ0GwG6sQSW2Bp
	 OlARcbFbx273nqhsury24a562sfO1VimQTI7lGDnKVsj5mG/EVIhBHVdWDI7aXVLpM7zp
	 ovMGzt5mBEOn7OtSEkshV+koeYZIwFzLHdzVkaOXZbQVHyOAowB+vSRxN/1Vwqh0k+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGnkFeho;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B29606A326
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 02:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80B29606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGnkFeho
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3acd523a802so46251811fa.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 18:32:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795573963; cv=none;
        d=google.com; s=arc-20260327;
        b=n5W4RoexfhNOr2da31MOH5rTGkS4g+4ajFHggAAXaL/Tw6ubOVxViCD+thR/jcdUS0
         +3ikdG31Oid4zxyzVIo1N6HA5f1j8qwo31oObFEHAAgF46NMTfVniHZTUdh7yEt+XDH5
         xgsRgJ7vE5wlS/c+rAzuk0T+dKrgFlfvt9gcQEroniL80P0Ba7IVGHUQyQ1ZW2YiOQI8
         caZFwnYjGVLduGzsI7h9UDChWXrWxi07IolcsgHYGVwd7ulJw1mI9kaRGDfLbcjFau6z
         hZ7V+OweALzCND+cPr97nIf3/sab2pVi+G+meRZbWCwBdxr7T/K9Yy9/fXW6W0gH99yl
         FdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZON3wd5LTh6DpO3AOL2NcXrQXtyEk2i6wBI9GQETg9A=;
        fh=22mKt9sg0uBrbAYrBiFc1Je1N6c5u8cV1XSgRDIC45k=;
        b=KKhBOyY6WiIrOLbqUMTcjh+ViJYzU5AQ5Nh6JhFNXCCuH58aC/kBsl0aCtnr4BXQ2e
         msvmA+FIkIobgoUIvkNeSX58qtt6ld06IpEXds+wN707SkRiE3L0m9OXyg+hHWCwQuro
         ZCT33L5O07jNhlKtx8wCoCtX2kPhg3ClBjaetOSIbTmcteC7/qxCppwOkVSGthSwKIN3
         am++58+NwRDrKMK+u1B0Nq635OEFUcXvEKc3xKwvZTBLmBR3/3ZfLEZC1fzFdPR5MvUv
         Bln16qsqinx1fFlaELxrkkWuekP/1Vr9D3qoYvExiKmtHQI/JOji6YC0/grhi7LBTLdr
         IplQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795573963; x=1796178763; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZON3wd5LTh6DpO3AOL2NcXrQXtyEk2i6wBI9GQETg9A=;
        b=JGnkFeho8NHko3O6xmJmlLpcKz9rm42Ze7zDq5eCUuPWhWk2DOetuwlfUCK/zrNhC9
         TySDjoqzKiD+nr+xj8/hVKIYHrk4RyLvfhaO7iuHEFVN2fKNqz2OhzBu9EkSWerrPTuV
         d/eSBJl+nY1/y9CGxu2xM9b7JYmQzUEWNBSSsJnaPL38DxjT0lyd93+RuyPGHSOBpOY8
         ZJXUfkXr61HXdHPJ3FKISio150uY+TrdPChotPmKCcie4Mv65YZIbBqYcyY2WY9z/YWA
         hRd7dXIMSuhXsVYmuTFOpKeFZJaEQSpGwA7sdfNBudqK80lfpDmagKfurFLDqLPdbK8X
         lDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795573963; x=1796178763;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZON3wd5LTh6DpO3AOL2NcXrQXtyEk2i6wBI9GQETg9A=;
        b=Wkl80FcwU6L724vVxmI6aBiShn8BOjvj+Xuvip3lLJnLw7oby11PxiDtoFjbQUyrMz
         3yn3m4GNlj1aoEkhTgvaOM32O1DAN9pLNTJVpwAm+7mP9qKkOgdhoUHMLrz5N1w4ntn/
         PBCfM0mxlauRDjoc0Lu1nX98K2ZFIRsrkloCOAFzHMqUDExFO0I+D/fN2bZr5g03fuJ+
         CFpv2G4ltqPAVIvnAdTey5WkSJbSh5XztVit01tfIEJeJ0CIgmH2nGWbnYXqjmr6Kobj
         l/0LAIcrDvQ1Ajw/1W+ZFFP1a/fA0c00jfUD2gbW6vOefu23IztTJ6HDYA3hJXL9PDmi
         qGmw==
X-Forwarded-Encrypted: i=1; AL+hErHcWn30KVUSGdoEBSF++O0ZBX9gSeN/qpcr6vwWhDZmEdJ/I/kGVfDkDQf0CsY3LNPYXqQLzwAb6V8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xNINlONwZ29xzbGs9xIUOOulrz4hIbzhqiTomBZ+N82pH1JGw
	dVpUo0qPOTQt/vhnjgSAR3AseazT9WTVYOgOlo8b3/4kMIf/WKKotc5vETXG6ahEuGgVup8Xp4T
	ZyUfkQ024fXKlwZC2c0ed+7KwwWo8Si8=
X-Gm-Gg: AZFdTZe8v4M2rr3LVXc0TbsjPhdmfFDo73gHS5vY8vAgAQW14kZ3S33a68tAH04G3du
	cOoOHZpKeZLtGP3DRGstLSJZggUhzanR+fYVLoCZMkYqDZr8kgmSxV0EDKFPTPob+oP3zuSI/UM
	bIa/PeBoD7hP8b2IGg/qbzN+PWjIJ0SwpSlphKCgsSLQZCCiROIf5NVHpRSZy2uhbGHLEUqWy+/
	PQeMyMBL1nTYqS3asoj9mj4NmlzpMKYcudixUSfoQpq17T5FqTllt7rKEziLpX9Sw5IhPx3cLD3
	M+8SGY/or4OBPa71HtpHBw7zYvkSTvK5xTHCNMIXhgujwmsEEDvSKMqxtOavoy+WGNvhMOg6ps2
	UtzJtSUz+RhKWWcape7hpeKNaYNeevbghSFxj
X-Received: by 2002:a2e:a98b:0:b0:3ad:f236:a652 with SMTP id
 38308e7fff4ca-3ae7fa6ce1cmr44004651fa.25.1795573962416; Tue, 24 Nov 2026
 18:32:42 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
 <20261109155743.83740-3-muchamadcoirulanwar@gmail.com> <947615fd284c416891ac6de5d16cdd00ec5267ab.camel@posteo.de>
In-Reply-To: <947615fd284c416891ac6de5d16cdd00ec5267ab.camel@posteo.de>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 25 Nov 2026 09:32:30 +0700
X-Gm-Features: Aa3M54rr1ufHp2-DDunLUXvNfYN2DvOkdEG5zZTIMyDI3WVeYzjwx6EaEbPlUvU
Message-ID: <CAO26r3QL4R_h4DGWE9CpYE_=6PW5LXo_qy+xKgxZndSUcpbGwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 2/4] i2c: rust: implement SMBus access via IoBackend
To: Markus Probst <markus.probst@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Shuai Liu <847807867@qq.com>, linux-iio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Nov 2026 at 20:34, Markus Probst <markus.probst@posteo.de> wrote:
> Hi,
>
> please add me to CC.
>
> Could you make `I2cClient<device::Bound>` Sync in this patch?
>
> `I2cClient<device::Normal>` already implements Sync. Functions exposed
> only for `I2cClient<device::Bound>` should be thread safe.
>
> I will need this patch (including the change mentioned above) for a
> future driver.

Hi Markus,

I added `Sync` for `I2cClient<device::Bound>`.
Thanks for pointing this out. I'll Cc you on v8.

Thanks,
Coirul

> Thanks
> - Markus Probst
>
