Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA43A0EA6;
	Tue, 26 May 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811203; cv=none; b=RqfXWnIx/VWthNiAKmVEDrtdAStTGbygFQDnQmORgR54lQv3GI16wCWpw0DNTxNV3zFs7loixVLPOzu5nrAYX7yNirWWIkKDHMEgOyPiGgxX3Vty67Y9i63DztsITvO6TT+201crhUJxmI5C1Jr+H0wQ0OSQNTb3v81W5Bdu6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811203; c=relaxed/simple;
	bh=K0tTiHiJp2nrqh9Sg0Ds3UM9JA5AQVx9aUGrbwvPesE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNOKHyhzUv1XF5w/8ybmfGwEAGQfq+2cDrVjXtOtNGGjNGcrW5t43zGcV0mqFkRG1fixCc/SltbEkM/EU9N+FXjZoQ/5/59PAdqeZpmkgatGQSxEYj/yEvKnP8b0lvMLvIPnw+08RJhhy+5LmnDZFbBN8w9/2EoC3HEadHTHjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHvio8Vx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHvio8Vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CB81F000E9;
	Tue, 26 May 2026 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811201;
	bh=O2yi96u78im7R7KKZA18SGumg68beCg60ymA8pEAfrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MHvio8Vx9E1QhfilOwJXZc9PsE5MbdpS2jvVyXk4xOEF1k8lW9TkMMtDzkyyw0U/O
	 OTp16xknkafmwZMdCUHKw9sUArdG3ZjSsuVhu31pvh9OcqVGhML3203gg+/z9JpGg8
	 NFIobO8hnT0iDL8FbCkJAUnJHwbofhRPIo3ZofCeRu/qSFzwNmy1Fg9a2Vqkixxwfk
	 ejA68r0FTlVSz8rQZgB1flAQKu3644RJleygfLbby6kSHHhIjwtQVQyFbrt/kIyZW0
	 oyAw7EM5sQ+OngLHgZLutkBG3S6i18u5FBbxyaLJms6ujhaAeMwN4GjGBvbbMEcibc
	 GXiL5pAijt3vQ==
Date: Tue, 26 May 2026 16:59:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wadim Mueller <wafgo01@gmail.com>, lars@metafoo.de,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/4] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <20260526165950.6ebbf673@jic23-huawei>
In-Reply-To: <95f0914a-cb25-44ea-9cef-d203c624f74d@roeck-us.net>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260524205112.26638-2-wafgo01@gmail.com>
	<95f0914a-cb25-44ea-9cef-d203c624f74d@roeck-us.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 14:39:06 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 5/24/26 13:49, Wadim Mueller wrote:
> > From: Wadim Mueller <wadim.mueller@cmblu.de>
> > 
> > Add a new IIO channel type for liquid volumetric flow sensors.  The
> > unit exposed via the standard _scale attribute is litres per second
> > (l/s), so drivers reporting smaller native units (e.g. ml/min) only
> > need to set a fractional scale.
> >   
> 
> Two questions: Why restricting to liquid (there are also gas flow sensors),
> and why litres/second and not per minute which seems to be a more common
> unit ?

I'd rather we went to the SI units where possible.
With long hindsight it was a mistake not doing this everywhere because
it means people have to constantly check what the units are for a given
channel type.  For almost everything we've added in last 10 ish years
it's been base SI units.

> 
> More on the latter in patch 3.
> 
> Thanks,
> Guenter
