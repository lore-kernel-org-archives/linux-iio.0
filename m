Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1851F03DE;
	Sun, 16 Aug 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786904852; cv=none; b=n3eijZ5kKXUU8Bx4INs8sLPWPBadmXY7LDbX5hito7CARmrHm7u8KkpaXVYlpDcieFoIGZ7QDFrwvZHAT3CczidLkHA0aqXqkw/aajr73LyccWOo8q5A5ciQX+ayYA0xmfqMcF7r8jduPIM1puCMluO2oMg594lI/N3RRDlJRgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786904852; c=relaxed/simple;
	bh=W2HS4ig+qeYYFDRO/z7t9ulATpLIx6x8H9MtkwYZUDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+Ce9fRoxQwvV8lf1AoQHoWkAepu1u7pKbumquni/06udcORgsAWZv+TUJvxwUUCEbRadoqcJNFjeGbCGo2AcuvYL3Jb+F1Ej/6UzIY65bWtIKULGTls2U8BPHE/NmsYD+x98wtthnnd/9TLMO37qq8wGS7UDHk3Ppg1kHjpSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR7Yax5V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR7Yax5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2871F000E9;
	Sun, 16 Aug 2026 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786904851;
	bh=MwAca75HMn3DfWB7XmMgYlGyKppnD1YTtZWTR+MljdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RR7Yax5VvrrqiDVxGq2nJ2/mRHWBr5ZweXPlt3rjwWkgW6LNussVI32lACr+wY+wW
	 wwOHC+i12d77ETmOGOwg0Y7oE5unq76IfGdB0qr+Cw4HwGrQmkvD4jRqlpZ4YPfMrJ
	 KnBx8h35cuBHdqBjRO4V/ip4Yx/EauWeBjXPxANVgRUzX/88ZzVg8ekU4dwX4fWoG2
	 AKLj9Qcap5RYxMVBUJs6a4ZqiaGYbMcjL+0brWtJjL2TCwaghWa8wa8HGSbH+DPVDz
	 OAQNlq8lRXp8Td/50XMnIXP3KHt/IDvO9PFyGWe5aRYYrREhBA6d9ph+Z51zzdpaei
	 buCrMTBiV3ASw==
Date: Sun, 16 Aug 2026 19:27:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 02/14] iio: backend: Add support for CRC
Message-ID: <20260816192725.672c0a83@jic23-huawei>
In-Reply-To: <20260813-ad7768-driver-v3-2-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-2-cb554399ad26@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:56:55 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add a backend operation to enable or disable Cyclic Redundancy Check
> processing for data integrity verification. When enabled, the backend
> will generate, verify, or process CRC information for data samples
> transmitted over the interface, allowing the host to detect corrupted
> samples.

The backend is generating them?  That seems odd. In my head at least
backend is representing the host end of the data pipe.  So what this is
enabling is the front end (the ADC itself) generating the CRC and
the backend either just passing it on, or potentially checking it
for us (the verification part).  So I think I'm either misunderstanding
what this is, or it needs a rewrite.

Jonathan


> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  6 ++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index f7a4be8ec320..792c2333b057 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -886,6 +886,39 @@ int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes)
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_num_lanes_set, "IIO_BACKEND");
>  
> +/**
> + * iio_backend_crc_enable - Enable the CRC generation.
> + * @back: Backend device
> + *
> + * Enable Cyclic Redundancy Check processing for data integrity verification.
> + * When enabled, the backend will generate, verify, or process CRC information
> + * for data samples transmitted over the interface.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_crc_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, crc_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_crc_enable, "IIO_BACKEND");
> +
> +/**
> + * iio_backend_crc_disable - Disable the CRC generation.
> + * @back: Backend device
> + *
> + * Disable Cyclic Redundancy Check processing. When disabled, the backend will
> + * stop generating, verifying, or processing CRC information for data samples.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_crc_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, crc_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_crc_disable, "IIO_BACKEND");
> +
>  /**
>   * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
>   * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 3f95ed1fdf9e..eddaddb47bea 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -133,6 +133,8 @@ enum iio_backend_capabilities {
>   * @filter_type_set: Set filter type.
>   * @interface_data_align: Perform the data alignment process.
>   * @num_lanes_set: Set the number of lanes enabled.
> + * @crc_enable: Enable CRC generation and verification.
> + * @crc_disable: Disable CRC generation and verification.
>   * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
>   * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
>   * @data_stream_enable: Enable data stream.
> @@ -189,6 +191,8 @@ struct iio_backend_ops {
>  			       enum iio_backend_filter_type type);
>  	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
>  	int (*num_lanes_set)(struct iio_backend *back, unsigned int num_lanes);
> +	int (*crc_enable)(struct iio_backend *back);
> +	int (*crc_disable)(struct iio_backend *back);
>  	int (*ddr_enable)(struct iio_backend *back);
>  	int (*ddr_disable)(struct iio_backend *back);
>  	int (*data_stream_enable)(struct iio_backend *back);
> @@ -237,6 +241,8 @@ int iio_backend_filter_type_set(struct iio_backend *back,
>  				enum iio_backend_filter_type type);
>  int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us);
>  int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
> +int iio_backend_crc_enable(struct iio_backend *back);
> +int iio_backend_crc_disable(struct iio_backend *back);
>  int iio_backend_ddr_enable(struct iio_backend *back);
>  int iio_backend_ddr_disable(struct iio_backend *back);
>  int iio_backend_data_stream_enable(struct iio_backend *back);
> 

