Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C382750FB
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949551; cv=none; b=T+mfF9viMA5FloOOftp8r8MaOFHFPxTsTKP5mH98/X0gBfigjwjxCVqGkLyskpubvb7JzoLREgkqHZGnpKKXJDXxsaHqisyLumhkHLKbejDZd3TAx0GuLsD+aPFEsW/joXP59TI5t+rFIU/WO3LpVLefZxixqrzd7tXbP5UG0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949551; c=relaxed/simple;
	bh=DrgI1F8SEYTmctsgluocodIMEfPVRwmpLPwyb/AG0LM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y72+nAZsX+4bdY4OeTj9cuKRpbCSPSG32wB9hNJs1YaOQAA184EmSp2XDmexECF/ToJrOXa7F/bOrCW8IQVzYIc5M3gnNHRbT1uY0+qYTQDtiRQAroFSmW4Q/oFkzPJOL1i+S0povBOPktKxkgS0UJpW3565STUUuT7vBdKdNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx7N5Egd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx7N5Egd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8909C19425;
	Sat, 16 May 2026 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778949550;
	bh=DrgI1F8SEYTmctsgluocodIMEfPVRwmpLPwyb/AG0LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xx7N5Egdr6OsO0OGCvbh+FfV3bICU0Jv/OFVJpz5qkO+xqV6Dznh6m9jgRkl1KD/y
	 V4YCBtRuSdcpki/OJNAyBBfecrTPHausWxrWi8T24HyQlvhei6aTMWOba+nlvYyY0f
	 hp4tB0ldWrjcHTnx5+QX/mPcJlHBqxYJ2HNJJ5jgpfbJvDzubU7wQzjp8PMwwWF0+6
	 vMGGZo1KsiMiDKFju8Bw6B8kL2UdEM7fqxSylh81HJQBsgU6Cdtc6MQTLl99c+6co1
	 GVYobKDnJOb0b4apeogqLAUK1IZeAdQuJMzfVM9RZjKJs077y/KWe0Hlz+jiew4LRG
	 pTBbfReKFvqng==
Date: Sat, 16 May 2026 17:39:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 2/2] iio: light: add support for APDS9999 sensor
Message-ID: <20260516173904.503259e6@jic23-huawei>
In-Reply-To: <d98bcb3d-21ae-4b62-af63-48fad4301f70@baylibre.com>
References: <cover.1778659152.git.azpijr@gmail.com>
	<f389419972fc790a25b6041f1212e15f155804e2.1778659152.git.azpijr@gmail.com>
	<d98bcb3d-21ae-4b62-af63-48fad4301f70@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 10:28:47 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/13/26 3:10 AM, Jose A. Perez de Azpillaga wrote:
> > Add IIO driver for Broadcom APDS9999 ambient light sensor.
> > 
> > The APDS9999 is a digital proximity and RGB sensor with ALS
> > capability. This driver implements the ALS/Lux functionality using
> > the green channel, which uses optical coating technology to
> > approximate the human eye spectral response.
> > 
> > Proximity (PS) and RGB color features are not yet implemented.
> >   
> 
> 
> 
> > +enum apds9999_gain {
> > +	APDS9999_GAIN_1X = 0,
> > +	APDS9999_GAIN_3X = 1,
> > +	APDS9999_GAIN_6X = 2,
> > +	APDS9999_GAIN_9X = 3,
> > +	APDS9999_GAIN_18X = 4,
> > +};  
> 
> Giving the natural values of enum explicitly just seems like noise
> IMHO. I wasted time looking for an anomaly.

I tend to ask for this when they are hardware field values to make
the point the values matter rather than just being an enum.
I'm not that fussed though.

Jonathan
