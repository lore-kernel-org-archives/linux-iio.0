Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B1233BBA7;
	Sat, 28 Feb 2026 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277669; cv=none; b=W89dsX6I/QOiE8XnroQOTE2kymVuWwMy+nC3zyhcIAwynUIhUGaZSthJdhUhHcKfDd6PtsNxmHWO+fmoszEP/Q4GvHe52lsly8X7hxNdWo+D2kVpDdm3Y8qfGGzwhoYURQk0v6pKf24KaCT5SAC0C4AGCKMRvM++I6C/W7VVbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277669; c=relaxed/simple;
	bh=1gn5uqFD2QKOmB7+Mn6M0aE2ebptqny5yp/c13GTCxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozycR3Wz3X7BKMT7VYcsFLdQK3pLb1K1XHw0dYGfnT4BAMMZFMx7V1kmEK0ERe6pSoWooIalUjNHXTLlUE6aD8iDzHaeGnk79b/JbgDGzZSOp8/1t4/BR+fb7Yv31Bb0yuEszngECkmnaLD1OkBqtQtmdoZCHLjiJ0Gga0aaX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlUXxHEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlUXxHEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52642C116D0;
	Sat, 28 Feb 2026 11:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772277668;
	bh=1gn5uqFD2QKOmB7+Mn6M0aE2ebptqny5yp/c13GTCxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QlUXxHEjBVren5OsMPVJiDe7U++IcIf7slEhpXzhy/TCeqrZuOplyH6ovW1WT638I
	 lkuRn4oELPwHnB94+AkfA5oOSe8J/O1G1OnjDqUoujY/5sRmNoFvBJTN1V5TVNYh8x
	 W1E6OGN1gIgYK+l4Xt9dv/QPTZhRWfp5yuL58MjXS7mbGa6vydu4ut9CkTGtJNWwfR
	 d8UxDW5bQx7NxRxqQCkeUoqDsoQmdv0wyUPMLRBOd7F1PB+fnCez2m1+cHW+7rTt7b
	 yBpRT+9rWAloA4xDU2uZ/RYWcEx1NVWyVXc6//BfjZIJSUcuqR5NxUjZl4JwWp7OC9
	 8do+DUsfpa3sg==
Date: Sat, 28 Feb 2026 11:21:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: junan <junan76@163.com>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, sakari.ailus@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Replace NULL thread handler with a dummy function.
Message-ID: <20260228112100.23946af3@jic23-huawei>
In-Reply-To: <aaLAVwiUZs_i8U3q@ashevche-desk.local>
References: <20260228023643.12000-4-junan76@163.com>
	<aaLAVwiUZs_i8U3q@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 12:15:51 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Feb 28, 2026 at 10:36:46AM +0800, junan wrote:
> > Hi,
> > 
Hi.

One general comment is to follow the formating of patch titles used in the
particular subsystem you are sending a patch to. So something like:

iio: hid-als: Provide a dummy thread handler to avoid warning.


> > This is a similar problem as [1]:  
> 
> > [1] https://lore.kernel.org/linux-iio/20260227071409.aEG-iBFD@linutronix.de/T/#m15ab81856b42f72169fe51bd87fa399b5147441f
> >   
> 
https://lore.kernel.org/all/20260220224514.471348-1-srinivas.pandruvada@linux.intel.com/

Is perhaps more relevant here and the preferred approach.  These sensors should
in theory have never provided a trigger in the first place but we can't fix
that now because of ABI issues.  The approach used in Srinivas' set gets us
to the position where the ABI remains the same but the underlying structure
correctly doesn't use a trigger.

I haven't checked how Srinivas' approach would apply here though so
I may well be missing something!
+CC Srinivas.




> Make it a Link tag.
> 
> > without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> > in IRQ request and gives a warning if there is no threaded handler.
> > 
> > There are two iio devices on my machine:  
> 
> IIO
> 
> > ```
> > junan@fedora:~$ ls /sys/bus/iio/devices/
> > iio:device0  trigger0
> > junan@fedora:~$ cat /sys/bus/iio/devices/*/name
> > als
> > als-dev0
> > ```
> > 
> > The function calling chain is as following:
> > 
> > hid_als_probe(hid-sensor-als.c)  
> > 	=> hid_sensor_setup_trigger(hid-sensor-trigger.c)
> > 		=> iio_triggered_buffer_setup_ext(industrialio-triggered-buffer.c)  
> > 
> > `iio_triggered_buffer_setup_ext` is called with a NULL thread handler, and the flag is set to `IRQF_ONESHOT` inside it.  

It's not as though the top half is valid here either!  This is a completely
fake registration of an interrupt handler that never gets called.

> 
> > I am not sure which flag to change, so I replace the NULL pointer with a
> > dummy function or can we just change the flag?  
> 
> Besides you used way too long lines, the last sentence (question) has to be
> located in the comment block...
> 
> > Signed-off-by: junan <junan76@163.com>
> > ---  
> 
> ...somewhere here.
> 
> And answering to it I think it's band-aid and wrong approach.
We need a bit of a band aid to avoid an ABI break, but the approach in Srinivas' patch
for the main hid sensors support is cleaner than the one here.

Jonathan

> 

