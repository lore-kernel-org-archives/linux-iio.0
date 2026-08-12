Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811012D6E44;
	Wed, 12 Aug 2026 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786511067; cv=none; b=c5PqeTNnjCwTw5rJewCCXKX6AH/au3G0plDgBWzNNFjePakUHAx1qVdNRbV+aokSHLfabu3mrm/AA08TNMf/wCmA2BWc5TkUX3AiZGX0rFh6VIPB3A+yurQ6dq0N5j+8J/MvUyO1iOhLFx6LDl+urNVgau3MLNBctRi4Gwe/gjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786511067; c=relaxed/simple;
	bh=fvUqixsMmENVtlOJZMvVOpg0P6xWQpGGWYuTbY84gHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihSmb3qsXZtfegUG0MUMLRnR0BHg6GnwfYsYlgKZAComnmshbS5aNS0LOE6MLNH4/JpgP30BpwM7hJAOklkdko+/l7TWtj5jqCvpGnijxkvEd92742+LVuMxPMqEexzuBW+keffzFcZwYQLif+dcFytrM3CU04mDCEYOQee6Bls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGVnY9Hk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGVnY9Hk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA361F000E9;
	Wed, 12 Aug 2026 05:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786511066;
	bh=xIp6Vw8cc/UG25l/s5hyO/zLfoyw8I/uHG2WqSpO++s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hGVnY9Hk7L7T+y0yvmM/rqSna9Tbsuefd4pkEiA2vPIOa60z1ksTnSkAUWN/r9aNS
	 r7JvPVt9aZzc+nlag6vTTmKvRtpZJ0vR7w49dQ8ft1LgsFLoeTX5mRpHx/t3Xh3/Qs
	 Gp/PIjIPPiiMSVRHabx3j1DJRoMCfWZ0mbQWhOdezt96mS5C7/dDC88InagLXXbNqm
	 JsLrXaoJbSbGJNpdqLboY5JmuXAmvSFEFOr6Zq3dTuUlVL9wj0d+b67mnSOOVC9nM5
	 dhufaBQ8bQO1gCbZItccshvgkILOW3AwnFo1KfSReulGlmNUa0NROJKfZD7v8XN8cC
	 ao+JQvKbjMNiA==
Date: Wed, 12 Aug 2026 06:04:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adinata Tan <adinatatan99@gmail.com>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/5] iio: humidity: hts221: report available values via
 read_avail()
Message-ID: <20260812060414.427f7616@jic23-huawei>
In-Reply-To: <CAG442=sRDMfdVZB5GY+f6Wud7Vx8xR3ORN0GWVRVV8NKLVX29Q@mail.gmail.com>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
	<20260808090026.34187-2-adinata.softwareengineer@gmail.com>
	<20260810010943.014d8db1@jic23-huawei>
	<CAG442=sRDMfdVZB5GY+f6Wud7Vx8xR3ORN0GWVRVV8NKLVX29Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 08:22:48 +0800
Adinata Tan <adinatatan99@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks for the feedback. I have checked with what Sachiko is saying is correct.
> The custom attribute was in_humidity_oversampling_ratio_available while
> the current on is in_humidityrelative_oversampling_ratio_available because in
> industrial_core.c only has [IIO_HUMIDITYRELATIVE] = "humidityrelative".
> 
> For this humidity case in particular, would it be better to keep the legacy
> implementation while adding the new read_avail()?

To me it seems vanishingly unlikely there is any code out there jumping
through the hoops to read the wrong ABI element to figure out a possible
value to write to in_humidityrelative_oversampling_ratio

So I think this is in the category of ABI that we can change as long
as no one notices.  For IIO I will also generally take ABI fixes on
basis we actually want to know if anyone is using the broken ABI
(and they very rarely are!)

> 
> The other case declaration will remain changed.
> 
> > > Replace the custom oversampling_ratio_available sysfs attributes with
> > > the standard IIO read_avail() callback. This lets the IIO core create
> > > and format *_available attributes and exposes the lists to
> > > in-kernel consumers.  
> >
> > Sashiko points out that there is an ABI change in here as oddly
> > the driver uses
> > in_humidity_oversampling_ratio_available rather than
> > in_humidityrelative_oversampling_ratio_available
> >
> > Which makes this an ABI fix.  Therefore this should have a fixes
> > tag and be moved to the start of the set.  Please check that logic
> > though as maybe I'm missing something.  

