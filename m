Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617406;
	b=HJ/aj6+Rk6ZTjNXfvMkc6/7kZfnAVDcB0Ld6oYRsIWvQuJhs2ZlKskt9Dv64P/yIuKHl
	 EtgjLPwAqkLmGNXmn8PHUMCS5UNHkTjN38Jt6PjZcJKiSFfyvZd7/cGf1JxxpX4Q17yZy
	 0f/7nnvpljI3R9RaYReNpw/Dho+brd/5E8DNkipvsLD1Lr1fphynW1WsiWRM8Mw3W4ecC
	 JhZwOj6HbTFu4km3cmSSjWVXGRYyuqfAAvmihS5/7U/VUcF+oVeqgzoIy2FZ8HHjTjO7z
	 zlJ9l5iXA/t189FhVGzvZr/R5pI7qtA/WuhS4w3e9VUUfOh4jmBtqcMMsXBMWdqz11A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617406;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=886ZKv8oxKzplQMbNQYTLWafnECEfQfG2glOVPBt3mo=;
	b=tMiDrSFoAi6b0vFdBzD8jwdBmSW+9BXewb9noq5MTx1cResKo+POL+o22GiIqgfmZtaD
	 rnpuUMERYy1cS82X/KSSpmx8FTJ7WWvtf39e6iPX9NLHR+UiUOo6dONBqneOSEPxoM2Hf
	 GiBG1gLW1DbYEojDkhJ3r6+EbTDapVSRPMHMlE+gTIBYuo8nMN/CI/ctnbaAs6sjHz9bI
	 gmuM72a4uP4XTLcQnJAz7ZuM7gu4/ATGMCvUNUxUgxqfYGh9YjKiSggBmAphDK1dlu4py
	 bCrUxZyhwPEh3BbmJkzBMQ8AhpeaLYYP+dVgqJSeRugsGSvoszQXrUbuig7R2nNPnlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQv9rpom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B72606A323;
	Sat, 14 Nov 2026 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQv9rpom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794CD1F000C4;
	Sat, 14 Nov 2026 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617405;
	bh=886ZKv8oxKzplQMbNQYTLWafnECEfQfG2glOVPBt3mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bQv9rpomp1BivT4TZ2O1pHoxYrouaHT5Wi1Ve9W1DZAFH7KdSrfTvRREbxrXNIVTD
	 pUusJJg3s0kjZqOvX4uqgaDCRgzIaeoxPTLxgHmsKrloHeaAkeCM1wdAMt94MdPTes
	 0nl8uNxgZDkjRwmonHJETT2fltwZHxeMmtqIq4ofC9uZj4xX5ALTVT4G9+re0wbahc
	 LQ9t9OcUa89cjrTHzHWglNiLPKtjTWRpFmxvnVyZlo4pf33YcEO78DnvfX8If7GMpU
	 FXoEos3qHVx8aPhWM2/JlCf8hp29bZpzS7p5KlG/iiasK5enz4TqGpdSXBq3BvBK3v
	 B1LohhB1dFWFg==
Date: Sat, 14 Nov 2026 00:49:55 +0000
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
Message-ID: <20261114004955.71c7ed7f@jic23-hlaptop>
In-Reply-To: <20261114002522.34f8aeff@jic23-hlaptop>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
	<20261114002522.34f8aeff@jic23-hlaptop>
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

On Sat, 14 Nov 2026 00:25:22 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 13 Nov 2026 14:33:30 +0200
> Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:
> 
> > This series adds support for the Analog Devices ADIS16607, a precision
> > MEMS IMU with triaxial gyroscope, triaxial accelerometer, and
> > temperature sensor, communicating over a non-standard SPI Half-Duplex
> > protocol.  
> 
> Applied 1-5 to the testing branch of iio.git.
> 
> I 'think' the proposed changes for the fifo handling shouldn't affect
> those and I don't fancy reviewing a mega series with library changes
> and the new device support.  So build on the base of these first 5 patches.
> 
> You will need to provide a base commit for dependency list though
> or sashiko may get confused.
> 
Change of plan. Dropped it over channel type issues in patch 5.

> Thanks,
> 
> Jonathan
> 

