Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3750C221FD4
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791160991; cv=none; b=t3sK+J1JC86t8UPokD8k5EYU6v1kw/u/oLzLGiK1XfzozyIVM9LOkoHtYQ0Bkcp5mPi/d8ffnPUn2CcczJm1td8PDtwa6hWjysHDG0c5eML1Ankd2ilJcqgbc0TYo+8DNHjaLKanwq2TuYFXaqdeOdHhx92vfdlbVNFVK7BIiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791160991; c=relaxed/simple;
	bh=cJ8dfAUymUi5/b4KAsqaDEF0/Kqegqnkf0HQS5fuWYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQopLwBSclDrWwdLB5betPPOOoz7bSj1RJbOuY7m3kNk9M/X8OqaqdiGxjU4wadCjg/JB49RJnzvjdaZbUshB0WgIzPG7rsD398OpSBPuLfrdXYEnm47sFINZ8ORiuyTOV9Fz1o8KPVcS9wAEhEzcpN5+FUlPIEeQIoBHta6Uww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRyWkFYZ; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRyWkFYZ"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c52caa3045so179447137.3
        for <linux-iio@vger.kernel.org>; Sun, 04 Oct 2026 17:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791160989; x=1791765789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JnCZgK6LbunIjGmFBSscnbMfeG5EqkEuWOG6i+CFlcI=;
        b=gRyWkFYZYirjoNRocFXy8Ydb3hEWu99h4NHqjxSMUcFsNiJWrvTx1juVd/NJZXjj1w
         e2nVpFrtI0gGVOTia9g+eNHG96BsQavqN2+rXX2b+cNxv2ARk9c87bj7vPbavW4Mb7Im
         yjIZ+XlYUzinBaAhckO5nfeDYmY/audGRo/VviANEU8/pU9Fqzu1DgE6DXxTjdsAO6fs
         W8CUR2QE22ziKrydwQIvTeODtIeSGVFSy7jJd+xTdtkxZ9Sc7Ua/eHTrzYqysl7gWPZ4
         Ftx4UClfZ00gktBN4FkNQvqHEdwCVnLS/3pCu0jx4LNMuCyyzUqenAG6nPrwT+vh8Skf
         Z3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791160989; x=1791765789;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnCZgK6LbunIjGmFBSscnbMfeG5EqkEuWOG6i+CFlcI=;
        b=X3yHfgNsjPDaAKBctqdqtrLcLC9hm5tWnHSZkyxK+ktJaUqeqPOhquMc4yroIbyULR
         29b8exjn4q7soxxeGaJX8Ct8KN8Anc03Qpt74pVilg9beUEd/bTII78ClaAv+uV/oLei
         JtXLWgkOx70bBxYEU42VWjCSGZRXMAxpxWGrgw2pyo3zulZmWxOtT07GNYpyDdMYVB21
         hoeeD11j7IoJgFgt99jNtpRK+CsU694MSyF929forb2YBgmHFG4L0JU9gL3FOxqZU+5m
         JcWZvcCWgJ1o81nG3YVUB1dbJw6f8cA8LU13UKvY62GkrqSM4rHUytJX3W/3lIcJBThx
         4yTg==
X-Forwarded-Encrypted: i=1; AKwUvBxQMDSkqow2RAJ57nw2nVQ/ARPI0IJ5mz/QSEO8NTetyV1rTSPk1DeAPfcF4UuX+sHlbAyd48kxLcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKC0rHMKAhwbzRA1rWA5A2b0q0wtSxueh24Sw+TB3H6tkT51fuw
	SR7Ka1xJ6RQy12uMM3CG6vT+Ur5x8tWdr/SLBretdvvzw4WLTFkPSGWe
X-Gm-Gg: AYBFou1waY601d5DAGvTcBRFD93s+PviaojvzQCaBKaOHUeujoLldcQF4AwTbCxFr2E
	JuX2wK6J/QBF8IE50JZSk4WIlLeG+2PvXknmgNLEzO/v4ob94n+GZ9MIlSrwogwX41xhetIOEUo
	kMpTcUuR9uZbAkfkQVLHq0m1sbTWuix9r4nTIVfyKfA978JCxqziXcglafrXUo91MYo4nGVdpXc
	z+Ycx/auOJEKPRF9ku9wNy11nAKgClDzzY90ayA6wimMjVjR5WeAcFNUdIvcM7r7/tEXTFD3U9U
	j6awAH/dho23+7ILBSHNXew95gg+dg2t2v/WZYs9Ou1fctbbBiyvszB1rjWMZO5pJ0JlEH3MCrd
	cSznDaCV48eFrd25wlM1shvXvsz8e3sfbK/iT2YDjaW+px4LrFSQL1NcWjAihMvP/oaAt4xDDZ5
	L/nW0o6BKRyf0lzR9C2Y+gLxu3Q8Z8ZdZ9LBryHIRcadwCb/icJJE8PkpZZAOHez077q541Z4d/
	S/rRw==
X-Received: by 2002:a05:6102:41a4:b0:7b2:508e:3d40 with SMTP id ada2fe7eead31-7c244b9b1d6mr1275758137.15.1791160989089;
        Sun, 04 Oct 2026 17:43:09 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c10002f77csm8504297137.10.2026.10.04.17.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 17:43:07 -0700 (PDT)
Date: Sun, 4 Oct 2026 21:43:20 -0300
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
Subject: Re: [PATCH v5 4/6] iio: imu: inv_icm42607: Add support for
 ICM-42370-P
Message-ID: <asLyqO50cSIil_WW@debian-BULLSEYE-live-builder-AMD64>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-4-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-b4-inv_icm42370p-v5-4-c65281b745c9@axis.com>

On 10/02, Kanak Shilledar wrote:
> Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
> accelerometer with built-in temperature sensor. This device is almost
> identical to the existing Invensense ICM-42607-P IMU, but lacks
> gyroscope. The device supports I2C, SPI and I3C. Implement only I2C
> support for now, and provide support for raw sensor reads via sysfs.
> There is also a built-in temperature sensor but it can not be turned off
> similar to the ICM-42607.
> 
> While at it, change so dev_err_probe() is returned
> when the WHO_AM_I read fails.
Not a hard preference, but the WHO_AM_I error path update could be a separate patch.

Nevertheless, looks mostly good to me.

With ID tables ordered by compatible according to Andy's suggestion,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
