Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F23D1CD4
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862672; cv=none; b=VeSYlpTAh8TKvv/hUJK3tkqVVjP+xLmSa/iNzKdzZZappmFQakyVMFwHOEAXX29n/RGOYSYfpI9MZ1cFviDpCEYyZ2L3sPRZoZJWkKt7DJ0vKAYgof0T8gt9VyykY1t0s3uH+ape/1xT1Qh6Y2ZJ0DkmkULOfoXMKXJKPvMASQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862672; c=relaxed/simple;
	bh=B5Qg7HYw3qbF3BY6rMn1hN7IpVHL5eO1PsdhHo0x1F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loOjSM6f1osyYPRHFOA/DtA9Ta/D/d+sYHgPZN8eAQi1+Z7vLXzfTNDUnPjsj8wLrcmhKE+YiozNHJ4hf8NjJ/OgxPSFdwty0OKrupYIN1sZ/28ALVOEi4SJOZpbU9sudT5bS7MwNiJy4MUasPWmDv/NT0+zZyhWtwYCzFvI030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9H1MHXo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9H1MHXo"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44b729aa7c5so879960f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778862669; x=1779467469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YqHNE38B6mwaDcSfUrOYOlsN+cah4kr68tj0DYVXe8w=;
        b=Y9H1MHXoKuSOD+4T3rMHI38PfRQtZ9DwxvMwWQDKpevZ2FlvaZvNaDIKGg60hYc1Oi
         GjY4db42FioXedrjKqRZBN5zfgtelT8dVXimGKDwnYzwELmR+6EM1MEN6Aw+i5MROT21
         2kzDBN8lAA+c9ECuRu8/4IebozJr0FuLTYPmVu+kY2A3OFcAZvI6cuEJ/ce1kvJtU9eh
         hDhSQ9ZRtGDU7UocbASQ/f378kf2zSCnjQ1LieY4IfuJrKSpOH5wKbYH7TMTf6eLceyR
         nHr3uk9m0LXCPQ467yI+6IxCKIsaWS556pfg6KnSu5NQInvYZe5qEIi42l48TUA65aN3
         nZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862669; x=1779467469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqHNE38B6mwaDcSfUrOYOlsN+cah4kr68tj0DYVXe8w=;
        b=pQwsffDHaAxmbQScrBizU+Y2RurPH9O4wIJHsqIgh6+oOsA7n3G9DmRa+N9M31hz15
         dHpwzg2nRIgTRjydQxvVKnh7ernKIjNT4G918KvcWkblVOuj5TWLZW0KLZeNOCdB7glp
         tlvt1dn3F8olAU2v2V0Jw4Ps1psHqlG4PfA7xJc/xn2m/8rJ9+z8OT0Wo+3BwblvNnh6
         6+ztpFam/XGr2zt4zu3IjPfKpOG82nkwAyzdoSzFZY+lIuSqVyOwdnYbvTSlkkIddh9e
         i0pi2rpUQnY2uFBkqSZZ3rrqnWZjx2d9X0rx3xRZ8O9RIzGQvqNM3j5KEKWg+rLjciEE
         PTAw==
X-Gm-Message-State: AOJu0YwS2HyXVkHMVo83YeiJeQM0GiGImzB9U/sfQqPe0mGvsfVNJB4r
	Dst3WA0c+xGD4VaoI0FNx5mev/30cZilE1HAr+t6Kmh/eWlZVjMnt9ge
X-Gm-Gg: Acq92OGgXO1g5FKh1328lEsgQrLL/VTeTeEXymDKj7DekLl4nLcDyvRUaXup+xRqiuN
	GAVtOcbAsMpCe3DaqoKbctm7xIQbnA1Mc4R7BD422WOB9MMYqeYxW5QwLOl5DT/PuyIiS7VrtkJ
	lsrN69lnc/aHRaK1b7rRJ27wy0FYqPyUYElYmc/7t68F+/5lUXFyB8cft8NAOP/h6+XSjKfhfau
	Ywk6UlV6LYGzgvh7ixmT6p7/jzZXiiSCjP6SHRlMKH/T64EfO8qv74VX0EeR0CLdg9UcYQiMipr
	HhjGDaai55Ld24NGhuTohsT+BCoMxEKVem6pas6MLdC2p6rJS338WImzJjJY7u1nrt18Hj0XIeq
	9ZJle1WVC869tgKWatIoyRbHFfS2uZNHSxmhcfw6fuRWJDMgciCjKKJ3L9PkNcEiHG9ojF1Ca6k
	H69LQkVGKlwF0DFObVGSoIJj5uYdM8eNVroteZHWD0A9dMTRb4fTZ+CA==
