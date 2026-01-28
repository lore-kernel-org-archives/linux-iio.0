Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC43491C8
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592685; cv=none; b=HZi6pN765Zmv/VPfj4IK2e9CoPTx6Ob9Fc+GuauGjJiPBODw6tBKOpJbZIpMikNqMOG9daiq96z7jqpcpqhs2Q4wt88fpQSRMbAJeli261PnlkV/8yBTUKaNlGWj/AdKUAbl4rOTr5QjrPa8jHuGnzDP1NIFbp/sMhAbgkMBffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592685; c=relaxed/simple;
	bh=NAvNu9FzsiaLNC01QuHIJv/9Rsx/bXNEy3ddn+PCg5g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MI7KL3vGA5X92vluiI3H6go5H/4qb77veQqfBRST+n3Z7Xt/LgM8WT5yf5piolJCpDP51joxrXDCGquHZtvYJX7VvuSkLaqEW+rZvGDbnL1DkDNbYmzbCvcdG8cRm2VzcBUlCyVbjNXFiwZTKbb/I0UbvmbHWPmybTJtzrL4Z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZRFkI1x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZRFkI1x"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4327555464cso4727407f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 01:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769592682; x=1770197482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RNSdF8NF1Qqll1XWLtY1WqSfii+PtXsNh/Cew2FGIM=;
        b=TZRFkI1xWYd/EVLwyr6fVqY5mUI169e/38QWi4hvS2sOYjGMmtpORx4/m5zu/YrKAk
         THm7Hi4WVpMmGP7+tySVxQzGL1kByPxmULqIGK89uN9oA1vmDaivP+xv4mWV3NcsDuZA
         n1gcmK4PI5F06PzYJgaXYErJjgE7n1JqB+C+m0CaCuUow4hhjXbrHhBtun4H9yIciFLf
         GOBOnAhIt4nMjxCNBJboI0RE96sxI214XAUOoy77paDXhjb0pL1CkTWdui59jtJHVUq6
         79ve34AAGG0UaF2gm7TKp6WSeV0UQu81ieH98pgmOZD89et35rWMtM7238G5CV4ie0m3
         Zrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769592682; x=1770197482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RNSdF8NF1Qqll1XWLtY1WqSfii+PtXsNh/Cew2FGIM=;
        b=hjNr2t/J+j14XYAZQikLWtyn6QNQsdBa3VqNMmUq/qlCk653+pxOsL8ADP4F33aLdB
         O1BHt2gRdjg2tVge7zmAhWC6fHi1U/Q50Bsr2umSqvH7HFUYdMblkeJLpn7gMg9zs83/
         1F7AZyloWdRCLrG/WF/qJcOF4DIvIze1V2YC1TMK1TLOws7VluwIIn30WTa48EA6Mn+v
         ey3wjCAd5A4K4yTSPn2X+h9FMmB75PAb4SU/txG1FG4XBW/8WWJC+V1w5riLAiiThfUK
         SwvqMPQK7ZkO+XjGFTEz3hccyCKsxrdVejcvuAoZd8AzmnMzG1XvyXGVEftzNFBWglbR
         0dpw==
X-Forwarded-Encrypted: i=1; AJvYcCVy+1M/EZLF5WBvPlgw5WYMk2+wQlLD4iWuTkdBcTrD+JHQMjGIHrUQr5jwu3cIW02hXs2vDTmIuto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQKW5woKd1pRctEDd70j9JU+1Kev3/niUaGDLDG8kAvO+dlc6
	Xx7fpdRDBhDb7z4sRobOVa05UYItfX/tmPKwloH39vwWFA91rlwU/TCxjTnb/g==
X-Gm-Gg: AZuq6aKaO+YNBBY2jePWkUOq5nTs2m3VCBm+yzzGtkRWNhQexnlDwxKTfPi/k1+HUb0
	lAkWMAAZDyxy5WOO3HuROf4niz/8PIcC/Qkind2ZGliakcPoYgNx5rZuo2dbO6eeUJ43r4tnq2t
	h5nfKgcTIAnPe6ctdR0s42BQIF9cxDTH7h8SxnT2xRnUIG4PRzm11UR9T6o9Sg9mz2ppPy7NXfi
	PqqbeO0j6JMiwvG9lz4EpbCxd2W3B6qMUzk+CgVl4a8VCldm615ItU9zR1/sL/+P5OijLcgq1q9
	HHcj/7770Yxx/K8MG5465NU1MP+hJ2LEzN7MwLAtUTBlye8Bkylvi9p6A3t2l+CyrO8A1vVPVDq
	qe6ccpKcyzF64iRiiaQbyypEplAhApN3gmTv4Z6bcaYoJqepC92t05SFNC75LbqLSzRYJm3NMv2
	rXkojny9EMdlx3FKakRfDnMGcP6HP65laVH35TloPEyBHFc6eCjB7p0S4IRXmz2gvyjpbhV9FNQ
	9ga
X-Received: by 2002:a05:6000:1786:b0:432:5bf9:cf2e with SMTP id ffacd0b85a97d-435dd02de05mr6653558f8f.13.1769592681473;
        Wed, 28 Jan 2026 01:31:21 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e46cesm5570352f8f.7.2026.01.28.01.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:31:20 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 28 Jan 2026 09:31:10 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 3/6] iio: amplifiers: ad8366: refactor device resource
 management
Message-ID: <rtu3nsjdufyhtox5uvtkoyzqtfcmq2wdfzmsr3xyvqlrdloirn@a3jdshanc7ha>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-3-c9a4d31aeb01@analog.com>
 <aXkqKZELWdjrB8wN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXkqKZELWdjrB8wN@smile.fi.intel.com>

On 26/01/27 11:12PM, Andy Shevchenko wrote:
> On Mon, Jan 26, 2026 at 01:51:04PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Adhere modern device resource management with the following:
> > - Voltage regulator managed and enabled internally;
> > - Proper mutex lifecycle with devm_mutex_init(), replacing mutex_init();
> > - IIO device registration handled with devm_iio_device_register();
> > - removal of goto's from the probe function;
> > - ad8366_remove() removed as it is not needed anymore;
> > 
> > Also, dev_err_probe() is used to report probe errors with created local
> > device pointer.
> 
> And also it uses the temporary dev variable in the cases that are not covered
> by the above.
> 
> So, three changes in one patch...

I can split. Using proper devm functions allowed me to drop goto's and
ad8366_remove(). Dropping the goto's allowed for the usage of
dev_err_probe().

I could place the temporary dev variable in a separate patch. 

> 
> Dunno if Jonathan is okay with this. I would rather split it.
> Code wise LGTM.

Yeah I can now see it coming. Thanks for the review.

-- 
Kind regards,

Rodrigo Alencar
