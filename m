Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686E320CD1
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231068; cv=none; b=TBmCtLIBErzVbWt/5DqMpn8BgAiGMua+NjjD4wlFD38IaeIlAzHLUker+6XeDhJXUATrKXvJ57x5AJ+mw4iL1Gh39V4c/hoj8FJVll0EP86TRTPKplCRttp9+7/TuYK/zzCitwyF5peI+TMAZgzuTtSthir4yCqkh7EzIMz7qrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231068; c=relaxed/simple;
	bh=RqoZ2lOUwXipev1wOwfjPIj281TjpHRgFncmUuFnWwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7ddmqO2iLXbAMRR9xsILBX0h5G8gPRL4OvenmltfJJErKmb2ddp973FPDScISUfusLUwdHbJ7xDGpstZyLEV8Zo6j4z343za9M0jE1HWbR50+tGNraw4x5IaJ9YZTSoKY1N1qsSa0mZmd+l/hvV9yx0i9Y24d7BRyvrWj/LJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/YkDuvD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/YkDuvD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0046078so14605815e9.1
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778231065; x=1778835865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RxKVhgDyrbibIlulRjrEdhEm0lLtD2F0pBS/KgkRV2U=;
        b=V/YkDuvDkl/VCE8my7JmHIyGsauA4wiWmf0AsMTI/QwZiNjTAOWiMq9kDLaWPFf3fo
         vrYq4h4h8BZ58SlQJl7JmERaLRFoh7Gf9gn1q43oouSbheANPkCNvDUjHcgLTLfuqyR8
         Ar1P6QZUpSpxHEfSekorb6zAcn6K+zgvJPzYEBv4w7ngtWewQhyWGg+IcOXHm18k0aYB
         tvS23jfl1LGFi0EoqERWlo+DRBwV9b9hCbRH4gH8BHlESAShUoZnz1+tkLJGyn3AtITM
         fEHK5hj70gFcxSkxifcZuCuKGGSMygTAzqiNpPrH93d7hLgA82iiIcy154lt4LJsf5pF
         MjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231065; x=1778835865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxKVhgDyrbibIlulRjrEdhEm0lLtD2F0pBS/KgkRV2U=;
        b=lI4Azc1Bb/pWHkAA2ABZbZHAtVe1QV4ptmuT8VixoMSh1mFggDOM60fKzCxUxltlw3
         IPc5yaBWkritiD1712VCDCQHpZ2Q+oEBmTvz+ziJkaQL/OAMzCHFSdUAcfciiA1R/HET
         g99fvxh4tKDHwh3fy4sfAmhYWoKP3h8M7A18cw6OJzqt2OPRpYt/Dk5sXoR9vWKMcwNW
         ZXhUnZ+7XVzdrpM8xI5XKUGcE//6FqMDU0mNoyuR+tzD38kUKcFAKmZbjLq2MledGIw3
         k7gvA1obHJg62cQdMOrctaUVc3aahtuWY3GRqstpd4Xb02QZS5rC6APWhd0pj5pN+oIF
         53kA==
X-Gm-Message-State: AOJu0Yzmkd87fQ+q6YOJwslwpS1abSh+WmBnCBMyKcyoHaJfccijnAhI
	dMnTV5JiuacBeTUTz5qlJtMedN+1+kwkI6nRXCjEJRicENI2sf71f/cE
X-Gm-Gg: AeBDietE/rsY/ysBDrjSWif7sMeUtKJi8u9qUA6IyXmbYLrx8V7unNu8PC0D6zJup3H
	dkrwPMi0Uq63Mfx/7Vax01Q7iA+2U3YMb4aqtqUA1u6GDPOk8fyKZO7s8gMTTvqWcpOb1N/i/Oq
	RTWbGSslHlByC6BvUH/s/jpbXRyjTIGJiSgeFUvbjYKG//6xYNVtmHWkGEg0z4ZBrZs1VuhhTtM
	haLVn7FXseq8QiQX+JMQaKPGY/awO8o4TteirGk7mKJquHcUoS7vf4yR6HqtbikpgfweOgEMXCP
	mYfrE8AFXnfcaCo7F7MtihvnMQnr5lYcJeql59ugrmbE5SSXSvAiYgDc7C/sd8Jx4XSoi7L5DGa
	8AFgc6W5fOCwgnsaOESxkkH2l0y8rcRHAz/58sgGiRN5VA9AFKyv/TLI66Dz13FNsFXkMF//m42
	17icxcKodCF8MVge7k98sCR94OjQ==
