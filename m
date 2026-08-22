Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39F137750;
	Sat, 22 Aug 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787418030; cv=none; b=ljHp/FfVTQGkPnEGFnplxMYiOpqW31y0jPHWAWtD4JZaWozdxCSrR/xODz1qTXdqq9pL7POEjVhXz7+8+7zb0zhHfd0ErIoJP1yRHUvn1NvQ2vCj7Qc01sunjHn3iNA0D8h08MaWYZWMwFSVLpjRfLu81xiF7ThozJ6x5QS2gIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787418030; c=relaxed/simple;
	bh=MtnB9l/KP5iYOj5jmxqjez/3NhKPOJo5xJPYjcgNkuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmtW2PWPgtZ0S0OrdG9TMYu0uinCvXQLoGB+/rP7O10eT16+sZUh6t/ZMfSJFyt2CUcVL+ctw0aTD9LW8vaiD8M2vtPIOarjru2R0eE+fG7sLgOSi2hABrUdwM/PAR4uNhBBR7wjiEU29RbS9PjJ0mpgURU/AngyC7DtFb6WABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qkds8baX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qkds8baX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VDb4qU+OUP/SfcfDdg5bSA4/21fc8YQn2UsRC0Iy+VM=; b=Qkds8baXr/Li/yxPUYFUiiHgmW
	p8a+Txz/uWm9orI2gP+BBEuv0U86bOTLLCnvrXgiW6IP/JPPquR+jrYhSERcUETIMyp7eIcg4RrNG
	kYldQYSWoeW4NQ1ih7EDscTpiCJ6sjx1yLx0f3pMEgC2prGoHR2ZK9q3BNYUq52bqlAcpM7BuWyH4
	B15kUnFMZdLQjSt2W6C41hbhR2d/rdQM3xcDGdxrBpYkWFdgMNZEpIWxwSWIJbe6AIiWU+q7CWoLg
	X2d1llxIho9b21no/6JxviZmkxibyTmgopLphySHfVpVgvBJa3Z9iC3p1eHLyIEjbnKXWU4uq1ImX
	T3/J/Yzg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxp4q-0000000Eg7i-3IDU;
	Sat, 22 Aug 2026 17:00:16 +0000
Message-ID: <a1eb791e-64b5-4602-8b5f-afe1ac15b7db@infradead.org>
Date: Sat, 22 Aug 2026 10:00:14 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: iio: Correct ADXL380 filter descriptions
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260822073653.54545-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260822073653.54545-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/26 12:36 AM, Karl Mehltretter wrote:
> The high-pass attributes were described as low-pass filters and vice
> versa. Correct all four descriptions.
> 
> Fixes: b6a097a9af00 ("docs: iio: add documentation for adxl380 driver")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/iio/adxl380.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
> index 654d4c0e84a19..a1c249dc2e51c 100644
> --- a/Documentation/iio/adxl380.rst
> +++ b/Documentation/iio/adxl380.rst
> @@ -39,13 +39,13 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
>  +---------------------------------------------------+----------------------------------------------------------+
>  | in_accel_scale                                    | Scale for the accelerometer channels.                    |
>  +---------------------------------------------------+----------------------------------------------------------+
> -| in_accel_filter_high_pass_3db_frequency           | Low pass filter bandwidth.                               |
> +| in_accel_filter_high_pass_3db_frequency           | High pass filter bandwidth.                              |
>  +---------------------------------------------------+----------------------------------------------------------+
> -| in_accel_filter_high_pass_3db_frequency_available | Available low pass filter bandwidth configurations.      |
> +| in_accel_filter_high_pass_3db_frequency_available | Available high pass filter bandwidth configurations.     |
>  +---------------------------------------------------+----------------------------------------------------------+
> -| in_accel_filter_low_pass_3db_frequency            | High pass filter bandwidth.                              |
> +| in_accel_filter_low_pass_3db_frequency            | Low pass filter bandwidth.                               |
>  +---------------------------------------------------+----------------------------------------------------------+
> -| in_accel_filter_low_pass_3db_frequency_available  | Available high pass filter bandwidth configurations.     |
> +| in_accel_filter_low_pass_3db_frequency_available  | Available low pass filter bandwidth configurations.      |
>  +---------------------------------------------------+----------------------------------------------------------+
>  | in_accel_x_calibbias                              | Calibration offset for the X-axis accelerometer channel. |
>  +---------------------------------------------------+----------------------------------------------------------+

These changes LGTM. Thanks.

Although I am a bit confused. When I look at the adxl380 driver,
I don't see any of these device attributes.
The attributes with these names are in other drivers/iio/accel/
drivers: bma180.c, mma8452.c, and sca3000.c
Can someone try to explain this, please?
thanks.

-- 
~Randy

