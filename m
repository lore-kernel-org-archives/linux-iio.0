Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48FF2DA756;
	Mon,  7 Sep 2026 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746100; cv=none; b=Um7ClgyPy4vAWHQfYjJOACAcUDkBUA09u/hb89qi7hlJIuFGQtVaocaEj5Bvf8mwP+KywqdwGPWQZPH4s1fDWsf1Q9ZmHVj3yTAMDABOfSRI7dX6hHCVQyinaxqF1r4hcxx87T87yDKMvP1rEFgZs5aZc1nnudrWbkXZNSZmKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746100; c=relaxed/simple;
	bh=xs2ugIzVtB58v5MdayMxyukTl8K7qiDBY1KVOp6qz34=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Q9MnjiLxi3H5La+ACvVnV+HIiwjKBBVlqQfxY1pbBjXSsbWf7LHmOB1SuHvp+HQpY6jTCJ6SOV86PG7H02JPkNWAjOwjRrUfIJZWDPDiUmE36Xfh6bzgU4H3HBN+3Pt+ncLhM9VJmUNGuFHNjmItGweci2ogMk3vQN37H8g1sBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxd6F7Xf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxd6F7Xf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584671F00A3E;
	Mon,  7 Sep 2026 01:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746098;
	bh=XbOsy+BgEoZxD2kuUcAs/xx9goR979fcjp22tui+2nU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=oxd6F7XfieWuQ1TpLzcOM4wDq/du0bRbSuMzuNogMMmxlkR2tsL+TSDhmsE7usfc/
	 T45GEdQIq0JNoFFssVqQeoKvvOB6aoMxlyh/M0ChLu5+EutJgbYRCEakE9Y7Da6dXQ
	 P6hASW3PbpNyx5MlwTsFB962vctp7JMV9RStXfyppC+Za86RHTE79TxHdpQBIT/29s
	 TUWCwNxbW0A7MSunJYIkiF+hXJVDXFgCWokwl7CXWrqZ7givIESqJXux7ZKXkBWft6
	 8ahC4yNEuGjb7fvdJLma0Tu1Wz5gvVsNcK6nVeD+u/k08hyfBZ5X2vx1uYEEp7gMW9
	 fwAzvGpqlUgiQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/8] iio: imu: inv_icm42607: Update
 _odr_to_period_us formatting
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901-b4-inv_icm42370p-v3-3-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-3-77cc31642115@axis.com>
Date: Mon, 07 Sep 2026 02:54:51 +0100
Message-Id: <178874609181.3402141.11177384276502703798.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=xs2ugIzVtB58v5MdayMxyukTl8K7qiDBY1KVOp6qz34=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnhluJnDkxJUW2ITZseZsa486S7TD41vfHKTdq
 UDUbJiADRqJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap4ZbhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiEthD/9XB8CecjGNAsEg8MA4XeJ6rFi3IEBq3S/p05lO/C0ma64
 /6elt1GjxBDcRH/ObBC3GismjT6oeLayiROvacbV+7AVQyBWJzy2QShv4xnUWqoxShx4SuygTVb
 1aYltdHWqtlRo/sVrU/YCux4a6nWFQTwI63SWHDgxdh/BMHjCbEbwHwgtaPLDrx9Lyb7OtYsi3L
 IQ/X4z4ucqO/oJPcnBM3JvbtpyvbXpzicwRIBi77l3Wt2n9lI1dpf4aTrF0NwlaIeQU7DgRv/yo
 bockqGPtzpo7Po3NTMyOvugYPrrjgjKfCWk48M0xlQ3FuYevCr8OKUKmgaSesoRjaDUsIdOU5QY
 jKZlrGMV0VWSmfbGM+YSEArA0yh3Vas2UgVqgKOWvaKUl0YErv05/Dk1RC50IaG6ijbOxnaE9RT
 CEM99OwDhjYhenujibTSZhJNoBBZ+alZRiLvd+QbwOO4H0X7O5yww+OE/NBLbO85VNOVyCtQS36
 9JEsEdKsJ4SiqK3ukRXRYBhTEoqwMvEGHW84SjYXuCNfFBtaYNiNTz2/aj2pba+/Yxd+QxjIrKE
 SonRdaxuqxsVsoETMeTaWpqkDTFK/nxw5yuSFWB95i7GdZ94OiyugFFqhAAloq7fzDFWDHXKChn
 BcjSv+s/JII85rjSWXmCz0EcCO+e4uNltH+Yebw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Update the function formatting for the inv_icm42607_odr_to_period_us
> function. This enhances the readability of the function and drop the
> unnecessary comments in the array elements.
The description doesn't mention the change I don't think is
beneficial.  Which makes it even easier to drop that change.

Thanks,

Jonathan

> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
>
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 4d51b0da1aa1..fa85cf738cc0 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -62,16 +62,16 @@ enum inv_icm42607_accel_fs {
>  /* ODR values  - Note Gyro does not support ODR less than 12.5Hz */
>  enum inv_icm42607_odr {
>  	INV_ICM42607_ODR_1600HZ = 5,
> -	INV_ICM42607_ODR_800HZ = 6,
> -	INV_ICM42607_ODR_400HZ = 7,
> -	INV_ICM42607_ODR_200HZ = 8,
> -	INV_ICM42607_ODR_100HZ = 9,
> -	INV_ICM42607_ODR_50HZ = 10,
> -	INV_ICM42607_ODR_25HZ = 11,
> -	INV_ICM42607_ODR_12_5HZ = 12,
> -	INV_ICM42607_ODR_6_25HZ_LP = 13,
> -	INV_ICM42607_ODR_3_125HZ_LP = 14,
> -	INV_ICM42607_ODR_1_5625HZ_LP = 15,

Why?  We often put all the values when they are mapping to hardware
register values simply because it makes them easier to compare to
a datasheet.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
