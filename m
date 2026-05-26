Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4B30C147
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846621; cv=none; b=t7UWnIciR9xgiinQhSWIauvNIhxx4CiZ/NOr6uQCcR52vK8iYsydYYvM0wEGvZca24g16U/Z6f484kyIZtI4klPgoiGB2QSTyBkzk+fLXDrDknVBIKYRZoKxA0EjC46LXCAwiA5syYJIeZwae8XItb2yVq95OD3qBWfPglPYB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846621; c=relaxed/simple;
	bh=hkYV74VxugRZRQkHvGHIswKMS+D9k+qkUc2sBRfJHps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jp7h8WPhRRMXmAAf/q0ZmIxMG8orHYZvRuVGL6maRjbXECWRyQy2zDeab2XD0Toj7vs2D0re3qBHLFFSjhYaTMZCRdQL8ohzxevbB14XyfK/vq6YNf6xsfyK5kRTB5jOIRobr2SwvgUl2zDL80b+5mfIxKKY/fgkcyL0ccqegSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCXkQE5t; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCXkQE5t"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44b729aa7c5so1160037f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846618; x=1780451418; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TuPyxrPMXcdLQvxGgGrx5Hv2T2guo30OkkHoRafnJGs=;
        b=RCXkQE5t/50duU80eiU1T9W9i1O7aStbE62UvV0lJO3gn8Hmorhmdjdc/I1+nsAMdF
         TOUR7mruF4Rzk/1vvHyoi4G54j3QZGi4tK2Dvsm3PKrm2HQNhulaj1ddwPgrgQVmLtKP
         L2vRLj9JF7XtPiqXu+OZAmD0/ZPHheTjen+qQV3Jl9NWh+PGzRE6JIgChsC6Lce0uuJz
         bVb0Y0iT80Vq4CVrl8HdIHa1EMcbOi3KPb049ATB/U0Qz1KHF8ceB4BYfsc5nJARIRxv
         ZaVi+lDl3SC6soVmDV7CPE4qa8qN7q2fcCkBv6YCGHIHeRcB5iQ3sOSyQ394OHG2Eug6
         m9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846618; x=1780451418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuPyxrPMXcdLQvxGgGrx5Hv2T2guo30OkkHoRafnJGs=;
        b=UgcPPldNqp1Jq+1jVxO6cE/IZ7UPczf4uBzjkFR84z1QR3CzjroRLIzfBzKmtqzJ8Q
         5XUnKMahMStrcOurePUST9IFVwnU86expz0e8S8m9P8Qx8whLn/DI/ZcnrvNqqwLyaDj
         5tK7Ym9bT9jbhxmmOyBQCqPtARe0OG5bNoJm0g8XKEQgKfhwLIuiHDpEkAOrR3p3hdju
         cq2z2HDceK7MMuZBXBQVpjMRZmZUuip1YzUdT0aUG1ZfkWR8B/JmuwnONqEFP6NHwbIO
         0BQiyckFIF3yNTVdnsoql0tq2QzOTDCMCh3jSWnZ3d4PM+/3Xscx3BU1azoV+fn1vFY0
         j8bQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zMedt8dZzLgEsB4YAbxUKuspOZBt2vbFFJL0ytAzOExWOmw14b0xt3B1crDxYObSkLT0Lu83hW/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkW7hS5Bs1/7eE0HK8kWCOeYbqYNEx65AxuVZKI1UE2W/g3eA
	kNAVsrN3tub6P47wxKCqvJ8kOLfGMwwjqTcnP9JtuYlzW1aPotwmLjf+
