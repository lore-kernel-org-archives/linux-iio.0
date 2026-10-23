Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792721354;
	b=mdpwxGXLcqZyiylFJGCTVxBELsvaVmiNCtcqJE/i0cEwhkC62vlru/bopBm7stXMrQKo
	 RJYZRJEPC/s0tyNEqOc4rg8lK99203RnZpHuvpy9a7lyqEsPSwZ5eXkldB8u9d+dFVB4+
	 CnOzLcTf/yeZ91xQ+baOW7Vxk6v+/4s9BaSPuLfLw77XSiJNd2W+yOba2kqtD1yFuu+VP
	 YpQpLUz3vQub4GM9uaRxSX4qAvwFWiBRRnqO6yk6bM7xGffJMRblFv9bdFE7Vt/ky9LMD
	 icIEMEnInKb9jtATfd1wTf7n1E+8KpAPzxbEZFl91AhrUV6xd787pEgGLUZZPFvGslA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721354;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GZicaRlOKce4kfeci8Vdnbi5v/gaq7iFexvz2gXMucI=;
	b=wpYij6Rd+B3R4SbIcf9OkiMfbCY2+XcCawKpKV1rhDG6B5XqfPQJY/eUij0d/ae3sh1h
	 UQ4OxSPm5Ipq0KuFjXe/dPrMLjYVl0q2pSuqqi+49BgG8r9k1mMAUi4l2/cTbA7eBklHn
	 tArmqiMHtt1xx/0fzMJ+4jUtXNJnXG31a14zaxmAjTfQFa/8QSPJmXh7V2QX6WeBGoxdh
	 Bu79w6f9idA9KAmlyRYLztAtLCwfQoAsENzv14IBPcgMlAv+MLc2kthQkSn6IeIkFzr30
	 zXx/IF1z+LRp6jCv8cUV1vHai6gTeZRgXwa99k3zCiEivjWNcCEiEn806VMk5vN5lng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVNOs76T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C46606A319;
	Fri, 23 Oct 2026 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVNOs76T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEAF1F01825;
	Fri, 23 Oct 2026 02:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792721354;
	bh=GZicaRlOKce4kfeci8Vdnbi5v/gaq7iFexvz2gXMucI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QVNOs76TJbGGrmpvh2g6Prmxl76HbvvwZ0hR2bLCxfEd51sMLTv88j5IifO1/lL4m
	 a1hKSo4noMlyc2zQtKEliYwPdjuBj7BWeWVV9Ze/elPxmMnGof/FQ6MKFtbdXS6Era
	 0SS9HgS/ICtGXWh/XxHAJwulnjeOT4x++Utf5lgpGDD2ZPeFRX1jlEig8LDBHlDSip
	 eAL7tIgWpqw8Qc3ZXjLEno3zeljQIZXq4vZgcfEXlV0UpzkPN0RgeI3FfTTmpjs+ed
	 qwXrk6tQxDF2VCyL9BmMSLa4aaDs4ITc7OaaBxTrp/VpRb973h/3a9bHRILZ37nn9s
	 6pThjqUqy659A==
Date: Fri, 23 Oct 2026 03:09:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Shawn Guo <shengchao.guo@oss.qualcomm.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Dan
 Carpenter <error27@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM
 aux device IDs
Message-ID: <20261023030905.78064e5d@jic23-hlaptop>
In-Reply-To: <atkMam-XiXcrUOFB@ashevche-desk.local>
References: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
	<atWzFlOgRICAGM-R@QCOM-aGQu4IUr3Y>
	<20261021195401.6a70fe6a@jic23-hlaptop>
	<atkMam-XiXcrUOFB@ashevche-desk.local>
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

On Wed, 21 Oct 2026 22:03:06 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Oct 21, 2026 at 07:54:01PM +0100, Jonathan Cameron wrote:
> > On Mon, 19 Oct 2026 14:05:10 +0800
> > Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:  
> > > On Thu, Oct 08, 2026 at 11:11:54AM +0800, Shawn Guo wrote:  
> 
> ...
> 
> > > > Assisted-by: LLM  
> > 
> > Applied to the fixes-togreg branch of iio.git and marked for stable.  
> 
> JFYI, this tag now is killed from documentation. The idea that the use of AI is
> described in the comments block or so.
I'm being a bit lazy on stripping them from patches that were
already out there before that change was merged.

Indeed useful to call it out though going forwards!

Jonathan



> 

