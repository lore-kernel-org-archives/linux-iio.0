Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156F358D37
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795145; cv=pass; b=p8wsvRqMcCGd5uY85+dsSAhwv+VR1kBr0ln4fcj+07e6N0MJ89F19qmqaV+V+yYeDZbSeTnU9ZndXug0QP46GmoGJl3dShiIPvBOkOtXNYqULCbqiaM+S6+U/7rxA5JMSjVhqrP56A6Chhc4tDV2cFkVRZVI+no+RatX2A5+MKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795145; c=relaxed/simple;
	bh=/fumETcNXkuUwjtt22qhIyHNr/QRYw4UJ/joNiHRbzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y533Legkpp2lumtYMyWyLDTbDmQB/Ch/ojEjq2BikPxTnmCfmgDnUtpQjEKW4whKjFQTET7FPlUS2ugXr/ouxepqrv9XJzY1hH2rZ8YRFn+azJ27TkgCHD3+vYHRa+oJX1NC0GaEWXscuKjFK/QNAtTMrBhT06xqQq4j/GCN+5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyGolsVQ; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyGolsVQ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d4be94eeacso3217699a34.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:19:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771795143; cv=none;
        d=google.com; s=arc-20240605;
        b=D3mbssq7jwxoxRKh84W5ABflxnUcqh+C51LSKhdNXFTsi+9QpMX11tO253pW29lAU+
         TwhEC0OayRlR90n+QVshoAPwDKKlCkLFR5S1ToKmMXkIgd/dQlg8Pffda3VsRgq53G2g
         VEpIfD3HmlGP3B0WTAU7zZGZVQ4U8pYXAfl/JH5/Zydtss46dSuiqSKCPORM4nCznfDw
         rQwLLWpcnD1Sc5xzHa/PK+WfGM3bPHicpJruC8bNUGouyMkEFVAlzPfi3yk1r7dUOV7z
         WIpaH3AwSC1YCXj6Qv6oFe+5yadQOso9xMOL0OJEtST1RhadYlkb46jghH81DaT7ODtV
         /IAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QvIx/fEzvA6zsjBjDW2OV3fYoRnp3OniXSL6cVSezps=;
        fh=HLWS4yAmrlunaXCawVE09I8Wd77YfZbG4JwlO4HkHpI=;
        b=FDSAg4GBI14NsTBDvJSHFAoZhDKTDc7fGpV89Mm7FpsyPyKRTvjESF1PfINmpI4sl4
         sREMMbrng7GP0P0LjWDvv34pr4RnegAe4vGAONcd/gR/5xBfj+4/7jrjVW/p9KG3Yxlj
         gotVOMTP6/nsHwBrttrss8Pt9ohb0nTPtx1AaycFNxIEYbdLOHFcCPH19Q3Cy4TAkIWH
         sf8vC+TDkFg+a1OmjQGRbySsuUqpDQB+GYwPYGsrGPOQq8k9Y2ZxbaHsSl45quOhLAvc
         jI/QBPwVjRwygg84l+FomkAgjMIhUtsL9u3DnWjrbk0A2LAyQCQ/7NoA08r1ICF+ARdL
         la1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771795143; x=1772399943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvIx/fEzvA6zsjBjDW2OV3fYoRnp3OniXSL6cVSezps=;
        b=eyGolsVQ+2Nks17JUHuyOLA4fRfdM+RZGr6/GYgVvQxvy0uAvx1gjIQL05ATlPwoeu
         3tS53Kn0mtEvO2rWEERC1eAbjSkfX42p3HJsg0xZjN3RaVyob3qlG7BL70CzkjuWq8kv
         EOGGKR0lkkyqo13T+wsop+OHEplQkWTvZ3iPNv3+3J6hJMcay08kWmPDfavO8jC89KA2
         IhDZ5a8/tv5bJoTWG06Dk5p6vFB/x6n3fRgzL4yTXOGWXEXaCnFQCZzN/BVNIkLj6/HH
         ffvJ9DuK39WvaylzGzH29+1fjWmqTEvIXk3zWWfO+Bb5//Fh6Bsfj21afr+3ddBg0WGT
         GGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771795143; x=1772399943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QvIx/fEzvA6zsjBjDW2OV3fYoRnp3OniXSL6cVSezps=;
        b=PG0t8yiRhtQlaVpYO8jYcFs0fUmI3o4IN9Dx3xfRv050PGjiWAIk54oS4NR0YfIsVc
         dQoTogkYI3jLqV964cQoxeUOOUBETdYrwjxnFRiyDGmOXQ+VzrlAICMHYqFa0ZpJrBA0
         ESoK+rBEPmtFc5V88FKJ4h7re9/KNo7j6CIY8sFX6bsr30wJuakuiTPT539RW1FInuwu
         Pb2iv7xUT7gvV6QlD0D1D9zBAVLtKLHnVu/GrPorSPfgl/6W9GfEjar1jM2VzkTOYx3H
         Tvf9f/gCLRe68yppDeWLJRtvUTQATyUf19pgEqF6j0EPJHZtRILLQm+Y+4HDDE6GYjT8
         m6dA==
