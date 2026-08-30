Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73A222580;
	Sun, 30 Aug 2026 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131804; cv=none; b=MwslTT1yfNf/jqKbx9ZHhFAzh1Yiu2t9gHUC/UlwCXcVrnP1IW88o+61UjEx9olMdvcwAgQ5tH0SbAfK/aDfCw785L8SxSVHc22EDT3YWudlz+3aIBFlJFLneUkDTi/jJ9gW02x9RAbAlnTMPzhQSzqkwK1jLiysi43NemeEglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131804; c=relaxed/simple;
	bh=YvcOrLOX7+Dh7BKOq2vJB6De9vJb64MmZFsD6HRQHZE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ppbzGLHni5+oiCEqLuPZwlfVbzmc3r6rCVwq4Psyom6sNqA5BoUSv2lA41+XTuU8olYt7Bj2gFnEKv83yJYCODIBBUdM6AGPJwv2r3Jic8LcyVBtt6C+uVnRNoGMYfaokDNXfGWLlkWkn3Zr+InIiP26XTwvT523XubFI3JVeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4TksJmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4TksJmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74241F000E9;
	Sun, 30 Aug 2026 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788131803;
	bh=DtclEM6AxlSQtUjv+MTQdeh9Y9YSmjfI3qtdFkZx3xw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=J4TksJmv/us19UxyzNF7i3g1OEAuHbnoKlj2ihxQFR44uMVjAFzw+03nc95G45NSl
	 um45pNKpekAwTi087/yf1UajSX/3IVW9/5e2exELJG8NJu0n2xOYzadwDyU7OPyXeS
	 3eAa2nEkPVm1V4fkVkKw2xkf6kPOUp9kk06tnYbbGvGidgOpMu78rO1bYT9zuptdxt
	 Qyh3HBu7TVN1Y7pYz2z/vkIAm41RVgQKD5kHOQkfCF8G/ofyBk0+x+vmy/se8qJTsS
	 qoSn/fq1HRZTb1+pymuPTGMY/VZOwMmE42L18ojgRhTHU8T9TW17Lsa7lcib1anpQV
	 u12uwZ8aodczA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Janani Sunil <janani.sunil@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, linux-riscv@lists.infradead.org
In-Reply-To: <ao_z9QTJC_q8gH0v@ashevche-desk.local>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
 <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
 <ao_z9QTJC_q8gH0v@ashevche-desk.local>
Date: Mon, 31 Aug 2026 00:16:12 +0100
Message-Id: <178813177252.2788519.10940489053707901297.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=2eHbvetl6bVxEL9oNB/90RLmkJwO/yTkkqjW8VAVLDE=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlLm9pxRlC7fEy2/vcPCiXMCjSkikzaEaADxH5
 j+amI5bJzuJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapS5vREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiGcTEACtTY8a9Tku89MTO+xwmX4mV7OVf4l4sZfYUgNwYBt4moR
 P/lauImhnjaafxKvAnHs4LFNT/J1ybhqUwC9+WAUBQu5vnqN4IUtjr6nUUCdoVK8GVAgZ7wxxSt
 /aHHDp+VH2AiN5Na25AlQp77Yx8+NAaaEhlleZlwMOoVxH+OmpPyGdmh3PuuptHBR5HAgAv0GJt
 iDIjIqLi8RQCpFIGq6Z7wwUP8ngc62/WXfKPJkXguWKfJn4Vi97sSj9IoVUPAyo5THKv/GjI2JK
 SLQGbkgOE69+LwNby0RMyHNf2ngYcQTANJKhkuMYnVtXlDk1exe52rV1vCIZnWFMm6UJczT2YfG
 2Y8z2u/Y4kKftLSaf/Cja6ptN/BtdCaqNb87ohbo9xHMetBhzMD8oU1DRMkYWZwj3UXowYgYRQ8
 3xZiaUyAB1neL+1OYHhN4i+qhx+NEMlBMsBGArRvF1XpZIcz/IiI/mJK3AdwQrHUnFJKhIWvHMf
 kTPXhMsKgGD7XP2Su8n7EHZvTqW5X15xqC8yQGeMtDWx1inNFWajoJO2Ui4522VtWZ4hc6l0k4Q
 VcLWhRqYFeVDUFlwOWGFAQIO5eCHjxKKvkPc5aclNTsvxWRHklNE9DUkVDC1RF7rHIROLuqhNWP
 W6NSLYXXQbITJ4kOYMZXw5UUR1+GRIQCy7fZwJw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688


> > +static int ad5529r_parse_channel_ranges(struct device *dev,
> > +					struct ad5529r_state *st)
> > +{
> > +	unsigned long channel_mask = 0;
> > +	s32 vals[2];
> > +	int ret, range_idx;
> > +	u32 ch;
> > +
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		if (st->num_channels == ARRAY_SIZE(st->channels))
> > +			return dev_err_probe(dev, -ECHRNG, "Too many channels\n");
> 
> Okay, this actually better to be ENOSPC
> 
> > +		ret = fwnode_property_read_u32(child, "reg", &ch);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Missing reg property in channel node\n");
> > +
> > +		if (ch >= AD5529R_MAX_CHANNELS)
> > +			return dev_err_probe(dev, -EINVAL,
> 
> and ECHRNG is here.

That one is getting rather creative even though I guess the description
does fit rather well.  So I don't object, but also feel -EINVAL is
probably good enough for an invalid property value.

> 
> > +					     "Channel %u exceeds maximum 15\n",
> 

J
