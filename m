Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB687134CCF
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785113909; cv=none; b=lLYw62x8CxddtvXUGq38HLBkJjO+2CFoj6zKnGn2KdNHAhFwRzRKcczD0P/enDYQKcNaNX0Sp8LL4kAgaCkU0iDWrDBS7HTbT6X2x8kR7vApH4DSbbX/xcYCIcVwMwF+gXpXqIgM7vHwtmxbqLl8MEOeZSaeBMo9zPrX/bI0aTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785113909; c=relaxed/simple;
	bh=ziKNlNSh0kETe9WKt1MuPQq06ZL/nvlBjewQtOXB838=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORefaWveVkhelGVn3/CldFvZbHPwvx2hZpdAu60mOwX8lGOhK5H5OQAwWQWYqJHfg8hc74jsNyTWdMJNhZzcDPBcRpkJFtQM3Kv+AHimvQc4TPCgGWn98wj7I8DyMSyuAq1N+YQF8MYz3zjhYqHajV7WT8DUUpOLyValkrd+vAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbiyg8Rm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbiyg8Rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5A71F000E9;
	Mon, 27 Jul 2026 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785113908;
	bh=xYVCeGXO2J6o3n/zBcqzUKBUZl9pPpB+NmEV4VWrqyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gbiyg8Rm03G0QAC6g0s9i8VqyujzKE+aPdNDUrMLLs5kge3BXVdM7kVBW90mOYm4W
	 lSU1veaLJ4r0CRDtu41KBpt1WjdPwGQnzS4ZY+3PBgSnsqcGp45gf8/tiCM5YN6bn/
	 /SGUlD8qYNpdW6efFivzzq2RFzWN11AUEQj1cwT082+xAJ0YbAc3Gb5vnBB4FWvsc7
	 dnz1NV9+dFm68yo8bDg+qHuZzax4QnY7IkqQ6bRLY+pIWWgwZz47rufanjnOhvL/o0
	 It12rUXfcUuxPNKrsi8JkLcPU9Dv4dqoF2Ci2aK4z8/RV4JJptR1lsEPaeSVahIuY2
	 IkPSWGEEN2TPg==
Date: Mon, 27 Jul 2026 01:58:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Olivier Tanoh <olivier.tanoh19@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: Looking for a sensor driver to contribute
Message-ID: <20260727015824.39da2987@jic23-huawei>
In-Reply-To: <20260724123953.000000fc@gmail.com>
References: <CAM49wQtgFL62Qm9LNe-DSwdY5av2uZVZMt3B7MzVg+jz6w-0+g@mail.gmail.com>
	<20260724123953.000000fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 12:39:53 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 24 Jul 2026 11:51:32 +0200
> Olivier Tanoh <olivier.tanoh19@gmail.com> wrote:
> 
> > Hi all,
> > 
> > I'm an embedded Linux engineer looking to contribute a sensor driver to IIO.
> > 
> > I've already sent a first (trivial) patch to staging to learn the
> > submission workflow, and I've studied the structure of existing IIO
> > drivers, si7005.c in particular to understand probe, channel
> > definitions and read_raw.
> > 
> > Before picking a target, I wanted to ask : are there sensors people
> > have been asking for that currently have no IIO driver? Or families
> > where a recent variant is missing?
> > 
> > I have I2C hardware available for testing (Raspberry Pi CM4), so I can
> > buy a part and validate the driver on real hardware.
> > 
> > Any pointers would be appreciated.
> > 
> > Thanks,
> > Olivier Tanoh
> >   
> 
> Hi Olivier,
> 
> It's really up to you to find something that that is missing in IIO. I'd recommend
> 
> - checking out newly released parts, preferably ones with an existing breakout
>   board to make testing easier. Stores like Adafruit are great for these.
> - finding an out-of-tree driver that is authored by a silicon manufacturer,
>   mobile phone vendor etc. and move the driver upstream (a good example of this
>   recently is a a patch series for the Sharp GP2AP070S, which has an out-of-tree
>   driver in the Exynos7870 kernel tree [1])
> 
> You don't just have to add new drivers, there is a lot of code that needs cleaning
> up :) I'm sure others will chime in with more ideas.
> 
> [1] https://lore.kernel.org/all/20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org/ 
> 
All good suggestions.  To add my 2 cents.

Find something you are interested in working with and where you feel the device
complexity matches how large a project you want.   For example I'd avoid an IMU
if you want something small.  Just see how much work Chris Morgan has put into
one of those!  Likewise big complex energy monitors or similar.

One option would be to look at the few things we still have in staging. However
before you go too far on that I'd suggest looking in the lore archives for
previous attempts.  Some of those are still there for good reason and solving
that will be a far from simple project!

Thanks,

Jonathan


