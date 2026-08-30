Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C788481B1;
	Sun, 30 Aug 2026 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788051595; cv=none; b=OXFDGc/OocZvUCBHGxV+6Mv0XDRKOs6pDX+5jilxojwRl6PChBFMIp/PCdl9XoKZrgVUIu48XAW0ZzJVfFdOpBbE4YfdEvj/GhBBRmsA5bFknIPRd9nL1SUPO0bbccdUbzMX9LU5wJsJRfDHsrkDmLC1Ivg2Dohm4bPl7U3V1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788051595; c=relaxed/simple;
	bh=EyB1xNFMYQ2Ew4bqHcCjB4Fg2/pDw+DsZwOOQicwQoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMiZ0UdkaaEjUKQEgwmYvdZjnM6dMWncV57FZgLsi+RYyHf2m/CfDcWsLEpkdsOLW723G0tBU8F7a1Ax8toXsnMh+ggPiVfV7dC8nhJ0yY6zzzcvmf+FBMPTbCsz2OWnTgWrm1TpZqtR1KmkW99c4BSHV2TwPGDaKnE/y400rPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3WOhWoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3WOhWoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A491F000E9;
	Sun, 30 Aug 2026 00:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788051593;
	bh=KJWnhFTNLrxaJHUUO4alJfw2twP+v9Y67h4I2HwF9po=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K3WOhWoIbZ39AY164GV1dGopB4xLc1TMioIRXRwgrITwZkPCMsbCRl7fmc+k9fm61
	 vQXAYOJCxI/QL7XP5AOKr85dfl1KUQqpevbb3yGYwN7e83t2hAoKpReqMdsYfih6dn
	 nnD4zRhoNmWdfHgU3i2k0+G43Wpfxu46EPgX6+pajDHoU9xmJtxlZ9DZqn/l1X69Wz
	 sMpxWb9KDF81qwU4DFBlOClSB9WlC4H/CzhrsF+KADuAvkK+TlvGMUC6cBxSxymTH5
	 jlEeARcT/47p0VKRs6joBbWe/Qa9++OTUlRu+2hdUoQmgZIPmn22/NV3RbLWI7hC2j
	 ODJkJFZT743Wg==
Date: Sun, 30 Aug 2026 01:59:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, siratul.islam@linux.dev, u.kleine-koenig@baylibre.com,
 linux@roeck-us.net, joshua.crofts1@gmail.com, ciprian.hegbeli@analog.com,
 krzysztof.kozlowski@oss.qualcomm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260830015947.5635b3a1@jic23-huawei>
In-Reply-To: <178805109906.2786293.17524353371768518972.b4-review@b4>
References: <20260828083119.54495-1-stefan.popa@analog.com>
	<178805109906.2786293.17524353371768518972.b4-review@b4>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 01:51:39 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > This series adds support for the MAX40080, a bidirectional current-sense
> > amplifier with an integrated 12-bit ADC.
> > 
> > The driver is placed in IIO rather than hwmon because:
> >   - IIO's scale/raw model naturally exposes the selectable gain ranges and
> >     lets userspace apply the correct scale per range.  
> 
> This one is a bit weaker as autoscaling is possible (if fiddly).
> 
> >   - Buffered capture support is planned for a follow-up series -- each
> >     conversion returns a matched current+voltage pair, which maps cleanly
> >     to IIO's buffered/triggered model.  
> 
> If you have this ready to post, I'd prefer seeing it sooner rather than
> later just to strengthen the arguement.  A link to a repo would do as well.
> 
> Anyhow, just a nice to have!
> 

The set of changes that Andy and I have asked for are pretty minor
so I would just have made them as tweaks whilst applying.  However, others
(e.g. David) have been active in reviewing this series in early versions
so I want to leave it on list anyway for some more time.

Given Andy's request wasn't entirely trivial, if you have time in a few
days to do a v9 with that stuff tidied up that'll save me a few mins
and cut down the possibility of me messing things up!

Jonathan
