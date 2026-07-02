Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5E2BDC26;
	Thu,  2 Jul 2026 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956638; cv=none; b=geIZXKUyHHoNnfzLzbguS7fuBbPBszHh9ImQUA10DmyH+3V91wLsw+1P4QhvWjVRlFc1bRHIuDTc5xeS+tnkPBobu4KblmXPUKds+NdenInWQT1iPyeMSK1NRIEbRttXB49ftXtGs0eWSTDTVv709M+QVXjjxwsdHkC+mVmCu6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956638; c=relaxed/simple;
	bh=8ZsoSlpZRk9/zjRuxZLZukgrWPGnIgypU4+TxfSLRn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXP+50PrDGfKQYCQZI/6fud5OQ2iWp8VC6Fc4RG5mHJuOMtIHMgDjycXBQ9CHV9rwSajV/3O5DwHYAJrfVtIA7EXWqjNOiIvFUp7nvsmcvau30b6eG6hvqIt8an3BomTlVQu7m7QSdPkIQxioyoF+fMFdG+DnfC27jiWbMFCTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLWe0BMP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLWe0BMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D2C1F000E9;
	Thu,  2 Jul 2026 01:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782956636;
	bh=xLrPP34nXbJjIg/1zjEMQWzEuKX2LMl+tzIQuEVRfug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JLWe0BMP32KkuBFc8VkzEEkQGdc9zsFmZj2Hu8RU6VHHjWoikxT2Ht+lW0jzgrLme
	 o9QJqAi48r0cFvNfkx9m2B5ZOVual8OFvX8/lvAujciRfzA2o8aoNbZ97zZfWdLWmW
	 9wf0qpmmPfc6y14wkgvh1IexH6DKIL0kRLnEc5lASttHRCd68A55zN7mWl3g8sLlEn
	 tk2f43KdLzqlz8hAdioqyN8LWPD0fAr7sSYGdKACMYpeEt3ScSIvOb+MAywNdfa8Mf
	 2+EPMKbQLYJehq8PtcpjiluUTShBhotcuo9WwGihYjfcB5DxUfBewwj3q+wixpjgRy
	 qbJ3Tu/fRgjkw==
Date: Thu, 2 Jul 2026 02:43:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v2 0/3] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <20260702024351.101fe3bd@jic23-huawei>
In-Reply-To: <0ca506a8-29d1-4514-b4bf-296fbf547513@baylibre.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
	<20260623155556.13701-1-shofiqtest@gmail.com>
	<0ca506a8-29d1-4514-b4bf-296fbf547513@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 16:04:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/23/26 10:55 AM, Md Shofiqul Islam wrote:
> > The MAX86150 (Maxim/Analog Devices) combines two PPG optical channels
> > (Red/IR LED) and one ECG biopotential channel in a single I2C device.
> > Data is produced at up to 3200 Hz and buffered in a 32-entry hardware
> > FIFO with a configurable almost-full interrupt.
> > 
> > This series adds:
> >   1. DT binding YAML schema for maxim,max86150
> >   2. IIO driver with triggered buffer support
> >   3. MAINTAINERS entry
> > 
> > Changes in v2 (addressing Sashiko AI review, Joshua Crofts, Krzysztof Kozlowski):  
> Please don't send revisions in reply to previous series. It breaks
> many workflows and tools that expect each series to be it's own
> message thread.
> 
> Also, when submitting a series for a new driver, please wait at
> least one week to gather feedback before sending the next revision.
> 
> 
One more thing - if you send a new version (e.g v3 here) without
anyone having reviewed, reply yourself to the previous version to
say what was wrong!

Jonathan

> 
> 

