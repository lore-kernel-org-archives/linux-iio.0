Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657869;
	b=se0vTNHXy6yMvRUv94RkECeJJJ83/P/lmRqc20oN3EKBix/AzU8/58P1XQ9xG2FADD+U
	 6z7Eg41aNT329OtdweCCi4pW4M3m3MQ7XaKwT4/SFb/6gz96Ve1tnecVoaZOXl4qDWasi
	 U5OtreNiEpojmaLHNqFS9CQ4ic2rNjTxc6OfVCh6Fq/6u/XJfHsUQljLvzCVCiKC9Li7a
	 AJMQrqImHbL36HyFbjzvsVzbbPJ1feyrLHDmWmc8FVe+7gsIsR9IVCs5z6AywfOOhdadI
	 P94Bc5qEXB/66fDupaITYAR+wr7hvpaixfWvcWgV/05VR1yXepUKQpH786OR/+rb1hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657869;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1LoOI02nUgf322enYv05Hw1vZImTbwLOdnlR5QXFbCU=;
	b=ZAQu8YviEYIXaLFIR/BiYRhCdMuq1Xims8jNVoYEaeCUMOQ9rhE2xVPFSxxXs2z8gWWV
	 alzNE4Y3wQYrUzleq48HYP5QjN3hUbgKsluEW0UoCEanSpMOJp94avwfqBnqQHWM/NZx5
	 nHmq+uy9M5M75TMJEEafBbpGfcUYBEnoExKbP/SmDS1J5SQ1e5P67U2aL9Yap2jupnZuD
	 KJcCBRIAxIMzMIiZUnDkL54N2eiv4jxKrDC/U34lrNIKXLF9efkRFLhafUrZKXZT/1g6D
	 IZtM8zIhUDokszGIT610ukp1KVlMtfBhKIWbe8aOjO39hOrt10fw560mKSMUppN/2Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObgOMNj5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17729606A327;
	Mon,  2 Nov 2026 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObgOMNj5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43001F00A16;
	Mon,  2 Nov 2026 22:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657868;
	bh=1LoOI02nUgf322enYv05Hw1vZImTbwLOdnlR5QXFbCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ObgOMNj5Lbd3V13//0LFm+utOm/JdVKk7AxgGFlxRn9SX1kIYeKyER2zPJe58+5XQ
	 ViXIdVRafeXa46tlIjLul/LH+U6Ul5GI+w/XunHpEIo5vCsjwSPUA807unl2WMxoqU
	 4l1HPGgjK/4Zyzs97BO/kAGr6KLrnOet/GT4vsZeIBsQT4EMFiEhRuChIuy//f3Mie
	 X08I1Qu/SZc8e5znS4ck/mQSOyJTDXaZFANax1+bymxWpu6iGPWi+AeWQbABWOibSd
	 iLtJg2zv7JVP31v0DmlEpG/z39iav5Jg8N9gs/+O/Y2G4h+EIa2kGCHzqFEEDBLb3X
	 UA0tO/6O2ynZA==
Date: Mon, 2 Nov 2026 22:17:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cwweng@nuvoton.com
Subject: Re: [PATCH v3 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <20261102221744.4bd13ae6@jic23-hlaptop>
In-Reply-To: <81173139-a43c-48a4-97c7-0a82de158b3e@gmail.com>
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
	<20261030031501.130290-3-cwweng.linux@gmail.com>
	<20261101005312.1ec5e393@jic23-hlaptop>
	<81173139-a43c-48a4-97c7-0a82de158b3e@gmail.com>
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


> >   
> 
> Hi Jonathan,
> 
> Thank you for the detailed review.
> 
> I will address these comments in v4.
Hi,

A couple of process things.

Most of this didn't need a reply at all.  When you agree with feedback
and plan to modify the code, keep any description of that for
the change log of v2.

Also, reply inline to individual comments. The reviewer has probably 
forgotten most of the details of what they commented on and so
has to do the tiresome step of reading their own reply and then correlating
that with what you have at the end.  If you reply inline as I did during
the review, the context they need is right there.  Keep to tight
focused comments where you want further feedback or disagree with the
review.

...

> 
> Regarding the one-hot scan-mask handling, the MA35D1 hardware itself is
> not limited to one sample module at a time. The EADC has one SAR
> converter shared by multiple sample modules. Multiple sample modules can
> be triggered together, after which the hardware priority arbitrator
> performs their conversions sequentially.
> 
> The initial driver, however, currently uses only sample module 0 and
> performs one voltage conversion for each buffered trigger. Therefore
> the buffered interface exposed by this version of the driver supports
> one active voltage channel per scan. I will make this limitation
> explicit using the standard one-hot scan-mask validation callback and
> use iio_for_each_active_channel() when selecting the active channel.
> Support for using multiple sample modules for multi-channel buffered
> scans can be added separately in the future.

This part would have been helpful inline next to the comment it is addressing.

> 
> Since the scan layout is therefore fixed to one u16 sample plus an
> optional timestamp, I will replace IIO_DECLARE_BUFFER_WITH_TS() with a
> fixed scan structure containing one u16 sample and an aligned timestamp.

Jonathan

