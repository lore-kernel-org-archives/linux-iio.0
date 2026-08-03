Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0B184;
	Mon,  3 Aug 2026 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785717795; cv=none; b=akaVYK8qxaJzXmJe56aX0h+5pjexSBU3LMcvWeyIdmVnrKhqj9+v/31uFjhcKDA/Im6zAc0C2qzzZSuH0qVii/vDYoe9jioPzFCT+RJZ2GaR786IxQ9QDd5VcOZxgV1+hQ9mJD5Cr2T36IedTVmLFYGhgc2vvKxdR/0co5rzdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785717795; c=relaxed/simple;
	bh=H2RN2X7zuOOR2LJrbilbjSOYRT52Ljcpia19lYY80R4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjrHu98fl4UINdBeFN9kekLfNfjxKrepF7teYYAo0DKVb3FlgW9l2I5Z+dn7SPhkLBiZ7RoQL1WSqg3KzR0jmsmBqI3P2baUtTCJT5Mo2lI7/EAksNtm4ClhhngZzwY2ivCFjprAx+VcVTsDk6FMRKZ+/y+sUKIWGs8cRVNyKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQMphwLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQMphwLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654C41F000E9;
	Mon,  3 Aug 2026 00:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785717793;
	bh=9wS1yn6KCsjBsbF8JgcmpxwB8Ea4aTf/8QEt3mhlQqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RQMphwLtpuzfyf5qmWmCleMQ0qfOxp2HSjcfQJs/1B3OQ5C1WkSHD8mNoP0pZNNfA
	 lyTPas5H9poAB/73lRKrAQXpjrZepdlDB+yVHixZMakCqZ+LqsKBA5pqkaSuHxxwi+
	 FZMNTax8CFNt0ml//iMoixim60nGY++i746nOiVbB4sZw6bGoSBcIE9J0ltxSJad2x
	 IO2dQrvoHbSK6NIUVGM7jOT2Z+svvOMxABaoP8NPyIBAAZcl6lnZTcVARCBaqf3JEV
	 W5c0UwC0W6s12Rjcom3MAxPMBiri0MHMnF+0H0BX87qRs/uQYCpanhNCMqGqOsBRKT
	 vv2sVRI5CuI8g==
Date: Mon, 3 Aug 2026 01:43:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, andi.shyti@kernel.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org, igor.korotin@linux.dev,
 branstj@gmail.com
Subject: Re: [RFC PATCH v4 2/3] rust: add minimal IIO subsystem abstractions
Message-ID: <20260803014308.35ce74a5@jic23-huawei>
In-Reply-To: <CAO26r3QDbT07dTsMfMB8Y6H+qBzh-PQxgcTTVKqJ7C9yv-emsQ@mail.gmail.com>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
	<20260707151542.91997-3-muchamadcoirulanwar@gmail.com>
	<DJVQDP9J54K1.AANCLIJC23YF@kernel.org>
	<CAO26r3QDbT07dTsMfMB8Y6H+qBzh-PQxgcTTVKqJ7C9yv-emsQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 23:20:48 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> On Sat, 11 Jul 2026 at 19:12, Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Tue Jul 7, 2026 at 5:15 PM CEST, Muchamad Coirul Anwar wrote:  
> > > Add safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem:  
> >
> > Does IIO's iio_device_unregister() synchronize against in-flight IOCTLs?  
> 
> From what I traced, yes. iio_device_unregister goes through
> cdev_device_del, device_del, sysfs_remove_dir, and ends up in
> kernfs_drain which waits for active sysfs readers to finish.
> Please correct me if I'm missing something here.
> 

That covers sysfs, but IIO has a bunch of chrdevs (though you aren't
using them here).  I'd go for 'almost certainly' for whether synchronizes
in all cases but we have found one or two races over the years.

The way it is supposed to work is that the unregister takes the
info_exist_lock and sets the iio_dev->info pointer to NULL.
It also wakes up any one polling etc, and returns errors on all
in flight actions.  Every ioctl takes that same lock and checks
if info is null before carrying on.  The lock is held across
the ioctl to stop any racing with the unregister path.

I can't recall any recent paths being discovered where the
lock + check was missed but we did have them in the past, though
normally not about IOCTLs but about in kernel consumer drivers.

There is an outstanding fix related to those, and read_avail
+ lifetimes if people allocate storage in that callback but
I doubt this goes anywhere near that area of IIO yet.

Jonathan

> Thanks
> Coirul

