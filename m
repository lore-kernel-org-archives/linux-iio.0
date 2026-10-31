Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793488963;
	b=zd4D1RI64TRAXFy8JlP5zD4gZagqhwXEZ7LOcNuXdPWkSN7FhqeYDxf9HYv43Md3oerF
	 vks0wME0rxfcwau2Fwr0LECLJ5eQZtJlCYFsVjOmnrd7yBi/CWvLWmNLhsBOrTpESgyqg
	 1f2WuioK13BFTw6HxaWuAAOLe9iFS1ANMmuLN0sAyTEvZpG/M9d93DLSkgISSwimjVPl9
	 kK1YlEEedFxdSNAoWGkYPN8BEjOGX2OZT44Zsoo50S5g+l3iy++kniucEgnwHkiePmRtn
	 3r5bGbOPVM2dxW0811otUDFCkl8vRFcruBjK8YE+NPvO+zQzsUbussTgCZvNE5/v5NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793488963;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fV4p4pT8b05EDd0cs56pO4nYULVqxq1pTyjlJHDowZs=;
	b=IEUe3DwRJxaX9dUViqHJnN05mfAvsTqNw6r0GqaI3dzneeL4fg94/ICebOOm/DzS9wdJ
	 gmDOSVLGt+r/nWsdaJVRppCYJGUAkvYJplOhPfhDC7lwtCXoRQDSkwpcI6hTzol9CtV+O
	 agoxatqaKKue4gdFF765A++wKSU8eekTu8lr1Ob2qTeBRims2Xq0GIwXwf0RxLvKOH5Jf
	 mMm2yX7EdFZHsicMG0tSIQ2o5GDx/VJJ8UlJTVQz6ovenbrU0lCCtiH//EA/s6N9sIymz
	 +L37sKj4pvP+MkQ+6rnIP691sljVKJ62CJfyKGGPHY3hKqyaYWUM0VkvVLfryKrWjCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRGd+FXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6B606A31A;
	Sat, 31 Oct 2026 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRGd+FXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6B91F000C1;
	Sat, 31 Oct 2026 23:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793488962;
	bh=fV4p4pT8b05EDd0cs56pO4nYULVqxq1pTyjlJHDowZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bRGd+FXdWURld+fqRN4CsUdUD6UDod0512LIhZb/6qETtnlx6HrbhEhjpUDnSAs8r
	 /mftxQ7zYPNV6YIRBf4Sv2osFcQNIgu7iYOQ2tgE8er1d098FqbspZiz4qVTlbEpON
	 iRRawWoSyKaomE6SUP/2fJ5JjIDfEPyR2dKI9H9DtJ+jRh7xHrR/Izldlsn3CZDmAB
	 hyG3U+8DwJy+JmDJQ8kjNFn6O5QcaocxOvrqDgUq6jTdfB65BYW1HycnTtkZI9eCPm
	 cln84FJOL0GCLr6CJ+iguj0zzuaT8dvFDTnWsaaTG1H6nMurTw4BmkFb358Id1YKaQ
	 AkRBy8WnGn6HA==
Date: Sat, 31 Oct 2026 23:22:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Cc: vidhu.linux@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] iio: proximity: Add Benewake TF-Luna LiDAR
 driver
Message-ID: <20261031232233.5dcf3ceb@jic23-hlaptop>
In-Reply-To: <20261031-tf-luna-v2-3-ce403579bb8a@gmail.com>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
	<20261031-tf-luna-v2-3-ce403579bb8a@gmail.com>
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

On Sat, 31 Oct 2026 00:23:30 +0530
Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org> wrote:

> From: Vidhu Sarwal <vidhu.linux@gmail.com>
> 
> Add a driver for the Benewake TF-Luna, a single-point time-of-flight
> LiDAR distance sensor with a range of 0.2 m to 8 m, connected over I2C.
> 
> The sensor is run in trigger mode. Each read starts one measurement and
> waits for the timestamp register to change before reading the result.
> In continuous mode a read can catch the sensor in the middle of updating
> its result registers unless it is synchronised to the data ready output,
> which this driver does not use yet.
> 
> When the signal strength is too low the sensor reports a dummy distance
> of 0, so such readings, as well as overexposed ones, return -ENODATA
> instead of a distance.
> 
> Datasheet: https://en.benewake.com/uploadfiles/2025/04/20250430174501874.pdf
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>

Nice driver.  I'll pick it up once the DT folk have had a look
at the additional serial binding if nothing else comes up.

Thanks,

Jonathan



