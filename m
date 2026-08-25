Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F33C13F8
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684459; cv=none; b=R4H999v6cOKBxJBhd9ketgYKshWSn9wbevT6svcjn7Ux6iBuv92AxRSj9VN4zjUEuvSB00Ny8m9SGTq3QQfQN5S5j+r/WjA9U8eGLmUbgMWuiqNPPkcfV/Ny6UnxINXpvTDUP9Y97V/iB2n92VeJVUIx9vivA2Dr22ShFcltdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684459; c=relaxed/simple;
	bh=PLc+UIp93p1yAKgU0X0rJzRPACg9Dfhzpyfrhe8xu6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rspXR9uY9JZjdtJf+k1QxPg4Y1B86HGEGn1w9l5i9+ZjDJJCtMMsS3+/sEs1FKxNNhdXRD7E/gktNdXL2xB7TXuoE2wUST1HnCWfF8nlal5XhDcXR3oFpDLn4Q8L8i6O73aVG3wCweKuNQGUyweMCP9VXopCaWb9HrmPumJyL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWrnEuYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWrnEuYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AA41F00A3F
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787684427;
	bh=C+gIv3r+kmtnr/z/On3cJqHzwyDLXmtum0pUvLEja/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZWrnEuYIP7QxU3N/fHzw+istcq4ljB0oCbR0MM5aHka/LZEno4yndBoFyWLRXz2C4
	 DLHauUrPjB9qY9pLu4bLYLug1MxnzoUdGWvwSVuikvZr443Xu3I8FrcT4Gw3zFSzdx
	 GcLv/K2+iZ6ELM317d3/yMMW0Slt6yICEy4fzLZJNzre3p8SxhEYg9EmzN4R/Oa+ph
	 3bZ533/vgHi8trjVsKaPj6M2vLOYXpXexHuFUqW4nlR7kfxCSqWcWZJnORvKK16c85
	 Zl85NFC8zSLYoqiz4uMrGFARSwBkc9ADeQRGEKj5drQA0uhUxgWMf4BEek7vYW9cej
	 uFLVvVOF6Ct0w==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c95395230so603331fa.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 12:00:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpSUYSrVdW77hUMRwDXpLKf9d277wbUIeDRRn5fJ31osn+vvk+nANsX2SSnGL80+iP1pkWUke3cR9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nzdbWtAwKgTHsO2JKtrOJ8qPeO81itCRkyXLgW+OwBUt5hdW2c
	ealjpHnI4lUmJBCb7SAnI2AUnNjUOyZZ9PxJYe6hcLCwtpJKK8CLi9C1fAEbiBz/VYN4bhk2H7b
	ZDIIyJH9mKrtiv/ARru3u69I19P6E4yk=
X-Received: by 2002:a05:651c:41d7:b0:3a1:a8c8:2e21 with SMTP id
 38308e7fff4ca-3a1fd67d0eemr1163941fa.9.1787684425509; Tue, 25 Aug 2026
 12:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org>
 <20260813023543.6936b188@jic23-huawei> <20260814000505.GA3919970@ax162>
 <aogl2JvYUnxwr_cE@monoceros> <5b840b5b-f44b-46c3-ac5d-9f7ae0a97d87@oss.qualcomm.com>
In-Reply-To: <5b840b5b-f44b-46c3-ac5d-9f7ae0a97d87@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 20:59:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixXqVG0TSSRFemjV4DdQ3prTyd=+gukLacQ7sOphwGoA@mail.gmail.com>
X-Gm-Features: AcwNN1U7qXf8B0tdFowc617EQ5X-WKcRiKeTesAWJ1eUFNuyiMc7ulgyLNPIAn8
Message-ID: <CAJZ5v0ixXqVG0TSSRFemjV4DdQ3prTyd=+gukLacQ7sOphwGoA@mail.gmail.com>
Subject: Re: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 12:40=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Le 21/08/2026 =C3=A0 12:29, Uwe Kleine-K=C3=B6nig a =C3=A9crit :
> > Hello,
> >
> > On Thu, Aug 13, 2026 at 05:05:05PM -0700, Nathan Chancellor wrote:
> >> On Thu, Aug 13, 2026 at 02:35:43AM +0100, Jonathan Cameron wrote:
> >>> I did plan for this being a possible issue:
> >>>
> >>> Ideal is merge
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git #iio-in=
kern-namespace-ib
> >>> to the thermal tree.  If I'd called that out originally (or a thermal
> >>> rebase is a possibility) it would be cleaner to do this before the
> >>> qcom patch adds another user then squash what you have here in the ap=
propriate
> >>> patch.  Alternative is do it as a merge conflict resolution whilst me=
rging
> >>> in that tree.  If the second, I'd also mention that in the thermal pu=
ll request to
> >>> Linus given it's a little unusual.
> >>
> >> Ah, I did not realize that you had a stable branch with the module
> >> namespace patch. Merging that in then applying this to the thermal tre=
e
> >> seems like the best course of action. If rebasing is possible, I do no=
t
> >> mind this patch being squashed into the original.
> >
> > FTR, this issue is still present as of next-20260820. Assuming that
> > c3dce117333c ("thermal/drivers/qcom: Add support for Qualcomm MBG
> > thermal monitoring") is supposed to go into v7.3-rc1, it would be
> > awesome to address this before the commit hits Linus' tree.
> Rafael ? Do you want to pick it up directly in linux-pm/thermal ?

Yes, I will apply it directly, thanks!