X-Gm-Gg: Acq92OH32SYKkfwYdBXSXMo/+8YpeU3z6DbcQBfKVkRc5HG5N2CWqi/7s5rd3Kz4/Vo
	eTqJWzwIs5K6zLCx6S3FCg9m8boATMGQPar9EJ7uPUd1b4lHlJb5WohgMUdXSeDH+FoXLzOYPUE
	KVUHRc7+zrhumO2kiN6tfhfIJeLtLFrsDZoWDVjZEY/n1aO0O3sL/JjCeiCmjNnag8ELbWWLJr9
	+wyEX9WgjU6xMB8Mle6rMOovMDG7BOmL+k/K+Y0Z3/YjFTFpnUkUBSukpyiPOMltCZQFgFIQX/8
	oVem0M7ZrRObcdtRY9umXvzuyeoK623x7XdmOkccJm4PH0FVpQQqMQG0xSqAwWvn0VuYNXbBrjJ
	7aSV0HHmTfee3w+C6FofpP6spCcvt7ycEYFCdM9XYX1Mgt/1kpa1OpfGc4LBy2OoSiP/H0qrAy+
	vRRC9YW+jHWCjktuDFZl7ojcldCUV77xI4pUhfWl+/Rq3YbSxPIVSESQ==
X-Received: by 2002:a05:600c:474d:b0:490:3d89:4bd1 with SMTP id 5b1f17b1804b1-49042ae9a03mr146046705e9.5.1779846617614;
        Tue, 26 May 2026 18:50:17 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([187.34.137.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454b7d57sm359399035e9.15.2026.05.26.18.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:50:17 -0700 (PDT)
Date: Tue, 26 May 2026 15:24:59 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
Message-ID: <ahXle0pZjpldxASF@JSANTO12-L01.ad.analog.com>
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
 <af2gJyG3rDjsjFmo@nsa>
 <agdKRhtywsThg/gT@JSANTO12-L01.ad.analog.com>
 <20260516113738.4103f388@jic23-huawei>
 <fe766c2a-3662-4896-b7ec-b569791630cd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe766c2a-3662-4896-b7ec-b569791630cd@baylibre.com>

On 05/16, David Lechner wrote:
> On 5/16/26 5:37 AM, Jonathan Cameron wrote:
> > On Fri, 15 May 2026 13:31:02 -0300
> > Jonathan Santos <jonath4nns@gmail.com> wrote:
> > 
> >> On 05/08, Nuno Sá wrote:
> >>> On Thu, May 07, 2026 at 06:28:58PM -0300, Jonathan Santos wrote:  
> >>>> Hi all,
> >>>>
> >>>> We have a request to support multiple devices tied together in a single evaluation
> >>>> board. The goal is to be able to read them simultaneously via the IIO framework,
> >>>> while also controlling them individually. Currently we have two ADC devices that
> >>>> would benefit from this, but there might be more in the future.
> >>>>
> >>>> This is the scenario:
> >>>>
> >>>> +---------------+                                                 
> >>>> |     ADC 0     |                                                 
> >>>> |               |                                                 
> >>>> |        SYNC_IN|---+---------------------------+                 
> >>>> |          DRDY0|---|------------------------+  |                 
> >>>> |               |   |                        |  |   +------------+
> >>>> |          SCLK0|---|------+                 |  |   |    HOST    |
> >>>> |           SDI0|---|------|--+              |  |   |            |
> >>>> |            CS0|---|------|--|-----------+  |  +-->|ADC_SYNC    |
> 
> 							Is this arrow
> 							supposed to be
> 							going the other
> 							direction?
>
                                                        Yes, sorry about
							that.

> >>>> |          DOUT0|---|------|--|--------+  |  |      |            |
> >>>> |               |   |      |  |        |  |  |      |            |
> >>>> +---------------+   |      +--|--------|--|--|----->|SCLK        |
> >>>>                     |      |  +--------|--|--|----->|MOSI        |
> >>>> +---------------+   |      |  |        |  |  |      |            |
> >>>> |     ADC 1     |   |      |  |        |  |  |      |            |
> >>>> |               |   |      |  |        |  |  +----->|DRDY0       |
> >>>> |        SYNC_IN|---+      |  |        |  +-------->|CS0         |
> >>>> |          DRDY1|---|------|--|----+   +----------->|MISO0       |
> >>>> |               |   |      |  |    |                |            |
> >>>> |          SCLK1|---|------+  |    |                |            |
> >>>> |           SDI1|---|------|--+    +--------------->|DRDY1       |
> >>>> |            CS1|---|------|--|-------------------->|CS1         |
> >>>> |          DOUT1|---|------|--|-------------------->|MISO1       |
> >>>> |               |   |      |  |                     |            |
> >>>> +---------------+   |      |  |                     | .          |
> >>>>                     |      |  |                     | .          |
> >>>>        ...          |      |  |                     | .          |
> >>>>                     |      |  |                     |            |
> >>>> +---------------+   |      |  |            +------->|DRDYN       |
> >>>> |     ADC N     |   |      |  |            | +----->|CSN         |
> >>>> |               |   |      |  |            | | +--->|MISON       |
> >>>> |        SYNC_IN|---+      |  |            | | |    |            |
> >>>> |          DRDYN|----------|--|------------+ | |    +------------+
> >>>> |               |          |  |              | |                  
> >>>> |          SCLKN|----------+  |              | |                  
> >>>> |           SDIN|-------------+              | |                  
> >>>> |            CSN|----------------------------+ |                  
> >>>> |          DOUTN|------------------------------+                  
> >>>> |               |                                                 
> >>>> +---------------+                                                                                                    
> >>>>   
> 
> Would there actually be 4 DRDY inputs on the host system? I assume that
> they would be the SPI offload trigger. But there can only be one trigger.
> So I would expect all DRDY going into an N-input AND gate and the output
> of that gate used as the trigger.
> 

Exactly, the host is combining the 4 DRDYs into an AND gate for the
offload trigger.

> > Took me a while to get to this. 
> > 
> > Another datapoint to perhaps look at is daisychain SPI devices. That's
> > moderately common on high end ADCs with applications such as electric car battery
> > monitoring as they need to scale to 100s of devices and separate CS for each would
> > be a pain.  
> > 
> > For those we just handled it in the ADC driver.
> > 
> > If we need to have a device specific aggregator driver to make any scheme work
> > then it might be better to just make it a driver problem.
> > 
> >>>
> >>> Do we have any FPGA IP for high speed transfers? If so, it would be nice
> >>> to have it in the above diagram.
> >>>   
> >>
> >> We only use the SPI-engine offload with the new multilane data feature.
> >>
> >>>> To summarize, the devices share SPI pins such as SCLK and MOSI, but have individual
> >>>> chip-selects and MOSIs (we can consider individual SPI interfaces). The ideia
> >>>> is to allow users to aggregate these devices so they can be read simultaneously
> >>>> from the user space.
> >>>>
> >>>> I found a similar case here involving the AD4880 (ad4080 driver), which consists
> >>>> of two independent ADC channels, each with its own SPI interface for configuration.
> >>>> In that instance, the ancillary device feature was used because it was considered
> >>>> the approach of a single device with independent channels rather than independent
> >>>> devices connected together. Additionally, the backend handled the buffered data
> >>>> aggregation.
> >>>>
> >>>> However, I would like to discuss a more generic approach to support device aggregation
> >>>> across different drivers. Marcelo suggested a while ago to consider the components
> >>>> framework. This would allow us to create a virtual device responsible for 
> >>>> aggregating and controlling the sub-devices in a standard yet flexible manner.  
> >>>
> >>> component might fit here but it has it's limitations and I fear (one of
> >>> the reasons I did not used for the backend stuff) is that it looks too geared for DRM. But yeah,
> >>> in theory is more or less what we have here with the distinction (I
> >>> think) that the type of devices are actually different :).
> >>>   
> >>
> >> Yes, they are different, but i did not find something more similar. Here
> >> the goal is to define a standard way of aggregating multiple devices
> >> from the same driver.
> >>
> >>>>
> >>>> The aggregate driver could either be an extension to the main driver (e.g. ad7768-1.c),
> >>>> or a separate file (e.g. ad7768-1-agreegator.c).   
> >>>
> >>> I guess we could support this in the main driver (more on this below).
> >>>   
> >>>>
> >>>> Here's an example of how the devicetree would look like: 
> >>>> (includes the multiple data lanes feature)
> >>>>
> >>>> spi {
> >>>>     #address-cells = <1>;
> >>>>     #size-cells = <0>;
> >>>>
> >>>>     /* AD7768-1 physical devices */
> >>>>     adaq7768_1_0: adaq7768-1@0 {
> >>>> 	compatible = "adi,adaq7768-1";
> >>>> 	reg = <0>;  /* CS0 - First physical device */
> >>>>         spi-tx-lane-map = <0>;
> >>>>         spi-rx-lane-map = <0>;
> >>>> 	/* other properties */
> >>>>     };
> >>>>
> >>>>     adaq7768_1_1: adaq7768-1@1 {
> >>>>         compatible = "adi,adaq7768-1";
> >>>>         reg = <1>;  /* CS1 - Second physical device */
> >>>>         spi-tx-lane-map = <0>;
> >>>>         spi-rx-lane-map = <1>;
> >>>>         /* other properties */
> >>>>     };
> >>>>
> >>>>     adaq7768_1_2: adaq7768-1@2 {
> >>>>         compatible = "adi,adaq7768-1";
> >>>>         reg = <2>;  /* CS2 - Third physical device */
> >>>>         spi-tx-lane-map = <0>;
> >>>>         spi-rx-lane-map = <2>;
> >>>>         /* other properties */
> >>>>     };
> >>>>
> >>>>     adaq7768_1_3: adaq7768-1@3 {
> >>>>         compatible = "adi,adaq7768-1";
> >>>>         reg = <3>;  /* CS3 */
> >>>>         spi-tx-lane-map = <0>;
> >>>>         spi-rx-lane-map = <3>;
> >>>>         /* other properties */
> >>>>     };
> >>>>
> >>>>     /* AD7768-1 aggregator/virtual device */
> >>>>     quad_adaq7768: ad7768-1-aggregator@4 {
> >>>>         compatible = "adi,ad7768-1-aggregator";
> >>>>         reg = <4>; /* ? */
> >>>>
> >>>>         adaq7768-components = <&adaq7768_1_0>, <&adaq7768_1_1>, <&adaq7768_1_2>, <&adaq7768_1_3>;
> >>>>           
> >>>
> >>> I guess we can avoid the dummy device! The one having the components
> >>> with be the main/controller device but I guess we would still need a custom
> >>> property for the other nodes in case they need to do something specific
> >>> for this arrangement.
> >>>   
> >>
> >> Yeah, defining one device as the controller looks cleaner, but we still
> >> have that problem of the main "owning" or using the CS from the other
> >> devices (if they are registered separately).
> >>
> > Long ago I did some thinking about the fidlier problem of aggregating multiple
> > unrelated device driver buffer outputs - was for sensor fusions stuff.
> > In the end I concluded it was easier to just do it in user space.  As long
> > as they ran off the same trigger then the data alignment problem wasn't too hard.
> > 
> > Obviously here things are a bit different as the SPI offload IP is doing the
> > data marshalling.
> > 
> >>>   
> >>>>     };
> >>>>         
> >>>> };
> >>>>
> >>>> Is it ok to proceed with component helper for this purpose or do we have something
> >>>> better? If yes, I have some following questions:
> >>>>   
> >>>> -> How to read all devices simultaneously in buffer mode given we can't assert   
> >>>> all CS from the virtual device?  
> >>>
> >>> Isn't this also an HW question? Not sure how that can be done
> >>> simultaneously without some kind of HW synchronization. In SW, I'm not
> >>> seeing other way other than  N SPI transfers and put them together in the buffer. 
> >>>   
> >>
> >> In HW we have that multiple data lane feature that receives the data
> >> from eache SDI lane and put them in order (for FIFO mode and offload mode).
> >> If we are not using offload, we could set N SPI transfers and then
> >> aggregate them into one buffer. But how to do that in offload? We cannot
> >> control the CS mask from userspace.
> > 
> > If it's not doing hardware offload is it worth the pain?  Easy enough to do
> > it in userspace - particularly if we have timestamps as a bit of nearest
> > timestamp maths allows easy buffer alignment.
> > 
> 