X-Received: by 2002:a05:600c:a404:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48e51f3e0f8mr166677795e9.22.1778231065034;
        Fri, 08 May 2026 02:04:25 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm3080543f8f.6.2026.05.08.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:04:24 -0700 (PDT)
Date: Fri, 8 May 2026 10:05:18 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
Message-ID: <af2gJyG3rDjsjFmo@nsa>
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>

On Thu, May 07, 2026 at 06:28:58PM -0300, Jonathan Santos wrote:
> Hi all,
> 
> We have a request to support multiple devices tied together in a single evaluation
> board. The goal is to be able to read them simultaneously via the IIO framework,
> while also controlling them individually. Currently we have two ADC devices that
> would benefit from this, but there might be more in the future.
> 
> This is the scenario:
> 
> +---------------+                                                 
> |     ADC 0     |                                                 
> |               |                                                 
> |        SYNC_IN|---+---------------------------+                 
> |          DRDY0|---|------------------------+  |                 
> |               |   |                        |  |   +------------+
> |          SCLK0|---|------+                 |  |   |    HOST    |
> |           SDI0|---|------|--+              |  |   |            |
> |            CS0|---|------|--|-----------+  |  +-->|ADC_SYNC    |
> |          DOUT0|---|------|--|--------+  |  |      |            |
> |               |   |      |  |        |  |  |      |            |
> +---------------+   |      +--|--------|--|--|----->|SCLK        |
>                     |      |  +--------|--|--|----->|MOSI        |
> +---------------+   |      |  |        |  |  |      |            |
> |     ADC 1     |   |      |  |        |  |  |      |            |
> |               |   |      |  |        |  |  +----->|DRDY0       |
> |        SYNC_IN|---+      |  |        |  +-------->|CS0         |
> |          DRDY1|---|------|--|----+   +----------->|MISO0       |
> |               |   |      |  |    |                |            |
> |          SCLK1|---|------+  |    |                |            |
> |           SDI1|---|------|--+    +--------------->|DRDY1       |
> |            CS1|---|------|--|-------------------->|CS1         |
> |          DOUT1|---|------|--|-------------------->|MISO1       |
> |               |   |      |  |                     |            |
> +---------------+   |      |  |                     | .          |
>                     |      |  |                     | .          |
>        ...          |      |  |                     | .          |
>                     |      |  |                     |            |
> +---------------+   |      |  |            +------->|DRDYN       |
> |     ADC N     |   |      |  |            | +----->|CSN         |
> |               |   |      |  |            | | +--->|MISON       |
> |        SYNC_IN|---+      |  |            | | |    |            |
> |          DRDYN|----------|--|------------+ | |    +------------+
> |               |          |  |              | |                  
> |          SCLKN|----------+  |              | |                  
> |           SDIN|-------------+              | |                  
> |            CSN|----------------------------+ |                  
> |          DOUTN|------------------------------+                  
> |               |                                                 
> +---------------+                                                                                                    
> 

Do we have any FPGA IP for high speed transfers? If so, it would be nice
to have it in the above diagram.

