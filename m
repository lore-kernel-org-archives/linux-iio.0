Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965600;
	b=AVMayYybJZunU8vGjVmNsfCS+tYuEmYiaitDKEEIXyaBGDKBOETo3twxqgdPyT4dAJ9D
	 aIHJwFVZ0ypgij40xrZ6dBvKnlsLSqEa8lFcfjoHBSWI2EIbLf32irYRgqHBI+oXKran4
	 3DgFbOAJ0EQaaEz4I/peU8a/tIAJ7h+sStnZgqPM4JPtKLsN6MNU9TvRxdMdJvP48e3/D
	 j+7qxohXbiSWEENXcHkL0T2rsOrQRXH9jtJkmXH7wogOxZ2goOwu4f9GpiRIJgMLjQUc1
	 6eJf7LC38wZGjAhzymJr4dpahZ+iPD8nvxij4YYXfjIZ8LhHBC5TOXsBR+tFz4xuQYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965600;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z7Oec1H1B66PlNrpgwqION9Mp2RyTNxhQ8Dr7dkYH4E=;
	b=aYsSTZgWQgvlEyLfYDiezjNEVmD4jzDxmyJFmO9IcWvFQ2rr/D4IYQTA5vyZWGZACw8y
	 VQjgLyQYOGoXwm10g/S8tx64n3SrUKfT0tzC/rXdvFNjVcANF0n1N7r7cMbuJScNVzj46
	 q+Qu4ysVz13QEe83Pzpg/szygnr57BQaOaw1+wLHBmTFhTSMyUs+seukwC8/IWPYx0scE
	 kZ+a70lRaIcGEF9n7plPThNWAVuimimMCaMkUSnQc7o1M9Yldyp/86FA5zUdKU2NLK4ml
	 roIe3H3h74+6UAIR3Tyn7feee4CZecOSalhORmF8MLA9HYJB8fVfqFqj69C0zQwihaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ltz2eLlc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF89606A31A;
	Sun, 25 Oct 2026 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ltz2eLlc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B9E1F01825;
	Sun, 25 Oct 2026 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792965600;
	bh=z7Oec1H1B66PlNrpgwqION9Mp2RyTNxhQ8Dr7dkYH4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ltz2eLlcAXtkIzyRyn55zSitjVCuCRG+XeP7R+NW/MB3HKmu+b9K+r5Tj9irK0/5M
	 bo1jIiJ4DWYX2J7T1sujPurHZRBMzW7T0gmpbhHhTl5ajRaXtFEQkGjCQ8JKnw633b
	 9PTIMWiscI33zFISVK/hcZu+pimro/qunnb3/aCTF1a8E4YnwiwaHBIM83e9LCvD4Y
	 W8bhRcsRViDTcmJv8rN8Ecyp6uDUQ8JrBFNPomVCw5lFpu9vzYsSfR2PryvTbFVBNW
	 19bPbbIcRNGzby7zoM9iHIQvu6rvhTf0Kh82DqKQShd5MD/KG5qJTcJD27M7pl3C5G
	 5RBl3dzjlxUoA==
Date: Sun, 25 Oct 2026 21:59:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Marco Elver
 <elver@google.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v3] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations
 on mutex helpers
Message-ID: <20261025215954.73549810@jic23-hlaptop>
In-Reply-To: <76bbebb4-7337-486d-8f21-a39bcb6dca93@acm.org>
References: <20261025191510.22261-1-zoone.rupert@gmail.com>
	<76bbebb4-7337-486d-8f21-a39bcb6dca93@acm.org>
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

On Sun, 25 Oct 2026 13:10:26 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> On 10/25/26 12:15 PM, Rupesh Majhi wrote:
> > Found by building with CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y  
> 
> Please include the CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y change in
> your patch.
> 

I asked that we didn't do this because intent is to follow with
remaining fixes to be able to enable this IIO tree wide.
I'd rather avoid the churn of piecewise makefile updates if
we are going to be there soon.

Rupesh, if you think that is coming soon then please just make
next version of this the first patch in that series.

If not I don't mind merging this sooner with the makefile change
to ensure this gets used in the meantime.

Thanks,

Jonathan

> > diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > index c68c6c5f6aca..6a3cabedf4e8 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > @@ -663,7 +663,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> >   }
> >   
> >   void adc5_gen3_mutex_lock(struct device *dev)
> > -	__acquires(&adc->lock)
> > +	__context_unsafe(/* returns with adc->lock held */)
> >   {
> >   	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> >   	struct adc5_chip *adc = iio_priv(indio_dev);
> > @@ -673,7 +673,7 @@ void adc5_gen3_mutex_lock(struct device *dev)
> >   EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
> >   
> >   void adc5_gen3_mutex_unlock(struct device *dev)
> > -	__releases(&adc->lock)
> > +	__context_unsafe(/* releases adc->lock */)
> >   {
> >   	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> >   	struct adc5_chip *adc = iio_priv(indio_dev);
> > 
> > base-commit: c9dbe2a47f635465c9985b7af74d2ae310e98125  
> 
> Please consider replacing the above with the patch below:
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c 
> b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index c68c6c5f6aca..09013c6e44a0 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -663,7 +663,7 @@ static int adc5_gen3_add_aux_tm_device(struct 
> adc5_chip *adc)
>   }
> 
>   void adc5_gen3_mutex_lock(struct device *dev)
> -       __acquires(&adc->lock)
> +       __acquires(&((struct adc5_chip 
> *)iio_priv(dev_get_drvdata(dev->parent)))->lock)
>   {
>          struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>          struct adc5_chip *adc = iio_priv(indio_dev);
> @@ -673,7 +673,7 @@ void adc5_gen3_mutex_lock(struct device *dev)
>   EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
> 
>   void adc5_gen3_mutex_unlock(struct device *dev)
> -       __releases(&adc->lock)
> +       __releases(&((struct adc5_chip 
> *)iio_priv(dev_get_drvdata(dev->parent)))->lock)
>   {
>          struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>          struct adc5_chip *adc = iio_priv(indio_dev);
> 
> Thanks,
> 
> Bart.

