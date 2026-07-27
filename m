Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D9221277;
	Mon, 27 Jul 2026 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119709; cv=none; b=Aq7HJs8nxyleL4I0WnWP5yg+NqTz0ga9JNMtKEoquLkdCMcpNnknKKcelbyshEj1+sj3GXKnAPk/1nSPapXxzw12+wUUFK3sioFo4U/tR4IGsZS4PrWEfz7n9hCTbqeiDy4RQd/78Hl3TxHYn0JQFcR+zt/Cl2YzBAhCS3AoolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119709; c=relaxed/simple;
	bh=MijYWheBixYAkBqDrDl8EzZxHZvOjDKlYkjhq0zQwdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzWv1JKaXxX68dpX79U+r8lHYYAnygu3K0+hdObP3Lm0JW6bBS0MkbxumTaWGpctZE5chQIWjLd0Mcncbz/EccGLB32/l3Gety+fU63WdWU+qB76oUsrW8tmt+lL1xKPBeHvGwD7rqsuQRZmdDkgzzY9FE3MdFgu5q49PUSXyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjRu5cfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjRu5cfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258151F000E9;
	Mon, 27 Jul 2026 02:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785119707;
	bh=MijYWheBixYAkBqDrDl8EzZxHZvOjDKlYkjhq0zQwdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NjRu5cfs1OKv9LX0DdlnVqynZG6o1drLVWBzAndOsCqQ6EkS3vGXfbeQger8mKDuN
	 l7InIzbKF63yr/+bMLAd+Mdx0rANRg3tomCE02nRGWs4csf021NkQpw11JhWkf6naW
	 uaVL3lTxFeDWMTuIxV8F+cT9eEOvhbxDPsw/bsWoDMKOS6w/EkjdfyunKvsUPyD+6G
	 tp+rnhfkREu5CI8alsp3vctoplM67FN/CIbJS/PXProG9OMWNlujkMEZxsrkxldn6r
	 p8Aljzrc3P1bimrT9xlS0iqM0NREFjO1vq2gzko7zvVHiU270frWJzQTUPzPQgPJRV
	 WPv9Iegc5GHtQ==
Date: Mon, 27 Jul 2026 03:35:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= \"(The Capable Hub)\"	"
 <u.kleine-koenig@baylibre.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Siratul Islam	 <email@sirat.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Sakamoto	 <o-takashi@sakamocchi.jp>, Danilo Krummrich
 <dakr@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"	
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: bme680: Use dev_err_probe()
Message-ID: <20260727033505.14c99429@jic23-huawei>
In-Reply-To: <eda63b141f49e544efb2accfbe5d5a6bc9e801bd.camel@linux.dev>
References: <20260726152111.171339-1-vo.kratky@seznam.cz>
	<eda63b141f49e544efb2accfbe5d5a6bc9e801bd.camel@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Jul 2026 23:59:33 +0600
Siratul Islam <siratul.islam@linux.dev> wrote:

> On Sun, 2026-07-26 at 17:21 +0200, Vojt=C4=9Bch Kr=C3=A1tk=C3=BD wrote:
> > Used dev_err_probe() instead of dev_err() to simplify error handling.
> >=20
> > Signed-off-by: Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz>
> > --- =20
> Reviewed-by: Siratul Islam <siratul.islam@linux.dev>
Applied to the testing branch of iio.git

Thanks,

Jonathan

>=20
> --
> Best regards,
> Sirat
>=20
>=20

