Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096C3290B8;
	Sun,  5 Jul 2026 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783294678; cv=none; b=Phou4EbYIP0OReGFhlPkrsgWETbvV5JHeqwLl5e4ZNyJz8J4ObQf5BMHfUE1ssBE+7VJiUWQ9jjfoBDyg54mq60djHgmrtNt4AVKCt0ol3ncS3O4B7luAwFOFx8Mpph1flhcKQgvT+U67XTj16DKMVNgntsc7VLEoaVu1EYq2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783294678; c=relaxed/simple;
	bh=ULLbBZaJSMMLCV0smch9WL/OdSJ3WnKQaW4m9sV+0Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nw1+xBDXsE9h87uZ5adm4A8DhPjnyTdel4b2QmkE8Qm2UX3nqlo8Mwp8WcdVLCflZnN3G2HCX4vnq0KFt4MRkclGlFH9Y6avXi+T7gx5CSh7waz/JbvghZQ0wMG7m0y3q3/Y8mCnXOvZdFshTeYfA8cZoW/sS+LwSGkfVHLixGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfKBXYtm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfKBXYtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEE1F000E9;
	Sun,  5 Jul 2026 23:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783294677;
	bh=w46ZYav/dvFCwu6KFwo2Dav0I+xlrSQs7nfMM5MhdTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VfKBXYtmsklSpWgNl/bOb4XIzoIynKiZS15SrvfdiG2rOgUb/nB7Dpx3R64MjZRZE
	 JpIYjvKbp7oF9DQbqthl15qhFq2GMcX6QOFTsChnE89Fcl0/47DKndGdQ8x9tDb+s4
	 8oTUM6LwpNCX4q/uK5rGkWnJ3DhdlTnLVzymT8ttNfZuWpPZ0vmbSdN0Bj6juHPkv6
	 rR2RQOZqcNg701MOsN/GrJouuHX+sTiIex/slOTTrdwmF7W5DlzgueBBtJLEUjYRiX
	 ZjIcF39GE4asX7rkgdTttGYYp6yQtY6kybrevFD2FfeMTHhYywodrY+4NcKxfS1tt9
	 r6mq0sp5qva5Q==
Date: Mon, 6 Jul 2026 00:37:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Maxwell Doose" <m32285159@gmail.com>
Cc: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ade9000: Drop incorrect kerneldoc marker
Message-ID: <20260706003752.376a2ada@jic23-huawei>
In-Reply-To: <DJQTTB91CSPU.1LSN2OFIRKGOH@gmail.com>
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
	<20260705172438.119204-4-krzysztof.kozlowski@oss.qualcomm.com>
	<DJQTTB91CSPU.1LSN2OFIRKGOH@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Jul 2026 12:50:28 -0500
"Maxwell Doose" <m32285159@gmail.com> wrote:

> On Sun Jul 5, 2026 at 12:24 PM CDT
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
> > Top-level comment is not a kerneldoc, so drop marker to fix W=1 warning:
> >
> >   drivers/iio/adc/ade9000.c:2 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >  drivers/iio/adc/ade9000.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >  
> 
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> 

Applied.
