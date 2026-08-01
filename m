Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434532B138
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785562136; cv=none; b=mYEeuYbUGYnM0tfxesp8ae3WfnDdwtmRGUGZDgoLbu7idYTN9Z+uvE25sXlbquCgjTGXnmuPDaH509XxcNtaIgiEGPUotvMmLwGUFN5crDTh8eujgOL9DDnL0/EwRXsL9YeLj6i592EIwxeKV7CZdQWDK/HRrJknpyi31Q9e40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785562136; c=relaxed/simple;
	bh=NKRiEWM7OmBlcThohq6rD6o3xFY86H5i1xR06buE38k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ym5cCLYysPkChS789Tp3dh9QW49yrE4NpXa0A4PZXqsDPd++9sxTiuUluae/sihUvJ75Xzmq43UNQlVbwFdt9bJzjmTnh+DlKe6vpdnOhPTGWfkTW1QG7xhelUHqMRbFB2OF8GdrnUBGe6p9HByPCDuEViL86UMS0GqMXgfYt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmWu6LZs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmWu6LZs"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f64ca1c2dso561800f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 22:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785562133; x=1786166933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VGWLDg96xg9X2R8tFVFYr1K1sw/dzYhsye3xehVIvdQ=;
        b=CmWu6LZsuZhcD01Ga1R13iKDSbcxHqqtUNyxZmduhrB0cme8EH1zpfnf6yAalWZzYW
         yZr6ocABG/0YiIWgWWcqXNQQUGE+Utlz83gxgvpU45kBntYIs537DFmvnqdMsWy+m5zd
         HSCsGMs5Kt2x0+viYVXfOCGWf7Hui2E6X8kdg8XU5jZryW1uh0k2+HcpBWo6QGwraOtD
         3noJDxHCM9cCtnEaC0Of8gMjnOZxcyWSRbMPPrQNDR3dc19/xFf7cqWHHe9L98MdpQB+
         sy3wEuFrzczNUy338VcYVpUEuLoVrv14g2rp7qkKMKgewdqt9kb/ERDUFMCiPiP6gRtN
         5cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785562133; x=1786166933;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VGWLDg96xg9X2R8tFVFYr1K1sw/dzYhsye3xehVIvdQ=;
        b=AB3sI2oSV97LPLxWjmESI53eKG6z7/EV80IfRz1OEqA+18wF0XDMgAEPzWFJW1QkVd
         5qlWO6jgZxy6n0nLp7AnYt+FhuyLVSYDLczBWm7wKy1RkSOfnsncYT890N06IIvyuxtr
         ZtlU70d2Ea5d9P1ya0aMmqz+J9ZRE04V/bL9QpY+daY3aUfeGeed8HkCCR7uSMOBq52Q
         90SO7RHbCXNS/SOWZRYflnRVuv0wwETwJyszBFhjt9DxpinHbjVWObJZm8U65vgv57Xc
         vJgMRDu8TJq3bCJG++dNaLuQIxUkwTKZZ6X+r2X9RwC5XOJcmHRmGZ6t8ZGPxNzRlfGa
         yrVA==
X-Forwarded-Encrypted: i=1; AHgh+RqaykXuKhv9jZ16r/6Q3e1TDdwHJ008K/ShHicSEO71J84WDiW3ZSx0oPuuXiaWgQTmgUwaLcbLNxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTH0pBAWwE5K0JNhXqBwvX3xL8ZTVc0v37cG8xpHWVlQSU2j/n
	Zw+lu7iW58cjqHhRo3yXlWRin5+PmegiU08rvcAOGEHAewh8sr3i5IXO
