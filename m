Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F435C6BA;
	Thu, 23 Jul 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848732; cv=none; b=sYPZVAAeBY/eT0oTXcNVLrcSRoie+x/76V+hU6pvo9AJ6UjnrUGSabE2MdnJaCAP02OgN7y11Y0zLy9mptVq+Q2JnfNPfarmo7K4zKdH/YRPu/UqPGbst4k8OWFsWlnYegBbBSieIBvXjcI7E3jHGbCXfdKFT1TWQ4tzJ6uC8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848732; c=relaxed/simple;
	bh=hH/gELiYQN6zzc+XOXAkEfoUH5nQ95YFtFYIYh5yhyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMM+/xvRN5O2RHdPx1cXKSsSiWGilpw9iES2BOX1Yv8yeIm78QGaCemv+pcQs37s6fUmYgnb9UJnaL+2d8z1LukbqLwEFLMMnW7ssN/p8n3qMg0Wa2hPyTzMwywb6C88XzdGGnFD/Wy7VxiAtbTCr+6g+9q0rJBfOgrE3+CZl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAeOzzn+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAeOzzn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F831F000E9;
	Thu, 23 Jul 2026 23:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784848731;
	bh=03L7NoK71JrSO2+rlndvZFvmPMFXfiGEYY7Ka5jQX0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eAeOzzn+ejgsAK3MuzY+USuuKCeIj1Y6dJpdvbqT5qZtzGGHmyb8FB6Erd8xKYb7F
	 rzjxNkCkdYb0G2spmkFVfhPE1fmxWYsWwMlYvsat8J1tyR7y1NOprfk5TXDTcT317+
	 LWpF3Hgw8pVs5gWUVOVYPLsPovjt5jDnftKizSfOjeGA4RkpXGSONtnndnDTty74GQ
	 GCS6aWIi5VFntYua/9ffn+Z/bnBNktAbhSognIwOASSG7U27XW5G+n1KIZvT0+0Y+W
	 sTjltp0GdfmW5AbDs0JjOiExjh7B/zcd9MaEPhKdKppUTOC7/efZNvsguVh942XfgK
	 y0IFBPGlb0TKA==
Date: Fri, 24 Jul 2026 00:18:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ti-ads112c14: add debugfs register access
Message-ID: <20260724001848.42db9509@jic23-huawei>
In-Reply-To: <c8bd955b-1d1f-40e1-bede-82e5e9a7bde8@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
	<20260714-iio-adc-ti-ads112c14-buffered-read-v1-1-fe6e1c971288@baylibre.com>
	<20260720012446.27f0411b@jic23-huawei>
	<c8bd955b-1d1f-40e1-bede-82e5e9a7bde8@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 17:52:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/19/26 7:24 PM, Jonathan Cameron wrote:
> > On Tue, 14 Jul 2026 19:19:30 -0500
> > "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> >   
> >> Add debugfs register access to the ads112c14 driver. This is a complex
> >> chip and being able to poke registers is useful for debugging and
> >> diagnostic/calibration purposes.
> >>
> >> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>  
> > Given this one is trivial, applied.  
> 
> Did this get dropped or just not pushed out yet?
> 
I forgot to push.  Done now.

J
> > 
> > Jonathan
> >   
> 

