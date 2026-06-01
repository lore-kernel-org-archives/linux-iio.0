Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41C39021B;
	Mon,  1 Jun 2026 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305685; cv=none; b=B4wZkibfunFt3n6D/Ov9CbzopK2Wimyq5d/7yxjzkDh/RuCvGIF/GGRbfznt8z9SBBvZ6MlrSTRDZ53mF/XkqBPxYE9o1TPdKhLiM6cfkXg+tRQ/HdBJWLYZgwpZ281RJHjKYho8jaEHATEMK0ayLpEvjfoEyXe3kDpaUzWHvxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305685; c=relaxed/simple;
	bh=auAF5Zd2qnn5gsldNA88VTQwjnq8GgXXiOwJi6POC/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEo3ctd0xra+A0E1eGDmmBp6XhcSyE35a0vrsJnhLso+aTWoeMBsGd+L1u7ZB/UBu3398teKswSdfVf+bzf8eorDazFBGPylDMt5qRnxTRgg2jTdfF4ZlgPdcmAURVfCqG1zWFn3xrHEMAYkVA0oPdFFpOCOAg5gfzV1QytJsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMBOMZ97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMBOMZ97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642251F00893;
	Mon,  1 Jun 2026 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780305684;
	bh=zT6Sjt8F9s7eqsMkwTydE5UJsr5P5YGKXUj0wFFLMOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FMBOMZ97wcMRBNrCLjFPSy97SEkuoNIItTTe3Yeoe0UKeI9o1Iz7w2Mydry5Bz8pX
	 c35sK0lf9zUKjNayHPZMQVs+h4yOh77ctecv4YOl3u46jnNG0os7Lb3LC/a8aTcVXc
	 IVkLIcl/4OKtRXVaR4FfM6EboJko4U61xjtmYS5Nq1guqCCMI5ed04jJmyYYdT16yL
	 uxpUILTPKVXB72WLFxu455x5uXl61aEVovye7Pvq5lgN1Wo4KucmpPv63+3JME+Kc0
	 VKzzbLUUdy9qFiqfVWfP7nbjeY6+s1U07bDmIvqQW7rSDQOQjpNQ3xzVoQ93McKgWh
	 Q+/XT1QzS/NWQ==
Date: Mon, 1 Jun 2026 10:21:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi
 Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: veml3328: add support for new device
Message-ID: <20260601102116.3e7dc661@jic23-huawei>
In-Reply-To: <CALoEA-wtEVO0+GaabshH03FLGBJu0JkyQi_FjSETzcAySAKERQ@mail.gmail.com>
References: <20260531-veml3328-v4-0-f9b65d71d917@gmail.com>
	<20260531-veml3328-v4-2-f9b65d71d917@gmail.com>
	<DIX3Y0PCFW9J.14RSKP23REFBO@gmail.com>
	<CALoEA-wtEVO0+GaabshH03FLGBJu0JkyQi_FjSETzcAySAKERQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 08:56:17 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 31 May 2026 at 21:26, Javier Carrasco
> <javier.carrasco.cruz@gmail.com> wrote:
> >
> > Hi Joshua,
> >
> > Just a nitpick I caught on the fly because it was missing in a driver I
> > recently sent as well.
> >
> > At least linux/mod_devicetable.h is missing to include of_device_id.
> > Probably that's the only missing header, and it could be added without
> > sending a new version, but that is not for me to decide :)  
> 
> Hi Javier,
> 
> Good catch, I completely forgot about mod_devicetable!

Tweaked.

Applied to the testing branch of iio.git.

Thanks,

Jonathan

> 
> Thanks!
> 

