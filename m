Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059945;
	b=dUDtDDpjme1rufEpL7qIsFOpYWlM8j1kDaltiB6xZXLV8DWmhu87TTDKVt37nwobt9x2
	 oyMofbmIB7UCf08EpMCBvJhxPa14S5TCA27mKe72d+k0SaTSydWAhPcNMUDZ91Ym4kW0Z
	 6Z6hzqJcg8qGreYMYbVTjRrsOHLmcAXhrbqoEQmh3e0v5o1+7WJhr91E981peBRvL8+ob
	 guJ7gTdOArZk/YUtHnupvNwJWGGB8b+cNQaXM51Qok7zh/YPRX4BPMiybDe2n0UL7LKVO
	 opXoFNjlaNMr2/hDKsYWFnwNyJCTQb7y8Am2Gm/JdOX20K3pt40LpUq8wp+ApcIb9HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059945;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QwLVkkJXCDMd73PO+77UQ/Yv23zkurxXTTr6JIgC8iU=;
	b=S8I5PyKaPKOdRD7j7s13SBbZM/XMBz3ZV+UBbsGHlQJrH/b3pCS/p27fzyLH8Me3EqnM
	 ofAhsuxGNzNVHgFMTJAyh5JASm4n2ITguPpLjT0/QqVyiqYGk2JFsxXg7DxWcBJDrP3pK
	 l+5qIl63w4WAFY2vVNqg+T0QPqldCtR+1D2Beb3b9Jwx93iz4PWwMjmUVnpvz9eU8dkLr
	 Wb2Fotw56U+EiX162LDZP70j1L6EwZUPdqtGWseTSV764ULGzKc96UuYmGJqBRyJdxi70
	 XKKVNwFczMbBAGQildmhknlazaMzhZlllrrzrcFTInYoZEkkmYGFZy7Qi0UUsWHOMYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGoEoSb7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E8606A32A;
	Thu, 19 Nov 2026 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGoEoSb7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2601F000C5;
	Thu, 19 Nov 2026 03:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795059945;
	bh=QwLVkkJXCDMd73PO+77UQ/Yv23zkurxXTTr6JIgC8iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hGoEoSb74yu5GqPhRT7MsVUUl+nLl3KYcO/InfU8F09dYm8aeaMesNZ9Aq5DoZRwo
	 MbgnDm3osxPZm2HpSDAr8ez65bNyscuGR63lxFMmwGIKYNNu5N/q5w5L9kN7zx+GHq
	 ZAYMD3gxGPsU2uUOGaxIpXX3WLa9kO2TDCV9LWvH5VNF/IRJQlORl2SrfMjzE3Fswg
	 Bb02XR4Ib0DbLlBSQjdMhovDEA4l23YjLGi0lAcnuG3BBnbbFdjFE6n7/3h/UD2YIu
	 Wry2CULXBql/HDqm2v92qmvyCZcB4Nr/nQFP8j1hIuAuViN7H04JsThlwCe5iuzrKf
	 hpRQ/95XrTv3A==
Date: Thu, 19 Nov 2026 03:45:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: potentiometer: mcp4018: Add Analog Devices
 AD5246
Message-ID: <20261119034536.6e5a3b9a@jic23-hlaptop>
In-Reply-To: <CAPY4CJ4zHV-wCszetvFnVNA=v5O_rhY1YAeMNhS8r3nWC5wJCw@mail.gmail.com>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
	<20261116-iio-ad5246-v1-5-ef6b7c06d4b0@telaak.dev>
	<avwP2P1zTgFteODM@ashevche-desk.local>
	<CAPY4CJ4zHV-wCszetvFnVNA=v5O_rhY1YAeMNhS8r3nWC5wJCw@mail.gmail.com>
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

On Tue, 17 Nov 2026 14:31:48 -0500
Joseph Telaak <joseph@telaak.dev> wrote:

> On Tue, Nov 17, 2026, Andy Shevchenko wrote:
> > Make it shorter and more generic, in this way you spread the same text to the
> > top comment in the file
> > ...
> > and to MODULE_DESCRIPTION().  
> 
> Will do in v2, with your wording.
> 
> > And here make it list that is scalable to expand  
> 
> Will do.
> 
> > Keep it sorted.  
> 
> Will do, for the DEVID comment, the enum and the cfg table.
> 
> > Why signed? Can the HW return something negative?  
> 
> No, I'll make it unsigned int in v2.
> 
> > Strictly speaking this patch can be split to two:
> > - adding 'div' member and providing it for the existing chips
> > - adding new chip support  
> 
> Will split it in v2.

Small process thing.  Crop replies to where you want more
discussion.  If you don't have anything that needs more
discussion then don't reply.  What changed can wait for
the changelog of the next version.

Saves us all a bunch of email reading!

I send this mail pretty often. It is kind of a request
to be less polite in the interests of efficiency!

Thanks,

Jonathan
