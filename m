Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53334AB07
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963644; cv=none; b=jLfGLJHCJK0ZgonODCE3Q5fith/BN/o0H5afnGc13JYE257nHdlHpHJFwylec6ieS9lqnHvVcgOW2zuLun9wIjBvD1O/CjZRcOHz7vtX37eGzvBOKoZOXAXA4FPXxVlZhf7ho6PQLBKAcD74IW77/BdH2zV+46lHpmL5NzcD8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963644; c=relaxed/simple;
	bh=ToxIZWctlQilSCoHqiefXHI/xunJ4P0DC5xriL95dRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dur3zhj3MLwOL93m9naKxP5F+tqTX5FcbsUrgD0f9nyGeGBETvdRM0Lw8ajCSm7+XwkUnD4OdiLrWUjBWMAckj46neXClKcvCGEhlHFV1B2ncP0fLMTCdy06cgqe8D3JO/SUPKwASmFDHOsLeijvMLH7cVKCgPbjPG9sQq3iWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOkuSnO3; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOkuSnO3"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ae287a8444so253058eec.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 18:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768963642; x=1769568442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQbdBgfkd7EcwE75AgiRI1/65NEwUWBGyhPvKNZxv3w=;
        b=lOkuSnO34aYx7/g7u1s6a4bOIf6xDW5g0ymownW6ldnrfVC3SH67XtlUDnOIXAZcyV
         Vl8x6NgmayGC6YQvP0Yd4mOYFT7/GBvNZfAQLI8mNu9PR8iQGAclG4/YjjohtTGp7uuV
         6Kw1E8Ael+3/jC+y/4O4QuDB4PiLEcjZyjlxi2T92O8bcKbms23VA6R0TArSCIH4ss/h
         aZZRztJNbO5H3lHIZVs3MRp9Tpkrm9Guxrt4Qsjj1lwpQI2glBZMsoD+1bG4D88SH236
         8cqif8QVuJlT/ODpoJVTP5oii8wDfgkCqpO6Ho4TfqlHzELFufIMpjkaUm38bRc6fb4U
         qTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768963642; x=1769568442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQbdBgfkd7EcwE75AgiRI1/65NEwUWBGyhPvKNZxv3w=;
        b=SAlHJNy3IjwhAQxs/863JJS8ubLIzazTVsT5tw24WlYgyyixJFB1D96PwIj5jVA9VE
         Nwmqbdk/rbbXPOPIhkJrAmGphb3DlFzjU1XRr8vEAjbg2dksqtp4TUM7UdPO6wFcK5X8
         V9QTNHZJyTl+za10+ot9/5PGmEarM99932GOGmW4M3yeH3mXqzj8+CjJkTXlRswGAtwZ
         drENMpGpeBC9LE+A+tnkszvn79Fi+xwnytDNvJ3Qi7YICsFevcvUytWXkZrwk9473gcB
         adpCV8qJ5U50ChhbaY3xbnb2EosbrecRVV1OLcr0UqTEqYIIFWer4LSQlpW/ukeuGa9e
         Vrvg==
X-Gm-Message-State: AOJu0YxD0xliQRgoqTjNavHG8axptoAE7VL2rt1GTsi5LGWyFD64kbFO
	AkSiqTSRSw2//NxJwLJOvDofSURvPdTDNf7CU37l2rmns5H0RFZ8vcPr
