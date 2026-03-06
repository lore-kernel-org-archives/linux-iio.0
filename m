Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23A3596E1;
	Fri,  6 Mar 2026 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796570; cv=none; b=lEA/pu8Gln3vfFrUNo9kVSkGJypqgV7aRlZKXF2gxl/94B9E5DOOWXmUFZg2SLX4j2wADgcaNhKzPfHRGJvEeAKh4RJq18t1i0jbFl64EQdnFJx8OTP+UIxJKsT/TuHDmF7gMv0Oxs5XWq7Xq+NMoF9toVU+JirL557jkozoGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796570; c=relaxed/simple;
	bh=XryNqzJpAbwoPPJDceu+o/RMktCv0sL78kkwIFXfp2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOgBWwgizguscq8jIQ/mwve/p7V2i1CfEyscdd9Zld2jYhWiFZLu6ZIs0kwIj6ZgIgfakqnXBMSo4ndggom8aCFNBAcx/3l99c0O6iQGfKw9ZojNHYWuCKpU2P8E3mq+nLz5D4cexIIfHoImLfNqS/jl1BQCDIH0tpMoLGFWFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqRr2BgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqRr2BgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE51C4CEF7;
	Fri,  6 Mar 2026 11:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772796569;
	bh=XryNqzJpAbwoPPJDceu+o/RMktCv0sL78kkwIFXfp2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqRr2BgDwmSvs5Hlh9XDngsdSc53G1yIc7aGX1uFjRRiZqnxwB1lRMQoq7QTxqesg
	 JLfbnw7piKywWe9WtsSPASsCyxqBVPcdadgdgT3IM8ZM5CnX6N5rvkonx1QbasGG2s
	 rOhRetD5OuGYkCOvvj+lWOYRVK7S6HfjiFhA0xcOZd9JPaT8sATuB85OOD8aiJnfRX
	 y5ayFUc3Fe6Q8fXtNA6kFZrQTFk7fF/KAxeM4RQp7S34+xaBsSDpmKw6i5ncas/DuK
	 yUG1/h2o/p2YUu+Yaxam0qqlC+uixpO1i7fkgLzVRc7uyVhZAefMsB+SrgcbquCpaD
	 A65RtASmO4M2g==
Date: Fri, 6 Mar 2026 11:29:18 +0000
From: Lee Jones <lee@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srini@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Linus Walleij <linusw@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 15/15] hwspinlock/treewide: refactor consumer.h from
 public header
Message-ID: <20260306112918.GG183676@google.com>
References: <20260303192600.7224-17-wsa+renesas@sang-engineering.com>
 <20260303192600.7224-32-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303192600.7224-32-wsa+renesas@sang-engineering.com>

On Tue, 03 Mar 2026, Wolfram Sang wrote:

> Factor out the entries only needed for consumers from the generic public
> header. This allows for a clean separation between providers and
> consumers. Also remove contact field in favor of MAINTAINERS entries.
> Fix the users, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> # for IIO
> ---
>  Documentation/locking/hwspinlock.rst              |  2 +-
>  MAINTAINERS                                       |  1 -
>  drivers/base/regmap/regmap.c                      |  2 +-
>  drivers/hwspinlock/hwspinlock_core.c              |  2 +-
>  drivers/iio/adc/sc27xx_adc.c                      |  2 +-
>  drivers/irqchip/irq-stm32mp-exti.c                |  2 +-
>  drivers/mfd/syscon.c                              |  2 +-

Acked-by: Lee Jones <lee@kernel.org>

>  drivers/nvmem/sc27xx-efuse.c                      |  2 +-
>  drivers/nvmem/sprd-efuse.c                        |  2 +-
>  drivers/pinctrl/stm32/pinctrl-stm32.c             |  2 +-
>  drivers/soc/qcom/smem.c                           |  2 +-
>  drivers/spi/spi-sprd-adi.c                        |  2 +-
>  .../linux/{hwspinlock.h => hwspinlock/consumer.h} | 15 ++++++---------

-- 
Lee Jones [李琼斯]
