Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21631ED8A
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161785; cv=none; b=FgGGlMS1CfHt66hPM4HWk1MPAfIz/WTVBFa/sy5EdFdzgo7y00mUxt//SkSyX/WCZS7Ck/RTVkzsTNt/QQc3BMLI2BvVmxGZZXdnBCooV8VPODrnMod9O0ulsHZ7RM3ZNLrWx/7IffjgQtcYNh9G2cjoPQ/OVrzbhGK9FhcGuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161785; c=relaxed/simple;
	bh=/DENgcYjGI73XTinEBOVeJktLir1+AMm2WJDLIBAhpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3Ei6+biP37RgfuaJ/I4wLD/iDvmwTOEclFLymR+Iu8/m+9oAWphTBPumII/hRAPufSQwHJs+RgkDbp3WGuTNq1sq2WYcD1me3Od6TaFfJ/tnM+chOB5zIfl6J1gkEY88PjWAjxBO2pe32wTmT7ONReawyfoIDlr2ehhz4cqx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVrc54hv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVrc54hv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55875C4AF09
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770161785;
	bh=/DENgcYjGI73XTinEBOVeJktLir1+AMm2WJDLIBAhpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OVrc54hvba4bfrmvNvEP0IWzH/TthZjv/wJjV1w6CvmOAGW//gUxoTsQPGwVIwjYI
	 DWC/ZMETB8XcTT5oeVNZKkrvFO5gLsdq1zBpNB3csGZiJ+OKSoeySGrMYiBjk060c3
	 sxwpeItspeUccvjEqfYfMhZcGd2Ft4trCbjer7r6S0iaBLV2RZtJMIlgFrWgG0Ffm8
	 Ri2tV/h76rq+FaBsookH/O2jjWXHTsbmFT4u77fq0AqYH7eeTB3ONtWnZ+JfucgkL7
	 qnHW6r7o/5xCTvjshCeOvy967bntCwdgnE6P7Q+hsCWFTyBhc6t8hDcSlpRBEh7wRD
	 ZiXfrvK/KY/ew==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649db2b6cdcso493435d50.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 15:36:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMM+f8V8+QKawKgpoB0LhnTh29B4J+1dDDQKgZ+VoLnN3YJi2DFuTy9gv9+ZoQH0MxoSXYQwvLD0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIW9Sptdl4KmaVCfqOVpieOiIPjVaaTTIiAFJdU8sUj8/O4rN
	E4WmgFtsmGU69QqdgmmybfL2Rt7wqMavWgQNYq2FeumPVDFwAKZlDdz8mDtEVMIO1DyiZvaePGX
	9CLIRaG1k0ZzDsxK5mbTehXuzZaEDVlQ=
X-Received: by 2002:a05:690e:1508:b0:644:6f3c:11fc with SMTP id
 956f58d0204a3-649db358cdcmr1142009d50.21.1770161784634; Tue, 03 Feb 2026
 15:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203143946.301233-1-jerrysteve1101@gmail.com>
In-Reply-To: <20260203143946.301233-1-jerrysteve1101@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Feb 2026 00:36:13 +0100
X-Gmail-Original-Message-ID: <CAD++jLkYBCWD4gXmYXSUYgmn76gCpi6=ZwFZZa4XhSCjxMzgRg@mail.gmail.com>
X-Gm-Features: AZwV_QiTjB2kvTFQj4pEB9ucXzUaaB3fCI7_XPTMEtaGL-7OAoGAxnnrcSlf6d8
Message-ID: <CAD++jLkYBCWD4gXmYXSUYgmn76gCpi6=ZwFZZa4XhSCjxMzgRg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: add support for Bosch BMX055 IMU
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, stephan@gerhold.net, 
	hns@goldelico.com, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:40=E2=80=AFPM Jun Yan <jerrysteve1101@gmail.com> w=
rote:

> The BMX055[1] is a Bosch 9-axis IMU integrating a 3-axis accelerometer,
> gyroscope and geomagnetic sensor.
>
> It supports SPI/I=C2=B2C interfaces, and existing compatible drivers can
> be reused by simply adding the corresponding dt-bindings for fallback
> coompatibles as follows:
>
> - accelerometer: bmc150-accel
> - gyroscope: bmg160
> - magnetometer: bmc150_magn

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
