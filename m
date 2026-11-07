Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079913;
	b=hdBkHRNjNTuty5PYG/rR1Yu4w8IL9MGN/VZNANJC+jqbrRx8N6+GnrU+iIegEQN9F6m3
	 iKOmSOupgk3/FwY09c+fQmnbENZNsm6tSh2MwE5Z/t0v9niK8p8a499VRYpUp5x+y29nN
	 Y36XaeAulB7OWyzw5/86rX7WPZNU2smTxAApqAiJ0usAV083vapzl0DYYxuQcfQt7pqFh
	 t/QQNtWBKzFG+75MyhseXhtT/iWsNKGoNgHK6TE+M+o1CTO7UkVrSkQeIJG3cxOnqCEmp
	 s2LpqXfLS11iEhj7FRCRaHQI8hrZzK7Spu6pQGNjtvDX12pIY8MKrt9tA1Dl/fK25sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079913;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wUtrFuYVC3VhB6CCQNq2depDs9g9ZYwIqGK1BODJXZs=;
	b=m2xpKqZyYcPGlls0YYNPr8r3aQO5eEZ2rYqRI73PK0xf193mxALMzgTwW5wW7Nk8Sc4W
	 0pgA4O2Poai6nMPEDe46D6+kmfQeRh6G0eKixWa2ks0rZ3BhuqMbh77+XjmcHWdkrT8ZC
	 qOiIQiSJiJnRppTqtRX5sYKAZuoT6vEzf62C4J0i4NGta2LfN45WCbVye9+ISRplFAQ9P
	 ZVrW9vxpwd3K1zgQNHjmER1vZoSXUwUk/khJAjTuIpPx+MMTSnHxPRYo8nkedDWwCDYOA
	 s32uJ9NcCHwk8UmuJ9KS/v1jZSK15HGUyh+Z8OvCwbhG99Zh1ucQ0JOiE1H/K7B+exw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0Z5X13B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2162606A332;
	Sat,  7 Nov 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0Z5X13B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0606F1F0089F;
	Sat,  7 Nov 2026 19:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794079912;
	bh=wUtrFuYVC3VhB6CCQNq2depDs9g9ZYwIqGK1BODJXZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k0Z5X13ByahJHQ++tQubcCyGgYcKh7awaUG19xJfAD9iSEnXluW0ke8jEjXIkzDBe
	 4CnUDoAkfy935lguDOAw23/S9kURheNGtyvqi3ylpuXcrBS5pMo8pn6GijJWruCYyx
	 RYkbzVq49uDzTFjLORjFgjszRXd8EINy4LQNwgOjojeQyqTN497mrrcZ0hax1VNd8Z
	 7gF04nwc9KY7TrBXghNgsm+BQ7cRcGvGcuqLiMdInnj3JuBvgMA4a+fno6iNRUm1h0
	 XdTI+xbd0tVBkJFY0hBauMjLBQ+SAmGpCY5tXTfprCNU7pmRsu047npYKmHvI+H3jc
	 512TTxlzxZKSA==
Date: Sat, 7 Nov 2026 19:31:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: lkp@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261107193145.4d21b8c3@jic23-hlaptop>
In-Reply-To: <SN1PR12MB252803226E23A0F6A7CB0384A5762@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <202611070503.6fdgeWCZ-lkp@intel.com>
	<SN1PR12MB252803226E23A0F6A7CB0384A5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 16:25:22 -0600
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> > >> drivers/iio/cdc/fdc1004.c:67:10: warning: integer overflow in expression of type 'long int' results in '-1246822400' [-Woverflow]  
> >      -0x8000 * 488281250L, /* min */
> >              ^
> >    drivers/iio/cdc/fdc1004.c:69:10: warning: integer overflow in expression of type 'long int' results in '758541150' [-Woverflow]
> >      +0x7FFF * 488281250L, /* max */  
> 
> Switched suffixes to LL for v6.
> 
https://sashiko.dev/#/patchset/SN1PR12MB2528805DB17DD015E191111FA5762%40SN1PR12MB2528.namprd12.prod.outlook.com

Had a few more things alongside spotting this one.
Some look valid such the poll related one and I'd have missed that.
Please check them all for v6.

Thanks,

Jonathan

