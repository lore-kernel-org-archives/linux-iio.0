Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F736F439
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839835; cv=none; b=IOT0lyZ2aH9dBli8fqjCl7jbdZ4b4XXj/HEn2u8pADTI8JtnSIjiNl2N+VhsqYup4yGXgHtQtcDsnOwW0Sfqxl/fkdrklwDy3d+bAelE9Rgl3wk/o7pn0DJ03bX9UdOIPCuOAIiXXuZQ/81MWGHCjFm5U7iGyv2c5o+1mMOjwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839835; c=relaxed/simple;
	bh=kcKTxLx8cg84Be3WriXq6zjc1QipNRUBwqHADcvNn3Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GcHmJLBJMpO3q0y+MKAeONuahaCHeH/JE8Z8GlPGiEbfNPVUwj9kqNO4XxxkmR3sf1IKE+ULBEw/55FaudM8k2AD8CuPJxEEptQMt9vEjmB54oYCGT577+XNrZQ3H8c5slxgl2/TEuAgh7IyNGbARDtduUOkLX84doh/pZctPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb0avsC8; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb0avsC8"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso1807479e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782839833; x=1783444633; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNos9pi0N+a/DhRm0VZ1MwDPwAUJhbz6pqtZ1iuOWS8=;
        b=Xb0avsC8+S4iv1mX1MNGC/56V3oapiakGKKA9lLIlRBpw8nBF7Dr+a4t7mIPe9s6BY
         nYTIrehhEaJxxsS3j5f8MTU7ZsaiZMEaDJVexnnwSJ2KGEhSd9InN4IKpIa8pqALeJF+
         WnsUGDct4s11XxsQPoqwARP5ziweJtWnEPQx2z0/F9tT6bCPcNoLY/1wWaH952O549F0
         X+BhFItaHo1ENuOZzb6XjCw4HozzwJLzAG7TZipd7TBFzpjF4yqGIttWzxBm+VINT+SL
         OZJp+hXxXgqJUTZapSyeynRjHR3ZIiZDf49KzMYLzMPjkiJ5BvP/NMMcncgYLTzxU4hi
         z7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782839833; x=1783444633;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNos9pi0N+a/DhRm0VZ1MwDPwAUJhbz6pqtZ1iuOWS8=;
        b=SAABZaNq622Dh+S3y9iV0XFr5E40rEZPipm8+4Q/74/1VvFfAratzSG8pmIRSwBQSD
         VvBSKo1Zt5UteV0N/mr9VZMTXDoqTbEjrowPDeyC08Iwcop32IiFw3eivyX9ewrs0mmW
         9aB4Y5S5bvVIxk+ie28VDJ2YW0lvPuD8zWQ+eRU7dnCQ2tLwkn+j3y3YIiE9nyWB67O1
         bEp/JtnxVVexdMmqD6fsDesjWtZ07k/Hv+UMRJkUxMyiU5Qd/6aYQuTRMgwDc8oG5FwZ
         SnrzXDuB52i4VM7DiPltO4SIqrRc5O8zhuJLYxq+IZKSkBleLGdi7B91JE5HEHBJjXyD
         uXFA==
X-Forwarded-Encrypted: i=1; AHgh+RrOiaLOfB2937KK7tYq01B7n2gM+9BPsM5kO0s5XqcY2GZNac7tHm+6RyliTs6M0u7QJLK7CrD12gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfoTUvQarlROKhaD6hHhrbZjnqRkE9RU8KmyUQNL7cxXiZLGg
	Q7CvQfHWJdGgQeWxiGhOKUffv6WZFEPb7z3Ke2dn7CT+B0yR8s1pyXCp
X-Gm-Gg: AfdE7clH1arrlxZkbjqQXAV9h2Sn/pFv0jQDRxGUfALEtcYn+y3c+e79R60hgVqrVUI
	wi9rs6J5BW01vhwnBC66MghCXNQifIDDYIjR3xFyBedTtdmJDD7w+a5icLbROUAjeMgWqsq1GZ+
	REefe+KNyQUsY3jJRB+yWcEaHVEshh9cDNTlCnxsrH4zcOx56ilbpmU9I4EyUiTtxJRwPAbjIZ+
	mj1McJBPkOyOO2dzia1jOfTg/NUw2D9XYlQE7STJxHAa3SR8sHkAHMWMcGuD1koTC1T6Chrzh5y
	IFm/DnGGj1DzhUIOeJJkYjsJoFMFqAA5IQo01njvZxmOg3GLTJS8WG6oyqa8/CxTv259iH8uqjB
	SEP6sBF0lIlQKr3jFZMMejs3zBsa85UO3OarnPwW6PvoYU+9mHA2urlhcCpcGE+1L3VMt71djoz
	vc++s=
