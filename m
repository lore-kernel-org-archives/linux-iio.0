Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082F18A6A8;
	Thu, 13 Aug 2026 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582096; cv=none; b=H+4oeh+5z1ADBmu42q2NFuSmbPu0wSSTVU+G3gQoahNYYl0usw3ui706XnUDe4f1HDjauvxxkj/phjiO+z65+IKhfRnr1cF0tefDLpqCnix3RM1clpINX5AQ1eoFTxLOHae75BpEqmFOXCcXwwi27LQ39Lx79W4PChqtl+GGv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582096; c=relaxed/simple;
	bh=OHwDDOJpUdur8efDN6Uu/4OUScP3Vlj9NZ1G4td0xIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soXIHkHzBZZS58ngC7Fs48geDuFJ4ImjLwV/sFCX4ntljPhBOpDBg1iGW9IvXlJ6gpKI6AugXxrUfA4fSj6oY40P97fqu64rEYP+XRRhW6RCXCkQFHIt3/cJQSw09I4bwJMXhcsIxMglockV6Z+Q9CpDDEJqDMM140FB+Fim0es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftdsSzr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftdsSzr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3F21F000E9;
	Thu, 13 Aug 2026 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582094;
	bh=bIa6JarE3fnXGpCz82modIZEaWbfBbVOC2RwfhR+/a0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ftdsSzr5lUk5SBEpY3TtMbY2dtT2YIeZ60KAdcdYa1ebGThmHByYquLEq4sGMWsG4
	 +pUony+vki6zKQhhnbxADdMvjQrxrL1KYWg3sn1pSeTO2PxWSXrQGAikKcY9ZbzXf2
	 UD8AJv1qRCd7L/BiFWa4W6Y/jgTMN98QjxmCfHTxqcmD+cWQ3J78kaU9CQI4FZASPq
	 gytrcV960A3knCTL5OH5ejW9XVRmwFl25+GjX9b6tfZAZf+IxNMqMddL9KOEFL2//S
	 SEHBEYR8VWlAug1DhXC+Iw0RSr3eqt6NkfPkuOKefAz18cWOk+pxZBkS6THGAF649v
	 alONuN140kOjg==
Date: Thu, 13 Aug 2026 01:48:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 0/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260813014801.4bca7c7f@jic23-huawei>
In-Reply-To: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 22:27:39 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These ambient light sensors with I2C interface provide two light
> channels (ALS and IR), high/low threshold alarms with configurable
> persistence, and a data ready signal.

https://sashiko.dev/#/patchset/20260812-veml6031x00-v6-0-7eef6e4ce290%40gmail.com

Seems to have one plausible point that is driver specific.
The first one about the devm action calling pm_runtime_put_sync()
rather than the autosuspend version. 

The others are a false positive (the one about the timestamp channel)
and the iio_trigger reference count thing that is real but needs
some work in the core to fix.  That one affects a bunch of drivers
unfortunately :(

Jonathan
