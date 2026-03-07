Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC2579DA;
	Sat,  7 Mar 2026 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772888467; cv=none; b=B9H1eKZ5KpHSsGfgJI8ZrvEtqyRGtuhUek/qj1bNnafbr1JArZVZZqCo8ZEkeeD6AFsOk3mOReO+r08v0r66BXfUCMSn7lUy2ovAQ4xxG/Lwb6CxFD0nLA8J/qQrnoLPwUtXbqSLrcNsbkqJaDgfvP/cbps0F6JWzdaCdip7Vd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772888467; c=relaxed/simple;
	bh=xAnQh1furyaz2PGfm6n6C/plQRiAp4inoicKfvWthC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2eJIJPSMNCJHdmjFwe3RX5aVdui6tEHDI1jHGZmnDnQr0YhY4PlHVtuoUlZjp+jjql4I1Ykv9gPCovV7BJGT7sXOhk0yMXPM6G7glnPRIWuKp70IqCoFqYQSZXVGGRzCKIWQ8Yno6gyMz17X9kkPOw0PMeXIEhadLiXkzGRBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E63Q0ODg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E63Q0ODg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEE2C19422;
	Sat,  7 Mar 2026 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772888466;
	bh=xAnQh1furyaz2PGfm6n6C/plQRiAp4inoicKfvWthC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E63Q0ODgGy/vTxFMM1+BUJHmVQdcV+RI2jMKZPE0YuNgT1cXPNvJkWkRMyB2hKSgC
	 hPJxIWmAOZ75ARemUkzLNUfTXCTuYtoIIU+K3eQtMjGfmiBEWNlC8Dtp76vf4XFp00
	 xI8Uw1wdh2W2v+XOJpeNkxT8bonkdEhasPwh4g1++o3TK+clqNNkAucA6U02fGIMYH
	 HpBghe4Ue1VQInsJ3mjlKC5SiBcffM8ZnJrOtyJ1JSpF3KbgQcVLbzcfHqILQ+dYip
	 jOWHJNRzbrx5lpirRixwsA9EV1/zIlbbqs7yicZz6nT7Dz+ZgeWuezuQyDlragg+PI
	 Be0TVdAswmcJg==
Date: Sat, 7 Mar 2026 13:00:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Francesco Lavra
 <flavra@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <20260307130058.190a0596@jic23-huawei>
In-Reply-To: <aakrCIJBdHb1T30Y@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	<20260304080706.2844472-1-flavra@baylibre.com>
	<77e10517-2b6e-417b-95d3-185d3a067ba5@baylibre.com>
	<aakrCIJBdHb1T30Y@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Mar 2026 09:04:40 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Mar 04, 2026 at 04:35:39PM -0600, David Lechner wrote:
> > On 3/4/26 2:07 AM, Francesco Lavra wrote:  
> 
> ...
> 
> > > +		- the quaternion vector is normalized, i.e. x^2 + y^2 + z^2 + w^2 = 1  
> > 
> > Isn't this usually written with w first?
> >   
> > > +		- the rotation angle is within the [-180, 180] range, i.e. the w  
> > 
> > Best to say the angle units. IIO standard unit for angle is radians.
> >   
> > > +		  component (which represents the amount of rotation) is non-negative  
> 
> Based on these, maybe the name should be
> 
>   normalised_360_quaternion
> 
> (or variations of this)? Actually "partial" quaternion some articles use
> for something different as far as I can say.

The "axis" naming for the define is probably as good as we can do for
something that is mathematically dubious in my view. There are two many
ways it could be interpreted and I'd be surprised if this does get used
in other devices, and they all pick the same way of filling in the
missing constraint.

Mind you I never much like quaternion's (part of my PhD was on Clifford /
Geometric algebra's and exponentials of bivectors are so much cleaner :)

Jonathan

> 

