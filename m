Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EA404BD8;
	Thu,  9 Jul 2026 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591395; cv=none; b=pMeqgamnRFoRYDgv3aRcWDEvBSWflgPQUYkhSL37ikM/GwEFwu0l4VrypjGP3mr4Qn633v6Om0lC9l5Qcv5cMs8X5qMiZJc9R3sa8Tjfv4zrtTX5nTzzAzis0jMsBJwAvEgZrsbDJrs55WScooz0uXEZ5pRIoAzT2vUhDflqzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591395; c=relaxed/simple;
	bh=R7Xz3VJ3wAt3PO2qZVMHAljVGd+M7I7HjBSYTI0Qz3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW6F7KRGHRcCno+exJI3tAOfLxKolzvSbxG0jurHa7lrZ+v++MegQGESQFTEhr1T9q/JSCt6YXXuAdGQGz41VSCB5A+9JSZbwGQ0YjHjHNfzbF7//alWHFDtMOArAaIeCHqMXKqHONVFwZzX+2BbpxMKootpqAtTqRMLJsAMJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbAbOtT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbAbOtT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E731C1F000E9;
	Thu,  9 Jul 2026 10:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591393;
	bh=+ak7g+bnNvjs6BgBEr/Bs7DjjcW1VaCyUfDXvUXZ24I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gbAbOtT3xXk/mcJ1eT0tQ/7wTMH+HHidCthinZFuF3zrSj6VpvqufBIjNyy9WdhAb
	 iXzvhaQZT0jUbVwaBDmQjSY0uw7WRKsLuAuN6zNSfBks8I9jTszW8LBQPKMLgNwl9N
	 2icoPJfvY1GX+9ejjz7LAV9bnkUnRhLJ2u+v76Sb5dGdp4iMqMudghZdRDXMSNi3iW
	 ttqmCKfFDH3pKqRy67YcIy1H1kaCh8ZA/R/Dt/K4R3ivi4aYKVyx0JRQBU9YbXskog
	 bkxfi5V3N1ohep4Cg6imr9Uc3pGgloh4rsV6NBuLw25Z6lX9IZ/PRw2VbyILse1DhH
	 6ATkVUShF/UWg==
Date: Thu, 9 Jul 2026 11:03:08 +0100
From: Lee Jones <lee@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v4 3/4] mfd: mt6397-core: add mt6323 AUXADC support
Message-ID: <20260709100308.GD2045740@google.com>
References: <20260623-mt6323-adc-v4-0-299680ad3194@protonmail.com>
 <20260623-mt6323-adc-v4-3-299680ad3194@protonmail.com>
 <20260708211056.GB1727174@google.com>
 <UV1EGIwox4bkh8ufCFb4GS_Pafo8bovmSI9jzRbQunz7AzjHnmItA-lLCPeeIxOLMoS3douarVEpoTF7DVffFJUcXZTdGTQ6-dfAYdomwak=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UV1EGIwox4bkh8ufCFb4GS_Pafo8bovmSI9jzRbQunz7AzjHnmItA-lLCPeeIxOLMoS3douarVEpoTF7DVffFJUcXZTdGTQ6-dfAYdomwak=@protonmail.com>

On Thu, 09 Jul 2026, Roman Vivchar wrote:

> Hi Lee,
> 
> +Jonathan
> 
> On Thursday, July 9th, 2026 at 12:11 AM, Lee Jones <lee@kernel.org> wrote:
> 
> > On Tue, 23 Jun 2026, Roman Vivchar via B4 Relay wrote:
> > 
> > > From: Roman Vivchar <rva333@protonmail.com>
> > >
> > > The mt6323 PMIC includes an AUXADC. Register the AUXADC in the mt6323
> > > devices array to allow the corresponding driver to probe using compatible
> > > string.
> > >
> > > Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> > > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > > ---
> > >  drivers/mfd/mt6397-core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > Doesn't apply.  Please rebase and resent with my:
> > 
> > Acked-by: Lee Jones <lee@kernel.org>
> 
> There's a slight cross-tree conflict. Jonathan has already picked
> patch 1 and patch 2 to the iio testing tree. This mfd patch doesn't
> apply because recently merged mt6323 efuse patch (bde6556744888).
> 
> The iio tree doesn't include mt6323 efuse patch, and there was some
> dt-bindings merge conflict.
> Should I rebase on top of linux-next and send mfd as a standalone patch?

No cross-tree conflict.

It doesn't apply because MFD has one of your earlier patches:

  bde655674488 ("mfd: mt6397-core: Add mt6323 EFUSE support")

Rebase onto either Next or for-mfd-next.

-- 
Lee Jones
