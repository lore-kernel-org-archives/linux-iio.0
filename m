Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4280243964
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791160787; cv=none; b=Rc7WNBbpUwjr91Wwe2ZjU9wmerLkNFgFBPKhQxIeHXMvkqTkh60fGZ3TBxY5cRy05cw968uPAexvv5yPFpNX9tdcC/Wrg9zIFl3H5uwX28lOFicKErueP7kR4IfTbdP5hBhNxRphQLE8h7i4FncPfKUiCF05BGgmJfHu1+MpY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791160787; c=relaxed/simple;
	bh=FpAYV6dwtieSe65iB/tgTKFYEOT1Q5FcoDQ0+sN+rF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up0GZJEpmR2lwSZErOd1dB3YjCPJFrPnJBBP90lH01MrDPVBvyiFsBMBh65783gDQB/Yl90Bg18DbgFZY8AGQR2uTZWT5IGVymQBanrIHT200HBIWZcMJ5UPyIXfLL+lHMbst16ufUOidAGxqQKpRag2kA/nSEkgPJAMP6LE3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7wMABIB; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7wMABIB"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-988f270d308so803026241.2
        for <linux-iio@vger.kernel.org>; Sun, 04 Oct 2026 17:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791160784; x=1791765584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IU7mqOMMBbfkeNzF2+wDQMXqKtPVHRNICdPeH0QrUdM=;
        b=I7wMABIBl7gK6+ItrTodA3fv6bp5Fpw1KJQsu6ZO+lVOEhD7vBbKruAj5OI8IieYME
         JGuFD+x5AZMdUz6IjYyzOiglt0eDoQ5YHe3tYCKVpbOrJKXU2a37wrxB78h1iodIKnLz
         Ex9gNu64xS1GvPVMx/S4VGZfiAuI0/+GAJGJh6l4RyJxXaep2oLuj8nil3f9lqrwzDFR
         cD0ZbbO2DSQR0cols8J6rafvfv2HTvdHJpOK2zv1joivHgOxMXaABTwc+vsVeGcM1KKa
         fQJFfuNKiV8V3ZkRWbhaCFvbC0i60fQyp/8DdoaUFpbdLyoSYg6gxPoBWttyHieMsKN9
         j2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791160784; x=1791765584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IU7mqOMMBbfkeNzF2+wDQMXqKtPVHRNICdPeH0QrUdM=;
        b=WSl71pwGjxLbx0bHk8+oR//iH9bWESpLPM1V/Iyzqc9k1pwcOqB72jOQ+bjAaEy3A1
         JVXI7WkdbVRTe/rWbH4ewD3h7mNffODCyfF5i0WUcPbdZ+etbztRDyOhNIg4Ac5mR0f+
         M8Xn8Ad2PA0hjX0dqDSu8DszyIq83rRSoMZt4h8vWSDg9+qQKC+Cj1G0JEvKRXkwNVTr
         pCLcOJhQYD0Im9WE7N4MkqeQ59OEPI4G7gCY9Zl2VFb9WT1YIee1fagSb9aI3ps7O47A
         XZQdPSquvYZpVXAkLAsSinp7BXuIvLRLGdmrsg2kP7DcEF8Fhr+XBrAHC7ViM43qpW1c
         oSwg==
X-Forwarded-Encrypted: i=1; AKwUvBxiEEcfC+F+uM0U1wrqbquAMIxDeXXez/XNqw9KAAlzlkSXDK4srP21bTIKIA6rJF4AlZPC4elDrm8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8Y8NqZQlOzGiS2B95LTzdyXfhnGE260MvFJLLf2vcZnF+X5JI
	5NAsoIvZ/tSlHAhZh50Sc0W0pBAUoauADTyQcdBAUOeV89NnOvf+hMD4
X-Gm-Gg: AYBFou36V+sAp8W+SbN/dj/NJlzPE73e4tXbxkANHruNe+aj9kUILRSU6LuIM+wqOGS
	P0cREVionN2/ZMRsa0RwmPEauPY7pqay8WMNvVhZ63MQiqkGrW8qldvrdM0r+buhB7krqjYk315
	+ZffA2RBVztK0y/dkXTPYHZj3TFrem1uupn8IFTRqGU+55YsifsvmVaF2zQCFi4b4R+d3n+7u4e
	pgKn34Re5Yb2B4kD2eSW0QM2MUiSE/sCdVTZlYUOBTJZc6/pGwLbkRFy/IP3h61+xdcwGygrIS4
	/9CisTjo2l+otztzR6/ldciA8yLODAFCV1hCW8TtmVzrHDyKG9JhjXlEEdbBEf5WemvoPFJEdGa
	CLpj2/VOgffzVm6BCzhijIuvhMrzCCMHlg3w7fuQAo6qnlSlKysv/zFj6dVO/NLiTsQP8EVm2jn
	Mz3FUlAg4xDEXrCjpfApp2ORSPphByJbtthlu2unon6z7dxcqn3djwbO8fkFtbn7waw9/pzrlgD
	3vDV3xZLmgNxtU=
X-Received: by 2002:a05:6102:3713:b0:7c3:6caf:bdc6 with SMTP id ada2fe7eead31-7c36cafc094mr863360137.21.1791160784624;
        Sun, 04 Oct 2026 17:39:44 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98c4c9d14bbsm7265834241.13.2026.10.04.17.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 17:39:43 -0700 (PDT)
Date: Sun, 4 Oct 2026 21:39:58 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] iio: imu: inv_icm42607: Initialize gyro based on
 chip_info
Message-ID: <asLx3gLw8CqCHssc@debian-BULLSEYE-live-builder-AMD64>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-3-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-b4-inv_icm42370p-v5-3-c65281b745c9@axis.com>

On 10/02, Kanak Shilledar wrote:
> Update the chip_info struct with a new `has_gyro` property to support,
> devices which do not have gyro functionality. This is a precursor to the
> next commit which adds support for the Invensense, ICM-42370-P. It is
> similar to the existing device except it only has accelerometer. Check
> all operations related to gyro with the boolean.
> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  1 +
>  drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 41 +++++++++++++++---------
>  2 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 4d51b0da1aa16..e4075288247b8 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -130,6 +130,7 @@ struct inv_icm42607_hw {
>  	const char *name;
>  	const struct inv_icm42607_conf *conf;
>  	u8 whoami;
> +	bool has_gyro;
>  };
>  

Might not be an issue but, don't we need to check has_gyro in
inv_icm42607_set_pwr_mgmt0() and inv_icm42607_get_pwr_mgmt0() as well? 
If I'm not missing anything, a sample read could cause the device driver to
read/write a reserved pair of bits (reserved for ICM-42370-P on the next patch).
inv_icm42607_accel_read_raw() -> inv_icm42607_read_sensor() ->
	inv_icm42607_set_sensor_conf() -> inv_icm42607_get_pwr_mgmt0()

On the read side, a simple safeguard could be
	if (st->hw->has_gyro)
		*gyro = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);

With best regards,
Marcelo
