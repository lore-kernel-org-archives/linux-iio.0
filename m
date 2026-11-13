Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533815;
	b=u1kiaKoGQ/SKORPrFXw/esrDUIXHuia9gEecG/X6757EmjxUQSibkHF8GOZc5YG268a9
	 WYT4cg6ywcHAzY9yyhdfMC9+8LHkAkz1X3kPnX8QbW8kB7oGjJooP9gq3ZrHIziXsTjmo
	 yokNVoDUDMW2b5dPLMhXIE4Y8ncp6J2frfte+1rQysusInOP29qe88C0iUt+3gAemMnNj
	 6jHZikRz6HZbukcujq/pxLN8piV7YioaBQZ37bkqcxYO8J9mI01th02rs8hUn8yjMkGuQ
	 b98Z5OIZnelGQEUPqkrS3xHE8QpqvH1Gc5sLgpv5YzDB1aJn+1FlWFNrke1BYmgYjZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533815;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=arMA0v5t1o98BajxZAqpCJPUMRuqqdv471JMZzK6vk8=;
	b=UbMe+QHfFZAqf1euV4V14f5pl7JvJFV/4G+buoU3KCpdiscJy6RefKh0l27iVl+8mGiS
	 ZIOmvkk41LtyU7utz/3bGSk/1uOQNX7iR7AALF5xqkqwbhj26kjNwiYP2Xd+a3hSFAo5k
	 RVuvtz8gGu0aIY7GeRmqQX/1XRuwLCBY4MfrOFzwwPh2qQ8JXk1HjODhIHNTZ9BEdVQqO
	 9/Q1bGICxRyV26Qg3h5O1g1Rp6igrVxczRgB1Xna8nb8p+32aOPTOgQIiNjVHF4MvT1Qe
	 NIhdfhVxoY9Oo3YVoCURMe8BuQqJBEJsXyNPclNe7l0Qx2RRuKM/2+cwhhjeGzxoI+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSbPldpL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50012606A321;
	Fri, 13 Nov 2026 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSbPldpL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E31F000C4;
	Fri, 13 Nov 2026 01:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794533814;
	bh=arMA0v5t1o98BajxZAqpCJPUMRuqqdv471JMZzK6vk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NSbPldpLgz4V6yCT5f2eIjnWlQqFg/91G4ZwJaqJkWdXQ/RdIDx7vKcKh+kmn6+RT
	 ffI3QvvK5Vz/fLdEzNRi/6YV2tPL1njOZDJeF7ziub2vRX+jfUMzz2KTHm9wv4JNwV
	 kyRpjfMJ53BS88y+8htuT/VUacCo8JnnpOLBa36caXSs3+lCkTT0RBhjQlxHBcpuZJ
	 DUHGLve2kZYetHSyE0ZzY7rDsmHrQntu8T/amkbgm0Gd3AHRrKBAXlgK69+AHiKsvZ
	 EoS0wTziKM3wyTLCh8dpJHnAsJ+IgpTOR9zNUTzL7Bhv+7B+k1Q1ND6wgNnMPsyqk9
	 qg3NV+aZ2Oidw==
Date: Fri, 13 Nov 2026 01:36:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Di Wu <diwux@google.com>,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <20261113013646.4c2f8456@jic23-hlaptop>
In-Reply-To: <20261112220218.1adae5e5@pumpkin>
References: <20261111072608.3490763-1-diwux@google.com>
	<avR-KT-6e77EexZn@ashevche-desk.local>
	<20261112020439.37b0da70@jic23-hlaptop>
	<20261112220218.1adae5e5@pumpkin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 22:02:18 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Thu, 12 Nov 2026 02:04:39 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed, 11 Nov 2026 16:39:37 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >   
> > > On Wed, Nov 11, 2026 at 07:26:08AM +0000, Di Wu wrote:    
> > > > Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> > > > and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> > > > PAGE_SIZE limit and is the preferred helper for show callbacks.      
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > 
> > > ...
> > >     
> > > > -	return sprintf(buf, "%d.%06u\n",
> > > > -		       latency / 1000,
> > > > -		       (latency % 1000) * 1000);
> > > > +	return sysfs_emit(buf, "%d.%06u\n",
> > > > +			  latency / 1000,
> > > > +			  (latency % 1000) * 1000);      
> > > 
> > > As David said, since you touched these lines, make the less amount of them
> > > while at it.
> > > 
> > > (But no need to resend, usually Jonathan is kind to tweak this small thing.)
> > >     
> > Done and applied.
> > 
> >   
> 
> I just looked at that line again.
> Why is it multiplying the remainder by 1000?
> It could be:
> 	return sysfs_emit(buf, "%d.%03u000\n", latency / 1000, latency % 1000);
> if the 6 digits after the decimal point are required.

Good point, I guess unrelated change that we could have on top.
Those trailing zeros shouldn't matter.

> 
> David

