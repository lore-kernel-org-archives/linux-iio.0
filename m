Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB02DF6E9
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991406; cv=none; b=Qf56pq1O/TJzgLKzjl4HuBgWQID0BbkBjuqbHvctiZvgt1m7zeSuwVdukXn4nbc3h4Nz0Ml3iqLmm9WZlk41X7BAQ0ohM+Si4zYbqQcCCN44ErSzwVnRX8eSngaGM3oajC3PsDhBcpNvuOvLloiClWK0VK7P2eTubM4KE9qstiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991406; c=relaxed/simple;
	bh=JoGNoeFYvaCgHxiFlTm+uOB3Kik3QPwFrFg/f03sR5s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWu+2gW+Ql6LxB9uLWYxSERFzgmPRp97/3tkWtLH4XhjnHpii1h7A/QUXd3wkZgH27AqCgrXqv9K7RNE+uqwZTaHa2jVQj+kfN+xYTVYc8IutP1Zkc2KkdLOgX5vtGnxo3AnT0SS+2cDPnj8qq/1SfmslKcLtt/TuUaUQLxq8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX6dKm6+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX6dKm6+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0046078so46221935e9.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777991403; x=1778596203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01vKRWT8Tz7XykjzJTy9m7cgaKj9BZDL4/9iSshKYAk=;
        b=NX6dKm6+dzuHK9f/p2xVWYgqyOIOuJfKyf/bCyPk7sZK+pD8tn/xV0ud+oI0gfQrZi
         OW+sE7DVUm6v6y44W02oS+5L+0vLkmrTsoHWfSZrkJBIXm311lEVr0s3ADT38HtKOWtv
         DdO4OIFHjz1Qxxmr4YW6QEipTcOAylqOVrRSfq44bvrsAN/qeQKv3bIKe3HjLO26SB6o
         AazOMIFX5vgMx/aI/OMQwn8lUbqwe5WXKV3mU4/k++A30M0V6923H4aj0RdP49UpTz6U
         T+64OuPcJfy6qJcdklZ9Puahnuyu8DKzt8g2wGaiqVE2Ma6eOwivYTl8IzVXdSi3elpg
         YP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991403; x=1778596203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01vKRWT8Tz7XykjzJTy9m7cgaKj9BZDL4/9iSshKYAk=;
        b=F/50u/I1LUvBOUsKp+ITuZxZi+OJbRgOTdOPuA68TixcPQgr7RU76TNlW3M/VlEdpd
         w84uInWxFa2PrCmhEgEe5DDtFBiAJz3s8QkO2RxzMb4ZVjGnKAmqaCdVzdn8Vpt1z4R1
         qtXo6hEosiMYAZ4ipoPyBcatDTgrXf1w6CaxfIzYm/XUx4KKdpploXUIS0njZWoFrrZ3
         w/6SgqWHTR3CCu8oBW2xGjpzvm32DMEvh0W1OfYYZ1lxdHajEUXL+QXRecDQc6eh5xR2
         Oanwn+idV+bIayLLQ+hnOJ4tTb3ubRkL0DKjSI4ngkwS0X/AuVs2xiiueS5Ftnt4XyQ6
         oPPA==
X-Gm-Message-State: AOJu0Yzjo1WnNMhql1qMS2h9E0wHTPEyAISh+f+MoU/+qcA4QdKQ3tTx
	aC1CWz5ooHFNTySyzTg7esl5NRsq1/LuZ16aF6ZBAuxyLfF0fp15nNhbfvsq8Frd
X-Gm-Gg: AeBDieur1yr4qJVNFOYL7R8e7OSLeJiddpL4Jps6CD/drtCIRRo9bYpYtGns0nHkfo+
	/pTjgCluNEYxzRdsutFwbGhiGBC8r+j+O6FTdqRQnyiXS34MkWMVnsyfMVWQAwf8cRV3w0lv8X2
	Ahi4bW415g7P2Z72h9QCTS8aeF0jIDFIVe6oL6MPL6++uTLqRCKcZLKuLnC1xEutf96wJYhe7fo
	GW/nPrdM7Wd5zl0Cbh+WxNYSVB1dNvMbf/ZhUw+AC1h7BEA44jZ13J6RevRecvCPGwNHAQnIPdL
	kNRLeFZE9H00bSlGcQOo9zweZg9Q9QRHTMnK1kNhuPVjPSY0VHRt0V4gL372mBQzB4Fh8YMHlXr
	C34n+4EwADMjCZWQhZElGJZtm4jRX3ox7rqfHrbOnDa6k6W/cUUmwVrxzzGmVU7OT3vkxpCaB0T
	6x+nU7Mrjf/8IvtxD6JGvN+VerGhPNDrz2nc0qvdYOkfHzBkxAuTc5igxPOEW6AX9aM4YxI1qPN
	HXxk8fjnopKt71viz0wJQYj+KnIEYuiQUUGLxcs7fkscNQIm+ZZO1x0vPz0
X-Received: by 2002:a05:600c:c4a7:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48a986642a3mr233049615e9.20.1777991403262;
        Tue, 05 May 2026 07:30:03 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a824f9f0dsm387504845e9.15.2026.05.05.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:30:02 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 5 May 2026 15:29:55 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Michael Auchter <michael.auchter@ni.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 00/12] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <egslrxgxzuj2rqsrjwo6xyjygnuwqqaqz7twkyetxtrhve2gfd@unmzoontm6kr>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <afnpvJ5dwkZBcTHL@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnpvJ5dwkZBcTHL@ashevche-desk.local>

On 26/05/05 03:59PM, Andy Shevchenko wrote:
> On Tue, May 05, 2026 at 01:35:01PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > This is the first series of three on updating the AD5686 driver.
> > 
> > A bigger patch series was sent before ("Extend device support for AD5686 driver"):
> > 
> > https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> > 
> > This one adds a number of cleanups and fixes, like:
> > - Refactor include headers (IWYU);
> > - Remove redundant register definition;
> > - Drop enum chip id in favor of per-device chip_info structs;
> > - Fix internal voltage reference control for single-channel devices;
> > - Acquire lock when doing power down control;
> > - Fix powerdown control for dual-channel devices;
> 
> > ---
> > Changes in v6:
> > - Protect powerdown masks on read access too.
> > - Minor changes to power down handling and constants.
> 
> You were too fast, Jonathan applied some patches already.

I understood He had applied the some of the fixes and was to wait on the fix
for the lockless read access issue to proceed. Also, most of the series have
been reviewed already. Indeed, I suppose I've been hurrying up things... will
slow down!
 
-- 
Kind regards,

Rodrigo Alencar
