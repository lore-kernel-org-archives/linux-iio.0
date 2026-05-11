Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134D35E947;
	Mon, 11 May 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518616; cv=none; b=OeXCiapAYPhBqu8zmBf87mNxnZePKjODW1YoKL8lJrwvny/5GLKCAXZ/RHtJRbI/L43GJgjnjG9fYKgSZhhRv2KmaES4RvBKvbs+4RBCNb5w+08b1l0q1gxfJMByc7D8ovxgO4yDZZKC5H75TgenV6rl4dOxhhzblb+kV+p0GJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518616; c=relaxed/simple;
	bh=ryTyckrSHsDh+60EUzz4omQDkK+CqkWIWTbWP41CmaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJnxzSPnPlxnkZXH1NY3NvkBcFNje67hNtuuVshUA9zeBabQ6lY1QNfXHHNkSshRSSHjt/HGHVxOBiP1YROneqogOzswg2RyCf7kgBpkzsLcMru7c8qrdKLhdobKpMDjuPxr8cR1hJI99LBdRqB6cOlCa1d5LxYlxK3kcnVAm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpNmZ2pL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpNmZ2pL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E03CC2BCC9;
	Mon, 11 May 2026 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778518616;
	bh=ryTyckrSHsDh+60EUzz4omQDkK+CqkWIWTbWP41CmaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dpNmZ2pL5XWruI/PNRFppOI+zIoJPyPNTyITdsVJI4MG4D7B73XoJJyNf5hAQlAmq
	 1i4eqeuKpHVJCCvpO4LOWBSrEL+S8A/ZL24XwIEkufxv7DniMHZGWaumyvJTWV7erB
	 mN/PsDMI5gbDgiaTu/fbHD+lsdOIvzgTNpuILZlxW7UKcAtsqPz/C8d/egNXvHPObj
	 mcn6YBuEWc0pCdMX/0b82s7ECSxRMWBCf7rnrZVXvtxyNpApoHtcjxX7qaDjPIJIl1
	 ARSGhKcsBqxlNixaqJIoACOoYFSXAWV+Yv4ZQ46nUhxaVuwbA3fEzwFn0jivSgPgex
	 B7E5ZeP4otqcw==
Date: Mon, 11 May 2026 17:56:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Message-ID: <20260511175648.3ef5e64d@jic23-huawei>
In-Reply-To: <F55DA41F-BF95-401B-BF6C-0FAF93EB2704@gmail.com>
References: <20260509013745.80478-1-dennylin0707@gmail.com>
	<F55DA41F-BF95-401B-BF6C-0FAF93EB2704@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 09 May 2026 07:40:55 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 9 May 2026 7:07:44=E2=80=AFam IST, Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
> >This series adds devicetree binding documentation for the
> >Analog Devices AD9832 and AD9835 DDS devices.
> >
> >v3:
> >  - Require spi-cpol in binding and example
> >  - Use generic node name (dds@0) in example
> > =20
>=20
> Hi,
>=20
> Thank you for the change.
>=20
> Ideally, multiple logical changes should be split into series. For a sing=
le patch you can include changelog like this:

Whilst in general that is true, here we are talking about a single
device tree binding.  Those are almost always single patch affairs
as they aren't normally that complex.

Jonathan

>=20
> Signed-off-by: ....
> ---
> Changes in v2:
> - Add SPI peripheral schema reference
> ---
>  .../bindings..
>          | 94 +++++++++++++++++++
>=20
> If reviewer specifically asked to update, you can mention in the changelo=
g as well. for examle:
>=20
> - Add SPI peripheral schema reference based on review comment from <Revie=
wer Name>
>=20
> Replace <Reviewer Name> with the actual reviewer.
>=20
> Thanks,
> Sanjay
>=20
> >v2:
> >  - Add SPI peripheral schema reference
> >  - Fix example by adding clock and regulator providers
> >  - Fix SPDX license format
> >
> >Hungyu Lin (1):
> >  dt-bindings: iio: dds: Add AD9832/AD9835 binding
> >
> > .../bindings/iio/dds/adi,ad9832.yaml          | 91 +++++++++++++++++++
> > 1 file changed, 91 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832=
.yaml
> > =20

