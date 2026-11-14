Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615689;
	b=pjjvp0zRwpmJbOdx2wyp9ZQXEu+10d6WtNVD4CsrZ6//r3DMmxE4PFv7MsAVBur/k2U7
	 DJlyyIJdEdezsQPKj2MdIJ2qEpGxaN8kNtIbrhlHxHH7q2cYIo9IYc9sZfbwn+gbA+ACL
	 V4GvEd3dhMfm9f3jA9N7O+pfaboiRjb8vwmoCD5R3FrQUDXcB8hNhBKbkeRMK1bZ2dKMg
	 K+BFkdQG7e0zBRXma/vyq3HeZaB91iCqEd7i8ITpvTVHug5OfknURxOUQBBh1jNIaevs7
	 C3aIhj7Uf+xnC8m3FAtfD035g+wNuetcopuAGE58vISXkzcL6E5jLA9v+yHMKw8LroQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615689;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9jnJqepH4Tqqtn3e0pqmMzgDUi7SBDCFkpGSogJI5dE=;
	b=Nyo/eJVXqPevl5e1B5ECr+7VWDjYXbqzeTpEDSY/EOO8shfFftz8orIRd0UQ/GWkuMZi
	 ANuNE+oa5vPcJttx4zVScqNDf3qmaiPqVnHFamYDhujpKWO1uOmvk3Z04g0d2MF+y2jyX
	 Jc9vUfAI2B6SGmjqZiEMST7TIKxpO0qgvCleo1TJYKzA7UTtKj22gKc2JNStbSVk37p4F
	 aIHmMISfcD9h/VsSmrfAoJGwAFMR7rPD7l+0b+dGyEPyn0mOWDxZc3Wv1pTRbgESgfWQN
	 4IilMwoU/9aOu78rNwa7ppf9MBG7xm+AaHIrCAq0xffRpeCsaM/2Ef89V7fwuUBXMWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3FUY3lS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB783606A32D;
	Sat, 14 Nov 2026 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3FUY3lS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699091F000C4;
	Sat, 14 Nov 2026 00:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615689;
	bh=9jnJqepH4Tqqtn3e0pqmMzgDUi7SBDCFkpGSogJI5dE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l3FUY3lSAsDBs4dlXwOZiI2wI+W7IliEjvpsFCdUXzgppXVrDpIl0xIKbTEYqFfya
	 ltxvkR47H0hkWAB4kThcoO/53kgTh8N9DbPAlzWEAv21iqRwt2wk94AfQAH8x0lM3h
	 F8AVPLpEfGeKd+uo/LHq+hRJJ0Nw1JbeiL4cwCt8TImTGo4ZqMHsiyq3MunyHISbAV
	 /1QEyIu3LtM2BDsCgNBMjtxQSxtW0VqrJgfuwGUaHvYFMSZToJHNZWYJmr+UqE4PZ8
	 FxGvxgZA9Qqf0/z7xvf9Yh9IeMhfWyhmnStMm7ptrSi1S/wjCivMfv4P1WeCpcdwal
	 EtOmGA6U+xGKA==
Date: Sat, 14 Nov 2026 00:21:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Sabau, Radu bogdan" <radu.sabau@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, "Budai, Robert"
 <Robert.Budai@analog.com>, "Gradinariu, Ramona"
 <Ramona.Gradinariu@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, linux <linux@analog.com>, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Message-ID: <20261114002118.2b7e1d22@jic23-hlaptop>
In-Reply-To: <avcaMvcntGjnKPAK@ashevche-desk.local>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
	<LV9PR03MB84148ACD16DBA8896A81582DF77F2@LV9PR03MB8414.namprd03.prod.outlook.com>
	<avcaMvcntGjnKPAK@ashevche-desk.local>
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

On Fri, 13 Nov 2026 16:09:54 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 13, 2026 at 12:41:04PM +0000, Sabau, Radu bogdan wrote:
> > > -----Original Message-----
> > > From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> > > Sent: Friday, November 13, 2026 2:34 PM  
> 
> ...
> 
> > > Patches 5-8 add the driver in functional groupings, as requested in
> > > v1 review:
> > >  - Patch 5: base driver - probe, raw channel reads, decimation/sample
> > >    frequency, startup and self-test via adislib, debugfs identity
> > >    entries. No buffered capture yet.
> > >  - Patch 6: buffered capture via the device's hardware FIFO, into a
> > >    kfifo buffer filled from a threaded interrupt (no IIO trigger).  
> > 
> > Note: this series implements the FIFO buffered capture with a kfifo
> > buffer for the adis16607 only, using its own threaded interrupt instead
> > of adislib's has_fifo trigger path. I tested it on hardware and it
> > behaves better than the trigger-based version in v5: the interrupt now
> > fires once per watermark batch instead of roughly once per sample, and
> > capture stays clean across repeated buffer enable/disable cycles.
> > 
> > I plan a follow-up series that updates adislib and the other affected
> > devices (the adis16475 FIFO variants) to use a kfifo buffer as well, and
> > then converts this driver to use the adislib helpers.

For those other affected devices be careful of ABI changes.
I'm not sure there will be any though. Not really figured out what you
are proposing changes! Don't worry about that though, I'll see it
when you send the code.

> > 
> > If you would rather have it handled here, I can instead do the adislib
> > and adis16475 changes in this series, as patches ahead of the driver.  
> 
> As you explained above I think the proper change is update the library followed
> by the driver.
> 
I suspect that we can in the meantime merge patches 1-5?  This exciting bit
only affects the fifo part of the series?  I might speculatively apply those
to reduce review load for the follow on series.

Jonathan

