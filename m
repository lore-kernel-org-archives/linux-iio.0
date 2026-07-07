Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72193F44DB
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421543; cv=none; b=kQBHzHDmAjKso8BmZ0OSfPt1YkO711Hc5HmiCjjU1TrRCPe40u6etF47IGV1Ff//hVDchBhJGkyA9LJ9miWuKoKXWTgfkmfW5SdRRQ0FmKyFbZxaX/SGBgqbbq6vHJ3DlTIN1FtfE5a+mfztdEcyMFQa0w4QjKCW1EpwXxdweFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421543; c=relaxed/simple;
	bh=U1qvcFxLKrwEquFjkv7uGnL3tOB3rFVzjZa3qamyz38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0+vThhlJDfwcpfjgYWBpq/MHkuMb4ZRVr9ofLI5lzHO6wo772KXgiq+qnpTBSr8yEm2OkIG88BxO+3rYzjmmXyvE/AAHrO+dCns1Hb82rbOjuBOPcFHYPvaWfL1wfKueSO1B0xN9anAC3nKW5T8HFe8cETongc/7k6NWQuuYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2S6VbhY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2S6VbhY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b966dd74so13774425e9.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783421540; x=1784026340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xD/I4R2QXs7s+95dAxGC6Ggop7ankDcEDMFD0oYB+2Q=;
        b=D2S6VbhYrlD2hqzn8sgapX710ygbTyX9A2BBWrt76Tx7hhh5DriMr8+490ICdkiCFw
         kH1zKsmQIKmcCUXiNLk12MG1iOpm14y2fU2IweNe8VJx1t46MIXKdYVC/7gcvGVnWcrW
         swl5DlcYq5R7HYmzehkMvTwdJ9PKINaP8mK8zVIPJkPZIhZrWop5QdklUSAxH1Sij+Su
         w+f3muko16oxQMzZ9spFWxlN2kg7mcBLb8tXSfauqoGE0s/5rE5iGNdWedxlUvR7GfAa
         0BoFpEaTePSRwCvz/IaIg3kiDRaxeFmiwVGv3FP3LnucQs/v3YcwGXDNIhO6N38NkEWh
         bRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421540; x=1784026340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xD/I4R2QXs7s+95dAxGC6Ggop7ankDcEDMFD0oYB+2Q=;
        b=O0R9CWW3ghC2kmKbwifviku9yy+fDqXOxXyZawbUwMmIy/WV3SY54OSnCNV2FqsAJt
         6gIX26MMW6t4nQ8Ltnnn7U9XCOgCWxyMMlVyPeazuG/DGWGF7P3PIZFsLW7fgDOqmVic
         8HCTnBs5RhrsY/whLc5fZjfpYeKIClDTrpCnsOSZlUwRFdWyChGoWBP/blRCJAV0vWcF
         /XfG8KEuap9MHfR4RDpZ2BlZDHyGevqHHEyDNKzBhiazeRAmWYsIkSxT1e3yGiz57DBW
         N8/Wzn3f0mDKX49IU57g02Vk6ezXmLU7DcHMFNbKXsf7wofm1FOZkqGo1uR1Im22Lihh
         7Zcw==
X-Forwarded-Encrypted: i=1; AHgh+RoYyYkUQYuvN4b2TYJXYkCRtqJnK1/ZJ12RWgoTeSUdBhRWGjnUJik5qCeQTq448PZwYv86OIEWIXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuw3p8/gfr42WZnUPfyZafPK6pmeT32rWa5mBxxsHyOcCUuHR2
	5/wHQjMI7qGc0tGI60QKFF2GRXzbL1UQVnQ4bSRylUQu0hi3acTFqT3D
X-Gm-Gg: AfdE7clUxPHoDmvgwZnIwB1iRHfpuVJ52Pa8GmNkCUfgxQXgJ7p5+qsHSt311KeL05Y
	LCy2nHAw9xaxwiEWsGOFq6Ku/StSkhp00TXjdAJd4j8MuRuWRFb33Gr+4173XGqHO7tNLbZKDNI
	8F/ae1IRRF2HfWXxs9XvObhO0HLEK+YGLybXGb4/yVJY2tYvKREei6Gl2bAxvNkVmOJm2FI4rlz
	WcoGYbu/lzEC/bhUToktVihfVZuN7CxObKHu/InjsHbguIPs+oHNOGQqXMB6L6Y3lXIOfkAn2lC
	ZPgy7f+Nn02PxhfFN/EkvDY0bhXQe7x2eJeRbafhAAL38u2XEYXEDl8uMm7l7SwVlBiD9DhtyOv
	QXsjE7Kg+OQGwdkKVXy4xzLnrlbcbLdqQxRBgFVEeuc93efersdjDoPgcl90ju58p+hZgGL5Pdu
	AmZtdf0/O8DKtGSWc=
X-Received: by 2002:a05:600c:c168:b0:493:d282:8298 with SMTP id 5b1f17b1804b1-493df052084mr54038025e9.16.1783421539970;
        Tue, 07 Jul 2026 03:52:19 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493df7010aasm40499085e9.0.2026.07.07.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:52:19 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:53:24 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 12/16] iio: frequency: ad9910: add RAM mode support
