Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065E3DBD76;
	Sun, 18 Oct 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348319; cv=none; b=bY6JYW7707FNtWWYTRQXzvY666IOd23Br/6ReabnLEYNQORM5DYq9Xs+jQkUdQVThH6Sg3zckOPbEfyvESlTeVrTS13cPiH2PeJd4XhZEx7fccH5ubObQAd1jWAika98e8EIsXA+wDBt7eM47fcyQaQQsjOdMl6KPDjgyoxxK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348319; c=relaxed/simple;
	bh=WT67iuxCMGC6fLNCIZBpN3agTJp86DIgv84RKvdjsJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTqkzasphZkWZ8KufCQ03F/zbXqfu6L/5v6aqUS8d3I89gmze8BhzGR9V7Br/p/GMWBTqgUHJtHJf+URNVnMt5XzwJ0iUCzBoApv1/jRb/AEG9GzjqkEEUjq16dcmCZV+xBi5r1EZHlkQKJqdRyf6YnWOD767vUXCEZa1vH/b6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9D5+qnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9D5+qnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6FC1F000C4;
	Sun, 18 Oct 2026 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792348317;
	bh=9VTmGlvh6GWXbZOSkJSpdLmPUXAfpePqwkORPlk+AM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m9D5+qnIuqjTr5cbX+Q1XQ3AQuDZ97IINiP43wdxX/2f5tw9wUPgTVb+Z6S1ZI9hj
	 2/fJPLSykuoKgB8nBH6xz5YTubTQ8QNmwu1IecjPTKgvCOG26SW+mSkPmo8nwfr4rc
	 BbNNmwqAIQFRCiLB1k9mopM9HPA82yH4h9CUS6ClwfYhM7NxJtC4p84PlszfLvLydO
	 6S6SiCT7iBFd8tFOlX5MjCzqaf60WzrueJAikTKScgS/DKDyQMmq1AA2VKEb238aNo
	 OQ+cuSsgcv2bY12JJLm4AqOV5Sw6piofLsfaQhxZq9gnFtOe8/tfYw53bxZrk+/EXK
	 I6vW3c4loeuqg==
Date: Sun, 18 Oct 2026 19:31:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, andriy.shevchenko@intel.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <20261018193150.65ed7032@jic23-hlaptop>
In-Reply-To: <20261014194544.2705-1-m.abubakar365@yahoo.com>
References: <asz4O0zceqa5lz8m@debian-BULLSEYE-live-builder-AMD64>
	<20261014194544.2705-1-m.abubakar365@yahoo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 00:45:44 +0500
Muhammad Abu Bakar <m.abubakar365@yahoo.com> wrote:

> On Mon, 12 Oct 2026 12:09:47 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > > +	indio_dev->name = "sdp31";  
> > Hmm, I'm not sure whether it is a big deal or not but, the hardcoded name might
> > cause confusion if the part connected is sdp32 or sdp33. [...]
> > The full disambiguation solution would probably be to read the product
> > identifier bits and match those against a table of supported devices.  
> 
> Hi Marcelo,
> 
> Thanks for taking a look, and good point.
> 
> I kept the name hardcoded because, after Conor's comment on v4, the SDP32
> and SDP33 use sensirion,sdp31 as a fallback compatible, the way the sdp510
> does with the sdp500 driver. You're right that it isn't quite the same
> situation, though: the sdp500 and sdp510 are identical, while the SDP3x
> parts differ in range. The readings are still correct, since the scale is
> read from the sensor at probe, but the name would always say "sdp31".
> 
> Reading the product identifier at probe and taking the name from a small
> chip_info table would fix that, and I'm happy to do it in a v7. Jonathan,
> would you prefer that, or is the current approach fine?

A question that is more 'interesting' than it would initially seem.
Normally I'd agree with Marcelo that we should be as user friendly as
possible, but there is a problem..

Given how well behaved and discoverable these parts are, the driver will
work fine for new parts that we don't know about (which is sadly rather
unusual!)  That is why we can just use a single compatible.
If we were to use the right name and saw an unknown part, what would call
it?  spd31 or something odd like spd31-compat.  Then we would want to
add the new part name but run into a problem. Doing so would be potential
ABI breakage if anyone happened to be matching on spd31-compat :(

So let's go the easy way and just call them all spd31 as you have it today.

Good question though.  My first reply that I typed out was to what Marcelo
was suggesting then I changed my mind!

Jonathan


> 
> Thanks,
> Muhammad

