Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795831422;
	b=z1+aDIn9CCAO1qxWo5oKeJ0+MzyxMQWGtaH3mFuYeP5OB6M1uIN3dnnb73/kF8HQyrl3
	 MqgQGsguVJgX3aPIhRSErV/VjdbSmoYDFJN/mB4h8/aWNH/mssRDr4/HlOg9z1Goeojn6
	 SZdwyceom9DgVcNzouV2+m2x0QWC3coGDJ3Fho2E/W4YrDc3XiFDOyN0/FRUhOFfZx641
	 5cy5zeLeCIIV+M2eYggC5ejdnueJTnO3KuP9f2+xtGdFYGcCz0Oia+fidaVPlrH3oNq0E
	 PoSr25Y8VQSn/zaEgOhZrt9uhuP7MzkfJnHhqqGSbnSuDOO2ckgjfb5wcy7Kz692Rbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795831422;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HeWBJ5g6LSzIQANkUriQ6+BUa0o6J4hp5r/mLuFEJR4=;
	b=b0bPeTyqzMk+h/nEnZGShPQjRRZd9c9F2qnw2ccyT74V4js0FlFp3zBVWVW+EB6QCsqY
	 H3tBg9xUoYg3ivp2R0QtvIvktX9Fox++aQipAUW28jpTOkvJ6e46tUpF4UNT4YpOX4JlN
	 blFeR5bdEOtpDH1AcJ7bGCHXlGMTzNJzT9MXM+YqchpG7O/gpXtIsu47x37R3lRzlebRw
	 5apLxtLt3SqZcsmj2veYze4cIUQZIUasUJLpPj7fhdYj4spaW9PajRYKXfVund4Mv1LpG
	 nbowmJ+az5rYvZDC7uCSnFfWUixa1DfbsbyB+4g8YTg9mnFV8nG/jZr7Fnk5fgJAUBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdVV4XqQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA287606A31C;
	Sat, 28 Nov 2026 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdVV4XqQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5411F0089C;
	Sat, 28 Nov 2026 02:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795831421;
	bh=HeWBJ5g6LSzIQANkUriQ6+BUa0o6J4hp5r/mLuFEJR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OdVV4XqQuHqJyrdZ/nloV3AawUrCEptGonozDqfHUjEip1IDYDkYXdmfyQMajNUlC
	 WrVNZ0nSJMaTc6+ak59kyaz3Tw5bCfl2pnWYgHk8dS9CK0HomdDFwe1jzZJ26e1xHQ
	 vg+y2yfM9T63NVecKuEfTFu1216J/CkmVc8zPr5em8vPpYaHn/No4h80/NuMXDFFHD
	 BXJgCWzCAyZQYtG7AO6zB3YR+L6XQZaVKYb6xUur67oDFxufDxzMkfxh6AHR6drjDo
	 NJv6mRFjNKO/PO5hCtowLinojop7AXzcL25ZcbJT2q6pB+vjWQPCwxmvKjCt5a3pvq
	 /nsPJ0MDmcpEA==
Date: Sat, 28 Nov 2026 02:03:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "=?UTF-8?B?TsOtY29sYXM=?= F. R.
 A. Prado" <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/3] iio: adc: mt6359-auxadc: various fixes
Message-ID: <20261128020337.20c8ff41@jic23-hlaptop>
In-Reply-To: <20261121235603.41ce1ec4@jic23-hlaptop>
References: <20261117-6768-6358-fixes-v2-0-1ffc3c2f3c80@protonmail.com>
	<20261121235603.41ce1ec4@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Nov 2026 23:56:03 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 17 Nov 2026 19:56:31 +0200
> Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:
> 
> > This patch series fixes various bugs in the mt6359 auxadc driver. For
> > some reason, the driver had channel types for temperature or resistance,
> > while the ADC can report only voltage. There were also issues with
> > battery channel ready bit masking and scale calculation.
> > 
> > Changes were verified on the mt6358 (mt6768 platform). Compile-tested
> > only for others.
> > 
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>  
> 
> Hi Roman,
> 
> The series looks fine to me, but as we have fairly active folk
> who care about this driver (or at least did recently) I'm going
> to wait a while for reviews to come in.

Given we are starting to get patches based on top of this and that
I'm only going to take this the slow way anyway (balance of how
old the bugs are, where we are in the cycle and general load of
stuff going on), I'm going to apply this now to the testing branch of
iio.git (so for next merge window) and mark it for stable so it
will get backported after that.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> > Changes in v2:
> > - Clarify bit number in the patch 2 commit message (Jonathan)
> > - Link to v1: https://patch.msgid.link/20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com
> > 
> > ---
> > Roman Vivchar (3):
> >       iio: adc: mt6359-auxadc: correct channel types to IIO_VOLTAGE
> >       iio: adc: mt6359-auxadc: mask conversion ready bit in mt6358_read_imp
> >       iio: adc: mt6359-auxadc: fix scale calculation
> > 
> >  drivers/iio/adc/mt6359-auxadc.c | 88 ++++++++++++++++++++---------------------
> >  1 file changed, 42 insertions(+), 46 deletions(-)
> > ---
> > base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> > change-id: 20261103-6768-6358-fixes-fcdc79afae11
> > 
> > Best regards,
> > --  
> > rva3 <rva333@protonmail.com>
> > 
> >   
> 
> 

