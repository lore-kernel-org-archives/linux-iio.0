Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806868;
	b=IO9dvfTDgt0iN2TCi4VhCoG9wbwa5cz+G1MFVAcqY6cAyaVCQiRP9XQY8Qv/KO9JjGwc
	 QO2XSQUpmu+20tnsN+LQ8ZwqZpoe/aW/XTCm0G1PtC1oaHWJPD2d7Ld5QMelb6dbdLBs/
	 indrz96WpYatzc2ProM65WheZDFFEZu2rb5sb2fkyimgSHBisDXvSs/ozCOvnMaEQsFIZ
	 FtSxHa9PZwEFCOTo8AzRq1wHLPFQrS7ZwAzD2xjzlOkkG+r97O1qI1+znCdlohe17BFVc
	 RQ4wl9vzbO7ZZgjAb0NTDuReKXPQ6ZebMXPvJy8h/477bfL8sMDTWUq9NBefuOn3nzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806868;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A27p2M9/xaIvn+bFCfo3tIVfmmIjJXmwN01Yx2Xqgu4=;
	b=hGCiaU7swohGRetE5J9tfHiaOvF0vWkWbIlJufr0ids4Wo+rqzBTfgHhMrX7Hd7vVAMo
	 fo3ACu8HhXrNL8pw7gXACm24SNzaXbRxE55NpTtzW4OZ3YgrjgPmrEFjTbw0mC9n070ff
	 AxTvODXlEsSk7HP4YEIopkM0G57j/VyIGWsG//f8bDo9JK8H6UEq1nvKFV1akPmgqWhk1
	 cFuPsRQVNAIFqAlYH+wUyqjrb/oZ/LiRV3bF7KlKkGJ0DHIkXO8A/4ccWwaGIAC7NiRsx
	 v+72vFo12OFC2SmfN2S5ouyIZklDlxa0RQPLY9+++lpQbGCmmzrxHgNJ48qAlPj6OjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiWNMkCZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170D606A31A;
	Sat, 24 Oct 2026 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiWNMkCZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937831F01825;
	Sat, 24 Oct 2026 01:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792806868;
	bh=A27p2M9/xaIvn+bFCfo3tIVfmmIjJXmwN01Yx2Xqgu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZiWNMkCZl/LOq5YkPQLykeIcdHFgbjMkjfso9wLOPKN7ZoN81BxqyF9zWXtuyQPrp
	 4G5HzJrJWuPJNkyxb+6VYjvToxadl8ANRQoWoh5dzMXqs75ZOc1RvPPcDf6q0FvTML
	 VexUsockdf1tc9/cNsJfrsx4bsejgHnHxi3Sm5g4vu7fe3uCu6sjcuauqdldj6vJvr
	 JF0VKgNw4LxdbxpiMtYTIGGZ/0uAnbIVjR3zbAkfNtegmYa8UELnZexe3D5fXbS6hD
	 ZsVIJ0ldg4OlcWQyqkrbMsk33YrUCENEaYun2k8tICtwJqDKMMOBfKebc5EgvTyRQ/
	 qEfsiKxJj7ZwA==
Date: Sat, 24 Oct 2026 02:54:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 00/16] iio: adc: ad4134: Enable greater sample rate
 data capture
Message-ID: <20261024025421.5c612c54@jic23-hlaptop>
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
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

On Fri, 23 Oct 2026 19:32:58 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Extend AD4134 support to enable greater sample rate data capture. To achieve
> that, provide control of digital filter type selection. The default filter
> type on device power up only supports sample rates up to 374 kSPS. In addition
> to that, enable interfacing with AD4134 in SPI 4-wire mode that can support
> reading ADC sample data through multiple wires. Finally, use SPI offloading
> to speed up data transfers at up to 1.49 MSPS.
> 

Hi Marcelo,

Series looks fine to me. I'll not pick it up just yet though
as want to give some time for others to take a look.

Thanks

Jonathan