We had a 'hack' in the HDL where we tied the CS pins to activate them at
the same time, but since we are aiming to handle each device indually it
would be nice to at least enable all CS defined in the devicetree. It is
strange that we can define up to 8 CS for one device, but the spi-engine
only selects the first one.

> For this type of SPI controller where it can read multiple data
> channels at the same time, the .dts should look like this:
> 
> spi {
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     adc@0 {
> 	compatible = "adi,adaq7768-1";
> 	reg = <0>, <1>, <2>, <3>;
>         
>         spi-rx-bus-width = <1>, <1>, <1>, <1>;
> 
> 	/* other properties */
>     };
> };
> 
> The reg property is the 4 CS lines and spi-rx-bus-width having 4 items means
> that the controller has four SDI lines (the value <1> could be different if
> each data channel/device was dual or quad SPI).
> 
> This goes along with what jic23 suggested about making it similar to
> what we do with daisy-chaining.
> 

Since last week I have been testing  the approach you and jonathan suggested,
handling the multiple device support within the driver and using the multiple
data lane. Additionally, I have included the ancillary device to manage
the devices individually when required (and to make it easier to write
and read using regmap), but some other problems came up:

* When addressing the devices/channels individually, I would like to
select only the respective SDI lane on each transfer, but with the 
ancillary interface there's no way to define a rx lane mapping.

