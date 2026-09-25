Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1171A6807;
	Fri, 25 Sep 2026 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790304181; cv=none; b=S6A8vaS8ulI+MOQO3kzhh0O1nqrB7qj2raV5QQXqwR8hVUvDf7o51v4kKyxYUZkXK0kA6ts1sEJ3cdfJ5+QZ/1ASR0N+D36GMYu1J6ickhO7BcYj0S1vZEkm56yXqamosSXRu1Vf4I2VJJoEM4v0mia+weAyrMsL01H4VndMp64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790304181; c=relaxed/simple;
	bh=RWuF28mSIJqsKyjpE7Z+j1COv7ALs2Tcuj7Dycg/reU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMQb/3GvmFQ7LvWN+jMcS0X8+AVYBGzd5NOHuG6uZYQuZhe/oUhH1SBPolAP1yz19r2oXCgLqCgsJfa6kfJm1opW5xwJCk/7PGH5fX3myFtIolFdrWavfqC79w/tSiH/sk1e3cnlIr55MUbU4gg9zM+LeudHu4eKuIFq7RlEHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JohkxDHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JohkxDHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD281F000FF;
	Fri, 25 Sep 2026 02:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790304180;
	bh=CBaKEWexDMlKGogM2tzTmc3hP2HGDXOByGKHoSy6W1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JohkxDHaYmfR8bj+RI3Ux2U89Fz9UyCN497zNlUcDwB50P+HQsX9E/FBmjlMjLAVX
	 01Ge1XgPdhJFXoUMMC3shh8P+yfosCEc7RhPy/Ch0W+NE6/u7RPZ95Ytb6MlJ6uVlG
	 O7HPa+PPyn5MxEAoOCNOpJSUhRNNAt8ZY7PV7JnxJm6y6mP0Y79Bvwqi2ZgYu73d+a
	 KanZSnACLsZFRJ+3DfHbF7uG9YfL1I391TGXD6V79C2ihP+l7bOV9F0LGJwGNBFt5F
	 wswf3q62zsvKxLA5iFSI4ku2/CBQFJdpn0+u5G33jud2N+eGO1Sti+Uhw7MAzVHj3u
	 uYuY9nFlysltw==
Date: Fri, 25 Sep 2026 03:42:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jishnu
 Prakash <jishnu.prakash@oss.qualcomm.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
Subject: Re: [PATCH] iio: adc: qcom-adc5-gen3: Annotate struct
 adc5_device_data with __counted_by_ptr
Message-ID: <20260925034257.0f034a59@jic23-hlaptop>
In-Reply-To: <202609230056.DF2B9BE56@keescook>
References: <20260922220950.2267270-1-morbo@google.com>
	<202609230056.DF2B9BE56@keescook>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 01:01:42 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Sep 22, 2026 at 10:09:50PM +0000, Bill Wendling wrote:
> > Under compiler-supported bounds checking (via KASAN or UBSAN), pointer
> > fields inside structures can be annotated with the '__counted_by_ptr'
> > attribute to specify which field in the same structure holds the element
> > count. This enables the compiler to perform runtime bounds checking on
> > the pointer.
> > 
> > Annotate the "base" pointer field in "struct adc5_device_data" with the
> > "__counted_by_ptr" attribute pointing to "num_sdams". The number of
> > SDAMs is determined from the device property and assigned to "num_sdams"
> > which is then used to initialize "base" via "devm_kcalloc".
> > 
> > By ensuring "num_sdams" is set to the correct element count prior to
> > the "base" pointer allocation, and since the size of "base" is never
> > reallocated or changed, this annotation is safe and will not cause any
> > false-positive runtime bounds check panics or KASAN issues.  
> 
> Welp, yes, it's allocated correctly to the size. It'll be interesting to
> see if this:
> 
>         ret = device_property_count_u32(dev, "reg");
>         if (ret < 0)
>                 return ret;
> 
>         adc->dev_data.num_sdams = ret;
> 
> is never at odds with this:
> 
>         ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
>                                         NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
>                                         adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
>                                         adc);
> 
> Nothing checks that num_sdams >= ADC5_GEN3_VADC_SDAM (0). I feel like
> that ret = device_property_count_u32 should check for < 1 :)

Whilst it's sensible to sanity check dt, I'm not sure we will ever
close down all the crazy ways an invalid dt can break things!

I'd certainly be fine with some additional hardening of this particular
case though.

Applied this one as any such change is a different issue anyway

Thanks,

Jonathan

> 
> 

