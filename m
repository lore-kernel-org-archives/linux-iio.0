Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31A492502
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558155; cv=none; b=brMGZr9tB0axX52FL/suRUQLeIzduT7UdM931gRjiWQkf0lZ7jfY+6piEzdvkh7ofHrRibxCacpknL1zfNwaV/QHBABku7102iPhFACNmicOIEkgrZHjAiOuwPc4CmjEUcEBTTeIxJeQRdBEyTFhJ3TTIfbyG2xAUu3TRdRlyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558155; c=relaxed/simple;
	bh=mXYstQbPCoqDNWhpwz7NiKnDkvyfKfjGt+vFhq+wBaQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atYVYrT9aN9BfrKF9c6cedWnEz8BgxGUKopf6vn+/rjQRo28j4cn/Doap8z6xjp1oyFK9hDvtvWo3pF3iAvjxavADdxjBdcl8P1PXMuYdHfbLBIwx21zF2UxeHNdrgRkB9a2VoQvWPaguGjIrcHWQVtVlEBvod5gpP6G6LrFie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfqnEx7X; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfqnEx7X"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c4a93841so347536f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772558153; x=1773162953; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXYstQbPCoqDNWhpwz7NiKnDkvyfKfjGt+vFhq+wBaQ=;
        b=mfqnEx7XR7yDGan2EjsrccJ/Y7gpsuG2h9MMQXBSPiSsrTCsSiXPcsJg338UVd5Zmw
         pa5shOLbFd4ccdp6ScgNh57gJifBRkUPq+Yp6UQqxjMBIFRMGjN6b+amInQxETspMfj3
         uDWBeksyE9eTZ9ITiaW6+55+mKUwqIf4dY7mIJC6gDiq38sB+o9jb3EGoOv2CpNN+eJI
         y/baonLapFHgt0H9M0BpCwfy/OqEzPpOcHLTnAcZT1kS+Qc8hfQLcz0PP8H/UZVYZPZZ
         GOvdU0eyC32TEngBRoWAS6fKZM439k7vGqXf+gXa+88+xF97tIuyU7Ypj80EUPF1TnhR
         lf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772558153; x=1773162953;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXYstQbPCoqDNWhpwz7NiKnDkvyfKfjGt+vFhq+wBaQ=;
        b=R2dNqHtPc/7n/OLuLzo+4m6kPqr643k/u1/Itb3Kl9VKxVsJVKpdEQBb4Fr7JPZlZu
         4pzKjJ6XqTR1STIydtuWcsn3ggQgjU4KCPXStDsuAtzEJcvjT5CYgIwFHx7Za/VDKo75
         LLIIambyeO8/gJnute0t7HHZyLFFiLscRFGvRL6vAYmUV3wTrVzRoZVah8QToWG1EFV5
         MXrI9P3ENLr6CPvslzvTzQbylDmEvYn8C1uwxB5T7c5HLZxiR6ng5JzIrE4CsSGqG1ym
         mPDbFjEuGqpn5gDUKvZcVMqzhJzMMd/M+FTRKqmS+c7MgjJJpsXgSGNuH9TanYSD4IvT
         dB+g==
X-Forwarded-Encrypted: i=1; AJvYcCWrr9Orub3betGzrBdiMz7EM6/n2EHDfCq2HN5cveVe+XUfDid7SVRYqvfkP1kJnS9Jo3VC0hDoVC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YychW3K6PnAg+RMgnexzlQ4rPCc5FHKfjJfC2005K+Ij9YEFZv6
	6SUZoqSaD7frbyM8c1nz5eb38C/fr9Z8TQNHYw8fHLldJtu+UZyACbCL
X-Gm-Gg: ATEYQzzCLHvBVG+3PL9b2nApZ5DgL5uOpJz/BDwI2f114stuA3yTMyLNX2nxpLzl9IV
	po4tnIF+nPTDDxr7HS7hUXmHn7sAkqRvsxeenzc44uw4SwtX3nk6cWAbeqNvfTaRaImajbmqsz7
	rOBV3svIxuu+Y/D/OFtlQEZ23vfAXndjfnSHhebfVpFU0tYmzyFDJ7UlL1nXEX1F/YQ3VTQZg6h
	3XaOeoOx7tsev+IAg1k2J0Mn96K3abkjcXfOATGeYzVQNiftk2JBol2atS1ZSBdzAKnzGNoPy1n
	P+TKGMzT7RDDnMdnepxAZfZLtp9dWagZhbbo92vcosEAoKvCDrU4MMOpvG1vV2yuumFkKPsHET2
	Ujt1/woOBnqi5MT7mwVt3SNXEJtXf0fpaw+k59oJ2Vi3goMHoHeDzgUEUKQaUT/1pqA3EaKZvit
	gv8fuCrKWVunFHEdhRAiD84Nn/PxB+bBs=
X-Received: by 2002:a05:600c:1c15:b0:483:6d4e:9811 with SMTP id 5b1f17b1804b1-483c9c0b6ddmr328267815e9.31.1772558152274;
        Tue, 03 Mar 2026 09:15:52 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b130abfasm20520790f8f.34.2026.03.03.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:15:51 -0800 (PST)
Message-ID: <59c3c6324ca971dc081624e0c31131b9e7dc9c63.camel@gmail.com>
Subject: Re: [PATCH RFC 6/8] iio: frequency: ad9910: add RAM mode support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>, Rodrigo Alencar via B4 Relay
	 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen	 <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel	 <p.zabel@pengutronix.de>
Date: Tue, 03 Mar 2026 17:16:35 +0000
In-Reply-To: <4rzqg6gax4r3symyoimekikz7p4pfwjzhfamjudk64f32675oj@nlrz53u56p55>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	 <20260220-ad9910-iio-driver-v1-6-3b264aa48a10@analog.com>
	 <20260301133153.7f2f8501@jic23-huawei>
	 <4rzqg6gax4r3symyoimekikz7p4pfwjzhfamjudk64f32675oj@nlrz53u56p55>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 15:32 +0000, Rodrigo Alencar wrote:
> On 26/03/01 01:31PM, Jonathan Cameron wrote:
> > On Fri, 20 Feb 2026 16:46:10 +0000
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel=
.org> wrote:
> >=20
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > Add RAM channel with support for profile-based control. This includes=
:
> > > - RAM data loading via binary sysfs attribute (ram_data);
> >=20
> > I'm not sure that's a long term viable path.=C2=A0 We either need
> > to figure out how to do it as firmware file load, or via an output buff=
er.
>=20
> Could you develop on this? it is not viable because iio would drop that
> support? using sysfs_create_bin_file() directly would be better?
>=20
> > Firmware load would probably be too static and I'm not sure quite
> > how we map these to IIO output buffers.
>=20
> will investigate this buffer route. At this point, we can have multiple
> buffers, right? I have the DMA engine buffer working with the parallel po=
rt.
>=20
> ...=20

In theory yes but we do have some issues with the implementation. I have so=
me
fixes but for code that, unfortunately, cannot land upstream anytime soon a=
nd with
no users, these fixes can be an hard sell. So if we go the multi buffer sup=
port it
could be a great opportunity for these.

That said, the fixes are only meaningful if we do need to restrict channels=
 to a specific
buffer. Not sure if that will be the case here.

- Nuno S=C3=A1