e.g: If we want to read a register from the device 2 (index 1), the
ideal scenario is to activate only the SDI1, so the controller writes
the right value into the read buffer. Without this mapping, we get
the trash from the lane SDI0.

can we add some new parameter to set the rx/tx lane mapping in the
devm_spi_new_ancillary_device()?

* This driver registers a regulator and a GPIO provider associated with
the main SPI device. Can we register them for each ancillary device too
or this is not allowed? I am still confused on how to handle this kind
of situation.

> The only tricky part with that is when devices don't share all of the
> same of another property. For example, in the wiring diagram above, I
> see that the DRDY lines are not connected together. But I would assume
> that everything else is the same (all chips share the same power supplies,
> etc.).
> 

Yeah, since the DRDYs are reduced to one pin in the controller, this is
not an issue for now. What concerns me more are the PGA and GPIO provider,
since each device has it own pins.

> We would need to modify devicetree bindings a bit in cases where a property
> needed a per-chip value. But I think that this happens rarely enough, that we
> can just do that on an as-needed basis rather than trying to make every property
> support multi-device use.
> 
> 

> 
> >>
> >>> thou>   
> >>>> -> Should the physical devices be registered in IIO during probe, or should only  
> >>>> the aggregator be exposed to control attributes and general configuration?  
> >>>
> >>> Good question but it would likely make for a better/simpler interface if only
> >>> one device was registered (with multiple channels - depending on the
> >>> number of devices). Similar to backends. I guess the idea is also to
> >>> only have one IIO buffer for all the channels?
> >>>   
> >>
> >> Yes, the ideia is to have a single buffer to allow reading them
> >> simultaneously from the userspace.
> >>
> >>> Or, IIUC, at the very least, only the aggregator could expose a buffer.
> >>> But again, linking the other device channels to the buffer is not really
> >>> doable without major changes in the core.
> >>>
> >>> Something that also just come to my mind! What about the IIO inkernel
> >>> interface and things like 
> >>>
> >>> industrialio-buffer-cb.c
> >>> industrialio-hw-consumer.c
> >>>
> >>> Maybe they have some limitations but something that we can work on? Not
> >>> sure though...
> >>>   
> >>
> >> The Inkernel is interesting, I will see what can be done to cover this
> >> case.
> > 
> > How common do we think this requirement is?  If it's just a couple of

For now, only two drivers have this requirement.

> > devices I'd go a similar route to the daisy chaining case and do
> > something in the specific driver.  Maybe the only point of generalization
> > is the dt-bindings if we got that way.  Designing that to maybe let
> > us do a generic answer in the long term might be the right compromise
> > in not adding complexity to the core until it's proven to be needed.
> > 
> > Now if you have customers asking for it on 10 different devices today then
> > sure let's look at it sooner!  Even then it might be some library code that
> > the drivers use rather than big changes to the data flow in the IIO core.
> > 
> > Jonathan
> > 
> >>
> >>> - Nuno Sá
> >>>   
> >>>>
> >>>> Regards,
> >>>> Jonathan S.
> >>>>   
> >>
> > 