X-Received: by 2002:a05:600c:4513:b0:48a:5501:799a with SMTP id 5b1f17b1804b1-48fe664c27cmr35087275e9.5.1778862668506;
        Fri, 15 May 2026 09:31:08 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c90b27sm76772265e9.8.2026.05.15.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:31:08 -0700 (PDT)
Date: Fri, 15 May 2026 13:31:02 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
Message-ID: <agdKRhtywsThg/gT@JSANTO12-L01.ad.analog.com>
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
 <af2gJyG3rDjsjFmo@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af2gJyG3rDjsjFmo@nsa>

On 05/08, Nuno Sá wrote:
> On Thu, May 07, 2026 at 06:28:58PM -0300, Jonathan Santos wrote:
> > Hi all,
> > 
> > We have a request to support multiple devices tied together in a single evaluation
> > board. The goal is to be able to read them simultaneously via the IIO framework,
> > while also controlling them individually. Currently we have two ADC devices that
> > would benefit from this, but there might be more in the future.
> > 
> > This is the scenario:
> > 
> > +---------------+                                                 
> > |     ADC 0     |                                                 
> > |               |                                                 
> > |        SYNC_IN|---+---------------------------+                 
> > |          DRDY0|---|------------------------+  |                 
> > |               |   |                        |  |   +------------+
> > |          SCLK0|---|------+                 |  |   |    HOST    |
> > |           SDI0|---|------|--+              |  |   |            |
> > |            CS0|---|------|--|-----------+  |  +-->|ADC_SYNC    |
> > |          DOUT0|---|------|--|--------+  |  |      |            |
> > |               |   |      |  |        |  |  |      |            |
> > +---------------+   |      +--|--------|--|--|----->|SCLK        |
> >                     |      |  +--------|--|--|----->|MOSI        |
> > +---------------+   |      |  |        |  |  |      |            |
> > |     ADC 1     |   |      |  |        |  |  |      |            |
> > |               |   |      |  |        |  |  +----->|DRDY0       |
> > |        SYNC_IN|---+      |  |        |  +-------->|CS0         |
> > |          DRDY1|---|------|--|----+   +----------->|MISO0       |
> > |               |   |      |  |    |                |            |
> > |          SCLK1|---|------+  |    |                |            |
> > |           SDI1|---|------|--+    +--------------->|DRDY1       |
> > |            CS1|---|------|--|-------------------->|CS1         |
> > |          DOUT1|---|------|--|-------------------->|MISO1       |
> > |               |   |      |  |                     |            |
> > +---------------+   |      |  |                     | .          |
> >                     |      |  |                     | .          |
> >        ...          |      |  |                     | .          |
> >                     |      |  |                     |            |
> > +---------------+   |      |  |            +------->|DRDYN       |
> > |     ADC N     |   |      |  |            | +----->|CSN         |
> > |               |   |      |  |            | | +--->|MISON       |
> > |        SYNC_IN|---+      |  |            | | |    |            |
> > |          DRDYN|----------|--|------------+ | |    +------------+
> > |               |          |  |              | |                  
> > |          SCLKN|----------+  |              | |                  
> > |           SDIN|-------------+              | |                  
> > |            CSN|----------------------------+ |                  
> > |          DOUTN|------------------------------+                  
> > |               |                                                 
> > +---------------+                                                                                                    
> > 
> 
> Do we have any FPGA IP for high speed transfers? If so, it would be nice
> to have it in the above diagram.
> 

We only use the SPI-engine offload with the new multilane data feature.

> > To summarize, the devices share SPI pins such as SCLK and MOSI, but have individual
> > chip-selects and MOSIs (we can consider individual SPI interfaces). The ideia
> > is to allow users to aggregate these devices so they can be read simultaneously
> > from the user space.
> > 
> > I found a similar case here involving the AD4880 (ad4080 driver), which consists
> > of two independent ADC channels, each with its own SPI interface for configuration.
> > In that instance, the ancillary device feature was used because it was considered
> > the approach of a single device with independent channels rather than independent
> > devices connected together. Additionally, the backend handled the buffered data
> > aggregation.
> > 
> > However, I would like to discuss a more generic approach to support device aggregation
> > across different drivers. Marcelo suggested a while ago to consider the components
> > framework. This would allow us to create a virtual device responsible for 
> > aggregating and controlling the sub-devices in a standard yet flexible manner.
> 
> component might fit here but it has it's limitations and I fear (one of
> the reasons I did not used for the backend stuff) is that it looks too geared for DRM. But yeah,
> in theory is more or less what we have here with the distinction (I
> think) that the type of devices are actually different :).
> 