X-Gm-Gg: AR+sD13aoRC9S1L/hztLHOXw/Oa6IV5K5Yh3YLsridO0saBGhf1fHgr9mtyd6rINaiq
	cSQKu2Tdf9yN3/g2oJmcToUt/Gny2FZc1sqF3cKY6t7mllxG7JA8elmotV7FVXlTv2w4cLNg86E
	AcgL59xp4TYTyjlgb4QbRiNAYwtQo0zPEV5Vw2Wyb/z04DS2KjjoJ48nEZy6YcMVksJu1j000Iu
	OGvf9dcOdx7lOmDzMCegpIwrhFY3o1vk9i1NZOV8lBI4wJFHZ5SvRWdGCud2kn7FOdQP728vgeg
	4InNSzGNeJH/AUv8sCPaN/j6XcMgQ2nJ5ARWCO/qKQsazgHDD2AC7Kz6i/ir9WgJMVMzYQImr34
	7l8paOTkeMOHvTNWwqBZQx0Ek07hMG1hzt990koGuQ+ODcSb4X5RqmncQe0mgvntieahBcL/Ghx
	63CgpzOLudEqpv9pHYMgpxCLxjj29elvqWhzI81oxp0CERi5rmCvhA1BMYNoxfSR+p31YJVlRBf
	os7JwBT/hRlJ1p5XbRZRrZr1X5WE7Rtnby6yW8vFAKMu4Cg7AhVsggQpOJ6NqOBX4xMh9hyex1k
	Nas5L0+NeWr3fDZHSTueRgadQzmPoUVCpenTO+bJGrMyIqmEf05HpOQxGjdsj351uN73QSbQNZG
	RVNLWIbt2eL+9FayPOmaKpDhkZJqq60M/15io2wFOr1U1pWxi9JmtkKngtqPSC+g=
X-Received: by 2002:a05:6000:1946:b0:47f:56f7:7a57 with SMTP id ffacd0b85a97d-47fd7309159mr3519771f8f.28.1785562132890;
        Fri, 31 Jul 2026 22:28:52 -0700 (PDT)
Received: from systembl0wer (109-81-110-164.rct.o2.cz. [109.81.110.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm13028897f8f.11.2026.07.31.22.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 22:28:52 -0700 (PDT)
Date: Sat, 1 Aug 2026 07:28:50 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com
Subject: Re: [PATCH v2 2/2] iio: dac: mcp47a1: add support for new device
Message-ID: <20260801072850.6f5d255e@systembl0wer>
In-Reply-To: <20260801033013.19ef2b2f@jic23-huawei>
References: <20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com>
	<20260727-mcp47a1-add-support-v2-2-d4591a2ce69e@gmail.com>
	<20260727184226.DFC1E1F000E9@smtp.kernel.org>
	<20260728151559.000067ef@gmail.com>
	<20260801033013.19ef2b2f@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Aug 2026 03:30:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 28 Jul 2026 15:15:59 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > On Mon, 27 Jul 2026 18:42:26 +0000
> > sashiko-bot@kernel.org wrote:
> >   
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Medium] Potential off-by-one in DAC scale calculation denominator.
> > > --    
> > 
> > Responding to Sashiko's comment.
> >   
> > > --- Patch [2]: [PATCH v2 2/2] iio: dac: mcp47a1: add support for new device ---
> > > commit 38bec2fbb020c3f749c52a26e5cc3e78e72eeaf5
> > > Author: Joshua Crofts <joshua.crofts1@gmail.com>
> > > 
> > > iio: dac: mcp47a1: add support for new device
> > > 
> > > The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converter
> > > which communicates via I2C.
> > >     
> > > > diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
> > > > new file mode 100644
> > > > index 0000000000000..140e93ff2ba01
> > > > --- /dev/null
> > > > +++ b/drivers/iio/dac/mcp47a1.c      
> > > [ ... ]    
> > > > +static int mcp47a1_read(struct iio_dev *indio_dev,
> > > > +			struct iio_chan_spec const *chan,
> > > > +			int *val, int *val2, long mask)
> > > > +{
> > > > +	struct mcp47a1_data *data = iio_priv(indio_dev);
> > > > +	int ret;
> > > > +
> > > > +	switch (mask) {      
> > > [ ... ]    
> > > > +	case IIO_CHAN_INFO_SCALE:
> > > > +		*val = data->vref_mV;
> > > > +		*val2 = MCP47A1_MAX_STEP;      
> > > 
> > > [Severity: Medium]
> > > Does this code use the correct denominator for the scale calculation?
> > > 
> > > Since this is a 6-bit DAC, shouldn't the scale denominator be 64 (2^6)
> > > instead of the maximum step value of 63? Using MCP47A1_MAX_STEP (63) here
> > > introduces an off-by-one error that could cause userspace to calculate
> > > output voltages with a ~1.5% LSB scaling error when reading the sysfs
> > > attribute.    
> > 
> > Yes, the max amount of steps is 64, which should be passed here. I'll
> > add a separate macro for this in v3.  
> I'd just use + 1 at this location given the clear relationship between
> the maximum value that can be taken and the number of steps.

Good to know, for some reason I thought that this type of stuff was
discouraged (MACRO_NAME + x would seem messy in most cases).

-- 
Kind regards,
Joshua Crofts
