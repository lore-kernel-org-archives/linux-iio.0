Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120355;
	b=EgqrUKpxIa6wvhcDSZU9b9+6l8oyTWH0nn/tuCtWmxNJL3wSfHhMttGg8QFNn+zmxCNk
	 BLLrq1UcIShYEO7S59XaL3iz0FpLTqq1hsP9M1+yEjBye18nYPBR/yQzVRi4aYkT5x/Ra
	 Uioh68eSYLtu+Vqn9UIe077uCcfXRm/VDP9TxEcKKavJ3HnP/8zKUeV3tNIsK6c3UeamD
	 70t8UP6KSnmDXdpaeP1ZXX6E2wh5HSXLLTmsX7E/NzUnY/xDzmDiQqBlUDXj8UcMKFuWR
	 qfeq38yUTFRDC3fOL3ZY1Sczhh0cTgLaE1uFVMFCvSfdSR38BL3kYJzzgoN0qp08PrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xn5mhyBYyHW6lr80G2bcaHtch3y/eIfqPoTaMRbJI2o=;
	b=hoAPnr32K90YNfCCL6wOY2Mof3DH+mXU96O0rftimhJMUJ254GIs1f7kMGwin83cCGdx
	 t5/Tn9S9769m3BXxHf30kR8W0s73Uc5yfskEm/7nj+zACjk4muYw15J9F0SKwPgz3mH9u
	 r9Y7i7ZUbMP9LhvKWV//hWXBf3uFCB9isaM5Ir/SxtTRdcGnKphrWcG5NJ+Ej//6cGQJC
	 sI/Dd449og4JGoT7Zq2rfDwySePP083+DXDxtpL8JeuDJnBhaUObGOguYtWG4lfGL0Iu7
	 PWas3xyJ5J3CWGyl14v5hqTewONCOhnYY/+RgHURFBLElS/w1xsMhaGJx9wL5rFzkZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=glow8yZ9;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51AC606A320
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 20:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51AC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=glow8yZ9
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso264761eec.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 12:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795120354; x=1795725154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xn5mhyBYyHW6lr80G2bcaHtch3y/eIfqPoTaMRbJI2o=;
        b=glow8yZ9x+fwdtBpevYvZuBcds4wjQwb5pkw7T5HxwXeXjjectDJKhqWkEEkXMUVAo
         iDkB1eQf65pA+YWetDavIjZxWu3D0CXdcLdC5zRdTXMVzWi3kNueRVgj6jRufzarTpv1
         gxCYBDvhbghHU4sAdIZRUE4ihqKc693X4BKNHm+kW0lNk74Bxx+PPCLkc4Z/A2urbqcR
         hI4dRLeUMIbg2L0hQHL4+a4rLN1b8DWdK78BNm7VRPUO3/6BRJfTKulUoE3DfsSi2BTu
         RSgs3Mzb6JyWNC2UFBk15BQOEpeSp47tIzg35P9FlIccQ72Bdl9/NdRjf33EW2kaivJ5
         jGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795120354; x=1795725154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xn5mhyBYyHW6lr80G2bcaHtch3y/eIfqPoTaMRbJI2o=;
        b=G8Y40YTQXhgVbJT4bssaVljM0OLOYj6SSn2RrDUg2ovzBAYM8gjiEdE0ETb7llp083
         GGrhuXs0xdFWN6e8u5Vc/Q4lF1X6xIRNmrobPuLC1LtLBBovg3LXS3SUed9ygG4ipH95
         mYqGln2+wz2uP7IOAzwFMHWKp+wQ+yekO32NvvmHhUPaYmihHjZN+k/xoCKInDNcFQnu
         EtEmWNQWXQ/WODdLPYYJO/HSh7B7lkhuwKxpMHdeW7Rr3JnSAD7MhoRl/EGoo2Z3hEMC
         rfrGKYS80fiDEIkjU8zBww4oW8hb8Jc8pS/e+jwHzlQoRnRS6u2+kesk9GoMXzhyi6Kv
         cD1g==
X-Forwarded-Encrypted: i=1; AL+hErFFaUD7OVRM5R9q0kNJ2QWVJBSJcNN9BZcplt3vaaCvctp5w7gTk+nZhLtAhLje95ce7TjRLQCo200=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PfWPs4YH+F69FSLDiRUvl95xMHZO3LTXzizkMNtWJ0IEVEawr
	7fe97J7Yokyww17Figj3z74UfeZzT+2xek+VYTc3O19aP2UxMk2a0YWU
