Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67AD19C54E;
	Sat, 22 Aug 2026 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787358091; cv=none; b=mFqWie+m+14rripvFOu3B0W7HKaaQrjtLHE/OidZH8fLIZy5R72OBARMJ+2gsDgoIKOdnxpH4UllcXBgEyHwZaoaJwZwTjRk6QePR2nUaMAU1SxwmJnuaST0R8wSjkFFFp6KYh5ticpf2PQAyr4YgKWyLRy4leXN0mrdbqz1sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787358091; c=relaxed/simple;
	bh=MBB4Y7LLYNDjY8KGDb1XT+5RpjW0wmIV6xyJxflWm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7A1gaBFRtnR4+EIoSLI92GZ5VgAaMpcjWFerSrhexupgmnK+t8ywYZRwwTT3vMfPbE0XxAA+vMk1QHxkviscSQ3qKWVOIMyhAFErL8AMsDEq9bT3RjSVKMelcseMFUKfda9H5x0Kl+zIqhvcOxQLQX5ZeySu5OSIJMIt0Ru340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+rB8+Ua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+rB8+Ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1C41F000E9;
	Sat, 22 Aug 2026 00:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787358090;
	bh=4HRXDBwdtlKnJ05J03V1SL20yum1NoWsJSQHstsQI4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X+rB8+UaZDAQW/1yEidX7VIBoU8IjneINmjE+eEmSFjea6wSX2MTq2rwIEbo7kZ8D
	 RXgTWOJvNL4fwK6bc8WJPOpBhgMEckLmZYbhtuveKYz+0NtZ/RIU8jrHJsFRKE+DTu
	 GRrfWpF2CTy+qxwDFcUarsqVZnEcgsYh6g7KjZ6mWV4GXFFE6mt+THBLe2C5eVu2pa
	 6hGoiaf6JWUP+NW4ZvjLsx19eeLbclRPrHkIQRrYbugaEh4p/4J7Ts6NXggXnuwNnz
	 eoNfRm5t9xBobkbT3SNxSk5bSjML80I294vuyh96MI4UGJ1g1U1Yebsh07tT/fNsvN
	 0yFa8gkTYI1AA==
Date: Sat, 22 Aug 2026 01:21:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Shengzhuo Wei <me@cherr.cc>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl367: reject out-of-range FIFO
 entry count
Message-ID: <20260822012125.2330b7e7@jic23-huawei>
In-Reply-To: <anwqC4tczcdnmF1u@ashevche-desk.local>
References: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
	<20260812-adxl-fifo-v2-2-86bea20faf1c@cherr.cc>
	<anwqC4tczcdnmF1u@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 11:08:43 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 12, 2026 at 03:58:50PM +0800, Shengzhuo Wei wrote:
> > The FIFO entry count reported by the device can be as large as 1023
> > (the low byte plus the low two bits of the high byte), but fifo_buf[]
> > only has room for ADXL367_FIFO_SIZE (512) entries.
> > adxl367_push_fifo_data() passes the reported count straight to the FIFO
> > read, so a count above ADXL367_FIFO_SIZE overflows fifo_buf, a heap
> > out-of-bounds write of up to 1022 bytes into adjacent memory.
> > 
> > Rather than clamp the count and silently drop the excess, abort the
> > read: a count beyond the FIFO size means the device is returning
> > garbage, so the data cannot be trusted. The message is ratelimited
> > because a stuck device can raise the IRQ repeatedly.  
> 
> Aren't they already were discussed in linux-iio@ mailing list earlier?
> 
> ...
> 
> > +		dev_err_ratelimited(st->dev,
> > +				    "FIFO entry count %u exceeds FIFO size %lu\n",
> > +				    fifo_entries,
> > +				    (unsigned long)ADXL367_FIFO_SIZE);  
> 
> In majority of the explicit castings when printing a message they are wrong or
> unneeded. Use correct format specifiers to begin with.
Even more odd when it's casting the number 512 to a long unsigned.

Applied both patches, this one with:

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 67b317eec035..a597fee61105 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -789,9 +789,8 @@ static bool adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
 
        if (fifo_entries > ADXL367_FIFO_SIZE) {
                dev_err_ratelimited(st->dev,
-                                   "FIFO entry count %u exceeds FIFO size %lu\n",
-                                   fifo_entries,
-                                   (unsigned long)ADXL367_FIFO_SIZE);
+                                   "FIFO entry count %u exceeds FIFO size %u\n",
+                                   fifo_entries, ADXL367_FIFO_SIZE);
                return true;
        }
 

tweak

Jonathan

> 

