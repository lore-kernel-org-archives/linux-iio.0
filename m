Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C930D41F
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296349; cv=none; b=jIJSXFx03KaCa2erLsCE2QrFE0DJXadPAU+ZmQHqv1ef1OEman3hSdHDOVvjbQxm8sr9WLOuUw58D9wIQqZwqsUpId/mwfdVh5n4foiMzbcoZC7z0BWR1oU7lj762uJWVDwf1oudQ2f3tmUmSTq/5d3dRTb1y5xl/J3Snv4clAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296349; c=relaxed/simple;
	bh=YNdudccxgF0GNeZMVRI+WGS9EJ7qAu7VHHOEJlJmZlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fubN2lzvxlEBYjFTmoIvbWmx005TI3flnQwdtkjgoz21HVd6S3C23ZPOe5zb9NRXSUY57AsQ/ZVVc1T3PUvkk1JdIn3/jtRTnIv+hvJGnVd8LgQ/gfQnZysrYm/3k/98nOxc+AzQn1LbJDY5mMp8flMvxYwANMGdVoIHXTn6j24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHCTH/ci; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHCTH/ci"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso46087685e9.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296346; x=1784901146; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aL2gd+WxGuY6Bl16wWSEIS9/aMLXAhdRbeLUUN3ab9g=;
        b=UHCTH/cicWaaigvH5YGRT1CK7H/et6c/VQGalUXh9iJVTrNl+t8YMOcDpkaLy9RhjH
         G94yF2PHO1ZTDEzqTD//sXtQglgiWGCN3/yBClXm/gDBCVhOoS+agY4dnfGvyLZKz/YJ
         JYdDzJ9HIJDjAgWykhIfqbbt5FR6/WbapDO/tGmf66U68VNdC8Xnw9PFac69yg++gXOy
         +P57ytzFhNE/YP9jP21a4R0q5M731q2eublSMJa52qIYT1zc85+WR959IGHGiVmK7WP4
         7KKrDmUWVkZ5wRgm6yLyvlES0deodwpjayUVNqqaXS10VM1i845RBJDwAN2o7iNpkte8
         tgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296346; x=1784901146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aL2gd+WxGuY6Bl16wWSEIS9/aMLXAhdRbeLUUN3ab9g=;
        b=qSI1J68OdtgA2pMpXnRyzvCtXXPAD4kWUCVWvutTmlchZ1SZHKNthth65DFPI282tJ
         Mk7LECQbbIhi1ki6mNhsM9S3f14jT3r2ELgKfNbbzqgMJ6viUheXuNik/YB1823QGSLU
         P3iA8OpXxx2b1BcT4y9Q07kY8RKFIF8bvYFG9V8C6C++7m7fPFZZUGUfqr/dfJne+RO3
         9ZaTrjxsCrSnEev/FbnM4EfvqOZswPZ/1647nxQCzgbwFhvJUhymZzH//3hliTX22yW4
         NS3kfoA12y2sU24mnQPKreeJxsH2+iu/mmsauqJQ457BS4UIYLZodzQD2MS7jFO5gxiI
         RB7g==
X-Forwarded-Encrypted: i=1; AHgh+RokVFSt/Yx0ZctdYSwhnQYpUuZufoDt8+AbvBOohrN+L99SaPy7a6cICgBlUDfkm2PWVrwvjSf0k8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyanUzHPleTxjTsbgvpCIIyLBGxhTzLKVPlXvg6VHZSFhaU5bJ3
	TeWcrs1poD0S5++lQ2zyaOM1li9MNTGUc66WBPpe1lvuylmeuRoZfSwVfX8Hy2KwfXU=