X-Gm-Gg: AZFdTZctjkQeP36IcwjX/KIDLODgaUgJO9K5WRB+b5FD1jKNCBw6diibOpe+dzqbt0H
	fdQqUt39HkXCKSHA0B6K33bqJ6SZGInF46HqKn+YCbFQxb6V1IADHUQjweIrCbHMJrV6q1Kzr0V
	3oe0UHpisBLBP04og3JO7tuooVYV2coE1nAV35tAbBlCiCw0YBsBQxvey8FwmPjGrEZBynn6Ti+
	H/U2WiBn6Mb5yB3YVYb9nWMy4wLXpuqi3H4HBHS3je2DpFC6nQBtYEaI9pDd4ZuLI0hjrlH2GWz
	BDiCL+7/7xWzR2avHtfpsXIkQDTxUl2eaEd72zP6gk/ZuJoDrxfBcsdpifnlnIkWMXna7aWxYjf
	b/NaWELKzBbS4kaotCuCoFBCJVtfVEUy/+42D/wYKjDoTxNFBEzVdq+cW71oKPHSY4rZPEtE8N8
	NHejWBAFeI0g8Mu/U8usTlms2gxEN9pyTpZi5NyOU/J2RiKefWMn2OhkWcVeuRfOX2dFR9PEpga
	hs/r5foo8nEiaWLMdHGYaBD+EGEzzFUxry333w7kQHbK0DvGAZeaIxFEjWAa2+A9FATBQE1yFWo
	JWQlMlcTvYuPK1cXyoylq31S8Ad26oUJAADtWg==
X-Received: by 2002:a05:7301:921:b0:375:c862:34e with SMTP id 5a478bee46e88-38570742392mr419227eec.20.1795120353679;
        Thu, 19 Nov 2026 12:32:33 -0800 (PST)
Received: from localhost ([2804:30c:914:4500:cd15:65cc:e2cc:7363])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm1101905eec.6.2026.11.19.12.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:32:33 -0800 (PST)
Date: Thu, 19 Nov 2026 17:33:58 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux@analog.com, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH v1 1/5] iio: backend: Add calibration source interface
Message-ID: <av9dNvWzHlbvBZf4@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
 <67582938820d6f206006b16de71ad6bcdacfa863.1795003864.git.marcelo.schmitt@analog.com>
 <20261119025747.53b30ba4@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119025747.53b30ba4@jic23-hlaptop>

On 11/19, Jonathan Cameron wrote:
> On Wed, 18 Nov 2026 10:03:17 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Some ADC front-ends send data over a configurable number of LVDS serial
> > lanes and may also need to have the data frame calibrated before capture
> > can start.
> > 
> > Add a backend operation for selecting the calibration source (data lane or
> > data frame) so that device drivers can perform the calibration of both the
> > data frame and data lanes.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  drivers/iio/industrialio-backend.c | 23 +++++++++++++++++++++++
> >  include/linux/iio/backend.h        | 22 ++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> > index fbf5c39d7655..682d5f735071 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -869,6 +869,29 @@ int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
> >  
> > +/**
> > + * iio_backend_calibration_source_set - Select the monitored error source
> > + * @back: Backend device
> > + * @source: Error source to monitor.
> > + * @lane: Data lane to monitor. Only meaningful for
> > + *	  %IIO_BACKEND_CALIB_SOURCE_DATA_LANE.
> > + *
> > + * Restrict the error reported through iio_backend_chan_status() to a single
> > + * source of the digital interface so that each lane can be calibrated
> > + * independently. Backends are expected to report every error source again
> > + * once %IIO_BACKEND_CALIB_SOURCE_NONE is selected.
> 
> I don't follow this description at all. If there is more than one how
> does it report 'every' error source? 
> 
> Add some explanation, probably to the commit message on how the
> flow using this works.  We might need more info here as well.

I've complemented the explanation about this new backend operation. I'll try
to further improve for v2 if the description below is still sounding confusing.


Some ADC front-ends group and send data from a single channel over a
configurable number of LVDS serial lanes and may also need to perform a
data frame calibration before capture can start. During a channel interface
calibration, the front-end device driver usually requests the channel
status multiple times to find out the optimal calibration point.

However, the backend channel status interface doesn't provide which
specific serial lane or data frame flagged errors when they occur. The lack
of error source information prevents proper calibration of channels
comprised of multiple serial lanes.

Instead, the backend may have a separate error source mask configuration to
restrict which digital interface source will have its errors reported
through iio_backend_chan_status(). With that, each serial lane can be
calibrated independently, enabling multiple lane LVDS channels to be
properly calibrated and supported.

Add a backend operation for selecting the calibration source (data lane or
data frame) so that device drivers can perform the calibration of both the
data frame and data lanes. Backends are expected to report every error source
when IIO_BACKEND_CALIB_SOURCE_NONE is selected.


sashiko comments seem to apply. Will, fix those for v2.


Thanks,
Marcelo
