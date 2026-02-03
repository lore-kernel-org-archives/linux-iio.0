Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA51A9FBD
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078450; cv=none; b=BX7LrXIP3OuVP/4m1SffT7p1r3jljec4keRp36Pv0PMhO0V8RClfDxh961CL+J7ub6GyITvTgk+yO+U/CurwpkH4clEBHJk2zSWBOsF+WI9kKLCm701fYLnvXEfExGzse8uH/W5WQL/LwWeDPUdQR5BMetKF8exn9l0uugLqpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078450; c=relaxed/simple;
	bh=X1dKeOc/P6I8oUv7+a1KPUZSaAiGr8VMKbdizFMZGjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ/kLMX11JxE8AL4EZcJnYlaOFSIKSpe+Q+FOB9+0H/hyiS5tr/TUevRga6AYHRpbrLdmxN+KtHo3cxFcWSdMINFCRJwUJMRT93GkCNV8RUWdWByNakuqt+1/8SxrPsztvI8pxH6j27iCOnY85rQ8d4yNGLrksOecFMdXReLH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfHPJtjq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfHPJtjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95317C2BC87
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 00:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770078449;
	bh=X1dKeOc/P6I8oUv7+a1KPUZSaAiGr8VMKbdizFMZGjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HfHPJtjq9EBXemCJ0NiQ87EkcaNo7owb5eh0Wg0pQpohNtwf/Jc1dT6Em02ZF5WId
	 zx6v7ycU3VOmXT1IyRQ4Z+5CX0TsCpiq44YwfNPK9Zp8zH5rxtKooMrLdpWLHsSh5Q
	 OQpR85vfFO7HMA8u25zBxXGEKE1+h6rnVCjnXfTGz9GWp5ay/woje3mhjSdJ8eV0gp
	 Bc/U6ExenCI9pwfuGtIfl6BjGqEUvtOQMeq40dgu5rFvIn/PuCnGIEYja2tEPAzzmv
	 E64dTUoOmW1/9pdm/w0aTe32zxb0bk7jT/6uVPNlJeUqhxLPPN6LO1Of0lOIgRF4SD
	 +RQSYYW5wNhmw==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6481bd173c0so4393826d50.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 16:27:29 -0800 (PST)
X-Gm-Message-State: AOJu0YzgaVn1eWopBDcWCFJjCjdVbqdRyyBV1mWE6VAkIyPwcUAZJ1vO
	NYe/ILkEDYB2C9ztVi12Ep3pYbu03j448ags3BStThKuhS+Dwh50hGs9jaoVl7jd3hN7rtW7D2B
	W7zpCaBKtu1BNchmN0AmMeynxBNA4OGM=
X-Received: by 2002:a53:ef06:0:b0:649:55f6:75c9 with SMTP id
 956f58d0204a3-649a84b96cemr8220578d50.58.1770078448972; Mon, 02 Feb 2026
 16:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202110304.236320-1-jerrysteve1101@gmail.com> <20260202110304.236320-4-jerrysteve1101@gmail.com>
In-Reply-To: <20260202110304.236320-4-jerrysteve1101@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Feb 2026 01:27:18 +0100
X-Gmail-Original-Message-ID: <CAD++jLk=TxX-zMOudMTniydopMFcvWONBMahSFhmA-7CD4-xKQ@mail.gmail.com>
X-Gm-Features: AZwV_QhOz72IXajNn806oefglpTpz4rdxYpe3f6YGHPcLGcouAU2fnPFNQ-6dFg
Message-ID: <CAD++jLk=TxX-zMOudMTniydopMFcvWONBMahSFhmA-7CD4-xKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: gyroscope: bosch,bmg160: add
 bmx055 gyroscope binding
To: Jun Yan <jerrysteve1101@gmail.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Cc: linux-iio@vger.kernel.org, stephan@gerhold.net, hns@goldelico.com, 
	jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 12:03=E2=80=AFPM Jun Yan <jerrysteve1101@gmail.com> =
wrote:

> Add the device-tree binding for the bosch BMX055 IMU (gyroscope part),
> which is compatible with bmg160.
>
> Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
asheet.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

Same story, post to devicetree list.

Otherwise looks fine!

Yours,
Linus Walleij
