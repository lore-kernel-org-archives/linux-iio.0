Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774860;
	b=E1mMX7ZpACysVYoimuN8O9IiciiZMRwWRjkmFVHdNDBpXLJRkS96sLTL3xQ0+mhfNZka
	 hZo8g97Dr68Vx3cdN9xNgjZfGM9m5WylS8HtRvfrNJGRsMIB5eLiX/oMV/CsID3ggvO37
	 CUll1O2SovsqOu5S3IenQU80AXV7smF5efP60z0P7p4B2CFv8M4Zm+REGfyj4m2AFgiro
	 17re7ZPJOthHJAOK8qWuxogBJKiQNiDAdPe9cN2/CzDFx4TWP9o6VvfGmKJKPK86CW/m3
	 o5j4C/U3jra+KW2fqCycBUKKmNgC0iX9ENjUI/Ud+MiEU9c+WgFcLo7mPpUSG1EJciA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774860;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0nGt0KgN7ZwITYkYsID+jJGz08PG7bgk+SBDh8jIF88=;
	b=RHogT9b2I3pCKzQz7CD1kY11NeKmI2aFh3c2d4g0AuTyC8QrS3EutkZXvf7E1a8JOGuk
	 KqH7S60sN+Ru/XW5q0XbK26zyE4tZOLpdNeliODJW7mTBc/SDeNxPYxOb24uJTFpfEcCr
	 cQfxJXXx0uH+2sprAcQAjcRmQidDzBFfI6RoQMT+wEYJyBmSPa6gbnWEn/AsD7zyvf2L2
	 5XdsKZLgD+lo33fuN0NHk5bDPmAAhT/6bDSG5lXpE+zSvRJAmjx9+aMiw5C47DNVr/dYu
	 nEYYK2merAmE6mUbzaeZRFmv7U7udlg9Dc2oA0ozSPXIuXOfBAt+4RLh+u8whemHJTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWVdNDT2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0C606A323;
	Sun, 15 Nov 2026 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWVdNDT2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8554E1F000C4;
	Sun, 15 Nov 2026 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774860;
	bh=0nGt0KgN7ZwITYkYsID+jJGz08PG7bgk+SBDh8jIF88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BWVdNDT2I6Vk73xHewDziaQdUL7i+7Wcy7QoU8sELD4SGUV/LqLPt1h0eRNM1zYUP
	 aIpnBwyP5RxS49grL0FB/aFKqnXnxfzXR+rkNqL/0v+oyzbDjjT/h1ZriCssh6dsk7
	 ysttIUEGJoTHeF/l19M3PMM0ma59B1oMLm3CX2NHy+Mi5vbwNqd7ZlLYbwC3uLdD9O
	 6tnsoTSqMVE5Dfy5b89s6uoTDnx/VPhoWvHOeG5Dcoy2mJ/tJU1khRMI+ZCyW8v9Gt
	 PE38ipo/EtN3gMMjnLfCseIjA4AluzPKpms8rrzXTjpG6t3kuFI8uaKW5xfNHRg1J/
	 g0amq3n3z0nfQ==
Date: Sun, 15 Nov 2026 20:34:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Arnav
 Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: don't wait for new
 temperature in trigger handler
Message-ID: <20261115203150.7faed0b1@jic23-hlaptop>
In-Reply-To: <20261115183949.11591-1-zoone.rupert@gmail.com>
References: <20261113230241.82046-1-zoone.rupert@gmail.com>
	<20261114013817.476f8fb9@jic23-hlaptop>
	<20261114083525.11972-1-zoone.rupert@gmail.com>
	<20261115010203.2a939bd6@jic23-hlaptop>
	<20261115183949.11591-1-zoone.rupert@gmail.com>
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

On Sun, 15 Nov 2026 20:39:49 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Sun, 15 Nov 2026 01:02:03 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > > Probe value only lasts until the next temperature result. By the
> > > time the buffer starts TMP_RDY is set, so first scan takes a new
> > > temperature anyway (checked on the board, buffer enabled 5 s after
> > > probe). The probe read also covers direct pressure reads.  
> > I'm a bit lost.  So how stale can it be in the direct pressure read case?  
> 
> One temperature period, so 1 s at the default 1 Hz. A direct pressure
> read takes new temperature result whenever TMP_RDY is set.
> 
> Probe read is for a pressure read that comes before first
> temperature result after probe. That one would use temp_raw = 0.

That all sounds good.  I tried to apply it to the testing branch of iio.git
but I'm getting some build errors (+ a load of fuzz). I guess this
has dependencies that I'm missing?  If they are fixes, then I may just have
to wait until I can merge back into my tree (after they are upstream).

Anyhow, if you can figure out what I have wrong wrt to patches before this
then let know!  + add that info to future patches.

Thanks,

Jonathan

> 
> Thanks,
> Rupesh

