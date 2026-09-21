Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71734BFE6B
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006953; cv=none; b=J78mmjo0BtvJd90eIN9//54omO3DnWheiOSV9ff+25twBoR7d/kjYol8kZkBrA1A3kB9Nnz++/g0VcCEllOaHsJj/hLyBK7ifIdOZMNBv7HvHtBUDglPho/scvUeboSQd41e8gvZlFXqrimPRhbE7osiVrBFG6nhht5K0VLjbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006953; c=relaxed/simple;
	bh=SwXDXkJwIoYgN9JLjT1MHlSGl5vnljq5mibJtxzwng4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqPfvqyF0jEgkO/Xj276+s7WVsSjP7tdi2FLwGW4Sr60LuUtNaOftcUg6vm4WkTFJSCowv48AzS4xoXRziFnru5zzIjoKRnDgZ0BTBnmYQbnFa8zRcNqMSVMxKFuE3CxFe3oy3ovSICTId3Y6gsYyKMb28sk1WFcCev2wFTDEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lf2Q2Hu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf2Q2Hu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246C11F0089E
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006951;
	bh=SwXDXkJwIoYgN9JLjT1MHlSGl5vnljq5mibJtxzwng4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=Lf2Q2Hu3d6HNlYFo89SJgU18eXG8uRVKiKwUhsd+93SLd+aqiy1Yy+ltU3zt0b+Z3
	 pIAQmtELu8125y9YHJz2d7eaNdHi27RweXHZd1E1bbxwOXS7E4V/nA686g+MgAZ3BR
	 kqv8CQcmN7qhO7tRIUbJOwKNgA+Ttsb/C6DRTwHP7cxOcOZZYa10jLwHhdGrHT1QFG
	 Y0w+29iurwcDa8y2uSYID309ABk1bDlStPQRBuuK7Cyrm3/UaM8fWgegvsI22PrAiz
	 5FtNpVchW4TpxKuwhdYKZJLZPLGUZdQbKX3azwj03zUe9swnFkC4HqhdehAs7tC10S
	 041a8XzneOrLQ==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a58fef219fso12498131fa.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 09:09:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzDQ1vIFtQ72d+h0sh1WSvp3oHLe/7YLnbdlBSjhfW33xYMnGM/Zx47y9DXn5lbrSczFPlTt8sLxU4=@vger.kernel.org
X-Gm-Message-State: AFuF++ktKN4wYkENVJMa4p3VDfAZaYSVaWX7QvBnFIywPOzjlZIZu1zF
	C2quMIWiA36izzYKAMP3VxryGpMp5BpTcysffCpMYudWrdipmm48nFv9QuhUH2vRd6xrStX/4+E
	1oE22x9VWuxZfp1UOlDpAXITWREILboc=
X-Received: by 2002:a2e:a593:0:b0:3a4:88c9:c51c with SMTP id
 38308e7fff4ca-3a624c861b2mr334421fa.1.1790006949528; Mon, 21 Sep 2026
 09:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604120201.116925-1-vo.kratky@seznam.cz> <20260604120201.116925-3-vo.kratky@seznam.cz>
 <rfot56KMT1aR8vVOIe5xxg@gmail.com>
In-Reply-To: <rfot56KMT1aR8vVOIe5xxg@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 22 Sep 2026 00:08:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v66iTrHY-MHTKsFM=Wqf3vVLy-g8eg6M8eP573YX92MDig@mail.gmail.com>
X-Gm-Features: AcwNN1VBgQvCEUdLs4z1ZySLJQVZFDsISBDYum893VnssHpsSzgjjYNxMBzotzE
Message-ID: <CAGb2v66iTrHY-MHTKsFM=Wqf3vVLy-g8eg6M8eP573YX92MDig@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] iio: adc: change from %ld to %pe for PTR_ERR() printing
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
	linux-iio@vger.kernel.org, =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Linus Walleij <linusw@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jonathan,

On Sat, Jun 13, 2026 at 4:06=E2=80=AFPM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne =C4=8Detrtek, 4. junij 2026 ob 13:59:22 Srednjeevropski poletni =C4=
=8Das je Vojt=C4=9Bch Kr=C3=A1tk=C3=BD napisal(a):
> > Replace numeric PTR_ERR() logging with the %pe format specifier
> > so that error values are printed in a more readable form.
> >
> > This change was identified using a Coccinelle semantic patch.
> >
> > No functional change intended.
> >
> > Signed-off-by: Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz>
>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Any chance you can still pick this up?


Thanks
ChenYu
