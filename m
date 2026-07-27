Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BB1DF72C;
	Mon, 27 Jul 2026 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117838; cv=none; b=hhGIlteRutWdnYcB2nse/h3gzvLeWR6i/1huGhK+ZDjCw/22UyVltcLNLyDGGv0/43wL5RNOoYfm3ObaRruf7aLwyNU+JQwYU2dglYywDgkFndx81kST7jB41FQpvKrR6grBZhhjkGXBL1ZtQJ0iWGWQYPuYAgpEMGNSnYBqCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117838; c=relaxed/simple;
	bh=eCBiw99GAmcqwUFkw2q+T7x9Je7EVbZq1sMRam49vDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoQ4+gHsS7mvNXZVBrt+G1maFZVBdDxn+zlerIWcp1V72TPzylJ9oKWSRxpWG6ocMH8ybMWFf8/o/MjBZbBAbUBu7e+grvD9GLm/lbKcbjoA0yR+TVpoMZmA3xsL3jNSVbFqAh1zjFv23JyhhcKaXDWUFlu6BOL2i6C81FNMEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz+YCKzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz+YCKzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC381F000E9;
	Mon, 27 Jul 2026 02:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785117837;
	bh=HLyWoGGxLYSJwoflDcLIRysEjWxT1bOU8qcYVdI9kP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iz+YCKzgZpYU0SSmqM9ZMen/+tHdpsAM4+w2NdfkGZSUNuIja37zTHr5xkQG20a+h
	 y+Uep5BjifLERECFbcQmGNbCOZAJi81b15LslcNnTzRBMTY2vk3kfeBbQ5npTTiF0e
	 nGfhp/GVEqpKJQGo4htY8WKWO4Ryqy0IQQ1ymSGVuKdpUuXwjkgIyOUI1ECftFxMET
	 zWAzYXYR7Fww28yJpmr3iuYOzYGq/6IcjOGgHucQgQTPhE+nfeq1Tvz1fzqzQelUuw
	 L9Vs+SKbZv7cT5UWxAxGvL3mnLLsSvew7WJt6YvzlwD1yIIqvs4KFauiliTdipbTMm
	 y9WAgKDvReoTw==
Date: Mon, 27 Jul 2026 03:03:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "shaikh.kamal" <shaikhkamal2012@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad5791: fix 'referance'
 spelling
Message-ID: <20260727030351.1c4df60d@jic23-huawei>
In-Reply-To: <01a34500-3cce-4934-93ed-59598718aa5e@kernel.org>
References: <20260726055609.18326-1-shaikhkamal2012@gmail.com>
	<01a34500-3cce-4934-93ed-59598718aa5e@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 13:28:14 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 26/07/2026 07:56, shaikh.kamal wrote:
> > Fix spelling error reported by codespell: referance -> reference.
> > No functional change.
> > 
> > Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 4 ++--  
> 
> Slow down, same comments.

Assuming this isn't the comment Krzysztof is referring to...

Already fixed in the IIO togreg branch. 

Thanks,

Jonathan


> 
> Best regards,
> Krzysztof