> To summarize, the devices share SPI pins such as SCLK and MOSI, but have individual
> chip-selects and MOSIs (we can consider individual SPI interfaces). The ideia
> is to allow users to aggregate these devices so they can be read simultaneously
> from the user space.
> 
> I found a similar case here involving the AD4880 (ad4080 driver), which consists
> of two independent ADC channels, each with its own SPI interface for configuration.
> In that instance, the ancillary device feature was used because it was considered
> the approach of a single device with independent channels rather than independent
> devices connected together. Additionally, the backend handled the buffered data
> aggregation.
> 
> However, I would like to discuss a more generic approach to support device aggregation
> across different drivers. Marcelo suggested a while ago to consider the components
> framework. This would allow us to create a virtual device responsible for 
> aggregating and controlling the sub-devices in a standard yet flexible manner.

component might fit here but it has it's limitations and I fear (one of
the reasons I did not used for the backend stuff) is that it looks too geared for DRM. But yeah,
in theory is more or less what we have here with the distinction (I
think) that the type of devices are actually different :).

> 
> The aggregate driver could either be an extension to the main driver (e.g. ad7768-1.c),
> or a separate file (e.g. ad7768-1-agreegator.c). 

I guess we could support this in the main driver (more on this below).

> 
> Here's an example of how the devicetree would look like: 
> (includes the multiple data lanes feature)
> 
> spi {
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     /* AD7768-1 physical devices */
>     adaq7768_1_0: adaq7768-1@0 {
> 	compatible = "adi,adaq7768-1";
> 	reg = <0>;  /* CS0 - First physical device */
>         spi-tx-lane-map = <0>;
>         spi-rx-lane-map = <0>;
> 	/* other properties */
>     };
> 
>     adaq7768_1_1: adaq7768-1@1 {
>         compatible = "adi,adaq7768-1";
>         reg = <1>;  /* CS1 - Second physical device */
>         spi-tx-lane-map = <0>;
>         spi-rx-lane-map = <1>;
>         /* other properties */
>     };
> 
>     adaq7768_1_2: adaq7768-1@2 {
>         compatible = "adi,adaq7768-1";
>         reg = <2>;  /* CS2 - Third physical device */
>         spi-tx-lane-map = <0>;
>         spi-rx-lane-map = <2>;
>         /* other properties */
>     };
> 
>     adaq7768_1_3: adaq7768-1@3 {
>         compatible = "adi,adaq7768-1";
>         reg = <3>;  /* CS3 */
>         spi-tx-lane-map = <0>;
>         spi-rx-lane-map = <3>;
>         /* other properties */
>     };
> 
>     /* AD7768-1 aggregator/virtual device */
>     quad_adaq7768: ad7768-1-aggregator@4 {
>         compatible = "adi,ad7768-1-aggregator";
>         reg = <4>; /* ? */
> 
>         adaq7768-components = <&adaq7768_1_0>, <&adaq7768_1_1>, <&adaq7768_1_2>, <&adaq7768_1_3>;
>         

I guess we can avoid the dummy device! The one having the components
with be the main/controller device but I guess we would still need a custom
property for the other nodes in case they need to do something specific
for this arrangement.


>     };
>         
> };
> 
> Is it ok to proceed with component helper for this purpose or do we have something
> better? If yes, I have some following questions:
> 
> -> How to read all devices simultaneously in buffer mode given we can't assert 
> all CS from the virtual device?

Isn't this also an HW question? Not sure how that can be done
simultaneously without some kind of HW synchronization. In SW, I'm not
seeing other way other than  N SPI transfers and put them together in the buffer. 

thou> 
> -> Should the physical devices be registered in IIO during probe, or should only
> the aggregator be exposed to control attributes and general configuration?

Good question but it would likely make for a better/simpler interface if only
one device was registered (with multiple channels - depending on the
number of devices). Similar to backends. I guess the idea is also to
only have one IIO buffer for all the channels?

Or, IIUC, at the very least, only the aggregator could expose a buffer.
But again, linking the other device channels to the buffer is not really
doable without major changes in the core.

Something that also just come to my mind! What about the IIO inkernel
interface and things like 

industrialio-buffer-cb.c
industrialio-hw-consumer.c

Maybe they have some limitations but something that we can work on? Not
sure though...

- Nuno Sá

> 
> Regards,
> Jonathan S.
> 