Message-ID: <akzaWsIIA-uF_Crs@nsa>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-12-79125ffbe430@analog.com>
 <20260703040544.08a8ea5e@jic23-huawei>
 <ake_YWfvVC9RQ3wu@nsa>
 <1493eed5-5bb8-4a2c-8f2d-8b4bc5dde157@baylibre.com>
 <akt3i_YxG-jF3IdJ@nsa>
 <2d84950f-c56a-48f5-ab7c-c7b7ccb3b28d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d84950f-c56a-48f5-ab7c-c7b7ccb3b28d@baylibre.com>

On Mon, Jul 06, 2026 at 09:10:21AM -0500, David Lechner wrote:
> On 7/6/26 4:47 AM, Nuno Sá wrote:
> > On Sat, Jul 04, 2026 at 11:50:35AM -0500, David Lechner wrote:
> >> On 7/3/26 9:09 AM, Nuno Sá wrote:
> >>> On Fri, Jul 03, 2026 at 04:05:44AM +0100, Jonathan Cameron wrote:
> >>>> On Thu, 18 Jun 2026 14:27:28 +0100
> >>>> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >>>>
> >>>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >>>>>
> 
> ..
> 
> >>>>> +static inline void ad9910_debugfs_init(struct ad9910_state *st,
> >>>>> +				       struct iio_dev *indio_dev)
> >>>>> +{
> >>>>> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> >>>>> +	char buf[64];
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * symlinks are created here so iio userspace tools can refer to them
> >>>>> +	 * as debug attributes.
> >>>>
> >>>> Maybe worth a reference to appropriate ABI doc here (even if it is introduced
> >>>> in a later patch)
> >>>
> >>> I'm not so sure about these links. I mean, I definitely agree we should
> >>> make it easy for userspace tools like libiio to be able to handle
> >>> these kind of attributes but using debugfs is questionable to me. Pretty
> >>> much because this is not a debug thing. It is a real setting for the
> >>> driver so ideally we would be able to control it (using the existent
> >>> tools) without enforcing one to mount debugfs (I know that most of the
> >>> times it's always mounted but still feels wrong to tie "real
> >>> functionality" to debugfs). 
> >>>
> >>> Having said the above, some suggestions:
> >>>
> >>> 1. Make the iio_dev the parent so that the attr name is just "ram" and
> >>> it will be a subdir /sys/bus/iio/iio:deviceN/ram/.
> >>> 2. Propose a new helper for the firmware_loader code so we can get
> >>> struct device from struct fw_upload then we can easily create a sysfs
> >>> symlink.
> >>> 3. Name the attr as dev_name(iio_dev):attr so that it becomes
> >>> iio:deviceN:attr_name.
> >>>
> >>> Now that I think about it, 2. does not make much sense when compared to
> >>> 1. And If I'm not missing anything both 1. and 3. can be sanely parsable
> >>> from userspace (being 3. maybe a bit more reliable). And yes, both require
> >>> user space tools (in this case libiio) to support a new type of
> >>> attribute (firmware) but that is another problem.
> >>
> >> I would say that udev should be used to find the firmware device from
> >> userspace rather than creating symlinks. And you probably don't even
> >> need udev if you already have the `iio-device:<ID>` value. The path
> > 
> > Just one note. If you mean <ID> as the attr name the above will fail for
> > multiple instances of the same device. That's is why a proposed
> > dev_name(iio_dev) which I think it should reliable be iio:deviceN. 
> 
> My <ID> is the same as your N. It looks like I just had a typo of
> an extra : in there.
> 
> > 
> > I guess N might change so anyone hardcoding it might have surprises. But
> 
> That is why I mentioned udev.

I see! I would still advocate for apps to properly do the matching
between the current device id and the firmware path :)

But the above is obvious something we can't control.

- Nuno Sá

> 
> > properly done and we have a sane way to match the above with anything on
> > /sys/class/firmware/iio:deviceN:<attr>/
> > 
> >> is always going to be `/sys/class/firmware/iio-device:<ID>:ram/`. It
> >> seems like the same amount of work for usespace to computer the path
> >> either way, so might as well keep it simple and leave out the symlink
> >> stuff.
> > 
> > Yes, at least for libiio, `iio:deviceN` is already what we call the
> > device ID so we can match fw attrs against it and everything after the
> > last ':' is treated as the attr_name. 
> > 
> > We just need to keep in mind that if a second user of this stuff pops
> > up, we should add a new helper to enforce the ABI.
> > 
> > - Nuno Sá
> >>
> >>>
> >>> - Nuno Sá
> >>>>
> >>>>> +	 */
> >>>>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/loading", st->ram_fwu_name);
> >>>>> +	debugfs_create_symlink("ram_loading", d, buf);
> >>>>> +
> >>>>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_fwu_name);
> >>>>> +	debugfs_create_symlink("ram_data", d, buf);
> >>>>> +}
> >>>>> +
