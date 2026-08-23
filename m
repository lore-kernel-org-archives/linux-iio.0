Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676F29BD8C;
	Sun, 23 Aug 2026 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507235; cv=none; b=X9CkjlZo6yHhZNCYwTqXorCxhNOtMGbd3K607Jp/M2wNECdQPRSodwGDv5pLT1p8N77zylUZUQIhHnP7FuyCUn0/gxJkmSJkWgWG0CMDq8+xW4QGnvIR4wwYCZUckJ70QDlY0rPMtb9BA/IvNlBHHMEHn77GKmd+vkCbdo7Fz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507235; c=relaxed/simple;
	bh=TeNf06ookgA5TFwyT2G9JQ1FvWBQEnxHZyq6UUc4bJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbwJxFKWsVNVcMIS7JQOtDxY1KZBR7pX0/7O/gmqaIVKV5tmN2Qmy94iR9CKSbl8Stqt2y0PqaIKyozrKfWEGGY92OfRConkoYHlkgP+dxzan3wHo+lb9FQwjY52JyDC+OC55nbP0vIDyPSYzVgwsUIc3BPiP7Sheww1ExiUrgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2RVOlcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2RVOlcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18A41F000E9;
	Sun, 23 Aug 2026 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787507233;
	bh=xWIXHOow0xAi0RxxpnmWp8ONbEwrRcraYhzxuEhH2hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d2RVOlcqhfwIQdF8q4vSyFlTjRSdRPDx+ylHlMWOmFYTlyOb2pY5RvjpSU0fWt9/V
	 iqRPU3BDh+BiVI/F1tDBXWemOTOUZkhCNx3eWDwXOqjYWQoPaAhbgtZIW7QGYBz58E
	 JBE3/8arIB7tRwy+YE21rHs8eIM9GjjGz7pJlb2GIWQpLMV/GFkJo7c7xLVk3nRPma
	 7BvPdjfOejDMQMXQgYKAi5ceiBDRtFIDBePkD5hDzVcXCGdgcwgxbjgckjS1dmXs0A
	 6RPsLYThEEx21IQ451cTHVixb3/KECv/69KkAUrazdDoY+0x56Ec5CyxJDvxuEtVci
	 Z01PpTD+9BKTw==
Date: Sun, 23 Aug 2026 18:47:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: David Lechner <dlechner@baylibre.com>, Karl Mehltretter
 <kmehltretter@gmail.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iio: Correct ADXL380 filter descriptions
Message-ID: <20260823184708.41150cdf@jic23-huawei>
In-Reply-To: <1c0ea889-3a06-4691-a759-0cff624ccc92@infradead.org>
References: <20260822073653.54545-1-kmehltretter@gmail.com>
	<a1eb791e-64b5-4602-8b5f-afe1ac15b7db@infradead.org>
	<32545533-b792-41a9-91e0-5353112cbb62@baylibre.com>
	<1c0ea889-3a06-4691-a759-0cff624ccc92@infradead.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 11:19:09 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/22/26 11:07 AM, David Lechner wrote:
> > On 8/22/26 12:00 PM, Randy Dunlap wrote:  
> >> Hi,
> >>
> >> On 8/22/26 12:36 AM, Karl Mehltretter wrote:  
> >>> The high-pass attributes were described as low-pass filters and vice
> >>> versa. Correct all four descriptions.
> >>>
> >>> Fixes: b6a097a9af00 ("docs: iio: add documentation for adxl380 driver")
> >>> Assisted-by: Codex:gpt-5.6-sol
> >>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> >>> ---
> >>>  Documentation/iio/adxl380.rst | 8 ++++----
> >>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
> >>> index 654d4c0e84a19..a1c249dc2e51c 100644
> >>> --- a/Documentation/iio/adxl380.rst
> >>> +++ b/Documentation/iio/adxl380.rst
> >>> @@ -39,13 +39,13 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
> >>>  +---------------------------------------------------+----------------------------------------------------------+
> >>>  | in_accel_scale                                    | Scale for the accelerometer channels.                    |
> >>>  +---------------------------------------------------+----------------------------------------------------------+
> >>> -| in_accel_filter_high_pass_3db_frequency           | Low pass filter bandwidth.                               |
> >>> +| in_accel_filter_high_pass_3db_frequency           | High pass filter bandwidth.                              |
> >>>  +---------------------------------------------------+----------------------------------------------------------+
> >>> -| in_accel_filter_high_pass_3db_frequency_available | Available low pass filter bandwidth configurations.      |
> >>> +| in_accel_filter_high_pass_3db_frequency_available | Available high pass filter bandwidth configurations.     |
> >>>  +---------------------------------------------------+----------------------------------------------------------+
> >>> -| in_accel_filter_low_pass_3db_frequency            | High pass filter bandwidth.                              |
> >>> +| in_accel_filter_low_pass_3db_frequency            | Low pass filter bandwidth.                               |
> >>>  +---------------------------------------------------+----------------------------------------------------------+
> >>> -| in_accel_filter_low_pass_3db_frequency_available  | Available high pass filter bandwidth configurations.     |
> >>> +| in_accel_filter_low_pass_3db_frequency_available  | Available low pass filter bandwidth configurations.      |
> >>>  +---------------------------------------------------+----------------------------------------------------------+
> >>>  | in_accel_x_calibbias                              | Calibration offset for the X-axis accelerometer channel. |
> >>>  +---------------------------------------------------+----------------------------------------------------------+  
> >>
> >> These changes LGTM. Thanks.
> >>
> >> Although I am a bit confused. When I look at the adxl380 driver,
> >> I don't see any of these device attributes.
> >> The attributes with these names are in other drivers/iio/accel/
> >> drivers: bma180.c, mma8452.c, and sca3000.c
> >> Can someone try to explain this, please?
> >> thanks.
> >>  
> > 
> > The attributes come from:
> > 
> > 	.info_mask_shared_by_type =					\
> > 		BIT(IIO_CHAN_INFO_SCALE) |				\
> > 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |	\
> > 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> > 	.info_mask_shared_by_type_available =				\
> > 		BIT(IIO_CHAN_INFO_SCALE) |				\
> > 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |	\
> > 		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> > 
> > in adxl380.c  
> 
> Thanks, David.
> 
> for the patch:
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
Applied to the testing branch of iio.git.

That will get rebased on rc1 once available.

Thanks,

Jonathan




