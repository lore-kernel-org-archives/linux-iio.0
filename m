Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100469;
	b=VP8p8+KjrbKfnZgglkFd1BKRoZbg8gl0GDOg9Kpvay4ccA+ABgQeBpXqhFety8xl5A5i
	 wKGzl2XN8orkz2ps/qjcn1r3g4NwmUfFIFrE8tw00d/m5BPuqmf2bKcQdKvKdFfRbtoEJ
	 /7EQZ1XjoxGtFfXlCQS9cb2auHvT4UTLCsIYvU+r75jwVKzhIDgxLKxz+Ic+yIy6DIbe2
	 kaYN3lSUHArexxfPdU+Ls1lBE3htyIBGT3fXQjG1nxrUDVBQHiSHIX0ISei1LrhR7wbAv
	 z2mvf5o1cS3DCf5jUvjN2p1LPSlBOGWVCxzl1OQpJrSHgzd5iwOsKqFaIhqN+3iEbaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100469;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+J8fn8bo1zsLZcfVPVJ7A4AT3JTui3GKdfsF38JLpLs=;
	b=FLdXdut6AV1XlfL3e56CbY6OYgqO9EVsx05ICVKTpLuJS9eRWv91ZiDVyCpL/kf6Hsw3
	 rouG5wjMRf5t/wZ6zZN0brkoIelpHeKhGnrgG7ogLdlOAqzHIAt7bvTSPfcLsHjH7w3in
	 jOD5J4pp6xkB4LJBUnsa6qX5yLvtqpvjq7mPqWMkSfLYdSaITH5EVSDkxTHzzTjaaUAld
	 O7so/YnK/Cr1EAxk97oNj/LL3YmlwhTyUHCnH6Fvm7mc5zkbMcWm725jghboLo01jf7Cl
	 Ui342T80pjOtnrusm7uAtMkKy6dUJ5Q8SDUUKxNecYMDL/tzvp4bWloFAspei74FKnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2Jups21;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802D606A326;
	Sun,  8 Nov 2026 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2Jups21
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECA01F0089F;
	Sun,  8 Nov 2026 01:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794100468;
	bh=+J8fn8bo1zsLZcfVPVJ7A4AT3JTui3GKdfsF38JLpLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n2Jups21xwKNJUBVB4RseJFlwrRJPH2p80u2ZPEiIWEwlhqvk1qnvLVmpc/e9Xkxt
	 O9aLgvWJrxxLL/AcWqHN2ZhteOxOwbB6Q1MvWwP3twYfJ1sBJ4VZhwEaOGYXY8xFGp
	 6BTry1ipiozLxTGtX6VOXd+3m2QppLC9HFp5c2U2PsP4WJSUagqCRvzXDc2QnubhpJ
	 2R2K7XDU++LGwzqFZgVBZ0t/TmvFs+kEBjzYIXHtCzURYXsZbzPx/SVIeQGLj+Rw7n
	 hKwMaSUzBmEpb937YIKaARTr2q/FP2DqbFb5pM8RVUAzHAQ0VonB/z7D+gaOP8sMd5
	 Yc8i+ne2/jdXQ==
Date: Sun, 8 Nov 2026 01:14:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Matt
 Ranostay <mranostay@gmail.com>, Robert Eshleman <bobbyeshleman@gmail.com>,
 Leonard Crestez <cdleonard@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: humidity: hdc100x: Report the available lists
 via read_avail()
Message-ID: <20261108011420.0c0cbf95@jic23-hlaptop>
In-Reply-To: <20261102074700.63075-6-arka@arkamondal.net>
References: <20261102074700.63075-1-arka@arkamondal.net>
	<20261102074700.63075-6-arka@arkamondal.net>
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

On Mon,  2 Nov 2026 16:46:59 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> The temperature and humidity channels have IIO_CHAN_INFO_INT_TIME in
> info_mask_separate, so userspace sees in_temp_integration_time and
> in_humidityrelative_integration_time. Two custom attributes list
> the values they accept, named temp_integration_time_available and
> humidityrelative_integration_time_available. Neither carries the in_
> prefix of the attribute it describes, so both sit at the device level,
> and userspace that opens either prefixed name finds no such file. A
> third attribute, out_current_heater_raw_available, already has the right
> name and keeps it.
> 
> Report all three through read_avail() and delete the attributes and the
> group that held them.
> 
> The two time lists hold what hdc100x_set_it_time() accepts. Its loop
> ignores a zero request, so the padding entry in the temperature row of
> hdc100x_int_time cannot be selected, which is why the temperature list
> has two entries and the humidity list three.
> 
> No value changes. The heater list still prints 0 1, and the core prints
> the times to the six decimals of IIO_VAL_INT_PLUS_MICRO: temperature
> reads 0.003650 0.006350 where it read 0.00365 0.00635, humidity 0.002500
> 0.003850 0.006500 where it read 0.0025 0.00385 0.0065.
> 
> Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")
> Signed-off-by: Arka Mondal <arka@arkamondal.net>
Applied this one.

thanks,

Jonathan
