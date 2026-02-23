Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A577329E44
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866485; cv=none; b=DKfro1iGFVfZYXyGrPX3zsw5kkFOnroZoX0gzxZwT3q/89Uug3V+0ZQ+5RRp30fMV+IKyHd6CuBD3xNgL4hV1h0LlQ6dUlxCyZ9ChHdTNP94hWYIUQPuLgOwVu9GwtB/s553frNWXoHy7QR35LvLiOjFWXaSvoqkGgf9RfWXTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866485; c=relaxed/simple;
	bh=H1kBU7PvbeWb0jc5d6yYTiN/bJJKJ8CR7DyRefl7KNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cup44DTeQ9vJx+uF8NS6R+YdZJOayQ0CxZuA+U1ykj6BiuVCZ0r3dIdU5+FhOehG1LZcOmKHplEKZnG00OmOq+E3eVGqv2fxCOXI43cYnCGEq7FuJpu3JHEqqsSPIN8yFipJdyYlE5/f0Yc9G+HTEhIICqMxVFDf1HrbjohhLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5e0nHvP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5e0nHvP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483a233819aso44188455e9.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 09:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771866480; x=1772471280; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H1kBU7PvbeWb0jc5d6yYTiN/bJJKJ8CR7DyRefl7KNU=;
        b=Y5e0nHvP83uqOQCPssQcpBauQUPCpGxUDhCPepbekGj7elKfNo+Bgl3Cus7fXvEKuF
         bk1VTKAQja1ZNHraoll+nijoS7p5Bo6TLLNchf9tAYRtdisJGpws4QlH97l1TmpwpwwS
         xBWmLEHOC9EPQdlN4Vbgc0W7155YVgZHq9lddfoJpmQ4Z2IvN6wzzA7yi20UU7uwye1x
         FKsBdkVHNKoGt+wkq52SFJxfebeLw3Q94fC2mLh9/bKnL1WbW3Y/7XvQbJbDGSClGpjj
         0juRu3GJ/DPM/XUHksap7tfQtrf/nqammlRzuhf+a0qBl4Qr9T7oMN37tT7WrA8vJgwB
         G7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771866480; x=1772471280;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1kBU7PvbeWb0jc5d6yYTiN/bJJKJ8CR7DyRefl7KNU=;
        b=klLVxBon173g53taQ4qajdd0UzDcCjYGOEsamp+tXsnCrZCH36QyHVj//WSjhVK3me
         B+QdrwBbtTEz8sXRhpMs4UlbR06CF6zqMjuxckX63xClDH3dF4AvWSe3EuGZLfV0EOEx
         8VcTjfPvqCHQkyXLjFOlNpo0R+dw3zAmEQ6iy3/3ca0pEJgVufCPLGzqInEFUQtryFzx
         y2+3gdDcK4vHBuaj3RvSa3qEDE5ofKOJGOb7jdhxj6ubbqqSSL1BajvgPbdy9OIZsYrJ
         ZcMxljFbdT1HozNV4vXoFB3k04KDTZm/o98rSfFmpr88Fnh/dkMYE0iXUC7wG56qSea1
         LPYw==
X-Forwarded-Encrypted: i=1; AJvYcCULT+/E9JTqPeGrgCBXXhgsPXTYuFKIY/8CsHk/hP3/7hFT6CFtWNbIqI7X1Nce5WnSn0spFjCN5P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOzluvQMNuiFeKbipY13mkyvQA8oUBrtmqsT+NNpZ+ZNfhfSf
	qjGQcz4szRUoQE2OyD/PoQ2/lGaao1Uuss3vc+EcKViobKibgM8qekP6
