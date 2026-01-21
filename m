Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658A288510
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987957; cv=none; b=n6e14oq72Gv+hSh5rkFXYyTaZpGxB0XpagQeVNfidKqUMNuBYOyepY6Hj9+u6fh98z0azjUy3S1PL9bh7LyP++yZ8xVBhgdb8BS4pMg1wPwqQuBNujm67PuXMfq4Fw8eG90vdQ+eowfHuAAfIL3JESx83WiaLZkKLgpqZR1ZGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987957; c=relaxed/simple;
	bh=9Z3GJR+oR4iElQBYLEJPW3P34rRlaSYDMSuwJ/wBKr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rl4okw/JqsXs9yIyqgbgxnmF4r9Q0gvwnCZ3Jsy4nIb6DhEDwnfl6DknLdW6ltGYT7JD8ot7yqlvyJtEN+0c+Wao4R3SkLjNxmC3OaxK10xRpN5vL+87tlcThULdyiNyyZufdVCzyuZjvjZEZOmJpcKvGC/7cLa6JbWeCY6RROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQYH/STp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQYH/STp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so41838225e9.2
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 01:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768987953; x=1769592753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6R7V3ZWTA9/RaVBxdw376Kf2ZDaVjKcJaNX1RQPxK4=;
        b=mQYH/STpTLYYTga+Vrlcwb5CSScvlmZutNonEZCUhpFwDYcpwt+9AFHzGcdKzSh02W
         QtqSP4M2cRRJ57NRA/rmcnBVj0exQTqR7iVwcuU0RoNAluC3r3Hy2HUKRGVSCV+nQ7Ku
         xQJ/IbyemhI3KcHVHWj+M9ONv3KXcsB+cc1JQc1hSjh2SflALszZ8ZjetuKX+8TLmrrB
         BB1+01s8EE28BvhgyZ7RhpiT4NfMk6XpX1dJCwspNPmrMlVWl01VMY4O4aKRP6TcvSW+
         13qanAjKsI9P5NwIz9yG+ZAwMUg978s0uejnNKb2fA/Vt9vm2wB7iQcUDv5bJ1auSexl
         Pxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987953; x=1769592753;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6R7V3ZWTA9/RaVBxdw376Kf2ZDaVjKcJaNX1RQPxK4=;
        b=VFRBtTGZUu1S+LcU41v8Xqwag2V0e+IAak/fySmMJJg51h2TiFEnNvRFZ9fklrQDZq
         Hi3+fJbMtRW+GnWKZS/+02xbCN7P8iopcbcBWygZefM8ndAcPzz5d3NGd+2B1YXhR7y0
         0519G2i1Kt5zFMQxEO/bs9ZpfWrKfFDUX+2riew6iP9ggvD36XqhuHPowyMRvNM2QPXF
         aj0YLP19kY6zKkS2BjLqSLWYbiTu+nH9m/KxA0ma0lDBzIH3liMtWCFFX0LHeV64YKvr
         PsAhT71CLjPH9H0KGc/w9WjGeORYWoHU/+IV64h2vd+v6jjC3pP2NK9nm7+nE4+Fn5h9
         1lDA==
X-Forwarded-Encrypted: i=1; AJvYcCVPahmqtFNbkjorfltjHvg9ARSVFr+VSf6UAIlKM2FOrAilkinvwGOZ8x1s6D7zdkJExSMogMQQvVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXmylig1dkdZY0TlhbguC7IayU8UIpkQasLK3+B9jYyNZfYnA
	BukHkmMoJKSUVMSTuIx0lXwiDe77ubKnlPopGK8pZVqUax2CLBaZ8jDW
X-Gm-Gg: AZuq6aI56RZ3xwfry+wS097z8+b68V2y051xgdCRe7yMufW9Xm7xdPpzcrYXMlp2Tfh
	RIrhfZd8oMG1UGZYfalWAZae2GAXPGCiZkX2DKvfZvi4NhUmRszoghfy3yhl3q+llUyY8CIv+3G
	HJvjj14mN8Pir07AeZtFEiK7O7h62TTZKjLZStRgEws7KqNrqEh5VXTrTxpVd6ukBpom2sn3VgK
	z4gUiFUJ4K8rtJAMAmKu+EypHvl1I4M4wS/NekZxnwcHdHamwSrer0jDGrlAdOW3Dlx4kq/qgR1
	MQn07RewxrUs1/hg4GmB8Tm2N1iipqzpDHvS0gOliOhyELmwpZHDeR8ELhSl6ggJyaf8yiEIlB+
	ItgncUegQK3W8XwjmfhU619L5W/Qk3uqrp48vXhr9yk6hkJ644k5YLs6yWPrxzuRrMhsiAquFPh
	AjySNgO6P4h23N4p66mI8=
X-Received: by 2002:a05:600c:35c2:b0:480:3b26:82cc with SMTP id 5b1f17b1804b1-4803b2683c0mr108208865e9.18.1768987953048;
        Wed, 21 Jan 2026 01:32:33 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8d90b3sm304721065e9.15.2026.01.21.01.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:32:32 -0800 (PST)
Message-ID: <2f9e7172885c5dd20be198f013283c6ec0513ef1.camel@gmail.com>
Subject: Re: [RFC PATCH v1 0/9] iio: Expand IIO event interface for
 real-world unit handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
	 <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com, 
	andy@kernel.org
Date: Wed, 21 Jan 2026 09:33:16 +0000
In-Reply-To: <4a04fa3f-c056-4443-a55a-e8622feb1c2a@baylibre.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
	 <4a04fa3f-c056-4443-a55a-e8622feb1c2a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-18 at 14:33 -0600, David Lechner wrote:
> On 1/18/26 12:18 PM, Marcelo Schmitt wrote:
> > This patch set adjusts and complements the IIO event ABI docs making th=
em
> > coherent with the fact that not all threshold value attributes had a _r=
aw/_input
> > indicator set in their names. In addition that, the latter patches on t=
his
> > series update the IIO event infrastructure to actually enable drivers t=
o provide
> > _input threshold value attributes.
>=20

...=20

>=20
> Just throwing out an idea here without thinking about it too much...
>=20
> Instead of adding a new field/parameter for units, could we extend
> enum iio_event_info to add IIO_EV_INFO_VALUE_RAW and IIO_EV_INFO_VALUE_IN=
PUT
> (and same for HYSTERESIS). Really, the units only make sense for these
> two info types anyway.
>=20

Makes sense to me.  Or we can just document that the old value is _INPUT? O=
r just make
it the same value in the enum.

- Nuno S=C3=A1
