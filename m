Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E53587D5
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028099; cv=none; b=M6w1Z8b0PUtoi6f+VOh91cJL5er8kw+BY5UcgsqXfCudCPoe5dyw70uMZ3hUpO+o01BphrazxiSAGeeEGllsmZSjIDrVGjh1aITHV8uyeRbeuhiYhWPZ/Mh6/q6nVKnhfshNa97TNd45cMMiLi2WB5/27q+GsZjvzjzb7vpQ4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028099; c=relaxed/simple;
	bh=rvNHL0ubLKI3zwcs+VS8kKlMu8XCU3hV0f73ltP7w04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwLAstasSASBkZazEwX8VtToRa1b7ubWQVNTO6qRlURWQlZWeD5F5x0tK1ZgkK9o0cL3lW0F7xx+C+Y6+HhyITMlT8+E8od5wpcUQZ+CWO+L8L7XDtPLFYfHr4mNA/Rjwn5wJblp5yy6rYr4qefiWcGN6JvmQzRKc4gMIY1nQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMKxaRTu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMKxaRTu"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-435f177a8f7so3191239f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770028095; x=1770632895; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SpynF7IJVQf6tAq+x4y7ONqAJ6iCab/3R//bsH8hURg=;
        b=QMKxaRTuOlmVFBxOEUdaxPkYgctAz0x1yP/Ui+KRUA10BFFBYhQHdhj6F3iczXoY6S
         ObmZAqvrQzWtvcfEDDvdNTyz/8O+LOfFpONEOiCOs/f+Vc3XQ5v+73ngAK/UeOx19aJm
         W/X9sJ9skMH/do0NmBN7eny6JChUCKbt8kWJjKoICVa+x1iXDbHIJS2TzMD96zLUGIVA
         2U5NV5ZJ8RLCypmqwTbXxbKi+phMthagbpgIFlSxRVfjsJcyNIjE9hZ35PaNMg2h5Fz1
         QOq7h6epARUNM+I3tjvDPtDeWWjWyMSlyl6sUffUrZ3D3hEPEjqOC2BWtG2cFRzCxnX3
         MM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028095; x=1770632895;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpynF7IJVQf6tAq+x4y7ONqAJ6iCab/3R//bsH8hURg=;
        b=q5wMbPB5QFRu3yEOPllQST1KxzLRL7UZeDnQ70v6N4o7PX+5qhic3Jx4WYGFLIEYF6
         q6ulOD0w8LRkfM8UeYnB3S7qrZPRBRFWEKG+WlvXDhdGxEIN1xkMlvwDP9fYWSzZyQqJ
         rrmGtktSVCY8uERVGWpJhhCEXPNyslOpYae7wJyyUi5VKMPpacza+giiHIr4kfQWsqI2
         c2gcfChiHxL2WQX9wbV0bluaFGI5LJWiGI0Dmm8iiDGcmgMU4hCokZ10ysPCOn5K+b8a
         ZL3v3sertu3K7ihw8xII1P1UlRmTCk5DeZMCEVNu+TkXxmL3ka/o4G7x3srx4nfPuhj/
         YYwQ==
X-Gm-Message-State: AOJu0YwLxRLamfD1mT5dbXbkNYWY39OA25fspWRLjHyVVXRVXEue5O6R
	GJzSXWd+YG2OHskP3e4ZvTN1wjr6xuwd27TAJRxdHrx7EzpeYyIVKH0MyFTexRsz
X-Gm-Gg: AZuq6aL9okVZvPgjyFPXLwCbVqeWgZe6vkSmvCYPppvofivPaFOrC4x1VaZrbVngiMs
	OAxzbqwayqkuiLPVyiZoddvRKSaXWFFOyd8FllOhvMCC1vcbhCzcO6LPVRO/yplM0ZXAu8Jdoo/
	YyM5f06tbquglJ52cp+/Jd60eK8nlJlVNAvM4zpFHdhJXn6lG8iyPhHJ539VFKlfGIdZaxFVMjm
	sF5qBBg+M6H4tbrq+Sb+nu8m92K1AdDhnBhhrFQtt7B9we0JWi1cwRj3unsuXiX4F7A0cAGTfI8
	7rKl1soYGFLp0jXVh336SSyqr4uk79ur8M59W1oB2OkjgJIopb2JQLZEv7zH5rdYoeMDYiMbo30
	6BY27ipvkoLhvUa1F868LRW7pqFv5Pie7fEYF1OeP8WxNgC3mohw6Sy+q22DTtNxGpIuBomHn4Q
	fmdgbnswuj6rUdK0lhxP4=
X-Received: by 2002:a05:6000:2689:b0:435:930a:658e with SMTP id ffacd0b85a97d-435f3ab06f2mr16177653f8f.53.1770028095214;
        Mon, 02 Feb 2026 02:28:15 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cefdsm43860452f8f.23.2026.02.02.02.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:28:14 -0800 (PST)
Message-ID: <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Tomas Melin
 <tomas.melin@vaisala.com>,  Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>,  Jonathan Cameron	 <jic23@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 10:28:57 +0000
In-Reply-To: <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
References: 
	<20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
	 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
	 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:
> On 1/30/26 3:16 AM, Tomas Melin wrote:
> > Not all backends support the full set of capabilities provided by the
> > industrialio-backend framework. Capability bits can be used in frontend=
s
> > and backends for checking for a certain feature set, or if using
> > related functions can be expected to fail.
> >=20
> > Capability bits should be set by a compatible backend and provided when
> > registering the backend.
> >=20
>=20
> ...
>=20
> > +/**
> > + * enum iio_backend_capabilities - Backend capabilities
> > + * Backend capabilities can be used by frontends to check if a given
> > + * functionality is supported by the backend. This is useful for front=
end
> > + * devices which are expected to work with alternative backend
> > + * implementations. Capabilities are loosely coupled with operations,
> > + * meaning that a capability requires certain operations to be impleme=
nted
> > + * by the backend. A capability might be mapped to a single operation =
or
> > + * multiple operations.
>=20
> It would be helpful to list these operations explicitly for each
> enum member.
>=20
> > + *
> > + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports digital interface
> > + * calibration. Calibration procedure is device specific.
> > + * @IIO_BACKEND_CAP_BUFFERING: Backend supports buffering.
>=20
> I assume this means it supports devm_iio_backend_request_buffer()?
>=20
> In IIO, we usually say "buffer" and rarely "buffering" so this name and
> description is a bit confusing to me.
>=20
> > + * @IIO_BACKEND_CAP_ALWAYS_ON: Backend does not need to be explicitly
> > + * enabled/disabled. It is always on.
>=20
> Do we actually need this one? Alternative could be, for example:
>=20
> int iio_backend_enable(struct iio_backend *back)
> {
> 	int ret;
>=20
> 	ret =3D iio_backend_op_call(back, enable);
> =09
> 	return ret =3D=3D -EOPNOTSUPP ? 0 : ret;
> }

I would prefer not to assume we can ignore the backend not supporting
the call. It opens up the question for other operations.

My preferred way for this kind of fundamental operation (enabling/disabling=
)
would be to check with DT maintainers if we could have some kind of fixed-b=
ackend
(fixed in the sense the HW is present but not controlled by Linux) dummy de=
vice that
with implement a no-OP enable/disable().

- Nuno S=C3=A1