X-Gm-Gg: AfdE7cmpVDYf2gSAA5I5xRWaJ7wjXw3GA4NzyFB+dDNbVyklN8h5NLkS3IrlYERrynN
	yALrBU9XQwCEIv57HNLXpI/wKiY0eWVSOGXU/+xlgupWY9RJuGQbSW4uJCdsiQk7oA6Hfz5B3nq
	IgC2iHfJPR0UknN/WY3wnSixR/1Q1K988/cI99oHbZp7tetSbCIs8rRjyTdduq20ousgwKQQ6uX
	Ul0F27UmxsCHJOh1PObkryuNGvJ9DOgkC8V7mR43nR8rP5XTGC64dkEbERiRLj5uIFjLQOmqE+6
	vlpWx1NF9/tqfQpoIMZHauKhu1rKhGvAtbr4Osoef2kKqOM0dXhURMz9Xg9RNrcAp4trYS5Idlg
	Iz6hPRttaftRRupTY2FzR4fNI43c9X/jaCp+FkXKF7LbUVw5DKqcBk1UxOpKIErtsAR0jEfBqBj
	Iw7GE69LbZNnor1DaPytD9PNj59T8=
X-Received: by 2002:a05:600c:304a:b0:493:af56:8e64 with SMTP id 5b1f17b1804b1-4954a40ff61mr24483915e9.32.1784296345884;
        Fri, 17 Jul 2026 06:52:25 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52673sm4424709f8f.15.2026.07.17.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:52:25 -0700 (PDT)
Date: Fri, 17 Jul 2026 15:52:01 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, 
	Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Marius Cristea <marius.cristea@microchip.com>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v6 1/5] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <zeooo2jqsp7rkovhdxtra6qjlzjsppyppe3nqojrskcv2sc2x3@2npaf56m66p7>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
 <1c4af9b1-9937-4cbb-b57f-52ac575b8b89@sirena.org.uk>
 <lpbqk3wv6emhdtxhnczrgufzzxprcfpfgenfepnmzhzfj3b3ci@rdphuko7ikti>
 <157154d1-3995-454b-9e08-1527f1c5d409@sirena.org.uk>
 <jsximyohkijphqrtgat6cjtcvtirjsdtbgn3lb6npw6yhgmcth@tq64dotfowss>
 <0e3e45fe-4c34-45d0-b985-0938f60b5914@sirena.org.uk>
 <20260716-stole-copious-7cdaacb6cef6@spud>
 <27746e91-ab2b-40a0-822b-6d3a8997cefc@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27746e91-ab2b-40a0-822b-6d3a8997cefc@sirena.org.uk>

On Fri, Jul 17, 2026 at 12:51:53PM +0100, Mark Brown wrote:
> On Thu, Jul 16, 2026 at 06:06:13PM +0100, Conor Dooley wrote:
> > On Thu, Jul 16, 2026 at 01:28:15PM +0100, Mark Brown wrote:
> 
> > > Oh, isn't that just multi-pin chip selects then:
> 
> > >    https://patch.msgid.link/cover.1783729282.git.Jonathan.Santos@analog.com
> 
> > No, I think that's something different.
> 
> > In this case, there is one chip select that all instances of the device
> > share. Both the ADI and Microchip devices then use the upper bits of the
> > first/address byte during reads and write to access individual devices.
> > In the microchip case that I'm familiar with, what upper bits the device
> > responds to are set by fuses in the factory. They also share the same MOSI
> > and MISO.
> 
> I'm struggling to identify a way in which this is functionally different
> to a multi-pin chip select.
> 
> > The SPI core already supports two of these devices from Microchip, since
> > it just modifies the contents of tx_buf in a spi_transfer.
> 
> When I said we'd have to modify the bitstream I was told that wasn't the
> case and this was just asserting more pins along with the "chip select".

Oh sorry,

Likely I was not clear. The part as some ID pins which are just
configuration! So they are two pins and depending on how they are set
(low/high) each chip can have four possible addresses! Now all of the chips
(to a max of 4) are connected to same CS of the controller so just one CS get's
asserted.

Of course the above will assert on all devices on that same CS but only
the one where the ID pins combo match the spi xfer high bits (part of
the address) will reply.

Hopefully the above makes it clear.

- Nuno Sá
