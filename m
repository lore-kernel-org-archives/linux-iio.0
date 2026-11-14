Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615928;
	b=F3SiyczvqQ6yH9EYdyQh6aIdTJU25/jKqSuvG879/QRa0auT4X8e2JmEl7Ew1qUN7iyq
	 6yrnonra4Q9vf0eDo9sn50MLD4B+0+uqdQU+n/A2dYYckbYXDb//B1XWpG11oNos7dYNe
	 o3ZxFTmDRNBhLB8eFDK6dJpG5BwL5bmlxMPW11ifxGCwtOy7tSFY+QrG4l89ilmddPPwI
	 rVoy+TBPD3AdeUXBkgONG5X9kNnFQ8DU+8bWJ+n+4qkoC7QEbbvxPHKlF/pQRPd/FHiTN
	 U7/zJsRiR5E/tjZQl1cGvii5dMjWKOw3luXM/bbUKlmELWXdNJj8VZezcVTtnB5FH+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615928;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R91S7PT8R6hGaHtM8iEhH+rkR3540lu/s98FHe+09U8=;
	b=orrdA9K0E0aG29uaNb8D+PsZxfhwPE9i1Z/ebHMGoQaoXrRVNseAbue90NemeafKalZp
	 fwBI7YkS8Gy65EzZTFysqRtFDrSZT7dyZOsGXQgsKmEpcbB+pXiIK3VIp5LMTIIlHxyfe
	 +aJehc9RQAjwT1jxsX8KjeP69BIhEVH26azF0+DVMuAw+SBzslFROr9cIS6xZSFhuq/LJ
	 QFe2JWm3kZI2vRF2005itzHPUzTlt/y9ufuMHNBWP4dmsgt2PfcOuUBbnvhjidA9iVyBH
	 9MJOimBY/A2F+xglBBpHC0i9nOnV+eByU/dtVP94P/z4QST5KDLkJVPj7CwQ7CbP4gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9cUOb1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C47606A327;
	Sat, 14 Nov 2026 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9cUOb1b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D271F000C4;
	Sat, 14 Nov 2026 00:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615927;
	bh=R91S7PT8R6hGaHtM8iEhH+rkR3540lu/s98FHe+09U8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U9cUOb1bGJNl1IZeha/bLxGDmXpQXtqWFoFOSpd9Vzld7ZCz9sEaZJyH0ILml1RiO
	 0WhxhJpN6/zESuiQRrp1JBy4LtDdFjFWfI1Y0YMPXFwVkSpY5AYrLnQ64TQ6DihpNR
	 b/A3TRic9EspamVGU+/FJXZmP0c2WUKaio1IMNUSgNXhKvyBU7vBGrmBl9FjStgasc
	 oGibEhTh/ZxM9KIpBtIqFgvSYVnSAj895U4lOlrQDEev7CGZyIY4mEMh/3bOxkdG9t
	 wdrn4WYtp20W9vAt4YZ5nY763gi6Qfg32D8Cn/I69MysYqnJvwHSZnpkmT52s52Ghr
	 Bm7tbvxBdIo5A==
Date: Sat, 14 Nov 2026 00:25:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Robert
 Budai <robert.budai@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com,
 Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Message-ID: <20261114002522.34f8aeff@jic23-hlaptop>
In-Reply-To: <20261113-adis16607-v6-0-3f678719942a@analog.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
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

On Fri, 13 Nov 2026 14:33:30 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> This series adds support for the Analog Devices ADIS16607, a precision
> MEMS IMU with triaxial gyroscope, triaxial accelerometer, and
> temperature sensor, communicating over a non-standard SPI Half-Duplex
> protocol.

Applied 1-5 to the testing branch of iio.git.

I 'think' the proposed changes for the fifo handling shouldn't affect
those and I don't fancy reviewing a mega series with library changes
and the new device support.  So build on the base of these first 5 patches.

You will need to provide a base commit for dependency list though
or sashiko may get confused.

Thanks,

Jonathan
