Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2B42E8FF;
	Fri, 31 Jul 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509646; cv=none; b=jyuai/GiiKI0vBaveJyKtv+aCibiUdA9L+R+Ob1+gjzQZC3aUkRO/JWlxzvNAT4iN4dohgKdTPOJcWm0dAdLbw38qoNQhB8Gp+g/Xbut1otuW9MKiG51knZNTDCrzVOQlBKTng9TV7VnF/Y75e2eq2ek7ZM1cEWXlV4RKJBYSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509646; c=relaxed/simple;
	bh=S3oGBtrmBUnlFSzk8cavyiVCzS8t4CDwXDGY1YqLfBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmQ71LtdjgmXIRoZtikfNacUwiUGXcrJYGgweMkhJrsIjG8+8zYk/cY0DiMit+upaNoXWMp8oL3SzJjDwsmiirX1BKEP6JSJ8ZDsAkIf61Qp5sjxfbiTZnv4ZrMUARLEU+rwxuHBnStrDaMCTKVwGcWeXh4q4Do4wBE7Vd687QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE7KUako; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE7KUako"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5FC1F000E9;
	Fri, 31 Jul 2026 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785509645;
	bh=1J69KhrZi+tCUCTcy0KQGCVDYT0irf6FmuwqoFPRASE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HE7KUakoPHqF/jJchSfHyZVglb2stswvwg9SFFTnxJV1Ce362pfu8smnPr5il6VZg
	 wJJ99NXPd7nqvcc8GrZbbheT5M9nHjuk8XwbI8+oQUW0/Y8yogB5oCEeZurx1FuGpl
	 XYIOcDGNv1KreKU39qtXkK4Ws9v8xu9g+EW9+d0DXrcHCS9L/07IGv0hqVD9ABoH2S
	 26uwVrY1TxAlEoFSk2c6Wr2F9zyHa8ftHKIWJdzGa5g6nLQ8/RCeEfN9cDjb5FgAXt
	 pWQKlOOER2mV6Aj9C1VOQvY5HemaKciEw1vprloTQPw6bbqQa5kS5U3HHX6z68mWe7
	 bzZIV3bE6A0mQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wpocc-00000000Xpm-2yrU;
	Fri, 31 Jul 2026 16:54:02 +0200
Date: Fri, 31 Jul 2026 16:54:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Message-ID: <amy3CuqWFS8ra89r@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-7-clamor95@gmail.com>
 <akeHfV45fs_wabFl@hovoldconsulting.com>
 <CAPVz0n1groC-4MxU-sjyPEDHYWqAweyBmVNC+iX4mVa_D3SnDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1groC-4MxU-sjyPEDHYWqAweyBmVNC+iX4mVa_D3SnDA@mail.gmail.com>

On Tue, Jul 14, 2026 at 04:32:40PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:57 Johan Hovold <johan@kernel.org> пише:
> >
> > On Wed, Jun 17, 2026 at 11:00:23AM +0300, Svyatoslav Ryhel wrote:
> > > The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
> > > only in lm3533_device_setup(), which in turn is only called by
> > > lm3533_device_init(). Incorporate their code directly into
> > > lm3533_device_init() to simplify driver readability.
> >
> > Again, this isn't needed. Why are you removing abstraction that improve
> > readability?
> >
> 
> Adding helpers to wrap custom regmap wrappers seems redundant. Regmap
> operations are pretty self explanatory without need in one-time-use
> helpers.

They are clearly not as easy to read so this obscures what is being done
and makes lm3533_device_init() harder to read.

Johan
