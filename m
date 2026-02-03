Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B90286A7
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078404; cv=none; b=KMGbMn48BGCvdHVKCvTHBvocUhOp7o4g2jl35mGJK2J+EHIaMlJpalksAgXtOdb9bF1C2Hzh5kgohQDiDEcxGidbIoT1ja+R4EBCm4IPdfg0aj7j1w+bcmQzdLwDMhZq8iq0awEMUrPon6j+d9t8pdO9OuOR/OrNw6xHommchRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078404; c=relaxed/simple;
	bh=oYhKi5mxsO5e/z0oz+DnDKp/rk+buFp2HSBmt3L08M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoXbF2Kk9EwWOdkT5KxyTXFtFCQaY3p7WEvNKJpI5UZt+6NVpRc+LPCsQ3yp8DYaer+JCrJxQjevzravfckUsQ6JINUSxDZRxPzAZ9Z6GWq/8Cxl3/rUmDH9jjATPJnyYVS888xsy3Mx8mGDOSGOowCL0+AgyZThUdm9dJmGSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoC94aeO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoC94aeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE94C4AF0C
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 00:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770078404;
	bh=oYhKi5mxsO5e/z0oz+DnDKp/rk+buFp2HSBmt3L08M4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aoC94aeOIqU7mnZzb7IGBWfd6meCMAXwyUxOLJIg87j3CSQhJpApXV6TRzadohc+Z
	 Yf+vH5lbKF3n5UWV/1Yq6nBnr6yGNuLbR2vfa3bZ1RNXxz1cJkz+1OLu9SMzn5CeU5
	 6bq389hA3hi/vYHY8ItrwCtbV0GKzz8O6ZyoxeN+CShT627RLFxnWyuJv9WVTn59wC
	 Ka+HF+R+4UmTh3OxW7MqNcml0tLy6eFLOyoln5RPSO5BSt5fcEJEUG336XtBMOAkrc
	 A0HA7/3KDY74uly+qZrZKJTzqywirQq4g7YXnQer5toxki4P0Pn51w1nEgxITFrGhG
	 vvwJXt77pRNRg==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64455a2a096so4029183d50.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 16:26:44 -0800 (PST)
X-Gm-Message-State: AOJu0YyI3QqeGBBWGcBCNgus3PnAhnno6LiRh5xU7thdTHeuBnu+C/XZ
	0mCJs288ESURHImb5FLWVusIp/1nVEkTHIk8yrBQDD+hqZ95Vgdf6bVNB+8RiSmW4EMDkiIxCih
	FapfhUnIPWFOpdkVzb0QXrCz+067Kq1I=
X-Received: by 2002:a05:690c:708d:b0:794:c60d:5c9c with SMTP id
 00721157ae682-794c60d6fdcmr126737907b3.69.1770078403718; Mon, 02 Feb 2026
 16:26:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202110304.236320-1-jerrysteve1101@gmail.com> <20260202110304.236320-3-jerrysteve1101@gmail.com>
In-Reply-To: <20260202110304.236320-3-jerrysteve1101@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Feb 2026 01:26:32 +0100
X-Gmail-Original-Message-ID: <CAD++jLkFpmpx3xLtha-t54RaWzqUmYsuEGe0HyOsV0kSik0fTQ@mail.gmail.com>
X-Gm-Features: AZwV_QgrGkv7NyUOXMd3__WW6hUWE4EhnAsyhpcaUFKFNu8hckNvHMDV9KXJ7Aw
Message-ID: <CAD++jLkFpmpx3xLtha-t54RaWzqUmYsuEGe0HyOsV0kSik0fTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: magnetometer: bosch,bmc150_magn:
 add bmx055 magnetometer binding
To: Jun Yan <jerrysteve1101@gmail.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Cc: linux-iio@vger.kernel.org, stephan@gerhold.net, hns@goldelico.com, 
	jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 12:03=E2=80=AFPM Jun Yan <jerrysteve1101@gmail.com> =
wrote:

> Add the device-tree binding for the bosch BMX055 IMU (magnetometer
> part), which is compatible with bmc150_magn.
>
> Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
asheet.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

Also needs posting to devicetree@vger.kernel.org so resend the patch.

Other than that it looks fine!

Yours,
Linus Walleij