X-Gm-Gg: AZuq6aLTxulzP/6W0RGmX9G7hz7BVxOP36u7Ys26ZpcJXaEx8KhG8WqREjhhitETjLa
	Am9+G4nHZrsx/YR/IxfycV7wmzKHz6xawOpgnqMfXkgPh1k4w6qFWxC6cZ0f0Hq69d0+IqiPOnU
	cLIv6wQsllgAACNWS0pX2a7d2aH7435A+xIfixRJJYNP1egyqY4zHqxzvD8C0C1VKvwOD6ucic2
	eii4B+tjUvzk3DNRZE5FUqYd6mUK6zmMqu7wBoXBxzlOoK3U+fNnwrTHWUlEn2atb5mX/HNxEJR
	/o2f3scck3hPdI8CiSYFDHkDrUqL0rXg5YS/OOI0prpSpw8vQTAl2iXJzcYkCLbHxKY0CjgrSLx
	TFlNO5ydGhmDRStqwV87Hrq3mfccXjEM4ydbNbkgGQPx/EoEoH82ctIEZOcd78W+IGLigRMDamZ
	mbtdHJTFuGQdEBEsG6uSTUlZINFrbezig=
X-Received: by 2002:a05:600c:1d29:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-483a95eb521mr170546565e9.5.1771866480182;
        Mon, 23 Feb 2026 09:08:00 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a430a33esm111835785e9.32.2026.02.23.09.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:07:59 -0800 (PST)
Message-ID: <68fdbc76efad375719547f3b20fcfdee8c34b0ea.camel@gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix wait_queue not being removed
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, 	nuno.sa@analog.com, linux-iio@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>
Date: Mon, 23 Feb 2026 17:08:42 +0000
In-Reply-To: <aZxsyzVegdm1Ex_5@smile.fi.intel.com>
References: <20260216-iio-buffer-write-fix-v1-1-bc08b239f37a@analog.com>
	 <6f5158e3-84e1-4159-9c61-789c2b198af2@baylibre.com>
	 <20260222123756.59273a33@jic23-huawei>
	 <09ea310dee18ba2174c29e078dce00a539a20a27.camel@gmail.com>
	 <aZxsyzVegdm1Ex_5@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 17:05 +0200, Andy Shevchenko wrote:
> On Mon, Feb 23, 2026 at 01:39:37PM +0000, Nuno S=C3=A1 wrote:
> > On Sun, 2026-02-22 at 12:37 +0000, Jonathan Cameron wrote:
> > > On Sat, 21 Feb 2026 15:27:42 -0600
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >=20
> > > > On 2/16/26 7:24 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > >=20
> > > > > In the edge case where the IIO device is unregistered while we're
> > > > > buffering, we were directly returning an error without removing t=
he wait
> > > > > queue. Instead, set 'ret' and break out of the loop.
> > > > >=20
> > > > > Fixes: 9eeee3b0bf19 ("iio: Add output buffer support")
> > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > ---=C2=A0=20
> > > > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > > >=20
> > > This brings the code inline with the near identical
> > > flow in the read path.
> > >=20
> > > It's been a while since I last looked at the locking / tear
> > > down (what that ->info check is all about).=C2=A0 I'll add actually
> >=20
> > Yeah not sure if you remember but I already said this a couple of times=
. In the buffer
> > paths I'm not convinced the check we have is enough. Still very open to=
 races AFAICT.
> > I have it in my list to try and trigger and actual issue/dump on that p=
ath so it's not just
> > theory. Already asked the bot to write some stressor/test code :).
>=20
> Perhaps also a good task for stress-ng? Ask Colin!

I would be surprised if there's a stressor for this :). We need to sample (=
read) an IIO buffer while
unbinding the device at the same tim. It might even be that some real issue=
s only pop for some
specific HW (which provides different buffer knobs).

- Nuno S=C3=A1

>=20
> > > documenting all the corner cases to the todo list as IIRC
> > > there are some non obvious ordering constraints.=C2=A0 IIRC,
> > > in the buffer paths, it is fairly straight forward
> > > as it's just an optimization to avoid queuing or draining
> > > data when the device is going down - nothing about the buffers
> > > themselves involves interacting directly with the hardware.
> > >=20
> > > Applied to the fixes-togreg branch of iio.git and marked
> > > for stable.
> >=20
> > BTW, I just realized we now have an Assisted-by: tag for getting help f=
rom AI. I should
> > say that this bug was identified by Claude code (when bulding the stres=
sor test app I=C2=A0
> > mentioned above :)). So, maybe (or can we Reported by: Claude Code?!!):
>=20
> > Assisted-by: Claude Code
