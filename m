Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9F39902D;
	Thu, 25 Jun 2026 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385120; cv=none; b=V+ofd251eP/9JTaXFmt+TC/H3gK27xuTmjVppTMIprUrt8kBqimLy0bI4QHk4r6LzhuHrISp3pfLhOgW6xlF1GS6i1GPFyOOQl+Bpq2rv5EaZkL2Fqu89JwG+G5M7ST3fSyCUaSmQjEfrNNPDwNeaMYfEPM4/Z58fHdoPp+uyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385120; c=relaxed/simple;
	bh=KwW7qyjgnxA70oz0aACby5DwbwCNuJlA4xR+bm64lZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7+1bi+rrwdaMw++qygdWKaZ1gJLriwLRQdPZ4EWcRxxPZv7+HZcT9uWB6jH/adYKIAFq1CKOzFEwLK4BSplhHyhDohcyGPsuYTfCRFgsBfrybN0R2BAxylQ5yuOVMYy7TB1FTgQmFkGKx6YkbMrjBE07QVWnCHlYPm+GmlwtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3TEOPYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3TEOPYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADA21F000E9;
	Thu, 25 Jun 2026 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782385119;
	bh=pMXF+NVKTFFxwr9GwGi5i1hUtipTiGvNWUzd91eHN4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k3TEOPYIDeRb/dRHX22w48vl7H0eKsTXCYREKNIoSRM0DSZailPMVLCHlYc8CRj/9
	 xpZZ2NKi7g4VR37BxD6tbWaj/EK4k89hNu1ZhH26fdy9P8f29ShnkN+IBUgK+N3q48
	 OPNC3qHQMRvuPxFWp3l+dtvDYEfgN+7ep8DTLAzUnVcwprWGkh1jmvbF0mM5nFSeBk
	 QGYshyA588f2L060+YXKyq2YCrpp9OxEm5Ve7kYuF4S1Mv3C6sQRXRQvFADUPmyOFu
	 RtWdXLghjqB0fkwS2vAiHNv0kzkoS+YhZo7vV/y/hCThfAxH2v5NOLAoxNPjoZ4Qx8
	 u8sQwhhiQJ1Ag==
Date: Thu, 25 Jun 2026 11:58:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux@analog.com, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v16 04/14] lib: kstrtox: add initial value to
 _parse_integer_limit()
Message-ID: <20260625115826.3c0f2052@jic23-huawei>
In-Reply-To: <ssrckqgv3rqpfgxwpx4ca3m5m2mp3frxs6sd673chvsorhsjiq@63t3eosivg3a>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
	<20260604-adf41513-iio-driver-v16-4-1a7d09143bc2@analog.com>
	<rvx36i2ydmwhbbkdgbvh26uqchyoptzuu7tleuyarqn2skzkxz@owzwp62mzkdo>
	<20260614210044.19dfc8df@jic23-huawei>
	<20260624155414.61755e9a@jic23-huawei>
	<ssrckqgv3rqpfgxwpx4ca3m5m2mp3frxs6sd673chvsorhsjiq@63t3eosivg3a>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 08:30:07 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 24/06/26 15:54, Jonathan Cameron wrote:
> > On Sun, 14 Jun 2026 21:00:44 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Thu, 4 Jun 2026 11:09:33 +0100
> > > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> > >   
> > > > On 26/06/04 10:58AM, Rodrigo Alencar via B4 Relay wrote:    
> > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > > 
> > > > > Add init parameter to _parse_integer_limit() that defines an initial
> > > > > value for the accumulated result when parsing an 64-bit integer. The
> > > > > new function prototype is adjusted so that the _parse_integer() macros
> > > > > stay consistent allowing for one more argument, which defaults to 0.      
> > > > 
> > > > ...
> > > >     
> > > > >  noinline
> > > > >  unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> > > > > -				  size_t max_chars)
> > > > > +				  size_t max_chars, unsigned long long init)
> > > > >  {
> > > > >  	unsigned long long res;
> > > > >  	unsigned int rv;
> > > > >  
> > > > > -	res = 0;
> > > > > +	res = init;      
> > > > 
> > > > This might generate conflict, as the code around have changed in linux-next.
> > > > It is an easy fix though.
> > > >     
> > > Thanks for the heads up. Hopefully that will all fall out when I rebase testing
> > > on rc1 once that is out.  
> > I've done a mid merge cycle rebase as the char-misc branches have merged.
> > So this should be resolve on my testing branch now.  
> 
> https://lore.kernel.org/oe-kbuild-all/202606250230.etPGuolf-lkp@intel.com/
> 
> Apparently, the documentation header now includes parameter descriptions.
> The new one is missing.

I'm snowed under for next few days so if you have time to spin me a fixup patch
that I can just apply that would be great.

If not I'll get to it next week probably.

Jonathan

>  