X-Forwarded-Encrypted: i=1; AJvYcCUvwSrpU4lwYNR+6Mzqbbu4Q5P8gFicfbfwcUGwFGpmEDmVBMjHl4MhfboB/p1BaQS0Lb4k/S3GwRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+OCisvL3EgS1ejk3fXBBpADsMNYEUBMHqkfOPyE/yztRxfMe9
	M1QlJbXBi3Nfk9LnKlhYTpT9ZmBNrPf+1CQVLWpdr/t2+Ae14kTytTLc9PhzNmYHg3zRjyncUMS
	f/u/8HeFoP8YofcWtf2GR7q0OjI7jSPU=
X-Gm-Gg: AZuq6aL2VRI6MKhzsZcbjrN7SmbFDstp3xBDXFFJNrKDl6VbXfFNN/df/8MOrFWgD7V
	KZpicDw96ZHUXBiu09ppeeOFSo96G40dMjcctddCNrAcQv65h7dyrTAkkDdt/QoIvKWNPttf7CS
	b/LOMWVHcbZElKvIF2dU705vHroQAvX+8MI5ySwLfNuVylqhpB+m943HTkM8W1AO3TPZUTRVN1f
	gpzrV2zCKYOFiRM2l89Eq4IHI9ppjYBTqrhmXaPUXDbJ9qDaxHccfSqpihq4sUxsb/UXtrmo6S/
	ueAetECPEhG/j6OyuQ24EP9CWJQ2gaNAjT7ZU+ta
X-Received: by 2002:a05:6820:4dc6:b0:679:95da:975f with SMTP id
 006d021491bc7-679c44729e7mr4047776eaf.27.1771795142983; Sun, 22 Feb 2026
 13:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com> <20260219213549.59645-1-rougueprince47@gmail.com>
 <aZgLutMih65WdesN@smile.fi.intel.com> <20260222135054.2e2012aa@jic23-huawei> <20260222135836.3f8d7a38@jic23-huawei>
In-Reply-To: <20260222135836.3f8d7a38@jic23-huawei>
From: Rogue prince <rougueprince47@gmail.com>
Date: Mon, 23 Feb 2026 02:49:12 +0530
X-Gm-Features: AaiRm52FgPzIDp_i4J2DFw_9083V4MVDEtX3GT16trReeZrpsadngWaRv8nTRj0
Message-ID: <CAPC4XCQQcvsyNQKkU9vLdRaJSQRbVxa5DGExoBv5H1Vt4fChKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: frequency: ad9523: fix checkpatch warnings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 7:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 22 Feb 2026 13:50:54 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Fri, 20 Feb 2026 09:22:34 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >
> > > On Fri, Feb 20, 2026 at 03:05:46AM +0530, bhargav wrote:
> > > > Changes in v3:
> > > > -Patch 1: updated macros to use '(x)' instead of 'x'.
> > > > -Patch 2: collected reviewed-by (no code changes).
> > > > -Patch 3: fixed vertical spacing and broken indentation.
> > > >
> > > > These patches address several checkpatch warnings in the ad9523 dri=
ver.
> > >
> > > Do a new email thread for each new version of the series.
> > > Do not send a new version more often than a couple of days.
> > > (The very bare minimum is 24h.)
> > >
> >
> > Series is simple enough I'm not going to wait on Michael
> > giving it a quick look (as the driver maintainer).  Still
> > time for more feedback though given I'll be rebasing the tree
> > anyway on rc1 later this week.
> >
> > Applied to the testing branch of iio.git.
> Pulled again.  Just a small thing I need to check.
>
> For sign off we need a "known identity" - see submitting patches.
> Mostly that's a legal name, but if people are commonly known
> by other names that's acceptable as well.
>
> Given short nature of your SoB and that this is (I think?) your
> first upstream commit I just wanted to check that bhargav is
> sufficient to meet this level.
>
> What counts for this varies a lot by culture or country so if
> that is the right level of identification to use that that's
> fine, just reply to let me know.
>
> Thanks,
>
> Jonathan
>
>
> >
> > Thanks,
> >
> > Jonathan
> >
> > >
> >
>
Hi Jonathan,

Thank you for checking! Yes, this is my first patch.
Actually "bhargav" is fine for me , but if you need my full name on
signed-off (i.e Bhargav Joshi) then please let me if i need to send a
v4 with updated signature or it is possible for you to amend the
Signed-off-by line to "Bhargav Joshi " rougueprince47@gmail.com" on
your end while applying.

Best regards,
Bhargav
