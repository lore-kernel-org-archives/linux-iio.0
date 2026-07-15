Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75432F8E84
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123931; cv=none; b=K9Rp3dC44QMRQBZOxECZKO2tXGPT/nz4sO9USfAB5x2r3ft2HPLdiqvYVmqarH725pU81gKm//vAf1PgIq+fcgYJg9tO+J7INysar/Loe2KfGWGO1YSA3a26EhQKGyaB+V25UsQHwVlwF3I80x7yUuCuD/sqamwdEiL9QoO5ffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123931; c=relaxed/simple;
	bh=lQHqeGCwF74T84TftX7GCSfuMO+83Vv2WQ/yAHb41qg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5O0jdu/sfLfFr5PoaZJbYAjXV9o/ghMwDnpgP7bsPcdADSyrg0WqkAfwOZhy0Zrmfz8cRvsWIynheIIJbtKofGKZjHHkcKB8q6MKgSDEyL4Hel5T/yRBOlaNwOJAAtYnP0kJ7ZMh7HAmkqP3KvacWJ3DTgKagBmZuQjkeJ5VXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYo9+TSG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYo9+TSG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so16744625e9.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784123928; x=1784728728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vktCBlgvyKkIFm950l6EwI7HLRpSzcsJ6rxKehyjGvg=;
        b=kYo9+TSG1YyLN2IDkVZdNEAmKHgu0d0UUiz/k1ucdwWMV1nrFlnOzjjjMBQ2EhYReF
         hk/00bDrnXBtf3NWtpVofTbFd5DGDeZXVLvRhE0J8aMzQbABNwdW2jThGufpq1PNUTkd
         m+8SRyuBBjqaJk87343kp5J/sdCtKQjl6N6MBnROWCDWfcIVMRS+i53xl9FU6HTtuFHa
         LkURKfeBpzHu6LL4pA953iB9/jMOoS0w8q9FnuHhzy08D8xb7fr5nVTZkk39AEHrimJq
         COK4+pwhF/Z2LRsI44cG8O5WMpcEUp8rvREqfk46pHYe3/3jg+/LLk+4g6YU4MeTcBgX
         Du0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784123928; x=1784728728;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vktCBlgvyKkIFm950l6EwI7HLRpSzcsJ6rxKehyjGvg=;
        b=EGu+rQYLYqZf0i2a6etRyLsYBgdSIHVXXvliiuf3ihr8cMiNbm9Vt7kQxmMqjHbS2Q
         /1u3IZSGfSW+RGshl1wHcD4T+eBKaZOXjZKySFrwefcbMa4z2Oiod3onh79bMion1HU9
         HWvJynbl0n1QM3Sezxa7vYJJj+DjrWO6rA34eYXtXH8UiIYEMxhg7N6fL+XzMHtigdCK
         A2eQSC5d5/dalZlTpmn/DwyKNYDsb2gClMw0Vb7GmsEjOHCwBsaPeKBLSB1GqHdt+Hwh
         Qld5AR8EJU9B9TlCut4scrL/cgpPYyx1vqeZkpb07OktM+w+y8JuhC+Nu/kP9rBFyF9S
         Jp0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqKmThsZf4Nog6kmSlFUxcyBo9dUEmEDh4blSZW5T1dBr5QArLT5w10Y3DjupOAg7+74Nj3MRqmzlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNu2uKvNGYMPGzwurhZi7vxMBebuUt7J3qAUtKXj9zPn78RDvO
	ERIrzAi5MDx7FCKsRzcW5n7p3GMBbxIN7P+osxvDC3ZFT5sSvE5+GdCDnGRnE5E4
X-Gm-Gg: AfdE7cl5jLaWl8TFVgM9sspenjLlILfJ23Sef7kAQKrEl8hNeMX7VYXYzUpOc9vqT7F
	ZSZA9kYOH9gIpRNxYS/W15sVO2tiMIj2GV45+MXaZmIovxyl4MZSCzjJln3DV8opZwFksD7HMBW
	BFugMa56F/hVSWvZuC8oE43VWbIvk3nGnYwd497/1pN2XoijI7KrwzBitkBaFd18oLXkhHbISmO
	Uh/Rl2bl8YynWJuY2BR4KihQ0fmXRILXiStPVfNZqqp9nSGNkQ5upVubjhQpj49EQiJR8Mr9FEE
	xJ3QNBMf2Sc6tflbSKrR3PK9UBZr7pPMR4sikKSqDoIWnK2x0Z3Y9slinIGy3a1lfPlTzhyuGTl
	JdKClWoDbB6Ul1LYoSdZs5+vrvJscOwAuInIoHGHBGG+mon7PPSBbeaM4YvVjZLyYagV220tSDX
	gKWfnkL7tGVoFGbxNCcbGBwzVabLBUR4y7a7WmCqErMRzQOUvvkCLVMcbh6VdvXrSgdpLNSdVtf
	imcugHLKI5JzDsCQQKbLPkBW/COinX8rbZ48bWl2JJ5KLOxvJChufRDnLXB9PHB2fw8m0YC9n0Z
	teeIiJ88KYVX3F+Vf7uZtJsvnZJq4f88UI+nUsG3KP556zYXAPeF1ix7UYi+febSIEqQrueO/+B
	qsLOLcjyU5wbJFcuJwL0clEk=
X-Received: by 2002:a05:600c:e557:20b0:493:f822:ac5e with SMTP id 5b1f17b1804b1-493f8818052mr137138925e9.23.1784123927767;
        Wed, 15 Jul 2026 06:58:47 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm45735865e9.9.2026.07.15.06.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:58:47 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:58:45 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Nikita Travkin" <nikita@trvn.ru>, "Maslov Dmitry"
 <maslovdmitry@seeed.cc>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: light: ltr501: Add ltr329 driver support
Message-ID: <20260715155845.00003526@gmail.com>
In-Reply-To: <878q7cmk63.fsf@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-3-d18af55edab5@geanix.com>
	<tsVvSFcobT5NwJPHCbN4M8cwEznnquSJ6o4W-MpVcf7z5q_RwC6XI-NNBTwrQnEBed-Stn56TW1e4iSdtzN54Q==@protonmail.internalid>
	<20260715145324.000005c6@gmail.com>
	<878q7cmk63.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 15:55:48 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Joshua Crofts" <joshua.crofts1@gmail.com> writes:
> > Just a small nit, even though the list isn't exactly ordered, please
> > try to add the new include approximately where it would be if ordered,
> > i.e. array_size.h goes to the top. Additionally, you don't need to add
> > a comment.  
> 
> So alphabetically sorted? And even before linux/module.h?

Yes, includes should be sorted alphabetically (or at least as much
as possible), not randomly or by importance.

-- 
Kind regards

CJD