Yes, they are different, but i did not find something more similar. Here
the goal is to define a standard way of aggregating multiple devices
from the same driver.

> > 
> > The aggregate driver could either be an extension to the main driver (e.g. ad7768-1.c),
> > or a separate file (e.g. ad7768-1-agreegator.c). 
> 
> I guess we could support this in the main driver (more on this below).
> 
> > 
> > Here's an example of how the devicetree would look like: 
> > (includes the multiple data lanes feature)
> > 
> > spi {
> >     #address-cells = <1>;
> >     #size-cells = <0>;
> > 
> >     /* AD7768-1 physical devices */
> >     adaq7768_1_0: adaq7768-1@0 {
> > 	compatible = "adi,adaq7768-1";
> > 	reg = <0>;  /* CS0 - First physical device */
> >         spi-tx-lane-map = <0>;
> >         spi-rx-lane-map = <0>;
> > 	/* other properties */
> >     };
> > 
> >     adaq7768_1_1: adaq7768-1@1 {
> >         compatible = "adi,adaq7768-1";
> >         reg = <1>;  /* CS1 - Second physical device */
> >         spi-tx-lane-map = <0>;
> >         spi-rx-lane-map = <1>;
> >         /* other properties */
> >     };
> > 
> >     adaq7768_1_2: adaq7768-1@2 {
> >         compatible = "adi,adaq7768-1";
> >         reg = <2>;  /* CS2 - Third physical device */
> >         spi-tx-lane-map = <0>;
> >         spi-rx-lane-map = <2>;
> >         /* other properties */
> >     };
> > 
> >     adaq7768_1_3: adaq7768-1@3 {
> >         compatible = "adi,adaq7768-1";
> >         reg = <3>;  /* CS3 */
> >         spi-tx-lane-map = <0>;
> >         spi-rx-lane-map = <3>;
> >         /* other properties */
> >     };
> > 
> >     /* AD7768-1 aggregator/virtual device */
> >     quad_adaq7768: ad7768-1-aggregator@4 {
> >         compatible = "adi,ad7768-1-aggregator";
> >         reg = <4>; /* ? */
> > 
> >         adaq7768-components = <&adaq7768_1_0>, <&adaq7768_1_1>, <&adaq7768_1_2>, <&adaq7768_1_3>;
> >         
> 
> I guess we can avoid the dummy device! The one having the components
> with be the main/controller device but I guess we would still need a custom
> property for the other nodes in case they need to do something specific
> for this arrangement.
> 

Yeah, defining one device as the controller looks cleaner, but we still
have that problem of the main "owning" or using the CS from the other
devices (if they are registered separately).

> 
> >     };
> >         
> > };
> > 
> > Is it ok to proceed with component helper for this purpose or do we have something
> > better? If yes, I have some following questions:
> > 
> > -> How to read all devices simultaneously in buffer mode given we can't assert 
> > all CS from the virtual device?
> 
> Isn't this also an HW question? Not sure how that can be done
> simultaneously without some kind of HW synchronization. In SW, I'm not
> seeing other way other than  N SPI transfers and put them together in the buffer. 
> 

In HW we have that multiple data lane feature that receives the data
from eache SDI lane and put them in order (for FIFO mode and offload mode).
If we are not using offload, we could set N SPI transfers and then
aggregate them into one buffer. But how to do that in offload? We cannot
control the CS mask from userspace.

> thou> 
> > -> Should the physical devices be registered in IIO during probe, or should only
> > the aggregator be exposed to control attributes and general configuration?
> 
> Good question but it would likely make for a better/simpler interface if only
> one device was registered (with multiple channels - depending on the
> number of devices). Similar to backends. I guess the idea is also to
> only have one IIO buffer for all the channels?
> 

Yes, the ideia is to have a single buffer to allow reading them
simultaneously from the userspace.

> Or, IIUC, at the very least, only the aggregator could expose a buffer.
> But again, linking the other device channels to the buffer is not really
> doable without major changes in the core.
> 
> Something that also just come to my mind! What about the IIO inkernel
> interface and things like 
> 
> industrialio-buffer-cb.c
> industrialio-hw-consumer.c
> 
> Maybe they have some limitations but something that we can work on? Not
> sure though...
> 

The Inkernel is interesting, I will see what can be done to cover this
case.

> - Nuno Sá
> 
> > 
> > Regards,
> > Jonathan S.
> > 
