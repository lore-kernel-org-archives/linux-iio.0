Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967994;
	b=Po25gcPVqoiIcQ7G2gPLZHLl5QUidf/V8k0yOQR6nz0EpUKsyLpPEBiBqeChq/LbP9f2
	 ZlJm76BYHzrRH3n39bgjil9hPHL0WevVMhru8BMAsdKyeyDWO8QcMgqH80OHmL/KLRqV+
	 tdrhiiSJji2gJIR8h9Sec9eOP56k1GEOfxrRpzhS+YAt3wdZK1JbzJl/GaVw8v56RhPxc
	 ErppOiuz36XeLH8pylwzelqkqOnonIdp6j8EVzeWP3OVW52U2Gr6OZ85/q+7+rZ4UMM1j
	 EqIhrsr8ngsXec/wCTOKQpviSswl4LQuatHKxfYyggNbg8CL4aBrCqL/iuvK9Lzkgxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FayQBlNoh1s2kSCFTdjsjVw8B+IVHg3hDI6P1xEO6UE=;
	b=Ep2irGVntE+TxLjHmZOFp9i7ACml8x2vcjrdQa9Kgm/t7/xlMML8zhJKOQt+iCjZHhDZ
	 Xxbt981NIdB4Yu+hvu22ChqV/WKOTL/2VYMTNtJkTaQtpROI3n0pJrkxVJpqvgKoKfGBD
	 oQAClM5VXUc3HK5C/3/JjYBopjmubVw9c0CfMzgm9C1plgjYsYngTOg/k+WP3UwI5EN0T
	 iuRcJnoc3X2Y9a+MWrsJrlHH8tk/1gzJOBZPMslOk24Ddh5rlDGapjsEnbHLiDQa+6MBD
	 +SKirxlQ9JfcLnSqJJ6Xj6YulYdLYhSXN0psQVUwYSO3m+kXSwJ5GCIbNEnUdQGXtTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TX4AIo/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A72606A31A;
	Sun, 25 Oct 2026 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TX4AIo/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F061F01825;
	Sun, 25 Oct 2026 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792967993;
	bh=FayQBlNoh1s2kSCFTdjsjVw8B+IVHg3hDI6P1xEO6UE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TX4AIo/Y0s8/PyQBe1Av/6vBrUbrtD2aP2AG9anoDVL5aAK6jWyQjf1eCUwbTp+0Y
	 3AMeE9Q34RPBlftSRuqMl8cabL0/yawfqMA1Gigt/gcC2g0/no3mu4NBPkDaNCIXFk
	 bLkHLweb6XDCrS86LoMaQ4cYany8NEceHsPKBcptkN+M7CVjmAXRT1KlHJeJXOD92T
	 DMctancMIIQbEwssuuL1YX/G3edgxjQLn1fwkiEnMYm99fwC2ouoxTIK9dJHcBwmUw
	 TnRWCW22LO3TpeFGyMrWtraJ1A7O0mkd8FgMP7z5Oc18o+COobVlGfI2w7QqdVQtxe
	 1zjxblN/tTbwA==
Date: Sun, 25 Oct 2026 22:39:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261025223949.00b98435@jic23-hlaptop>
In-Reply-To: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
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

On Sun, 25 Oct 2026 00:48:03 -0500
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> This series adds support for the FDC1004 4-channel I2C capacitive sensor.
> This sensor can report single-ended measurements of any one of its
> channels, as well as differential measurements between any pair
> of them. It has a measurement range of +-15 pF and a resolution of 0.5 fF.
> 
> Patch 1 adds higher-precision IIO_VAL_DECIMAL64_* formats, used
> in the driver.
> Patch 2 adds the devicetree bindings.
> Patch 3 adds the driver itself.
> 
> Tested with the sensor connected over an i2c-tiny-usb adapter.
FWIW. I look a look at this version and didn't have anything
to add to Andy's review and the discussion that already happened.
As such, marking it changes requested in patchwork.kernel.org

Thanks,

Jonathan
