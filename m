Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168872;
	b=Qef2OjnmirA4rdA7EKKkOdNCLWSwIgjJyalSnYTB7LM4PKiFav9YIhXJvWIzdCiK8oh7
	 yOjxFHJsS6yX3Cdcm8KuQLGrYL7Y1chNON3xLS1j5Xl+REyK/zfVEcLWjd5Q5eN6tZwFG
	 KSPXeiXzAP/7dpyW6NigQKFOnmiGgQI8hl3tOu+/dkDX5/PsT6dk+HRqGdoHtIKiqogog
	 s9VDpci/hAt4/Ed5+q3GaAn+AV06XCBmRVKVgdpTXxzBhJhUbOx1fVaSCSx8xhg9FgaRO
	 ooyg3DC9X+0QkN1+zoo19BSIzaQ5zqRCBGQYVfTmwo7jgEqDpvz4III24orHA0K67AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168872;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7cmD6RnKiIbHGKNwDGy/SglYlUMQ7sGAc4wq8Hssvz0=;
	b=rfSVSadVNp+erkvh61pgXKkUYNcrA4PE0Qwbsv5X/I0YEFGBycc0rgCbsllAbpG5avie
	 QAP8j90XntCuOX2HM9R3Qt1CaIIUTqis9Dh0V0MOBTE6TqJAOtS1mjBSffDFgwYOkExU5
	 +bzLukqHTHubM5DcanH7k6Rx2Uvi+q+CmQe/uNEG/JtHp8Ukx4ZPCvdDlEZVptwh6fo+f
	 8o3j04jJmz/Dai+v4wF0M19rL6nz7rvkV3vqG540o9OJST4pbJvwX/5s0jSR6AJygkrTf
	 MSpO2IgDDZMt9mnnjR3WASxOdTf802foV1VmU9RGWnrjTu14p6rvEiQ8CKUHR2XV8PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/QC2o0v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37064606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/QC2o0v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1271B1F0089F;
	Sun,  8 Nov 2026 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168872;
	bh=7cmD6RnKiIbHGKNwDGy/SglYlUMQ7sGAc4wq8Hssvz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z/QC2o0vY4LFWra3ZbH2nM2XI6FFtHeVXwvA1irgbuNvdKlPncApS9Rn5mbt0P8YC
	 GAWL13Zcr5kPlBNirAF3Is8h9H42Vjy5Up96K5Z1VeATH25nm7sOzLQJP6G4vWWkP7
	 5qATh9IBQvghZJL1ipJ2g5QrADo5HXvDH167kikGexksj0jHA18NKMvXjnj/jegXFl
	 L6yJqktm2uVcNCXO6q+BxbK3Tj0JbWIS8VkqyxX2OkN7910KdZ9AbZHFNc6DasNS2V
	 exHVE+vznaZYH8QOyKiMx1DDSCfpXQXZ1eyIMUXxtWbnFBi40IeMtLImDFEI9lsNTu
	 M7FnOhX8JzVMw==
Date: Sun, 8 Nov 2026 20:14:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 30/39] iio: gyro: fxas21002c: use
 iio_push_to_buffers_with_ts() with explicit structure
Message-ID: <20261108201425.0c7a9248@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-30-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-30-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:48 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the s16 buffer[8] with a struct containing the 3 channels
> followed by an aligned_s64 timestamp, named scan.
> 
> Correct the channel array type to __be16 to match the declared
> scan_type.
> 
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> which is a structure within the iio_priv() data.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied 29 and 30.  Some fuzz due to crossing with Brian's runtime pm
work. Just line number changes so should be clean.

Thanks,

Jonathan
