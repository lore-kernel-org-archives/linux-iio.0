Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D452580F3;
	Wed, 23 Sep 2026 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150503; cv=none; b=Va1cm9W1dYVi30OGurmcAnWv7tzswYe5heM4PwVyiJvm7fQRM84fPoxuIZ2XsweaRRuHKFUZSgaKmX2L4ylFAl3d7t2Dgfl/l/YNt+TqNQ/T/Q1htpbFiR3Oh2E8bwt/+YNJc9nYa3XtNTSK6rLjzp/LWRadqkaJdFOSdn3t8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150503; c=relaxed/simple;
	bh=m1xkiKN/X1JJIxueyxrugvHruIUDkXslW2W5JUJ+vF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZU6uG811nDDdaBzoE5UpoFz3Wevmwpwa8umZA/P1+/1DhUY595FF0qCvzxS8vdwhdjiOqFjA8wTdJaXhesNhAwTN5PnrVJQvku2lj3G7OxC/kIyL+tuF1ly+1hMWlJSAVq4nOpqabQmDL5k3JteXe2OUEwrAabbUuu6QlJHqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+O8OlcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+O8OlcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFB71F0089E;
	Wed, 23 Sep 2026 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790150502;
	bh=Dc6gkHP2bbSbrikastse9j6lN/sY09368OBTKwNLCJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S+O8OlcRHfiV3jFyTVyebprGjiJPU69uoB4tXVI2SoJ26RbPw5/o7srll9Y8wlH1P
	 +FYPK9BKzdERa4aiK/QJynq+pGiRZ/pOyumwww2izNJ8XJvbE7G6SOKQU74KVzPhtf
	 mn8JxAvz8jpr4egL35I82DCYvnLhoqx6xBmsGBD+bC+2zx4/fK3hHhoXOXUhNrYI9K
	 STVVAL+NQiK/sJsJTDdsf2UmsO2KVL4MPEm0bOyS0h5axcbMcGdSKj1Ru4HnlOUUBZ
	 p5k7a3wuzoNHJK0PYkHRr52jTyHQ+HiXxcooqPKzGyhKJRrtHsOE9FD9Z5thFWm8QS
	 EIl4ZQ6QB51iQ==
Date: Wed, 23 Sep 2026 01:01:42 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] iio: adc: qcom-adc5-gen3: Annotate struct
 adc5_device_data with __counted_by_ptr
Message-ID: <202609230056.DF2B9BE56@keescook>
References: <20260922220950.2267270-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922220950.2267270-1-morbo@google.com>

On Tue, Sep 22, 2026 at 10:09:50PM +0000, Bill Wendling wrote:
> Under compiler-supported bounds checking (via KASAN or UBSAN), pointer
> fields inside structures can be annotated with the '__counted_by_ptr'
> attribute to specify which field in the same structure holds the element
> count. This enables the compiler to perform runtime bounds checking on
> the pointer.
> 
> Annotate the "base" pointer field in "struct adc5_device_data" with the
> "__counted_by_ptr" attribute pointing to "num_sdams". The number of
> SDAMs is determined from the device property and assigned to "num_sdams"
> which is then used to initialize "base" via "devm_kcalloc".
> 
> By ensuring "num_sdams" is set to the correct element count prior to
> the "base" pointer allocation, and since the size of "base" is never
> reallocated or changed, this annotation is safe and will not cause any
> false-positive runtime bounds check panics or KASAN issues.

Welp, yes, it's allocated correctly to the size. It'll be interesting to
see if this:

        ret = device_property_count_u32(dev, "reg");
        if (ret < 0)
                return ret;

        adc->dev_data.num_sdams = ret;

is never at odds with this:

        ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
                                        NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
                                        adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
                                        adc);

Nothing checks that num_sdams >= ADC5_GEN3_VADC_SDAM (0). I feel like
that ret = device_property_count_u32 should check for < 1 :)


-- 
Kees Cook
