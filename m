Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF9E346E5D;
	Sun, 26 Jul 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091608; cv=none; b=KcWaSTpqW7stKS5g5mCLJ+f4te07JFfNAlkh8PnP8fMQ+WS95Kn7IJE5wXpQl+mA+6WUSU8zjjz0sH4bFc/azcdYK8LpKBMSS1FE/vJm+Nd1vyQxxKi+pBMRRndf/hLd5WMhiD1E6lQJBlZsaOs5zbxHZEu9fVMyFNXA5wAro1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091608; c=relaxed/simple;
	bh=EnQyttK1bd0fMNn14oTG4+NOGlYTMxaMDpq4hD0rqfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1k9kS14K5UHJUjruITOqqd4iqBfKB66+bKrJVSndHfFTVdSmHdtpxlJE0Zu5gTZv+FueTSeUmbKFu3tVWnNvjhgISpAcZhkQc1GN/tCiETKaAZnVyWpKDurOkOP7CeYZ/0EV+L9aCOJxV1dKZTQjx4U3/xtTDb3i286krsny9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=SGFpei8D; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="SGFpei8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1785091601; x=1785696401; i=lukas.metz@gmx.net;
	bh=3TEh94AaH2TTYHQXTc8R782NeDG4NPFS4/znguQR5Mk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SGFpei8DkH7RKuVjMvOMmsARKzZgeJVwNjjex0L24/EE59VwiN5Iqu4utMOVBB5B
	 QKUnXJc3phxkqYldy/FdYAdY/Uowe5Oiwr8Acqwly23+e9sYyZN7LlCgEoagf9u1O
	 mC0Lu1iB20fIziXa7dj1juN9aDS/85mDdDVcw6tojYLQ/RjGu78IelVny2KLWLxuA
	 hE4c4qvKtqYh3hgxJq/fLVf6LCO8dXdRDpuviBIaAvVwwsw0gwyfsnbkHF5mMMkqU
	 KsnModuImZIGyjCpBmu5pOFbutDFXIlO0AFDlqCEycF0/rNXvKv+/bD9AMD7XTjIN
	 gtHY8lZgU6dkACUAYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlGk-1xRmOv2ebA-00jVhK; Sun, 26
 Jul 2026 20:46:41 +0200
Date: Sun, 26 Jul 2026 20:46:23 +0200
From: Lukas <lukas.metz@gmx.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Siratul Islam <siratul.islam@linux.dev>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <amZV_2_dsNZmp7Bb@berta-MS-7693>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
 <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
 <amYVZtbxu4fjhBkx@berta-MS-7693>
 <6b3f1b6188afbb8ebf9576274894b5ed292eca92@linux.dev>
 <20260726191833.67dcfac2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726191833.67dcfac2@jic23-huawei>
X-Provags-ID: V03:K1:14mY/KeAh+tQIQcANXDLBanipkGtuYFUxuHwVD0V4WXiHI7QJ8l
 S5peOzEUlA5qfe/QfNHRtEyv5cAq/IwtUnVkLYlB0Lqwq7bQcjYL9aw8Qxat8srSRsoWwPe
 m/V4CP885jZXt5HNkZh2Ty6yOdFogz0PAuCB07+vcZkfCzW0/MybUqRSjfx1HXjgwvzECP3
 DeolVqkgyD41eXd3oPvZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1a2UNFYhAmA=;qqFU33eoUSjVWcfWmHItuUHUAOe
 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
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 07:18:33PM +0100, Jonathan Cameron wrote:
>=20
> As this has come up, I'd favour just having two static const regmap_conf=
ig structures
> and picking between them.  Obviously I haven't checked but I'd guess tha=
t any
> overhead of extra text data for those is not that different to the extra=
 code of the current
> approach.  Generally if you can make this sort of thing data rather than=
 code it
> is a net gain.
>=20
> Jonathan

I actually misspoke before. Since all dacxxx3 devices have different
default values (mid-scale varies for different resolutions), 4
different reg_defaults are needed to cover all the devices. I could
define 4 static const regmap_configs and pick between them or go with
Siratul Islams approach.

Best regards

Lukas