X-Received: by 2002:a05:6122:8016:b0:5bd:c441:a823 with SMTP id 71dfb90a1353d-5bdc441b11amr988081e0c.6.1782839833216;
        Tue, 30 Jun 2026 10:17:13 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bdc1846eb0sm1760954e0c.4.2026.06.30.10.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 10:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 12:17:05 -0500
Message-Id: <DJMJZ199MYOB.1T11CAYXWSEQG@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] iio: adc: Add ti-ads1262 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-2-4b1b231325ba@gmail.com>
 <0d7a5a3b-dc11-472f-a09a-44df887d5147@baylibre.com>
 <DJKY6WN6KS2R.2ZF2TTJU7LBE3@gmail.com>
 <dba5ef4d-57e3-4016-842c-dad6990d7207@baylibre.com>
 <20260630013255.3ed41e28@jic23-huawei>
In-Reply-To: <20260630013255.3ed41e28@jic23-huawei>

On Mon Jun 29, 2026 at 7:32 PM -05, Jonathan Cameron wrote:
> On Mon, 29 Jun 2026 09:38:13 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 6/28/26 3:00 PM, Kurt Borja wrote:
>> > On Sun Jun 28, 2026 at 12:15 PM -05, David Lechner wrote: =20
>> >> On 6/28/26 12:36 AM, Kurt Borja wrote: =20
>> >>> Add the ti-ads1262 driver with initial support for the primary ADC
>> >>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate dr=
iver
>> >>> and interoperability considerations were taken into account.
>> >>> =20
>>=20
>> ...
>>=20
>> >>> +static int ads1262_read_raw(struct iio_dev *indio_dev,
>> >>> +			    struct iio_chan_spec const *chan, int *val,
>> >>> +			    int *val2, long mask)
>> >>> +{
>> >>> +	struct ads1262 *st =3D iio_priv(indio_dev);
>> >>> +	struct ads1262_channel *chan_data =3D &st->channels[chan->scan_ind=
ex];
>> >>> +	u8 realbits =3D chan->scan_type.realbits;
>> >>> +	__be32 raw;
>> >>> +	int ret;
>> >>> +
>> >>> +	switch (mask) {
>> >>> +	case IIO_CHAN_INFO_RAW:
>> >>> +		ret =3D ads1262_channel_read(st, chan_data, &raw);
>> >>> +		if (ret)
>> >>> +			return ret;
>> >>> +		*val =3D sign_extend32(be32_to_cpu(raw), realbits - 1);
>> >>> +
>> >>> +		return IIO_VAL_INT;
>> >>> +
>> >>> +	case IIO_CHAN_INFO_SCALE: {
>> >>> +		guard(mutex)(&st->chan_lock);
>> >>> +
>> >>> +		ret =3D ads1262_channel_get_scale(st, chan, val, val2);
>> >>> +		if (ret)
>> >>> +			return ret;
>> >>> +
>> >>> +		return IIO_VAL_INT_PLUS_NANO;
>> >>> +	}
>> >>> +
>> >>> +	case IIO_CHAN_INFO_HARDWAREGAIN: { =20
>> >>
>> >> There is only one other ADC that uses "hardwaregain". Usually, we jus=
t make
>> >> scale writeable to control the gain. I don't remember what the rules =
for
>> >> that attribute are. Using it for in_voltage is not documented in the =
ABI. =20
>> >=20
>> > I went with hardwaregain because the scale loses too many significant
>> > digits at high gain. With the internal reference and gain =3D 1, the s=
cale
>> > is at 0.000001164; then at gain =3D 32, the scale is at 0.000000036.
>> >=20
>> > In this case I expect users to just calculate the scale themselves bas=
ed
>> > on the hardwaregain. Is this acceptable? If not I'll go with
>> > scale_available. =20
>>=20
>> I'm pretty sure there is a series floating around that has proposed
>> adding new fixed-point IIO_VAL_* types that could be another solution.
>> We'll see what Jonathan says about this too.
>
> Yup. That series should allow for easy representation of very small value=
s.
>
> It's in my testing branch already (see iio.git on kernel.org)
> and IIO_VAL_DECIMAL64_PICO for most extreme case.
>
> HARDWAREGAIN doesn't seem appropriate here, so please do the really
> small scales instead.

IIO_VAL_DECIMAL64_PICO is just what I needed. I'll go for that, thanks!

>
> Thanks,
>
> Jonathan

--=20
Thanks,
 ~ Kurt
