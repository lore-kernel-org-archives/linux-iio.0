Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DF405C5E
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018012; cv=none; b=FpErvTIO//c0cWpUVKv1RDxRMDV/z3y5eGYgM6PCOYg+yPWo3FJgI/6R+O/+pALzCj4IHFve0g+kt3tzM8IKCKyFCyR264J68KNF7bDZjWoZe6YH9kuPuS3M8jlEQP5FfX3soflx7402cQwNf7li/ZpmvQTrzNB+g324S5Ra+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018012; c=relaxed/simple;
	bh=xvusDt/r+3yHshkqlx92jVDIZsDAlGM6wpILC69a0Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLtCi9qJ2WT1B9xpnVL6k2GyoeMfQZPK5QeOFbvE4Zxp+HxZTzg1RfEpRQmZYq5d8LTdrx8U9F/C/GJecN//dIXt4/aUwGdOqv59nlzeTTZlnpX9D4Vnth8lvav9vP4BnBzrCTsbU9CekcDsgJizhSvK2A9ugSrF3JWuNl9sDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcud9mpa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcud9mpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477E2C2BCB0;
	Sun, 17 May 2026 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018011;
	bh=xvusDt/r+3yHshkqlx92jVDIZsDAlGM6wpILC69a0Xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bcud9mpa4spjMVTeb7jQ30Pa0X3drA61GY3GH1Q+G7BrE9pjgYPmgrKgPeKAsQJUc
	 HCvjOBHW5xdZW+zMF40L83173CophL4ismYkKJ3ykVZGCmGD9c92iPU5gNd90i3ukC
	 gkVy0z4MjLNS6Q6n2zXKMyEjYrgP5ADpIktglNtqi/sU6CKBGbb+tTDFmXAMdalVOV
	 aoHSp/OofuXwGL/4u5A7Xn+YfhNAST1F8+dLkK658jPIvFLkuVQ8ieWOwNAOSLg9M5
	 FUf/nt35hIvJjfgeQnVZHHhz+4EM7okOxQCbBRlxRFQYDXA9mDUZxMihVLuBvVlcBX
	 a/c4AYsgmgyaA==
Date: Sun, 17 May 2026 12:40:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 2/2] iio: light: add support for APDS9999 sensor
Message-ID: <20260517124005.27b738c1@jic23-huawei>
In-Reply-To: <1da2847a-275b-4260-9d07-76ebbb2c558c@baylibre.com>
References: <cover.1778659152.git.azpijr@gmail.com>
	<f389419972fc790a25b6041f1212e15f155804e2.1778659152.git.azpijr@gmail.com>
	<d98bcb3d-21ae-4b62-af63-48fad4301f70@baylibre.com>
	<20260516173904.503259e6@jic23-huawei>
	<1da2847a-275b-4260-9d07-76ebbb2c558c@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 13:19:28 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/16/26 11:39 AM, Jonathan Cameron wrote:
> > On Sat, 16 May 2026 10:28:47 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 5/13/26 3:10 AM, Jose A. Perez de Azpillaga wrote:  
> >>> Add IIO driver for Broadcom APDS9999 ambient light sensor.
> >>>
> >>> The APDS9999 is a digital proximity and RGB sensor with ALS
> >>> capability. This driver implements the ALS/Lux functionality using
> >>> the green channel, which uses optical coating technology to
> >>> approximate the human eye spectral response.
> >>>
> >>> Proximity (PS) and RGB color features are not yet implemented.
> >>>     
> >>
> >>
> >>  
> >>> +enum apds9999_gain {
> >>> +	APDS9999_GAIN_1X = 0,
> >>> +	APDS9999_GAIN_3X = 1,
> >>> +	APDS9999_GAIN_6X = 2,
> >>> +	APDS9999_GAIN_9X = 3,
> >>> +	APDS9999_GAIN_18X = 4,
> >>> +};    
> >>
> >> Giving the natural values of enum explicitly just seems like noise
> >> IMHO. I wasted time looking for an anomaly.  
> > 
> > I tend to ask for this when they are hardware field values to make
> > the point the values matter rather than just being an enum.
> > I'm not that fussed though.
> > 
> > Jonathan  
> 
> In that case, I would just use #define instead of enum.
Likewise unless the type is actually used.

For that matter if type is not used, should perhaps be an anon enum
but that tends to also indicate defines are more appropriate.

Jonathan


> 

