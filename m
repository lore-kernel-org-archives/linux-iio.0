Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6172DF15C;
	Tue, 23 Jun 2026 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240729; cv=none; b=bDDjcIfz0+MzkQGS9fdGgFD8bu8QGh7/W8ufmyEI/lQT1QEdVOKojlMo5sFxfaUj1aJLvTyE+8EufEwxul404Tv3vlvh4ja32CA0+4GW3+v5uq8Dvo4hwPCkEAMHwnxbPu8hHPS0IcXEP8/DzpeNweCBE3aes8kWAhgGFfX5kyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240729; c=relaxed/simple;
	bh=V8d9KE78xVxUehKXmhyQTfSoGfgAT632ERJy2HyJ+zY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LA/gvvU5JgYQCE3286G3q0wrkq6l26uVtI3cZQ/hxhA4sDsD84KQ4XY9Ox4xwqxMgHt/JTuNtNDOJF7be7l+2tkkWEw+1gHl/Y9miq036ownW3qNsEH+pb1TurOSechNztMsEYxCAdIejDgtbpkAVW3z2mqAee7eIYFGIWgE0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzXSO2Ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzXSO2Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E805F1F000E9;
	Tue, 23 Jun 2026 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782240727;
	bh=EEJYJ15+Ujre1nAaXsjxS2daKSXsHzOdkPaxKxBDzlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dzXSO2BaKw5bvrEP5N8XJ4oZUzO+d+CC9e0CDYKR6EgLt8vd0CRriU1KOKraT0VW3
	 LQk7wq0Z7l8ZjuPunqVzeOA/1ahv4lIHYG/p74eoliif2rBiQkDxc47QUa3+Ii8pgv
	 fRQ/31etoIRShGCsZ5GaMRAe4QvPOfyg2ziLgKxO8+nNWOviPILxuTKAW9Zksm+6JV
	 2HTMkIZ3BPSbp7NT8KmxZu7HDwF115MCs1XFFzSV+9hx53OmKVVyzkScjrW3lU2dnV
	 +WZuKdCNawoOjnG0lHc0TCiq9n94djEhGQ1tI3ErkRVCwFpeAJdwIcRotUPslTtBRd
	 bBXOL6VfjaukQ==
Date: Tue, 23 Jun 2026 19:51:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 12/12] iio: dac: ad5686: add gain control support
Message-ID: <20260623195157.57298838@jic23-huawei>
In-Reply-To: <20260623-ad5686-new-features-v4-12-28962a57db0f@analog.com>
References: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
	<20260623-ad5686-new-features-v4-12-28962a57db0f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 11:55:52 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Most of the supported devices rely on a GAIN pin to control a 2x
> multiplier applied to the output voltage. Other devices, e.g. the
> single-channel ones, provides a gain control through a bit field in
> the control register. Some designs might have the GAIN pin hardwired
> to VDD/VLOGIC or GND, which would have no "gain-gpios" device property,
> being able to set "adi,range-double" if it is hardwired to VDD. The
> vref_mv field is moved down in the struct ad5686_state, so that the
> overall size increase is reduced.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
The rest of this series looks good to me. Let's see what others think.
Take a quick look at the sashiko feedback (much of it is invalid
stuff about the supplies being added) just to check there is nothing
there.  There be16 one might be real though I'm not sure the channels
are actually marked as IIO_BE - maybe I'm missing something,

Thanks,

Jonathan



