Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381015;
	b=f9acBtNDPnEe7Ll/ClM2owxyi6d1cNGfG18dwmmPiGlV8Pas7aLTT/KIIEzrNoKQR+WN
	 g9veIUtbDt6DC7mH8N75T9m31w/F4LHCaLdVnV5a8RjCajyZ2bIk3LYw/YtLJfTGcqSeM
	 g0vvz1iQ+bX2YiAC58Ui3xZhICVFZItMmKTuWDzq69HFBr5vR4W8K7SinXgQ6awv+K3C9
	 3f9cfkbsQsD4D1Iygh6l4Z7tg6fDUx58nLwSl3oektyv/KsAQvAM71sHwjcHbw+9WOdo9
	 hptTxChSgNumcNNrBHmx2dNrKKjWpjnLfF7Cabe7DKaZWfyAADPZa8ORNV+2vaF10Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381015;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DMRTLh9QWHOBTrKkxFKvDAuRmtTkhznpxAQUhX+xPS0=;
	b=Hb2/OfwLk4B8XKHjuaZybDXg+muwy175oo10LEwnRAuPfzhS28ineor8hMEcynO7a6Rz
	 zvDUdRJLjbA6DxOIDcAsX5wvsKRDOBkL2H8PtFTd9taax+0Zx7Rp4v7r6qDmPXjUAVL6R
	 9FcfQIdC7jFPKaY0vxM4tONlIRDW3n1bm5QvB0R2SJERkT2vinuA7gOo8ihhoyVQG1awB
	 MvBpZnTF3n8QEvzc+uputp/4ko4OgE+Weqi9vBmotNJbwyLzla/YE2DWhGVC/a6Kn7VLJ
	 TsERwwNEUYORskcet1Rb3ajrRmKOq+KN1xvwIbpQvAD6MmOs/RDrxkR+Zx81qDMnTlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRIkpwCS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E2606A31A;
	Sun, 22 Nov 2026 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRIkpwCS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE8C1F000CA;
	Sun, 22 Nov 2026 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795381014;
	bh=DMRTLh9QWHOBTrKkxFKvDAuRmtTkhznpxAQUhX+xPS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iRIkpwCSESegoxpoYoH22GhlNBh6pu1HUkR3zRg3z/dpekm0FlsVCt+z1jrtM3pWf
	 dX07ANSeCqaY2DbSB+ROulmH1tET2YGKmk/f43ZCP0Mz5Up6Er+CbPdMxquawk9lts
	 yGLG5DIOQTiSX6+D11w7GzVzwAK7mNISSWJqYa9CqXlsVnqmt+XpDwd1YznMui2P6l
	 JnuAj5+QG6wV1UOfGZLQMEOGd0HVx2TYO7XoDvegC8RiIxnioJEP4B0NgiQBeRSI9a
	 yBjmjkmJgjv09o7nq9rJglVu+eKlFMrLBdAdDQoCma6JFSxkgQNFgFO+lrngft/Znf
	 cmondaoHE69vg==
Date: Sun, 22 Nov 2026 20:56:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Balint <dbalint@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, Benson
 Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, Tzung-Bi Shih
 <tzungbi@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, mwojtas@google.com
Subject: Re: [PATCH v1 0/3] Introduce cros_ec power monitoring
Message-ID: <20261122205648.73f3cf17@jic23-hlaptop>
In-Reply-To: <20261120091022.1459658-1-dbalint@google.com>
References: <20261106193129.43493-1-dbalint@google.com>
	<20261107010356.39d9eddf@jic23-hlaptop>
	<20261118204532.257423-1-dbalint@google.com>
	<11a821f4-aef6-425a-8626-1d8641e9f83d@roeck-us.net>
	<20261118220033.70425495@jic23-hlaptop>
	<20261120091022.1459658-1-dbalint@google.com>
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

On Fri, 20 Nov 2026 09:10:22 +0000
Daniel Balint <dbalint@google.com> wrote:

> On Wed, 18 Nov 2026 22:00:33 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Do you need that coherent snapshot to get to userspace in one go? 
> > 
> > For accumulator channels the way they are normally done to sysfs
> > style reads is to snapshot on each read, update an internal store
> > of accumulation since enable then provide whichever one was requested.
> > That way no data is lost - but you don't get an aligned snapshot.
> > So it depends on what maths you are going to do with them, whether
> > it can be done in kernel and if not how much interchannel skid
> > matters.
> > 
> > So tell us more on why you need that coherent snapshot to userspace.  
> 
> Sure, I can provide more context. Usecases are broad, but an example
> would be that we calculate per-rail drain contributions over short 
> time windows for comparative analysis between device states (device state 
> transitions like screen on/off trigger snapshot), or for debugging and
> power profiling purposes we correlate fine-grained ODPM data frames
> (~1s intervals) with other timestamped system diagnostics in our tracing
> tools (e.g. perform per-process-per-rail energy attribution), so math
> happens server side, and the relative energy deltas between channels
> within a frame are just as important to us as their absolute values.
> In general, data from a single channel makes sense in the context of
> other channels, there wouldn't be a client that requests only one
> channel.
> 
> At higher userspace sampling frequencies, e.g. ~1s trigger intervals,
> which can happen in both abovementioned cases, interchannel skid becomes
> an issue if we read individually.
> Because the latching and data delivery (up to 64 MKBP events)
> roundtrip between EC and kernel takes non-trivial bus time that's in the
> ~10 ms range, latching per sysfs read across 64 files spreads channels
> across a hundreds of ms long interval, which would compromise coherency
> and render the data minimally useful. It would also make the EC
> unnecessarily busy with redundant work, so latching per channel read
> isn't really an option.
> But to Guenter's point, this could be solved by driver-side caching.
> 
> 
> On Wed, 18 Nov 2026 15:00:20 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > You could accomplish that the same way many hwmon drivers are doing it:
> > Read all attributes in one go from the hardware, then cache it for a period
> > of time.  
> 
> I should have mentioned the importance of timekeeping earlier. As we're
> correlating the snapshots with other diagnostic time-series data,
> userspace needs to know when accumulators were latched as accurately as
> possible.
> In contrast to IIO, in hwmon:
> (1) There is no timestamp ABI to propagate latch times, so userspace has
>     to rely on its own timestamp when initiating a read.
> (2) There is no trigger ABI to force a fresh latch on demand (e.g. on a
>     device state transition), so a userspace timestamp only marks the
>     start of a sysfs read sweep rather than the actual hardware latch.
> 
> So, unless I missed something, with a timeout-based cache in hwmon, a
> reader has no visibility into whether it's hitting newly latched or
> cached data or when the cache was actually latched (skewing time-series
> alignment) or whether the cache has expired mid-sweep across 64 sysfs
> reads.
> 
> We could probably tune a short enough cache timeout where time skew
> would be negligible and mid-sweep expiries would still be infrequent,
> then it's a trade-off between accuracy and more mid-sweep expirations
> (more EC roundtrips). It could work, although we still would do 64
> sysfs reads instead of 1 on each trigger.
> So I guess it's not a must to send the coherent snapshot in one go, and
> I cannot provide any data to claim that hwmon would be a suboptimal
> solution to IIO, but our technical judgement is that IIO's explicit
> trigger, latch timestamp and single buffer read is a cleaner fit for
> power monitoring via the ChromeOS EC.

This is all good information.  Capture a short version of it in cover
letter for v2 and include a link back to here for anyone wanting
the full gory details!

Jonathan


