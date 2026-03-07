Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8B28BA95;
	Sat,  7 Mar 2026 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772902882; cv=none; b=MMtv9t8ovFc8SpGC3N6QlIXz6l7GNCyeeQPXnTQ6ERyc0tZ+pMiwXVS6FJXGY7NCyScmd5pAXWe6RZEux+lUDmj/LndUbbuGk69tTp82JyCB5pdD3dHpq+Roes0ukkmfrNTZG5YgLdkX7+g9m8pLmhPYGj+EJ6StfKK8sJM96PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772902882; c=relaxed/simple;
	bh=4PQOnmZE4i7nYeFONjFfq74mV+vHbWSwVxp7l/wzkaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhBmCgosO9bwjyHXx3swkASrKYL7ADCs5knofe+VdSflRW418W/+dKIp4LQTEmr4hdv4SXsc/ZsLn4cjhd9/5KsNmmrMV1uVb/AEmszXIy+rPbSW0asZoP28BLDMO9ESBhG8UUt0J6aEFzsG9W+1aPVechv5ki9K3TTrbmCsxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgEaTdd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgEaTdd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE612C19422;
	Sat,  7 Mar 2026 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772902881;
	bh=4PQOnmZE4i7nYeFONjFfq74mV+vHbWSwVxp7l/wzkaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SgEaTdd9owY9gaipmUFAdiEQAffCZa19dogkaDlZHM9+jh6EAsehq+QB29YCBvPRa
	 TN/OTrYg0RFwVc+6OMW8zuOMwocr4lIjIjUhoYoOMj+kQ9Gfa/Y3wiXPZuPvaybjWp
	 h/+1gXryINAy8Z1jmHaDq5/HGxjmsVJr1NFgi2JYcYX3qqSRPjzpMWmQbDq5HIvsqc
	 Ycz5gkC0Na33RtwpO/VMLt+gH76rKbrPhEcYfy57rzgZwk3ay1HbcldJIeIrfLClou
	 TJi+PHBxHnO75cUCrgaLNTX/3r47KEB+hc7rV7yaEm9GmVSRKj8QjlQHNLQ8NaYNyd
	 Tlo6uf1qYyQDw==
Date: Sat, 7 Mar 2026 17:01:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Santos
 <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 cosmin.tanislav@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad4130: add new supported parts
Message-ID: <20260307170111.4a6af284@jic23-huawei>
In-Reply-To: <18438082-8efc-475f-acde-be3cb313f2ab@baylibre.com>
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
	<1d5baeec27724a1c8ebf909c29c3599d583948a1.1772078999.git.Jonathan.Santos@analog.com>
	<aaWH1wL8odeCmE6w@ashevche-desk.local>
	<18438082-8efc-475f-acde-be3cb313f2ab@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Mar 2026 10:27:41 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/2/26 6:51 AM, Andy Shevchenko wrote:
> > On Sat, Feb 28, 2026 at 09:39:04AM -0300, Jonathan Santos wrote:  
> >> Add support for AD4129-4/8, AD4130-4, and AD4131-4/8 variants.
> >>  
> 
> ...
> 
> >   
> >> +	/* Triggered buffer data structure */
> >> +	struct {
> >> +		u32 channels[AD4130_MAX_CHANNELS];
> >> +		s64 timestamp;  
> > 
> > Use aligned_s64 type...
> >   
> >> +	} scan __aligned(8);  
> > 
> > ...instead of this.
> >   
> 
> This is used with SPI, so it actually needs to be:
> 
> 	IIO_DECLARE_DMA_BUFFER_WITH_TS(u32, channels, AD4130_MAX_CHANNELS);
Whilst you are correct, that reasoning is partial.

We could have marked it as sufficiently aligned.
The buffer part make sense because we may have only a few channels enabled
so the timestamp may be much earlier in memory than the structure suggests.

Thanks,

J