X-Gm-Gg: AZuq6aJddlrCcByGtfh74C16F11nwWSXMq30zvrx5Hw16forW6kz6Kg+I8u/2atFy3x
	HHYrJTfdgKt23c7zJxC7AkeyGch65xDC1FisPQglxaX6NOmx4TKlNmT3R6xhPv4hOZsnr2irqVj
	cYSuG/rcXb9dXfh+7ujzjTghOpeO67fYwPWGqrHHhQQPcbeuhfmQtTcM4VVzDBmI83oaq8Z0cCZ
	ccbpsGNWaE4V0t8sVeLqe2WOOGJJsGhXNl8uaVd1+zff6rDx0DlNlDHxh4WE9uPz+Bphh1amCxB
	BdJ6nvDPCrqTr8vF6N/Btywxsvn95E50n7sT1de/CjM1qi90eJVSd+Rk4pITj/vIebSYixVI4T+
	U8kz/6Si8gMsemnPBEI7x8NrB/47EaMeyQdANcbobpQ4f28YMl9PbAx+7It5HhBz7Crm0UMOLCK
	Xa7IZmtKAMvBDr3OrkSkcYoCgtvdDXcQ==
X-Received: by 2002:a05:7300:3208:b0:2a6:a306:efdb with SMTP id 5a478bee46e88-2b6b3468f3amr12058623eec.3.1768963642311;
        Tue, 20 Jan 2026 18:47:22 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b712881482sm1136344eec.5.2026.01.20.18.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 18:47:21 -0800 (PST)
Date: Tue, 20 Jan 2026 23:49:11 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [RFC PATCH v1 2/9] iio: ABI: Accurately describe
 in_distance_input
Message-ID: <aXA-p5p5dT3uBDva@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
 <b38d761e3d78d6121bd3f3de0908a156ad9ea277.1768759292.git.marcelo.schmitt1@gmail.com>
 <2d148091-9e40-41ee-95cb-544abcbf81be@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d148091-9e40-41ee-95cb-544abcbf81be@baylibre.com>

On 01/18, David Lechner wrote:
> On 1/18/26 12:20 PM, Marcelo Schmitt wrote:
> > There is only one driver (drivers/iio/accel/mma9553.c) that declares a
> > channel of type IIO_DISTANCE with an info_mask containing
> > IIO_CHAN_INFO_PROCESSED. Though, mma9553.c provides distance in meters (as
> > would be expected for the _input interface). Split in_distance_raw and
> > in_distance_input ABI documentation to provide accurate description for the
> > in_distance_input interface.
> > 
> > Fixes: 7cf78db585b1 ("iio: Add ABI documentation for illuminance raw and scale values in light")
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> > Added a fix tag though not sure it's needed/desired since it might not be worth
> > to backport documentation?
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index aec39b8e3345..27251b65ea0e 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1613,6 +1613,13 @@ Description:
> >  		user). Units after application of scale are Joules.
> >  
> >  What:		/sys/.../iio:deviceX/in_distance_input
> > +KernelVersion:	4.0
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute is used to read the measured distance (in meters)
> > +		to an object or the distance covered by the user since the last
> > +		reboot while activated.
> > +
> >  What:		/sys/.../iio:deviceX/in_distance_raw
> >  KernelVersion:	4.0
> >  Contact:	linux-iio@vger.kernel.org
> 
> I'm not sure it is worth splitting these up since the documentation is
> just repeated except for the bit about scale. And it is common knowledge
> that scale only applies to raw and not input.

It's common knowledge to us who are familiar with IIO. For anyone else, it might
not be. Plus, it is tecnically incorrect to have _raw and _input together like
they were before.

> 
> Also, looks like raw and input are swapped. raw it the one with scale
> so the sentence about scale should be with the raw attribute.

Hmm, have I messed up with the patches? Their final look in my local tree is:

What:		/sys/.../iio:deviceX/in_distance_input
KernelVersion:	4.0
Contact:	linux-iio@vger.kernel.org
Description:
		This attribute is used to read the measured distance (in meters)
		to an object or the distance covered by the user since the last
		reboot while activated.

What:		/sys/.../iio:deviceX/in_distance_raw
KernelVersion:	4.0
Contact:	linux-iio@vger.kernel.org
Description:
		This attribute is used to read the measured distance to an object
		or the distance covered by the user since the last reboot while
		activated. Units after application of scale are meters.
